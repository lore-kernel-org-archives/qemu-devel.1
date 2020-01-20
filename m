Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A132BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769FC21835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769FC21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itakj-0005Pu-Er
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itacu-0005Mw-6W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itacs-0004Qn-Sf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:14:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:37506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itacp-0004PD-U2; Mon, 20 Jan 2020 12:14:08 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1itaco-0002hc-Gg; Mon, 20 Jan 2020 20:14:06 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 1/2] docs: improve qcow2 spec about extending image header
Date: Mon, 20 Jan 2020 20:13:44 +0300
Message-Id: <20200120171345.24345-2-vsementsov@virtuozzo.com>
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

Make it more obvious how to add new fields to the version 3 header and
how to interpret them.

The specification is adjusted so for new defined optional fields:

1. Software may support some of these optional fields and ignore the
   others, which means that features may be backported to downstream
   Qemu independently.
2. If we want to add incompatible field (or a field, for which some its
   values would be incompatible), it must be accompanied by
   incompatible feature bit.

Also the concept of "default is zero" is clarified, as it's strange to
say that the value of the field is assumed to be zero for the software
version which don't know about the field at all and don't know how to
treat it be it zero or not.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/interop/qcow2.txt | 44 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..355925c35e 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file header:
                     Offset into the image file at which the snapshot table
                     starts. Must be aligned to a cluster boundary.
 
-If the version is 3 or higher, the header has the following additional fields.
-For version 2, the values are assumed to be zero, unless specified otherwise
-in the description of a field.
+For version 2, the header is exactly 72 bytes in length, and finishes here.
+For version 3 or higher, the header length is at least 104 bytes, including
+the next fields through header_length.
 
          72 -  79:  incompatible_features
                     Bitmask of incompatible features. An implementation must
@@ -164,6 +164,44 @@ in the description of a field.
         100 - 103:  header_length
                     Length of the header structure in bytes. For version 2
                     images, the length is always assumed to be 72 bytes.
+                    For version 3 it's at least 104 bytes and must be a multiple
+                    of 8.
+
+
+=== Additional fields (version 3 and higher) ===
+
+In general, these fields are optional and may be safely ignored by the software,
+as well as filled by zeros (which is equal to field absence), if software needs
+to set field B, but does not care about field A, which precedes B. More
+formally, additional fields have the following compatibility rules:
+
+1. If the value of the additional field must not be ignored for correct
+handling of the file, it will be accompanied by a corresponding incompatible
+feature bit.
+
+2. If there are no unrecognized incompatible feature bits set, an unknown
+additional field may be safely ignored other than preserving its value when
+rewriting the image header.
+
+3. An explicit value of 0 will have the same behavior as when the field is not
+present*, if not altered by a specific incompatible bit.
+
+*. A field is considered not present when header_length is less or equal to the
+field's offset. Also, all additional fields are not present for version 2.
+
+        < ... No additional fields in the header currently ... >
+
+
+=== Header padding ===
+
+@header_length must be a multiple of 8, which means that if the end of the last
+additional field is not aligned, some padding is needed. This padding must be
+zeroed, so that, if some existing (or future) additional field will fall into
+the padding, it will be interpreted accordingly to point [3.] of the previous
+paragraph, i.e.  in the same manner as when this field is not present.
+
+
+=== Header extensions ===
 
 Directly after the image header, optional sections called header extensions can
 be stored. Each extension has a structure like the following:
-- 
2.21.0


