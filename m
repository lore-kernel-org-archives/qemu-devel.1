Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701DFC31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A0F21721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SRoCeBT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A0F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdg7f-0007ID-Gl
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lidong.chen@oracle.com>) id 1hdg4g-0005e1-8h
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lidong.chen@oracle.com>) id 1hdg4d-0007ph-Ap
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
 id 1hdg4Y-0007Ya-Bs
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJ8bnl074726;
 Wed, 19 Jun 2019 19:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=w4zQwFBs6OSGWyN6TLexthqpHY6F+pJcdy03AuqSzx0=;
 b=SRoCeBT9lMhQm+lG6u3e65jDRC49VIql81xKBN5G9deh6e4+dMnIXVaHvng2tpA5eu3e
 KI8TTs8yY1o++lENm/ShRHGgclMBQE3TsZc8rMHaVgO/hPQ1Yp0/2TN9QRcc+ZP1RLKT
 HvdvmHqRRFCby6vWCemoefLBal8IkcOq0qneh6oUPMjD8TmGkWCDu1uqaHotsuBV4snq
 6SpLwKADCCYoNWjz/I41LJe/Ul+/ove0AtMUDNnxoz0cV9jhO5+dv0xFYFZzHDPCYMbR
 dP8GOHt+V/X+uu1BlZoqRmQHX8dkdseoUBmRUC1PBLTYsWaM88d7C04sEojgEaNFM3LN DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2t7809d8rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 19:16:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJFrik168835;
 Wed, 19 Jun 2019 19:16:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2t77yn98aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 19:16:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JJGRxQ024019;
 Wed, 19 Jun 2019 19:16:27 GMT
Received: from ca-virt2-2.us.oracle.com (/10.211.11.112)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 12:16:27 -0700
From: Lidong Chen <lidong.chen@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 15:14:45 -0400
Message-Id: <cover.1560806687.git.lidong.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190157
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [Qemu-devel PATCH v3 0/2] fix incorrect assertions in
 sd and main-loop
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liq3ea@gmail.com,
 f4bug@amsat.org, armbru@redhat.com, lidong.chen@oracle.com,
 darren.kenny@oracle.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 amarkovic@wavecomp.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This v3 added Philippe's Reviewed-by in patch2 (main-loop.c) 
I also included Philippe's previous comment about patch1 (sd.c)
in this cover: 

--------
Not sure via which tree this patch is going (trivial?).
To the maintainer, please consider adding when applying:

"This access can not happen. Fix to silent static analyzer warnings."

As confirmed by Lidong in v1 here:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01337.html

Thanks,

Phil.
-------

Lidong Chen (2):
  sd: Fix out-of-bounds assertions
  util/main-loop: Fix incorrect assertion

 hw/sd/sd.c       | 4 ++--
 util/main-loop.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.3.1


