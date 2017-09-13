Received: from eggs.gnu.org ([2001:4830:134:3::10]:50381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsAIa-00050f-4w
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsAIV-0004Nd-3k
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:14:00 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:45123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dsAIU-0004MA-SU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:13:55 -0400
Received: by mail-wm0-x22b.google.com with SMTP id g206so10842177wme.0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:13:53 -0700 (PDT)
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-12-david@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170913132417.24384-12-david@redhat.com>
Date: Wed, 13 Sep 2017 17:13:50 +0100
Message-ID: <87lglia85d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 11/22] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


David Hildenbrand <david@redhat.com> writes:

> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
> guest tries to bring these CPUs up but fails), because we don't support
> multiple CPUs on s390x under TCG.
>
> Let's bail out if more than 1 is specified, so we don't raise people's
> hope.

Why does this restriction exist? Without MTTCG enabled -smp > 1 should
be safe from any races.

>
> Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index f67b4b5d58..417998ec28 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -23,6 +23,7 @@
>  #include "hw/s390x/css.h"
>  #include "virtio-ccw.h"
>  #include "qemu/config-file.h"
> +#include "qemu/error-report.h"
>  #include "s390-pci-bus.h"
>  #include "hw/s390x/storage-keys.h"
>  #include "hw/s390x/storage-attributes.h"
> @@ -55,6 +56,11 @@ static void s390_init_cpus(MachineState *machine)
>      if (machine->cpu_model == NULL) {
>          machine->cpu_model = s390_default_cpu_model_name();
>      }
> +    if (tcg_enabled() && max_cpus > 1) {
> +        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
> +                     "supported by TCG (1) on s390x", max_cpus);
> +        exit(1);
> +    }
>
>      cpu_states = g_new0(S390CPU *, max_cpus);


--
Alex Bennée
