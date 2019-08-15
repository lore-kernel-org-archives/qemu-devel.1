Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74A6C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F2E21744
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OdqokE6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F2E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyDSN-0008K4-L4
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 06:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia@oracle.com>) id 1hyDRZ-0007t2-Jg
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia@oracle.com>) id 1hyDRY-0003ii-7m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:57:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
 id 1hyDRX-0003hI-KS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:57:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FAsF47103255;
 Thu, 15 Aug 2019 10:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=aWutlwqDGeNEgNoCYYW8OGnS+3UrdZI1k4FVmY3UnlI=;
 b=OdqokE6jPc0Qf+TdvL+rcruzu1wJj3sJTnEKI9F8osKVrEZj1yxndjahWzD0EptkrSQY
 z/+ZK4g26ZDPB4pFEoGTTMM9Qu+UuCqFx19DcOo/ET2ThSjrSkivMryhvcdNlMW6gThe
 vJe6Mw/MNVrNYCJ7oiglXsjFfK1FeDHYpvAAOyGMu7ox6L0wwDgbbgbAaJhAq77TSL9Z
 TBMy+AnuHlPKE+/eHfU1toW9w5dF9Ht1VTmyhxE9BKs8r5IBzKvqJ+7cneJ2J0/ZAXJy
 kPLOCeN4A2ysx7ZdAO26zQcN0iBlq7j2b5LFsq3djm8JNKIvS/bwlQA2KgMfQjPdDWBs 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2u9nbtt704-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 10:57:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FAsEMo137841;
 Thu, 15 Aug 2019 10:57:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2ucmwjjf3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 10:57:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7FAvCUv008328;
 Thu, 15 Aug 2019 10:57:13 GMT
Received: from lap1 (/218.189.35.1) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Aug 2019 03:57:12 -0700
Date: Thu, 15 Aug 2019 13:57:05 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Stephen Kitt <steve@sk2.org>
Message-ID: <20190815105704.GA3018@lap1>
References: <20190811194247.9861-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811194247.9861-1-steve@sk2.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH] Fix hw/rdma/vmw/pvrdma_cmd.c build
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

On Sun, Aug 11, 2019 at 09:42:47PM +0200, Stephen Kitt wrote:
> This was broken by the cherry-pick in 41dd30f. Fix by handling errors
> as in the rest of the function: "goto out" instead of "return rc".
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index bb9a9f1cd1..a3a86d7c8e 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -514,7 +514,7 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>                                       cmd->recv_cq_handle, rings, &resp->qpn);
>      if (resp->hdr.err) {
>          destroy_qp_rings(rings);
> -        return rc;
> +        goto out;

This label was removed, can you please check master branch?

>      }
>  
>      resp->max_send_wr = cmd->max_send_wr;
> -- 
> 2.20.1
> 
> 

