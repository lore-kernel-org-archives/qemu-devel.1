Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dVEnR-0006wQ-AP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dVEnN-0003Eq-42
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:23:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dVEnM-0003DQ-Qz
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:23:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CAJbJf123516
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 06:22:57 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj4v4yc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 06:22:57 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 20:22:48 +1000
Date: Wed, 12 Jul 2017 15:52:37 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
Message-Id: <20170712102237.GB5377@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix potential memory leak in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, Jul 12, 2017 at 11:48:39AM +0200, Greg Kurz wrote:
> Since commit 5c1da81215c7 ("spapr: Remove unnecessary differences between
> hotplug and coldplug paths"), the CPU DT for the DRC is always allocated.
> This causes a memory leak for pseries-2.6 and older machine types, that
> don't support CPU hotplug and don't allocate DRCs for CPUs.
> 
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 12b3f099d4c9..4a480e1c1dd9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2993,8 +2993,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      CPUState *cs = CPU(core->threads);
>      sPAPRDRConnector *drc;
>      Error *local_err = NULL;
> -    void *fdt = NULL;
> -    int fdt_offset = 0;
>      int smt = kvmppc_smt_threads();
>      CPUArchId *core_slot;
>      int index;
> @@ -3009,9 +3007,12 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> 
>      g_assert(drc || !mc->has_hotpluggable_cpus);
> 
> -    fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> -
>      if (drc) {
> +        void *fdt;
> +        int fdt_offset;
> +
> +        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> +
>          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
>          if (local_err) {
>              g_free(fdt);

You say this in the patch description already, but want to note explicitly
that this prevents double allocation for pseries-2.6 and ealier types and
not for newer machine types.

Regards,
Bharata.
