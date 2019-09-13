Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF6C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F84208C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F84208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ip8-0002ZH-NF
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8ilu-000870-QS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8ilt-0005pU-OY
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:25:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8ilt-0005p2-IN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:25:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E036A83F45
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 10:25:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7F7B5D9E1;
 Fri, 13 Sep 2019 10:25:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 berrange@redhat.com, quintela@redhat.com
Date: Fri, 13 Sep 2019 11:25:35 +0100
Message-Id: <20190913102538.24167-3-dgilbert@redhat.com>
In-Reply-To: <20190913102538.24167-1-dgilbert@redhat.com>
References: <20190913102538.24167-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 13 Sep 2019 10:25:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/5] migration: Fix missing rcu_read_unlock
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use the automatic rcu_read unlocker to fix a missing unlock.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b2bd618a89..cff35477ec 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3445,28 +3445,27 @@ static int ram_save_setup(QEMUFile *f, void *opaq=
ue)
     }
     (*rsp)->f =3D f;
=20
-    rcu_read_lock();
-
-    qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_MEM_SI=
ZE);
+    WITH_RCU_READ_LOCK_GUARD() {
+        qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_ME=
M_SIZE);
=20
-    RAMBLOCK_FOREACH_MIGRATABLE(block) {
-        if (!block->idstr[0]) {
-            error_report("%s: RAMBlock with empty name", __func__);
-            return -1;
-        }
-        qemu_put_byte(f, strlen(block->idstr));
-        qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr)=
);
-        qemu_put_be64(f, block->used_length);
-        if (migrate_postcopy_ram() && block->page_size !=3D qemu_host_pa=
ge_size) {
-            qemu_put_be64(f, block->page_size);
-        }
-        if (migrate_ignore_shared()) {
-            qemu_put_be64(f, block->mr->addr);
+        RAMBLOCK_FOREACH_MIGRATABLE(block) {
+            if (!block->idstr[0]) {
+                error_report("%s: RAMBlock with empty name", __func__);
+                return -1;
+            }
+            qemu_put_byte(f, strlen(block->idstr));
+            qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->id=
str));
+            qemu_put_be64(f, block->used_length);
+            if (migrate_postcopy_ram() && block->page_size !=3D
+                                          qemu_host_page_size) {
+                qemu_put_be64(f, block->page_size);
+            }
+            if (migrate_ignore_shared()) {
+                qemu_put_be64(f, block->mr->addr);
+            }
         }
     }
=20
-    rcu_read_unlock();
-
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
=20
--=20
2.21.0


