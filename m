Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA21C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC758208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xXoUhihV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC758208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfna0-0007BC-7k
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yuval.shaia@oracle.com>) id 1hfnX1-0004L9-9r
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hfnWz-0000ZL-RQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:38:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hfnWz-0000X3-I8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:38:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PFch9C026985;
 Tue, 25 Jun 2019 15:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FSPlglVOrRdME8UV5LathSA879RvzYgoT97B86S4sig=;
 b=xXoUhihVOvmSjEy8RUVE4uHinmBEfrh+3QJwwPEJWueHBDYs9qDEFnstBNGdklKuRdq8
 q++J8dL3i9BRZyRxto1aG18bsO8L+xZIECBnnFEvCge+cz2ftwKAagTKXZSkBu42tnIK
 QVGLsp7QY88ELLp4wEAOaBtBumNMYi6/mzIw2ij/tyKXZuuiNb1CzIpEtA+wwFpucAH1
 KH1tL30T5Gmzm2ib9/7Ti6V1SU36Eou4pdcPr9VcWi1p1pCM4eL7FLvaievYZrnkqDBw
 yp0nqYcnu/RvYwEcwc3VjPItTAc2LkqNbWOyJXLU3qZiDTOuXqHJL5qyY8l5pXO37DsO Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t9brt57pt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2019 15:38:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PFcS7h129036;
 Tue, 25 Jun 2019 15:38:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2t99f3xn5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2019 15:38:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5PFcf6g025042;
 Tue, 25 Jun 2019 15:38:43 GMT
Received: from lap1 (/77.138.183.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 25 Jun 2019 08:38:40 -0700
Date: Tue, 25 Jun 2019 18:38:33 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190625153830.GA10554@lap1>
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
 engine=8.0.1-1810050000 definitions=main-1906250118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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
> +        rdma_error_report("Failed to map to command slot address");
> +        return -1;
> +    }
> +    qemu_log("pvrdma_load: successfully remapped to cmd slot\n");
> +
> +    // Remap rsp slot
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

Don't forget to unregister_savevm on fini()

>  out:
>      if (rc) {
>          pvrdma_fini(pdev);
> -- 
> 2.21.0
> 
> 

