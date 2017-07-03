Received: from eggs.gnu.org ([2001:4830:134:3::10]:48940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dS1AZ-0003rv-3J
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dS1AV-00011y-Qo
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:13:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dS1AV-00011S-H0
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:13:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v63DBZ0m114685
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 09:13:34 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bf2b9yq64-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:13:33 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 10:13:29 -0300
References: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 10:13:21 -0300
MIME-Version: 1.0
In-Reply-To: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <6116aa74-eafa-4f91-094d-4b64e29cf8e0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: fix memory hotplug error
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>



On 07/03/2017 09:21 AM, Greg Kurz wrote:
> QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
> Let's propagate the error instead, like it is done everywhere else
> where spapr_drc_attach() is called.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 70b3fd374e2b..e103be500189 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>       int i, fdt_offset, fdt_size;
>       void *fdt;
>       uint64_t addr = addr_start;
> +    Error *local_err = NULL;
>
>       for (i = 0; i < nr_lmbs; i++) {
>           drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> @@ -2611,7 +2612,12 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>           fdt_offset = spapr_populate_memory_node(fdt, node, addr,
>                                                   SPAPR_MEMORY_BLOCK_SIZE);
>
> -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> +        if (local_err) {
> +            g_free(fdt);
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>           addr += SPAPR_MEMORY_BLOCK_SIZE;
>       }
>       /* send hotplug notification to the
> @@ -2657,7 +2663,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>
>       spapr_add_lmbs(dev, addr, size, node,
>                      spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> -                   &error_abort);
> +                   &local_err);
>
>   out:
>       error_propagate(errp, local_err);
>
>
Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
