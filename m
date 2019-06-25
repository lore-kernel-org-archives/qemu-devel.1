Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B6C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D37208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CbecMq1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D37208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnaB-0007N2-Vs
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33196)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yuval.shaia@oracle.com>) id 1hfnRb-0007f7-SK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hfnRa-0003nO-IQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:33:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hfnRa-0003iR-9j
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:33:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PFIZ95112723;
 Tue, 25 Jun 2019 15:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=giQLjB4r70OrOQgwF2ArWb04iuzHkVajgXm3mrAXfFY=;
 b=CbecMq1OBLZlP8ZIm4ik49Yz8ilam2Z2DRVgSchjVrC/U+ZRlhgJZWYc+apral4d5GRu
 ZoH9DdBRX64C9otwu8/ul4sS+5VeXrPPlP6xf2EvyTEpT/Z5NePzFPNPfEUhPVd9/96P
 eEL4GYMoWD3uNf/B/HZU1CMGNh3BbWfx9QUgdjZ2UFo70nf+vIFOUgL7b80D3suHjqeh
 bAa7A+/owS3MkFBFkpjy3E1/muPDUkbSl1DPxhIh9MqUrEcOPpe8NDPk84fw96sTfjh0
 VGsRzRMuc0mf5mljI8WWp59bwycKt7aiAfxsUoxDpjo7PiuVSdLhQWwJg4bXyUHeBGLc bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t9c9pn45u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2019 15:33:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PFWiji109348;
 Tue, 25 Jun 2019 15:33:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t9p6u8hnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2019 15:33:05 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PFX4xP004583;
 Tue, 25 Jun 2019 15:33:04 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 25 Jun 2019 08:33:03 -0700
Date: Tue, 25 Jun 2019 18:32:55 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190625153253.GA10458@lap1>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <20190621144541.13770-2-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621144541.13770-2-skrtbhtngr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC 1/1] hw/pvrdma: Add live migration support
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

On Fri, Jun 21, 2019 at 08:15:41PM +0530, Sukrit Bhatnagar wrote:
> Define and register SaveVMHandlers pvrdma_save and
> pvrdma_load for saving and loading the device state,
> which currently includes only the dma, command slot
> and response slot addresses.
> 
> Remap the DSR, command slot and response slot upon
> loading the addresses in the pvrdma_load function.
> 
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>  hw/rdma/vmw/pvrdma_main.c | 56 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index adcf79cd63..cd8573173c 100644
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
> @@ -592,9 +593,62 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
>      pvrdma_fini(pci_dev);
>  }
>  
> +static void pvrdma_save(QEMUFile *f, void *opaque)
> +{
> +    PVRDMADev *dev = PVRDMA_DEV(opaque);
> +
> +    qemu_put_be64(f, dev->dsr_info.dma);
> +    qemu_put_be64(f, dev->dsr_info.dsr->cmd_slot_dma);
> +    qemu_put_be64(f, dev->dsr_info.dsr->resp_slot_dma);
> +}
> +
> +static int pvrdma_load(QEMUFile *f, void *opaque, int version_id)
> +{
> +    PVRDMADev *dev = PVRDMA_DEV(opaque);
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +
> +    // Remap DSR
> +    dev->dsr_info.dma = qemu_get_be64(f);
> +    dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
> +                                    sizeof(struct pvrdma_device_shared_region));
> +    if (!dev->dsr_info.dsr) {
> +        rdma_error_report("Failed to map to DSR");
> +        return -1;
> +    }
> +    qemu_log("pvrdma_load: successfully remapped to DSR\n");
> +
> +    // Remap cmd slot
> +    dev->dsr_info.dsr->cmd_slot_dma = qemu_get_be64(f);
> +    dev->dsr_info.req = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->cmd_slot_dma,
> +                                     sizeof(union pvrdma_cmd_req));
> +    if (!dev->dsr_info.req) {

So this is where you hit the error, right?
All looks good to me, i wonder why the first pci_dma_map works fine but
second fails where the global BounceBuffer is marked as used.

Anyone?

> +        rdma_error_report("Failed to map to command slot address");
> +        return -1;
> +    }
> +    qemu_log("pvrdma_load: successfully remapped to cmd slot\n");
> +
> +    // Remap rsp slot

btw, this is RFC so we are fine but try to avoid such way of comments.

> +    dev->dsr_info.dsr->resp_slot_dma = qemu_get_be64(f);
> +    dev->dsr_info.rsp = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->resp_slot_dma,
> +                                     sizeof(union pvrdma_cmd_resp));
> +    if (!dev->dsr_info.rsp) {
> +        rdma_error_report("Failed to map to response slot address");
> +        return -1;
> +    }
> +    qemu_log("pvrdma_load: successfully remapped to rsp slot\n");
> +
> +    return 0;
> +}
> +
> +static SaveVMHandlers savevm_pvrdma = {
> +    .save_state = pvrdma_save,
> +    .load_state = pvrdma_load,
> +};
> +
>  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>  {
>      int rc = 0;
> +    DeviceState *s = DEVICE(pdev);
>      PVRDMADev *dev = PVRDMA_DEV(pdev);
>      Object *memdev_root;
>      bool ram_shared = false;
> @@ -666,6 +720,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>      dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
>      qemu_register_shutdown_notifier(&dev->shutdown_notifier);
>  
> +    register_savevm_live(s, "pvrdma", -1, 1, &savevm_pvrdma, dev);
> +
>  out:
>      if (rc) {
>          pvrdma_fini(pdev);
> -- 
> 2.21.0
> 
> 

