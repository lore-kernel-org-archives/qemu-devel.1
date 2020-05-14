Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AA7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EA72065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yqZLHvF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EA72065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDop-0002Wx-3y
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jZDo4-0001fF-N8
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:21:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jZDo3-0000o5-O4
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:21:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EDGjM7046553;
 Thu, 14 May 2020 13:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=P90ts0VtQ8SCuNezQKe2EtwdC06yHNRgdAwyrZ2ctAY=;
 b=yqZLHvF+Hyqhhg+dbqiWIKbVWR/gCjV3McrjTaexKQNMm2qxvTbuOrp8ABe+qPrG3fZ4
 wpRgw+fratdw1Ne4VAYpqYwmcOkvHKYI9AmvajCiBJvUwpjClBvFuy9FGqfyLLDsSxkV
 b7zIV+fil2nulCFQAPXbtSql25xsyqh4/M38VnDFx0Tz8Xa6vMZmHOjD9SnrrWPMb0ZO
 gDxw9HDk6NPtFst89mNJFJQnA9P4m3CpR13pMbFrjlf3dNp/cilzD4wP1chs4DSx3oRA
 l2CtWPB8gTwzd6Dw8wVd2qblocsxKkPPbhIG4vZzArHz7S4yQLnzt1W3Zvn7TGc/lcdm gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 3100yg2ggr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 13:21:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EDIfni166160;
 Thu, 14 May 2020 13:19:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 310vjsny59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 13:19:35 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04EDJXd2002441;
 Thu, 14 May 2020 13:19:33 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 May 2020 06:19:33 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 4F6DA696EBC3; Thu, 14 May 2020 14:19:26 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/3] megasas: avoid NULL pointer dereference
In-Reply-To: <20200513192540.1583887-3-ppandit@redhat.com>
References: <20200513192540.1583887-1-ppandit@redhat.com>
 <20200513192540.1583887-3-ppandit@redhat.com>
Date: Thu, 14 May 2020 14:19:26 +0100
Message-ID: <m2h7wik61t.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005140118
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:21:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Ding Ren <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-05-14 at 00:55:39 +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While in megasas_handle_frame(), megasas_enqueue_frame() may
> set a NULL frame into MegasasCmd object for a given 'frame_addr'
> address. Add check to avoid a NULL pointer dereference issue.
>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 6ce598cd69..b531d88a9b 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -504,7 +504,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
>      cmd->pa = frame;
>      /* Map all possible frames */
>      cmd->frame = pci_dma_map(pcid, frame, &frame_size_p, 0);
> -    if (frame_size_p != frame_size) {
> +    if (!cmd->frame || frame_size_p != frame_size) {
>          trace_megasas_qf_map_failed(cmd->index, (unsigned long)frame);
>          if (cmd->frame) {
>              megasas_unmap_frame(s, cmd);
> -- 
> 2.25.4

