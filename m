Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A96C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABBB21835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABBB21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ital8-00066B-Aj
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itacz-0005W0-4g
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itacx-0004SY-Ta
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:14:16 -0500
Received: from relay.sw.ru ([185.231.240.75]:37530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itacu-0004R9-GU; Mon, 20 Jan 2020 12:14:12 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1itact-0002hc-0z; Mon, 20 Jan 2020 20:14:11 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 2/2] docs: qcow2: introduce compression type feature
Date: Mon, 20 Jan 2020 20:13:45 +0300
Message-Id: <20200120171345.24345-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200120171345.24345-1-vsementsov@virtuozzo.com>
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, dplotnikov@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch add new additional field to qcow2 header: compression_type,
which specifies compression type. If field is absent or zero, default
compression type is set: ZLIB, which corresponds to current behavior.

New compression type (ZSTD) is to be added in further commit.

Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/interop/qcow2.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 355925c35e..4569f0dba3 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -109,6 +109,11 @@ the next fields through header_length.
                                 An External Data File Name header extension may
                                 be present if this bit is set.
 
+                    Bit 3:      Compression type bit.  If this bit is set,
+                                a non-default compression is used for compressed
+                                clusters. The compression_type field must be
+                                present and not zero.
+
                     Bits 3-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
@@ -189,7 +194,16 @@ present*, if not altered by a specific incompatible bit.
 *. A field is considered not present when header_length is less or equal to the
 field's offset. Also, all additional fields are not present for version 2.
 
-        < ... No additional fields in the header currently ... >
+              104:  compression_type
+                    Defines the compression method used for compressed clusters.
+                    All compressed clusters in an image use the same compression
+                    type.
+                    If the incompatible bit "Compression type" is set: the field
+                    must be present and non-zero (which means non-zlib
+                    compression type). Otherwise, this field must not be present
+                    or must be zero (which means zlib).
+                    Available compression type values:
+                        0: zlib <https://www.zlib.net/>
 
 
 === Header padding ===
-- 
2.21.0


