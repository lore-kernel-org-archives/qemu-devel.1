Received: from eggs.gnu.org ([2001:4830:134:3::10]:58931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deigQ-0005Lb-I1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deigP-0006eN-5h
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:07:02 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deigP-0006e3-0c
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:07:01 -0400
Received: by mail-it0-x244.google.com with SMTP id t78so485856ita.1
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 07:07:00 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <77c63a1b-92f9-8fc5-dbf5-855c28adc03d@redhat.com>
References: <150210580404.1343.7325713896658799315.stgit@bahia.lan>
	<77c63a1b-92f9-8fc5-dbf5-855c28adc03d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 7 Aug 2017 11:06:59 -0300
Message-ID: <CAAdtpL7+_Tq2N4TKv2yoed=z_oeBzTY7eDMwLQ94mcq2YdFvUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] kvm: workaround build break on
 gcc-7.1.1 / fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Eric Blake <eblake@redhat.com>

On Mon, Aug 7, 2017 at 8:55 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 07/08/2017 13:36, Greg Kurz wrote:
>> Building QEMU on fedora26 with the latest gcc package fails:
>>
>>   CC      ppc64-softmmu/target/ppc/kvm.o
>> In file included from include/sysemu/hw_accel.h:16:0,
>>                  from target/ppc/kvm.c:31:
>> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=
=80=99:
>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may be=
 used uninitialized
>>  in this function [-Werror=3Dmaybe-uninitialized]
>>              cap.args[i] =3D args_tmp[i];                               =
\
>>                                    ^
>> target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may be=
 used uninitialized
>>  in this function [-Werror=3Dmaybe-uninitialized]
>> cc1: all warnings being treated as errors
>>
>> $ rpm -q gcc
>> gcc-7.1.1-3.fc26.ppc64le
>>
>> The compiler should obviously optimize this code away when no extra
>> agument is passed to kvm_vm_enable_cap() and kvm_vcpu_enable_cap(),
>> but it doesn't. This bug should be fixed one day in gcc, but we can
>> also change our code pattern so that we don't hit the issue anymore.
>> We workaround this, by using memcpy() instead of open-coding the copy.
>
> Nice way to do it, thanks.  I'll queue it for 2.10.

Indeed :)

>
> Paolo
>
>> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>> ---
>> v2: - use memcpy()
>> ---
>>  include/sysemu/kvm.h |   14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 91fc07ee9afe..3a458f50e9f4 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -428,11 +428,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned in=
t extension);
>>              .flags =3D cap_flags,                                      =
\
>>          };                                                           \
>>          uint64_t args_tmp[] =3D { __VA_ARGS__ };                       =
\
>> -        int i;                                                       \
>> -        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                 =
\
>> -                     i < ARRAY_SIZE(cap.args); i++) {                \
>> -            cap.args[i] =3D args_tmp[i];                               =
\
>> -        }                                                            \
>> +        size_t n =3D MIN(ARRAY_SIZE(args_tmp), ARRAY_SIZE(cap.args));  =
\
>> +        memcpy(cap.args, args_tmp, n * sizeof(cap.args[0]));         \
>>          kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);                       \
>>      })
>>
>> @@ -443,11 +440,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned in=
t extension);
>>              .flags =3D cap_flags,                                      =
\
>>          };                                                           \
>>          uint64_t args_tmp[] =3D { __VA_ARGS__ };                       =
\
>> -        int i;                                                       \
>> -        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                 =
\
>> -                     i < ARRAY_SIZE(cap.args); i++) {                \
>> -            cap.args[i] =3D args_tmp[i];                               =
\
>> -        }                                                            \
>> +        size_t n =3D MIN(ARRAY_SIZE(args_tmp), ARRAY_SIZE(cap.args));  =
\
>> +        memcpy(cap.args, args_tmp, n * sizeof(cap.args[0]));         \
>>          kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
>>      })
>>
>>
>
