Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C8C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0919D233FF
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pMna4PZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0919D233FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Jzk-0006HV-7e
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 08:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1i3Jyw-0005sj-PC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1i3Jyv-0001JK-FC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:56:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1i3Jyv-0001I8-6U
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:56:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCs9Nd039285;
 Thu, 29 Aug 2019 12:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=quSTKCSkODREe2s9wzr3owE5Gu9o2LdrmZywxbmWh3o=;
 b=pMna4PZzYJSzExk/0h3F/Hf0bfH11uMSSRqxClqxlCWx5tomH/xt+5a/hZ+Nv6CvGXmH
 lV1PyNCykR5ExVC2JfJjleWmaG+l8hlPijp9TntIzpCGbvyQJYahlTDeHXCop+SM/w5d
 cfji7Y0voAYu6oYQN1Abi8pSS/xuWZEvlk28O+zV4che4qRIfUHkgg8q3JWdMJgYV3L+
 NdoqbOvvS3jMLs4R6Wyxgz4bJe/ikpBS3tS/W2Xn9G8EIj5MMNAeajXgib71OGkHXFaL
 fPzwS6LFCVaSDXHzGovOtXySTlNXyHqsR+s3T3KHdaCYZTSrzUJdtZ8yzsm+31XmzAwc pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2upeyfg4u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 12:56:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCrqIV096528;
 Thu, 29 Aug 2019 12:56:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2unvtywy46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 12:56:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7TCuo3l021126;
 Thu, 29 Aug 2019 12:56:50 GMT
Received: from lap1 (/10.175.46.168) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 29 Aug 2019 05:56:49 -0700
Date: Thu, 29 Aug 2019 15:56:46 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190829125645.GC9911@lap1>
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-3-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828142328.24561-3-skrtbhtngr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290142
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

On Wed, Aug 28, 2019 at 07:53:28PM +0530, Sukrit Bhatnagar wrote:
> vmstate_pvrdma describes the PCI and MSIX states as well as the dma
> address for dsr and the gid table of device.
> vmstate_pvrdma_gids describes each gid in the gid table.
> 
> pvrdma_post_save() does the job of unregistering gid entries from the
> backend device in the source host.
> 
> pvrdma_post_load() maps to dsr using the loaded dma address, registers
> each loaded gid into the backend device, and finally calls load_dsr()
> to perform other mappings and ring init operations.
> 
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>  hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 6c90db96f9..6f8b56dea3 100644
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
> @@ -593,6 +594,81 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
>      pvrdma_fini(pci_dev);
>  }
>  
> +static int pvrdma_post_save(void *opaque)
> +{
> +    int i, rc;
> +    PVRDMADev *dev = opaque;
> +
> +    for (i = 0; i < MAX_GIDS; i++) {
> +
> +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> +            continue;
> +        }
> +        rc = rdma_backend_del_gid(&dev->backend_dev,
> +                                   dev->backend_eth_device_name,
> +                                   &dev->rdma_dev_res.port.gid_tbl[i].gid);
> +        if (rc) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int pvrdma_post_load(void *opaque, int version_id)
> +{
> +    int i, rc;
> +    PVRDMADev *dev = opaque;
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +    DSRInfo *dsr_info = &dev->dsr_info;
> +
> +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> +                                sizeof(struct pvrdma_device_shared_region));
> +    if (!dsr_info->dsr) {
> +        rdma_error_report("Failed to map to DSR");
> +        return -ENOMEM;
> +    }
> +
> +    for (i = 0; i < MAX_GIDS; i++) {
> +
> +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> +            continue;
> +        }
> +
> +        rc = rdma_backend_add_gid(&dev->backend_dev,
> +                                  dev->backend_eth_device_name,
> +                                  &dev->rdma_dev_res.port.gid_tbl[i].gid);
> +        if (rc) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return load_dsr(dev);

This check is better performed before any gid manipulation on the host
because no one will undo it if load_dsr fails.

> +}
> +
> +static const VMStateDescription vmstate_pvrdma_gids = {
> +    .name = "pvrdma-gids",
> +    .fields = (VMStateField[]) {
> +            VMSTATE_UINT8_ARRAY_V(gid.raw, RdmaRmGid, 16, 0),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_pvrdma = {
> +    .name = PVRDMA_HW_NAME,
> +    .post_save = pvrdma_post_save,
> +    .post_load = pvrdma_post_load,
> +    .fields = (VMStateField[]) {
> +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> +            VMSTATE_UINT64(dsr_info.dma, PVRDMADev),
> +            VMSTATE_STRUCT_ARRAY(rdma_dev_res.port.gid_tbl, PVRDMADev,
> +                                 MAX_PORT_GIDS, 0, vmstate_pvrdma_gids,
> +                                 RdmaRmGid),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>  {
>      int rc = 0;
> @@ -688,6 +764,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
>  
>      dc->desc = "RDMA Device";
>      dc->props = pvrdma_dev_properties;
> +    dc->vmsd = &vmstate_pvrdma;
>      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>  
>      ir->print_statistics = pvrdma_print_statistics;
> -- 
> 2.21.0
> 
> 

