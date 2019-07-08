Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6961CC48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 05:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DB020651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 05:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QSAxz4wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DB020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkLzN-00040x-8G
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 01:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yuval.shaia@oracle.com>) id 1hkLyM-0003Z0-2w
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 01:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hkLyK-0003yQ-LZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 01:13:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hkLyK-0003wu-Bw
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 01:13:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x685DchH155572;
 Mon, 8 Jul 2019 05:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bKpHI3iHiimOh+WP1IiqFKrgV4gWcpStEG+H2R2hG/s=;
 b=QSAxz4wZXrUTrbN3MJ0XjGWmfRTsyA0vE4nb2thhPW3ttStgGCHO8rkFzuOYyYsDREMX
 PiXOvA6Ttw8/coe+HyHsq2ME5+5IlKpdiHen3CqKnlUUySyAiJqCUVT09mFHFTdghv18
 zCe3/P8XgVKEOFMjEI3NBzABEbC2iiWaIaTI3eDuziw/haR2+xW5lNy7x/bYM6jOmowb
 KSEj60LwDZiOYa+NKzPNbI+oJSE4hTmCbaSSJU5OF6F9EDEyK76GUxgvWcxnK/rnWG/q
 q9zzwXFedFJJlBjwUWPc83peaw27VkNjXWaNtUefMSzl8k1Df90UziCD1LAmCSba0TwG kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2tjm9qc2nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2019 05:13:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x685CsAI007646;
 Mon, 8 Jul 2019 05:13:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2tjgrtanxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2019 05:13:47 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x685Dkms008724;
 Mon, 8 Jul 2019 05:13:47 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 07 Jul 2019 22:13:45 -0700
Date: Mon, 8 Jul 2019 08:13:39 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190708051338.GA5441@lap1>
References: <20190706040940.7884-1-skrtbhtngr@gmail.com>
 <20190706040940.7884-3-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706040940.7884-3-skrtbhtngr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [RFC v2 2/2] hw/pvrdma: add live migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 06, 2019 at 09:39:40AM +0530, Sukrit Bhatnagar wrote:
> Use VMStateDescription for migrating device state. Currently,

What do you mean by 'Currently'?

> 'vmstate_pvrdma' describes the PCI and MSIX state for pvrdma and
> 'vmstate_pvrdma_dsr_dma' describes a temporary state containing
> some values obtained only after mapping to dsr in the source.
> Since the dsr will not be available on dest until we map to the
> dma address we had on source, these values cannot be migrated
> directly.
> 
> Add PVRDMAMigTmp to store this temporary state which consists of
> dma addresses and ring page information. The 'parent' member is
> used to refer to the device state (PVRDMADev) so that parent PCI
> device object is accessible, which is needed to remap to DSR.
> 
> pvrdma_dsr_dma_pre_save() saves the dsr state into this temporary
> representation and pvrdma_dsr_dma_post_load() loads it back.
> This load function also remaps to the dsr and and calls
> load_dsr() for further map and ring init operations.
> 
> Please note that this call to load_dsr() can be removed from the
> migration flow and included in pvrdma_regs_write() to perform a
> lazy load.

The lazy load was suggested to overcome a potential problem with mapping to
addresses while still in migration process. With that been solved i would
suggest to drop the idea of lazy load.

> As of now, migration will fail if there in an error in load_dsr().
> Also, there might be a considerable amount of pages in the rings,
> which will have dma map operations when the init functions are
> called.
> If this takes noticeable time, it might be better to have lazy
> load instead.

Yeah, make sense but i hope we will not get to this.

> 
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>  hw/rdma/vmw/pvrdma_main.c | 87 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 6c90db96f9..4a10bd2fc7 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/sysemu.h"
>  #include "monitor/monitor.h"
>  #include "hw/rdma/rdma.h"
> +#include "migration/register.h"
>  
>  #include "../rdma_rm.h"
>  #include "../rdma_backend.h"
> @@ -593,6 +594,91 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
>      pvrdma_fini(pci_dev);
>  }
>  
> +struct PVRDMAMigTmp {
> +    PVRDMADev *parent;
> +    uint64_t dma;
> +    uint64_t cmd_slot_dma;
> +    uint64_t resp_slot_dma;
> +    uint32_t cq_ring_pages_num_pages;
> +    uint64_t cq_ring_pages_pdir_dma;
> +    uint32_t async_ring_pages_num_pages;
> +    uint64_t async_ring_pages_pdir_dma;
> +};
> +
> +static int pvrdma_dsr_dma_pre_save(void *opaque)
> +{
> +    struct PVRDMAMigTmp *tmp = opaque;

For me tmp sounds like a very bad name, if it is the convention then i can
live with that, anyways suggesting something like mig_tmp_info or something
like that.

> +    DSRInfo *dsr_info = &tmp->parent->dsr_info;

Can you shad some light on how the parent field is initialized with the
pointer to the device object?

> +    struct pvrdma_device_shared_region *dsr = dsr_info->dsr;
> +
> +    tmp->dma = dsr_info->dma;
> +    tmp->cmd_slot_dma = dsr->cmd_slot_dma;
> +    tmp->resp_slot_dma = dsr->resp_slot_dma;
> +    tmp->cq_ring_pages_num_pages = dsr->cq_ring_pages.num_pages;
> +    tmp->cq_ring_pages_pdir_dma = dsr->cq_ring_pages.pdir_dma;
> +    tmp->async_ring_pages_num_pages = dsr->async_ring_pages.num_pages;
> +    tmp->async_ring_pages_pdir_dma = dsr->async_ring_pages.pdir_dma;
> +
> +    return 0;
> +}
> +
> +static int pvrdma_dsr_dma_post_load(void *opaque, int version_id)
> +{
> +    struct PVRDMAMigTmp *tmp = opaque;
> +    PVRDMADev *dev = tmp->parent;
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +    DSRInfo *dsr_info = &dev->dsr_info;
> +    struct pvrdma_device_shared_region *dsr;
> +
> +    dsr_info->dma = tmp->dma;
> +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> +                                sizeof(struct pvrdma_device_shared_region));
> +    if (!dsr_info->dsr) {
> +        rdma_error_report("Failed to map to DSR");
> +        return -ENOMEM;

Will this cause the VM on source host to continue functioning besides
failing the migration?

> +    }
> +
> +    dsr = dsr_info->dsr;
> +    dsr->cmd_slot_dma = tmp->cmd_slot_dma;
> +    dsr->resp_slot_dma = tmp->resp_slot_dma;
> +    dsr->cq_ring_pages.num_pages = tmp->cq_ring_pages_num_pages;
> +    dsr->cq_ring_pages.pdir_dma = tmp->cq_ring_pages_pdir_dma;
> +    dsr->async_ring_pages.num_pages = tmp->async_ring_pages_num_pages;
> +    dsr->async_ring_pages.pdir_dma = tmp->async_ring_pages_pdir_dma;

I expect the above 6 fields to be already populated with the correct values
as we just map to driver's DSR that should be migrated as part of memory
copy of source to dest host.
Can you verify it and if my assumptions are correct to remove these
assignments (and the corresponding from pre_save)?

> +
> +    return load_dsr(dev);
> +}
> +
> +static const VMStateDescription vmstate_pvrdma_dsr_dma = {
> +    .name = "pvrdma-dsr-dma",
> +    .pre_save = pvrdma_dsr_dma_pre_save,
> +    .post_load = pvrdma_dsr_dma_post_load,

I'm looking for a hook that is triggered just before leaving the source
host so we can do some needed cleanups such as unmapping the DSR, removing
IP addresses from the host etc.

> +    .fields = (VMStateField[]) {
> +            VMSTATE_UINT64(dma, struct PVRDMAMigTmp),
> +            VMSTATE_UINT64(cmd_slot_dma, struct PVRDMAMigTmp),
> +            VMSTATE_UINT64(resp_slot_dma, struct PVRDMAMigTmp),
> +            VMSTATE_UINT32(async_ring_pages_num_pages, struct PVRDMAMigTmp),
> +            VMSTATE_UINT64(async_ring_pages_pdir_dma, struct PVRDMAMigTmp),
> +            VMSTATE_UINT32(cq_ring_pages_num_pages, struct PVRDMAMigTmp),
> +            VMSTATE_UINT64(cq_ring_pages_pdir_dma, struct PVRDMAMigTmp),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_pvrdma = {
> +    .name = "pvrdma",

Suggesting to use the already defined constant PVRDMA_HW_NAME.

> +    .version_id = 1,
> +    .minimum_version_id = 1,

Hmmm...interesting, what's the use of these fields?

> +    .fields = (VMStateField[]) {
> +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> +            VMSTATE_WITH_TMP(PVRDMADev,
> +                             struct PVRDMAMigTmp,
> +                             vmstate_pvrdma_dsr_dma),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>  {
>      int rc = 0;
> @@ -688,6 +774,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
>  
>      dc->desc = "RDMA Device";
>      dc->props = pvrdma_dev_properties;
> +    dc->vmsd = &vmstate_pvrdma;
>      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);

Besides the above comments looks like a great job, thanks!

>  
>      ir->print_statistics = pvrdma_print_statistics;
> -- 
> 2.21.0
> 
> 

