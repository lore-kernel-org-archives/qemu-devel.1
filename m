Received: from eggs.gnu.org ([2001:4830:134:3::10]:57690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtzGZ-0002KV-KW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtzGW-0006Lq-G9
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtzGW-0006Ks-0S
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:51:24 -0400
References: <20170918163322.206581-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a82be132-6363-6875-9cb2-837eb9787ac4@redhat.com>
Date: Mon, 18 Sep 2017 18:51:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170918163322.206581-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Jing Liu <liujbjl@linux.vnet.ibm.com>

>  # An enumeration of the guest panic information types
>  #
> +# @kvm-s390: s390 guest panic information type (Since: 2.11)
> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'GuestPanicInformationType',
> -  'data': [ 'hyper-v'] }
> +  'data': [ 'hyper-v', 'kvm-s390' ] }
>  
>  ##
>  # @GuestPanicInformation:
> @@ -335,7 +337,8 @@
>  {'union': 'GuestPanicInformation',
>   'base': {'type': 'GuestPanicInformationType'},
>   'discriminator': 'type',
> - 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV',
> +           'kvm-s390': 'GuestPanicInformationKVMS390' } }

kvm-s390 is wrong. This is general s390x and should be named s390/s390x
and GuestPanicInformationS390(x). One can argue about s390 v s390x. See
last comment in this mail.

>  
>  ##
>  # @GuestPanicInformationHyperV:
> @@ -350,3 +353,15 @@
>             'arg3': 'uint64',
>             'arg4': 'uint64',
>             'arg5': 'uint64' } }
> +
> +##
> +# @GuestPanicInformationKVMS390:
> +#
> +# KVM-S390 specific guest panic information (PSW)
> +#
> +# Since: 2.11
> +##
> +{'struct': 'GuestPanicInformationKVMS390',
> + 'data': { 'psw_mask': 'uint64',
> +           'psw_addr': 'uint64',
> +           'reason': 'str' } }
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 74b3e4f..bfaee04 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -35,6 +35,8 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  #include "qapi/visitor.h"
> +#include "qapi-visit.h"
> +#include "sysemu/hw_accel.h"
>  #include "exec/exec-all.h"
>  #ifndef CONFIG_USER_ONLY
>  #include "hw/hw.h"
> @@ -276,6 +278,58 @@ static void s390x_cpu_set_id(Object *obj, Visitor *v, const char *name,
>      cpu->id = value;
>  }
>  
> +static GuestPanicInformation *s390x_cpu_get_crash_info(CPUState *cs)
> +{
> +    GuestPanicInformation *panic_info;
> +    S390CPU *cpu = S390_CPU(cs);
> +
> +    cpu_synchronize_state(cs);

Is this the correct place here? Or rephrasing it: in order to detect an
crash this should already have been done. E.g. unmanageable_intercept()
uses cpu->env.psa, which has to be synchronized (especially for older
kernels).

So we should rather make sure that all crash paths have synchronized the
state (e.g. in unmanageable_intercept()).
[...]

> index d07763f..950ea42 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1941,15 +1941,31 @@ static bool is_special_wait_psw(CPUState *cs)
>      return cs->kvm_run->psw_addr == 0xfffUL;
>  }
>  
> -static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
> +static void unmanageable_intercept(S390CPU *cpu, int32_t reason, int pswoffset)
>  {
>      CPUState *cs = CPU(cpu);
> +    const char *str;
>  
> +    switch (reason) {
> +    case EXCP_CRASH_PGM:
> +        str = "program interrupt";

program interrupt loop

> +        break;
> +    case EXCP_CRASH_EXT:
> +        str = "external interrupt";

... loop

[...]

>              break;
> @@ -2016,7 +2032,8 @@ static int handle_intercept(S390CPU *cpu)
>                  if (is_special_wait_psw(cs)) {
>                      qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>                  } else {
> -                    qemu_system_guest_panicked(NULL);
> +                    cs->exception_index = EXCP_CRASH_WAITPSW;
> +                    qemu_system_guest_panicked(cpu_get_crash_info(cs));

Especially because in my latest series ([PATCH v1 00/27] s390x: SMP for
TCG (+ cleanups)) this code is also used for TCG.


-- 

Thanks,

David
