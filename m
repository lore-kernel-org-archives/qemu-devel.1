Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD42C31E47
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683C1207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Yx/EFno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683C1207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazpy-0007H7-KS
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44072)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmn-0004ux-Lg
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmm-0000kU-BD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hazmj-0000j9-M2; Wed, 12 Jun 2019 05:43:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9Xcl4007421;
 Wed, 12 Jun 2019 09:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=wNJVY/MJnZ0hr3JnQpWCYzEqCzxEtI5MUZ+RiQowC2s=;
 b=1Yx/EFno0MGssNYY+JSDpoPAI7saF4YFB30AhEENjXFRO/Q8aQ4iiapjlkB5D+FgkeK+
 +I9zfIFvpvQAmlbaKYGElSWb5/IReunzKoaGmsSIV9Mcl1sYNOE8IihjLjrq3npO0JEp
 fFidsKJnfiUudK61fYFqf+/JKqRyA2kPgxO/2lwjAyS7+yr9gEibjURXRyJGz9lxXtPd
 eifNuCPpD9VyGegOIxBwQVDGu2UDLi0jyKMmo1OWCcn8oBUjeU/mHSnuc+FYZw5gpP0R
 u4JRDZH9beCQFCQ4C6iFCLC0OVjcuwIbI2mSK/RmxPRY2WZn8oDXgGHokDFXMQbEoUgp 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 2t02hetf5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9gRtX116167;
 Wed, 12 Jun 2019 09:43:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2t024uvyen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5C9hA38020150;
 Wed, 12 Jun 2019 09:43:10 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 02:43:09 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 12:42:31 +0300
Message-Id: <20190612094237.47462-3-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
References: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120066
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: [Qemu-devel] [QEMU] [PATCH 2/8] block: Support providing LCHS from
 user
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
Cc: liran.alon@oracle.com, shmuel.eiderman@oracle.com, karl.heubaum@oracle.com,
 arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add logical geometry variables to BlockConf.

A user can now supply "lcyls", "lheads" & "lsecs" for any HD device
that supports CHS ("cyls", "heads", "secs").

These devices include:
    * ide-hd
    * scsi-hd
    * virtio-blk-pci

In future commits we will use the provided LCHS and pass it to the BIOS
through fw_cfg to be supplied using INT13 routines.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 include/hw/block/block.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index fd55a30bca..d7246f3862 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -26,6 +26,7 @@ typedef struct BlockConf {
     uint32_t discard_granularity;
     /* geometry, not all devices use this */
     uint32_t cyls, heads, secs;
+    uint32_t lcyls, lheads, lsecs;
     OnOffAuto wce;
     bool share_rw;
     BlockdevOnError rerror;
@@ -65,7 +66,10 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 #define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
     DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
     DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
-    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
+    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0),                  \
+    DEFINE_PROP_UINT32("lcyls", _state, _conf.lcyls, 0),                \
+    DEFINE_PROP_UINT32("lheads", _state, _conf.lheads, 0),              \
+    DEFINE_PROP_UINT32("lsecs", _state, _conf.lsecs, 0)
 
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    \
     DEFINE_PROP_BLOCKDEV_ON_ERROR("rerror", _state, _conf.rerror,       \
-- 
2.13.3


