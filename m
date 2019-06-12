Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00992C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B9320866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oLcqa9oT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B9320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazpv-0007E5-Rv
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmm-0004t1-0A
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmk-0000jq-LF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hazmh-0000iF-SN; Wed, 12 Jun 2019 05:43:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9XcNH007409;
 Wed, 12 Jun 2019 09:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=IF99orgPl5PZbXP/iOJCxdKOiazKw347UHLBH9LWKbA=;
 b=oLcqa9oTDBacS85yX/RMqqWRUHYs4dsocJzIqF6w7GQtRyNyBmWSUfAH/myqS4K6gS0g
 aZCd2Qul9HCSIDUrI9XVuHDBQLUSrotV1kNEXJ/R/SKfhPGnKa8sZUzuxuxxAUZPNpNN
 /nfB4GItQKiKg5QTsMFClTN77Et7ZvZY255cZCS9+AXx372BfEVG21NJ06UNQlu2Cv6n
 hCCM4rOOxHvXn/GifEuunHMBtDjdg0A6F0i/VxUems9NeH+1Gf5tkhy94IOjhJW96W1M
 hZUVzeMIHemtBDmBEBeer5z2NsiCChp0yE/Vw2FHQXBh5cATN3hleE9uoSlBMIdKjAMd PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 2t02hetf52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9gufU064402;
 Wed, 12 Jun 2019 09:43:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2t04hyuasr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5C9h7CM003336;
 Wed, 12 Jun 2019 09:43:07 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 02:43:07 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 12:42:30 +0300
Message-Id: <20190612094237.47462-2-shmuel.eiderman@oracle.com>
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
Subject: [Qemu-devel] [QEMU] [PATCH 1/8] block: Refactor macros - fix tabbing
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

Fixing tabbing in block related macros.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 hw/ide/qdev.c            |  2 +-
 include/hw/block/block.h | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 360cd20bd8..9cae3205df 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -285,7 +285,7 @@ static void ide_drive_realize(IDEDevice *dev, Error **errp)
     DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
     DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
     DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),    \
+    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
     DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
     DEFINE_PROP_STRING("model", IDEDrive, dev.model)
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 607539057a..fd55a30bca 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -50,21 +50,21 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                           _conf.logical_block_size),                    \
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
                           _conf.physical_block_size),                   \
-    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),  \
+    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
-    DEFINE_PROP_UINT32("discard_granularity", _state, \
-                       _conf.discard_granularity, -1), \
-    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, \
-                            ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_UINT32("discard_granularity", _state,                   \
+                       _conf.discard_granularity, -1),                  \
+    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce,           \
+                            ON_OFF_AUTO_AUTO),                          \
     DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
     DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)
 
-#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
-    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
-    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0), \
+#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
+    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
+    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
     DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
 
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    \
-- 
2.13.3


