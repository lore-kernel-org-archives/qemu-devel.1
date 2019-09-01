Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC684C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 09:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936052339D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BNqP2/Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936052339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4MHG-0003Al-QI
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 05:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1i4MGW-0002eb-73
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1i4MGU-0006eU-QC
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:35:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1i4MGU-0006cz-Hf
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 05:35:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x819YSKv100850;
 Sun, 1 Sep 2019 09:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zwV3MHBreaOuq2IXlLh7TFDAYTcJ0XZ9W78Y0hXR5bM=;
 b=BNqP2/Av/bJjP9VTTv+rCxkun4EzwPpqc+yB7McFAKtvjg9ekgyz+DguaUeLsm5ZUWy5
 UxrluaIML3aR381smPvHq5UGfboT38yyA/HHWUFsv5DqOEZenopKWSOQBfGv28pS+eUT
 64A7J5bGQOAfTCoAupGaxNaXAIyw2yE2c3a7IkSWJrJhqAT4HfpJdgjq1cPlfY08675r
 n1eakSOIo+c4dbZlcjI3i61fQsNjsakoT6WgDGQgC5LAsqbpW9RVCpVTZRvS5TIZSJMC
 oqLdk+k7SGyKLUCyn5UtI+WDLmqArO25XVOIyJz2KM9G5+B8oLPCVfknx8N/xtjOaZqB gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2urbf3r03y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 01 Sep 2019 09:35:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x819XIpi142635;
 Sun, 1 Sep 2019 09:35:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2uqgqjjsf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 01 Sep 2019 09:35:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x819ZDk8020295;
 Sun, 1 Sep 2019 09:35:13 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 01 Sep 2019 02:35:13 -0700
Date: Sun, 1 Sep 2019 12:35:09 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190901093509.GC16041@lap1>
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-3-skrtbhtngr@gmail.com>
 <710966e9-d1ac-3c55-0a12-02ff19005531@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710966e9-d1ac-3c55-0a12-02ff19005531@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9366
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010112
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 31, 2019 at 10:45:44PM +0300, Marcel Apfelbaum wrote:
> 
> 
> On 8/28/19 5:23 PM, Sukrit Bhatnagar wrote:
> > vmstate_pvrdma describes the PCI and MSIX states as well as the dma
> > address for dsr and the gid table of device.
> > vmstate_pvrdma_gids describes each gid in the gid table.
> > 
> > pvrdma_post_save() does the job of unregistering gid entries from the
> > backend device in the source host.
> > 
> > pvrdma_post_load() maps to dsr using the loaded dma address, registers
> > each loaded gid into the backend device, and finally calls load_dsr()
> > to perform other mappings and ring init operations.
> > 
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > ---
> >   hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 77 insertions(+)
> > 
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index 6c90db96f9..6f8b56dea3 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -28,6 +28,7 @@
> >   #include "sysemu/sysemu.h"
> >   #include "monitor/monitor.h"
> >   #include "hw/rdma/rdma.h"
> > +#include "migration/register.h"
> >   #include "../rdma_rm.h"
> >   #include "../rdma_backend.h"
> > @@ -593,6 +594,81 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> >       pvrdma_fini(pci_dev);
> >   }
> > +static int pvrdma_post_save(void *opaque)
> > +{
> > +    int i, rc;
> > +    PVRDMADev *dev = opaque;
> > +
> > +    for (i = 0; i < MAX_GIDS; i++) {
> > +
> 
> No need for the extra line
> > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > +            continue;
> > +        }
> > +        rc = rdma_backend_del_gid(&dev->backend_dev,
> > +                                   dev->backend_eth_device_name,
> > +                                   &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > +        if (rc) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int pvrdma_post_load(void *opaque, int version_id)
> > +{
> > +    int i, rc;
> > +    PVRDMADev *dev = opaque;
> > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > +    DSRInfo *dsr_info = &dev->dsr_info;
> > +
> > +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> > +                                sizeof(struct pvrdma_device_shared_region));
> > +    if (!dsr_info->dsr) {
> > +        rdma_error_report("Failed to map to DSR");
> > +        return -ENOMEM;
> > +    }
> > +
> > +    for (i = 0; i < MAX_GIDS; i++) {
> > +
> 
> The same here
> 
> > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > +            continue;
> > +        }
> > +
> > +        rc = rdma_backend_add_gid(&dev->backend_dev,
> > +                                  dev->backend_eth_device_name,
> > +                                  &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > +        if (rc) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    return load_dsr(dev);
> > +}
> > +
> > +static const VMStateDescription vmstate_pvrdma_gids = {
> > +    .name = "pvrdma-gids",
> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_UINT8_ARRAY_V(gid.raw, RdmaRmGid, 16, 0),
> 
> Is 16 the array length? If yes, do we have same macro definition?
> 
> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_pvrdma = {
> > +    .name = PVRDMA_HW_NAME,
> > +    .post_save = pvrdma_post_save,
> > +    .post_load = pvrdma_post_load,
> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> > +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> > +            VMSTATE_UINT64(dsr_info.dma, PVRDMADev),
> > +            VMSTATE_STRUCT_ARRAY(rdma_dev_res.port.gid_tbl, PVRDMADev,
> > +                                 MAX_PORT_GIDS, 0, vmstate_pvrdma_gids,
> > +                                 RdmaRmGid),
> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >   static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >   {
> >       int rc = 0;
> > @@ -688,6 +764,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
> >       dc->desc = "RDMA Device";
> >       dc->props = pvrdma_dev_properties;
> > +    dc->vmsd = &vmstate_pvrdma;
> >       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> >       ir->print_statistics = pvrdma_print_statistics;
> 
> Very simple an elegant.
> If I understand correctly the live migration of a pvrdma device with no
> active workloads works with this patch, right?

And no QPs also.

> If yes, I think we should consider merging this code already.
> Yuval, do you agree?

Sure i do!
Even with the limitation, this is huge enhancement that can be used right
away.

But first suggested some fixes, let's see v2.

> 
> Thanks,
> Marcel
> 
> 

