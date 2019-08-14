Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC614C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B95B2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B95B2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxzqH-0006Pa-KI
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznS-0004AL-S9
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxznQ-00045g-My
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxznJ-0003y4-2V; Wed, 14 Aug 2019 16:22:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5EB6302C07B;
 Wed, 14 Aug 2019 20:22:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E046910016EB;
 Wed, 14 Aug 2019 20:22:42 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:12 +0300
Message-Id: <20190814202219.1870-7-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 14 Aug 2019 20:22:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 06/13] qcrypto-luks: implement more rigorous
 header checking
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check that keyslots don't overlap with the data,
and check that keyslots don't overlap with each other.
(this is done using naive O(n^2) nested loops,
but since there are just 8 keyslots, this doens't really matter.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 crypto/block-luks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 336e633df4..1997e92fe1 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -551,6 +551,8 @@ static int
 qcrypto_block_luks_check_header(QCryptoBlockLUKS *luks, Error **errp)
 {
     int ret;
+    int i, j;
+
 
     if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
                QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
@@ -566,6 +568,46 @@ qcrypto_block_luks_check_header(QCryptoBlockLUKS *luks, Error **errp)
         goto fail;
     }
 
+    /* Check all keyslots for corruption  */
+    for (i = 0 ; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; i++) {
+
+        QCryptoBlockLUKSKeySlot *slot1 = &luks->header.key_slots[i];
+        uint start1 = slot1->key_offset;
+        uint len1 = splitkeylen_sectors(luks, slot1->stripes);
+
+        if (slot1->stripes == 0 ||
+                (slot1->active != QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED &&
+                slot1->active != QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED)) {
+
+            error_setg(errp, "Keyslot %i is corrupted", i);
+            ret = -EINVAL;
+            goto fail;
+        }
+
+        if (start1 + len1 > luks->header.payload_offset) {
+            error_setg(errp,
+                       "Keyslot %i is overlapping with the encrypted payload",
+                       i);
+            ret = -EINVAL;
+            goto fail;
+        }
+
+        for (j = i + 1 ; j < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; j++) {
+
+            QCryptoBlockLUKSKeySlot *slot2 = &luks->header.key_slots[j];
+            uint start2 = slot2->key_offset;
+            uint len2 = splitkeylen_sectors(luks, slot2->stripes);
+
+            if (start1 + len1 > start2 && start2 + len2 > start1) {
+                error_setg(errp,
+                           "Keyslots %i and %i are overlapping in the header",
+                           i, j);
+                ret = -EINVAL;
+                goto fail;
+            }
+        }
+
+    }
     return 0;
 fail:
     return ret;
-- 
2.17.2


