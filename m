Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC499C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8035B205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8035B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVZz-0006f1-F1
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVVN-0001d9-Hh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVVL-0006Xa-W8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:05:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:56606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHVVH-0006SH-Ef; Mon, 07 Oct 2019 12:04:55 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHVVD-0003oB-Uk; Mon, 07 Oct 2019 19:04:52 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 1/2] docs: improve qcow2 spec about extending image header
Date: Mon,  7 Oct 2019 19:04:50 +0300
Message-Id: <20191007160451.27334-2-vsementsov@virtuozzo.com>
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

Make it more obvious how to add new fields to the version 3 header and
how to interpret them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/interop/qcow2.txt | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..3f2855593f 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file header:
                     Offset into the image file at which the snapshot table
                     starts. Must be aligned to a cluster boundary.
 
-If the version is 3 or higher, the header has the following additional fields.
-For version 2, the values are assumed to be zero, unless specified otherwise
-in the description of a field.
+For version 2, header is always 72 bytes length and finishes here.
+For version 3 or higher the header length is at least 104 bytes and has at
+least next five fields, up to the @header_length field.
 
          72 -  79:  incompatible_features
                     Bitmask of incompatible features. An implementation must
@@ -165,6 +165,26 @@ in the description of a field.
                     Length of the header structure in bytes. For version 2
                     images, the length is always assumed to be 72 bytes.
 
+Additional fields (version 3 and higher)
+
+The following fields of the header are optional: if software don't know how to
+interpret the field, it may safely ignore it. Still the field must be kept as is
+when rewriting the image. @header_length must be bound to the end of one of
+these fields (or to @header_length field end itself, to be 104 bytes).
+This definition implies the following:
+1. Software may support some of these optional fields and ignore the others,
+   which means that features may be backported to downstream Qemu independently.
+2. Software may check @header_length, if it knows optional fields specification
+   enough (knows about the field which exceeds @header_length).
+3. If @header_length is higher than the highest field end that software knows,
+   it should assume that additional fields are correct, @header_length is
+   correct and keep @header_length and additional unknown fields as is on
+   rewriting the image.
+3. If we want to add incompatible field (or a field, for which some its values
+   would be incompatible), it must be accompanied by incompatible feature bit.
+
+        < ... No additional fields in the header currently ... >
+
 Directly after the image header, optional sections called header extensions can
 be stored. Each extension has a structure like the following:
 
-- 
2.21.0


