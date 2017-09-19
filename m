Received: from eggs.gnu.org ([2001:4830:134:3::10]:56853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duIEP-0001BW-IR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duIEL-0005n7-I0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1duIEL-0005mh-Bj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:06:25 -0400
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dba8f914-b9f1-f942-0c57-4cfbadf08655@redhat.com>
Date: Tue, 19 Sep 2017 15:06:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170919074314.10350-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
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


> +##
> +# @GuestPanicInformationS390:
> +#
> +# S390 specific guest panic information (PSW)
> +#
> +# Since: 2.11
> +##
> +{'struct': 'GuestPanicInformationS390',
> + 'data': { 'psw-mask': 'uint64',
> +           'psw-addr': 'uint64',
> +           'reason': 'str' } }

Wonder if we should rather use an enum for reason.

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 74b3e4f..5b835fe 100644
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
[...]
> +static void unmanageable_intercept(S390CPU *cpu, int32_t reason, int pswoffset)
>  {
>      CPUState *cs = CPU(cpu);
> +    const char *str;
>  
> +    switch (reason) {
> +    case EXCP_CRASH_PGM:
> +        str = "program interrupt loop";
> +        break;
> +    case EXCP_CRASH_EXT:
> +        str = "external interrupt loop";
> +        break;
> +    case EXCP_CRASH_OPEREXC:
> +        str = "operation exception loop";
> +        break;
> +    default:
> +        str = "unknown crash reason";
> +        break;
> +    }
>      error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",
>                   str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
>                   ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
>      s390_cpu_halt(cpu);
> -    qemu_system_guest_panicked(NULL);
> +    cs->exception_index = reason;

Hmmm, this might work for KVM but most probably in the current form not
for TCG. cpu_handle_exception() will most probably just clear it and
then exit to the main loop.

Most probably we would the need to reset the exception index after
returning from tcg_cpu_exec().


Apart from the TCG concerns, looks good to me.

-- 

Thanks,

David
