Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15EAC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91612070B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DcIE4VQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91612070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3K1Q-0007DL-TT
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 08:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1i3JzW-0006G5-5O
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1i3JzV-0001rT-4i
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:57:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1i3JzU-0001qd-Tk
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:57:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCs9Ck033615;
 Thu, 29 Aug 2019 12:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=R3YQ6LntOPcdI0aOT9QG/w62HT6GR//uZ0BHGz5Joas=;
 b=DcIE4VQ0w3YQDXBrcE0yXAAAgk8vyyxJssUGaHoPsabyka7QJ18XEguc3wzhKY6TKrAo
 qDjVmu/NeO4krK5IXWl5GaZLOTQYXimc5IBnatIwjTzsNJpVDEDR8uUulafKwZOMUDz0
 NfoGQA3nrpvTnELci66/AiMuIsBWlXyP15NfCDte7Yx6K73TVng/PMUGPSAuBUP1tF2Y
 kNo/rGouczwzhlLmGy1VP4NyRYyagftRT8CBuu6zaMkUM+qUR9SjuApCWnhp3A28G19J
 uPx4BFz0vc1O1NVxk5gI0r0l7/XIJRjsEyR7Lc+0Hqgp/3tp/B2Njq1WctXztvz2dgNW 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2upeyv03c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 12:57:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCrwEV050400;
 Thu, 29 Aug 2019 12:57:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2up98supx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 12:57:26 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7TCvPIo021557;
 Thu, 29 Aug 2019 12:57:25 GMT
Received: from lap1 (/10.175.46.168) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 29 Aug 2019 05:57:24 -0700
Date: Thu, 29 Aug 2019 15:57:21 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190829125720.GD9911@lap1>
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-2-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828142328.24561-2-skrtbhtngr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH v1 1/2] hw/pvrdma: make DSR mapping
 idempotent in load_dsr()
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

On Wed, Aug 28, 2019 at 07:53:27PM +0530, Sukrit Bhatnagar wrote:
> Map to DSR only when there is no mapping done already i.e., when
> dev->dsr_info.dsr is NULL. This allows the rest of mappings and
> ring inits to be done by calling load_dsr() when DSR has already
> been mapped to, somewhere else.
> 
> Move free_dsr() out of load_dsr() and call it before the latter
> as and when needed. This aids the case where load_dsr() is called
> having DSR mapping already done, but the rest of map and init
> operations are pending, and prevents an unmap of the DSR.
> 
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>  hw/rdma/vmw/pvrdma_main.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index adcf79cd63..6c90db96f9 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -172,15 +172,15 @@ static int load_dsr(PVRDMADev *dev)
>      DSRInfo *dsr_info;
>      struct pvrdma_device_shared_region *dsr;
>  
> -    free_dsr(dev);
> -
> -    /* Map to DSR */
> -    dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
> -                              sizeof(struct pvrdma_device_shared_region));
>      if (!dev->dsr_info.dsr) {
> -        rdma_error_report("Failed to map to DSR");
> -        rc = -ENOMEM;
> -        goto out;
> +        /* Map to DSR */
> +        dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
> +                                  sizeof(struct pvrdma_device_shared_region));
> +        if (!dev->dsr_info.dsr) {
> +            rdma_error_report("Failed to map to DSR");
> +            rc = -ENOMEM;
> +            goto out;
> +        }
>      }
>  
>      /* Shortcuts */
> @@ -402,6 +402,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
>      case PVRDMA_REG_DSRHIGH:
>          trace_pvrdma_regs_write(addr, val, "DSRHIGH", "");
>          dev->dsr_info.dma |= val << 32;
> +        free_dsr(dev);
>          load_dsr(dev);
>          init_dsr_dev_caps(dev);
>          break;

LGTM, thanks.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> -- 
> 2.21.0
> 
> 

