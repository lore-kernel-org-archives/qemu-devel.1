Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD701C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833522065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X77pgnlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833522065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDmz-0000hB-Lk
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jZDm9-0008Vo-ET
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:19:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jZDm7-0008WE-9C
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:19:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EDH9dT147341;
 Thu, 14 May 2020 13:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=34+SX/BZZRdw/zhcsNKJLvomIh/0bKQmaEkMLzsqcOQ=;
 b=X77pgnlcHZhfOcvI+wN1p+oRzhTl62qtUHNMaaFOp89hvTvyEMLF6d3h25D047uf+CLY
 i7z6VHvn3azRMiIG8IP+2QPDJPSatwbKfohHn5pk0IcQadxhvwN+7s4Vuao+3Bb5rZRy
 u024G6sLYO3h6jglqV5KgsIHLcaOLQ8XbvyifNWSmfz47hD9sNbdFOSxtlz5DY1GXgfD
 STse/PbfRL0x4VzhBCi3Kst89h0VPRUs50yogcD0LzNkTBdvhI1ieJD00k/+x2gCo6yG
 FPdK6dlgVTGJaUIjoeCM2LkJfLC1+mmh3hQwKMnc1wulbI8V9n0+P8kjDNyhsVUNNnRV +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 3100xwteqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 13:19:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EDIfmu144259;
 Thu, 14 May 2020 13:19:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 3100yp9eyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 13:19:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04EDJGdL015689;
 Thu, 14 May 2020 13:19:16 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 May 2020 06:19:16 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 52611696EBB4; Thu, 14 May 2020 14:19:08 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/3] megasas: use unsigned type for reply_queue_head
 and check index
In-Reply-To: <20200513192540.1583887-2-ppandit@redhat.com>
References: <20200513192540.1583887-1-ppandit@redhat.com>
 <20200513192540.1583887-2-ppandit@redhat.com>
Date: Thu, 14 May 2020 14:19:08 +0100
Message-ID: <m2k11ek62b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005140118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140118
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:19:43
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Prasad,

On Thursday, 2020-05-14 at 00:55:38 +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> A guest user may set 'reply_queue_head' field of MegasasState to
> a negative value. Later in 'megasas_lookup_frame' it is used to
> index into s->frames[] array. Use unsigned type to avoid OOB
> access issue.
>
> Also check that 'index' value stays within s->frames[] bounds
> through the while() loop in 'megasas_lookup_frame' to avoid OOB
> access.
>
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/megasas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Update v1 -> v2: fix OOB access when index > MEGASAS_MAX_FRAMES(=2048)
>  -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03131.html
>
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index af18c88b65..6ce598cd69 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -112,7 +112,7 @@ typedef struct MegasasState {
>      uint64_t reply_queue_pa;
>      void *reply_queue;
>      int reply_queue_len;
> -    int reply_queue_head;
> +    uint16_t reply_queue_head;
>      int reply_queue_tail;
>      uint64_t consumer_pa;
>      uint64_t producer_pa;
> @@ -445,7 +445,7 @@ static MegasasCmd *megasas_lookup_frame(MegasasState *s,
>  
>      index = s->reply_queue_head;

While it is probably unlikely that it would cause an integer underflow
here, for consistency, index probably should also be declared as
unsigned, but from what I can tell it is still an 'int'.

Thanks,

Darren.

>  
> -    while (num < s->fw_cmds) {
> +    while (num < s->fw_cmds && index < MEGASAS_MAX_FRAMES) {
>          if (s->frames[index].pa && s->frames[index].pa == frame) {
>              cmd = &s->frames[index];
>              break;
> -- 
> 2.25.4

