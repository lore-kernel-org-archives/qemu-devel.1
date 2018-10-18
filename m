Received: from eggs.gnu.org ([2001:4830:134:3::10]:38788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD7xz-0006PT-G4
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD7xx-00015X-O3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:03:55 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD7xw-000155-B1
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:03:53 -0400
Received: by mail-oi1-x243.google.com with SMTP id u197-v6so23903920oif.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:03:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018123332.23518-1-pbonzini@redhat.com>
References: <20181018123332.23518-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 14:03:30 +0100
Message-ID: <CAFEAcA_6jGoD3-iTwc7=RUrYc1ac7jcjA8m26-JpRrcW+P-qRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-i386: kvm: do not initialize
 padding fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 October 2018 at 13:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The exception.pad field is going to be renamed to pending in an upcoming header
> file update.  Remove the unnecessary initialization.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  linux-headers/asm-x86/kvm.h | 5 +----
>  target/i386/kvm.c           | 2 --
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 7a7acf9e47..dabfcf7c39 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -300,10 +300,7 @@ struct kvm_vcpu_events {
>                 __u8 injected;
>                 __u8 nr;
>                 __u8 has_error_code;
> -               union {
> -                       __u8 pad;
> -                       __u8 pending;
> -               }
> +               __u8 pending;
>                 __u32 error_code;
>         } exception;
>         struct {

Do we need to include this hand-edited update to the linux-headers/
in this patch, or could we just drop the initializations, and leave
the header itself to be changed by some future update ?

> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6e5f951f4f..74193b1b9d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2696,7 +2696,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>      events.exception.nr = env->exception_injected;
>      events.exception.has_error_code = env->has_error_code;
>      events.exception.error_code = env->error_code;
> -    events.exception.pad = 0;
>
>      events.interrupt.injected = (env->interrupt_injected >= 0);
>      events.interrupt.nr = env->interrupt_injected;
> @@ -2705,7 +2704,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>      events.nmi.injected = env->nmi_injected;
>      events.nmi.pending = env->nmi_pending;
>      events.nmi.masked = !!(env->hflags2 & HF2_NMI_MASK);
> -    events.nmi.pad = 0;
>
>      events.sipi_vector = env->sipi_vector;
>      events.flags = 0;

You could also mention in the commit message:
 * these initializers were added by commit 7e680753cfa2
   in order to suppress a valgrind warning
 * they were rendered unnecessary by the later commit 076796f8fd27f4d,
   which added the "= {}" initializer to the declaration of "events",
   thus zero-initializing the whole struct (and so this patch does
   not change behaviour at all)

thanks
-- PMM
