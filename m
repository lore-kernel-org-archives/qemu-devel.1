Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7696EC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493E620659
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493E620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVce-0000sl-V3
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVVN-0001cT-3I
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVVL-0006XK-L4
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:05:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:56598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHVVH-0006SG-7I; Mon, 07 Oct 2019 12:04:55 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHVVE-0003oB-8Y; Mon, 07 Oct 2019 19:04:52 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 2/2] docs: qcow2: introduce compression type feature
Date: Mon,  7 Oct 2019 19:04:51 +0300
Message-Id: <20191007160451.27334-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007160451.27334-1-vsementsov@virtuozzo.com>
References: <20191007160451.27334-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, dplotnikov@virtuozzo.com,
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
 docs/interop/qcow2.txt | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 3f2855593f..82ec0845d8 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -109,6 +109,12 @@ least next five fields, up to the @header_length field.
                                 An External Data File Name header extension may
                                 be present if this bit is set.
 
+                    Bit 3:      Compression type bit.  If this bit is set,
+                                non-default compression is used for compressed
+                                clusters. In this case, @header_length must
+                                be at least 108 and @compression_type field
+                                must be non-zero.
+
                     Bits 3-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
@@ -183,7 +189,18 @@ This definition implies the following:
 3. If we want to add incompatible field (or a field, for which some its values
    would be incompatible), it must be accompanied by incompatible feature bit.
 
-        < ... No additional fields in the header currently ... >
+              104:  compression_type
+                    Defines the compression method used for compressed clusters.
+                    A single compression type is applied to all compressed image
+                    clusters.
+                    If incompatible compression type bit is set: the field must
+                    exist (i.e. @header_length >= 105) and must be non-zero (
+                    which means non-zlib compression type)
+                    If incompatible compression type bit is unset: the field
+                    may not exist (if @header_length < 105) or it must be zero
+                    (which means zlib).
+                    Available compression type values:
+                        0: zlib <https://www.zlib.net/>
 
 Directly after the image header, optional sections called header extensions can
 be stored. Each extension has a structure like the following:
-- 
2.21.0


