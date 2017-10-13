Received: from eggs.gnu.org ([2001:4830:134:3::10]:44379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2uMQ-0008Gp-7G
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2uMN-0005Ar-2R
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:26:22 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:37827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2uMM-000590-Rx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:26:18 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 18B8513FE1C
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:26:16 +0200 (CEST)
Date: Fri, 13 Oct 2017 09:26:07 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171013092607.69f2135d@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1507823299-270245-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-15-git-send-email-imammedo@redhat.com>
	<1507823299-270245-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 14/24] fixup! ppc: spapr: use
 cpu type name directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Thu, 12 Oct 2017 17:48:19 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> follow up commit that registers host-spapr-cpu-core type unconditionally
>  "ppc: spapr: register 'host' core type  along with the rest of core types"
> 
> makes 'non' machine crash
>  ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core
>  ERROR:qom/object.c:217:object_type_get_instance_size: assertion failed: (type != NULL)
>  Aborted
> 
> before it qemu fails cleanly with
>  ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core
>  qemu-system-ppc64: -device host-spapr-cpu-core: 'host-spapr-cpu-core' is not a valid device model name
> 
> spapr_cpu_core_realize() already has explicit check for pseries machine,
> so move access to host cpu type after it so 'none' machine would fail
> cleanly as expected.
> 
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

That's much simpler indeed than trying to register the host CPU type at
QOM init... which turns out to be quite hairy compared to the gain :)

>  hw/ppc/spapr_cpu_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index b5bbb6a..7dbf9c3 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -151,7 +151,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(OBJECT(dev));
> -    size_t size = object_type_get_instance_size(scc->cpu_type);
> +    size_t size;
>      Error *local_err = NULL;
>      void *obj;
>      int i, j;
> @@ -162,6 +162,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    size = object_type_get_instance_size(scc->cpu_type);
>      sc->threads = g_malloc0(size * cc->nr_threads);
>      for (i = 0; i < cc->nr_threads; i++) {
>          char id[32];
