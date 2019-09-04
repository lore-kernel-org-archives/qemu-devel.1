Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3EEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B587920820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j17HyTYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B587920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5NVO-0003FJ-TX
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 01:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1i5NTU-0001kz-Up
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1i5NTS-0006nb-VH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:04:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1i5NTS-0006lu-GD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:04:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8453whm062186;
 Wed, 4 Sep 2019 05:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=qETKlptniUtACCoeU1xsv99VVjPFQpUGFsW5eVSA85s=;
 b=j17HyTYmaA0/zTP2JB1kVRerAAewKlDVA9EQdUGRcmdQ4wTQDQlqFiIjdrYrqzy8c1pR
 DHixNiL1vxaIJp+WihIvPjxT5KRSrPdzCaDKzTyILaavdF9RdquXX/+z7VW1rrV/UH1D
 slhZ194djcCJvAmei09DOz3Ts0gE4ZGHpHyGx90Dv+hOap6sEu2FovlbAMFi7AaoYJeD
 KhWMcYNcwsqU6nZkFUjISOtQcTTb1tlW+76RL+Jg06tHzgRUUSlZ7dSu97pxTBQqiyyh
 +73t5zeZzGfiiRZyNO/HiHISvHsQ5YLJvPhc5RHzCVmT1PCay+680orTe1LHt46+fmEd Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2ut6rgg0nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2019 05:04:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8453n69091577;
 Wed, 4 Sep 2019 05:04:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2usu51cxud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2019 05:04:48 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8454mjx032079;
 Wed, 4 Sep 2019 05:04:48 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 22:04:47 -0700
Date: Wed, 4 Sep 2019 08:04:43 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190904050442.GA2844@lap1>
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-3-skrtbhtngr@gmail.com>
 <20190829125313.GB9911@lap1>
 <CAMzgYoO24uhNUg_4RTVkw0JZ1Eerwyd549GX8T82M_18eUp8fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzgYoO24uhNUg_4RTVkw0JZ1Eerwyd549GX8T82M_18eUp8fA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040053
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH v1 2/2] hw/pvrdma: add live migration
 support
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

On Wed, Sep 04, 2019 at 03:03:20AM +0530, Sukrit Bhatnagar wrote:
> On Thu, 29 Aug 2019 at 18:23, Yuval Shaia <yuval.shaia@oracle.com> wrote:
> >
> > On Wed, Aug 28, 2019 at 07:53:28PM +0530, Sukrit Bhatnagar wrote:
> > > vmstate_pvrdma describes the PCI and MSIX states as well as the dma
> > > address for dsr and the gid table of device.
> > > vmstate_pvrdma_gids describes each gid in the gid table.
> > >
> > > pvrdma_post_save() does the job of unregistering gid entries from the
> > > backend device in the source host.
> > >
> > > pvrdma_post_load() maps to dsr using the loaded dma address, registers
> > > each loaded gid into the backend device, and finally calls load_dsr()
> > > to perform other mappings and ring init operations.
> >
> > I think it worth to mention that the dma address is kept in driver/device
> > shared memory (dsr->dma) which is migrated as part of memory migration and
> > it is out of the scope of this change and so we do not need to save/load
> > the dma address during migration.
> >
> > Also you should specifically comment that this migration-support does not
> > includes QP migration. This means that support for life migration *during*
> > traffic is not yet supported.
> >
> > >
> > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Cc: Yuval Shaia <yuval.shaia@oracle.com>
> > > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > > ---
> > >  hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 77 insertions(+)
> > >
> > > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > > index 6c90db96f9..6f8b56dea3 100644
> > > --- a/hw/rdma/vmw/pvrdma_main.c
> > > +++ b/hw/rdma/vmw/pvrdma_main.c
> > > @@ -28,6 +28,7 @@
> > >  #include "sysemu/sysemu.h"
> > >  #include "monitor/monitor.h"
> > >  #include "hw/rdma/rdma.h"
> > > +#include "migration/register.h"
> > >
> > >  #include "../rdma_rm.h"
> > >  #include "../rdma_backend.h"
> > > @@ -593,6 +594,81 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> > >      pvrdma_fini(pci_dev);
> > >  }
> > >
> > > +static int pvrdma_post_save(void *opaque)
> > > +{
> > > +    int i, rc;
> > > +    PVRDMADev *dev = opaque;
> > > +
> > > +    for (i = 0; i < MAX_GIDS; i++) {
> > > +
> >
> > Empty line is redundant here.
> >
> > > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > > +            continue;
> > > +        }
> > > +        rc = rdma_backend_del_gid(&dev->backend_dev,
> > > +                                   dev->backend_eth_device_name,
> > > +                                   &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > > +        if (rc) {
> > > +            return -EINVAL;
> >
> > Some error report will help here i guess.
> 
> rdma_backend_del_gid() already generates an error report
> when rc isn't 0.
> 
> Adding another statement for the same seems redundant.

Sure, make sense.

> 
> > > +        }
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int pvrdma_post_load(void *opaque, int version_id)
> > > +{
> > > +    int i, rc;
> > > +    PVRDMADev *dev = opaque;
> > > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > > +    DSRInfo *dsr_info = &dev->dsr_info;
> > > +
> > > +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> > > +                                sizeof(struct pvrdma_device_shared_region));
> > > +    if (!dsr_info->dsr) {
> > > +        rdma_error_report("Failed to map to DSR");
> > > +        return -ENOMEM;
> > > +    }
> > > +
> > > +    for (i = 0; i < MAX_GIDS; i++) {
> > > +
> >
> > Empty line is redundant here.
> >
> > > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > > +            continue;
> > > +        }
> > > +
> > > +        rc = rdma_backend_add_gid(&dev->backend_dev,
> > > +                                  dev->backend_eth_device_name,
> > > +                                  &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > > +        if (rc) {
> > > +            return -EINVAL;
> > > +        }
> > > +    }
> > > +
> > > +    return load_dsr(dev);
> 
> Now that I will move load_dsr() before the del_gid loop,

You probably meant before add_gid loop.

> I can use goto jumps on exit/error paths, so that I can
> undo load_dsr if any del_gid fails.

Yeah, it will be easier to undo load_dsr than add_gid.

> 
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_pvrdma_gids = {
> > > +    .name = "pvrdma-gids",
> > > +    .fields = (VMStateField[]) {
> > > +            VMSTATE_UINT8_ARRAY_V(gid.raw, RdmaRmGid, 16, 0),
> > > +            VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static const VMStateDescription vmstate_pvrdma = {
> > > +    .name = PVRDMA_HW_NAME,
> > > +    .post_save = pvrdma_post_save,
> > > +    .post_load = pvrdma_post_load,
> > > +    .fields = (VMStateField[]) {
> > > +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> > > +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> > > +            VMSTATE_UINT64(dsr_info.dma, PVRDMADev),
> > > +            VMSTATE_STRUCT_ARRAY(rdma_dev_res.port.gid_tbl, PVRDMADev,
> > > +                                 MAX_PORT_GIDS, 0, vmstate_pvrdma_gids,
> > > +                                 RdmaRmGid),
> > > +            VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > >  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> > >  {
> > >      int rc = 0;
> > > @@ -688,6 +764,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
> > >
> > >      dc->desc = "RDMA Device";
> > >      dc->props = pvrdma_dev_properties;
> > > +    dc->vmsd = &vmstate_pvrdma;
> > >      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> > >
> > >      ir->print_statistics = pvrdma_print_statistics;
> > > --
> > > 2.21.0
> > >
> > >

