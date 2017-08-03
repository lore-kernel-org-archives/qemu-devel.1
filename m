Received: from eggs.gnu.org ([2001:4830:134:3::10]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGH7-0002gH-2E
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGH3-000186-Ce
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:34:53 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ddGH3-00017q-89
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:34:49 -0400
Received: by mail-qk0-x244.google.com with SMTP id a77so1224737qkb.2
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 06:34:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
Date: Thu, 3 Aug 2017 10:34:45 -0300
MIME-Version: 1.0
In-Reply-To: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

Hi Greg,

On 08/02/2017 11:47 AM, Greg Kurz wrote:
> Building QEMU on fedora26 with the latest gcc package fails:
> 
>    CC      ppc64-softmmu/target/ppc/kvm.o
> In file included from include/sysemu/hw_accel.h:16:0,
>                   from target/ppc/kvm.c:31:
> target/ppc/kvm.c: In function ‘kvmppc_booke_watchdog_enable’:
> include/sysemu/kvm.h:449:35: error: ‘args_tmp[i]’ may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]
>               cap.args[i] = args_tmp[i];                               \
>                                     ^
> target/ppc/kvm.c: In function ‘kvmppc_set_papr’:
> include/sysemu/kvm.h:449:35: error: ‘args_tmp[i]’ may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]
> cc1: all warnings being treated as errors
> 
> $ rpm -q gcc
> gcc-7.1.1-3.fc26.ppc64le
> 
> Testing the size of args_tmp seems to be enough to prevent the warning
> to pop up.

This sizeof() use looks unnatural to me. I wonder why not use size_t, 
since this is about sizeof()/ARRAY_SIZE(). The problem seems to come 
from the commit this cast was introduced (61c7bbd236):

target-ppc/kvm.c:1302:21: error: comparison of unsigned expression < 0 
is always false [-Werror=type-limits]

So I'd rather suggest this code, which looks more natural to read to me:

     if (ARRAY_SIZE(args_tmp)) {
         for (i = 0; i < ARRAY_SIZE(args_tmp) && ...

I Cc'ed Eric :)

Regards,

Phil.

> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   include/sysemu/kvm.h |   12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 91fc07ee9afe..41fc1005a9ea 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -429,9 +429,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
>           };                                                           \
>           uint64_t args_tmp[] = { __VA_ARGS__ };                       \
>           int i;                                                       \
> -        for (i = 0; i < (int)ARRAY_SIZE(args_tmp) &&                 \
> +        if (sizeof(args_tmp)) {                                      \
> +            for (i = 0; i < (int)ARRAY_SIZE(args_tmp) &&             \
>                        i < ARRAY_SIZE(cap.args); i++) {                \
> -            cap.args[i] = args_tmp[i];                               \
> +                cap.args[i] = args_tmp[i];                           \
> +            }                                                        \
>           }                                                            \
>           kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);                       \
>       })
> @@ -444,9 +446,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
>           };                                                           \
>           uint64_t args_tmp[] = { __VA_ARGS__ };                       \
>           int i;                                                       \
> -        for (i = 0; i < (int)ARRAY_SIZE(args_tmp) &&                 \
> +        if (sizeof(args_tmp)) {                                      \
> +            for (i = 0; i < (int)ARRAY_SIZE(args_tmp) &&             \
>                        i < ARRAY_SIZE(cap.args); i++) {                \
> -            cap.args[i] = args_tmp[i];                               \
> +                cap.args[i] = args_tmp[i];                           \
> +            }                                                        \
>           }                                                            \
>           kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
>       })
> 
> 
