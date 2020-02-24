Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3CC3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F300120675
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F300120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j67iT-0001mf-6X
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 01:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j67dm-0003GY-P4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j67dl-0006EE-P0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52524 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j67dl-0006Co-DN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:53 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4E4FD83CDB1972F96EFE;
 Mon, 24 Feb 2020 14:54:51 +0800 (CST)
Received: from huawei.com (10.133.214.142) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 14:54:42 +0800
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH V2 8/8] migration/colo: Only flush ram cache while do
 checkpoint
Date: Mon, 24 Feb 2020 14:54:14 +0800
Message-ID: <20200224065414.36524-9-zhang.zhanghailiang@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.214.142]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: danielcho@qnap.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After add migrating ram backgroud, we will call ram_load
for this process, but we should not flush ram cache during
this process. Move the flush action to the right place.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 1 +
 migration/ram.c  | 5 +----
 migration/ram.h  | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index c36d94072f..18df8289f8 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -799,6 +799,7 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
=20
     qemu_mutex_lock_iothread();
     vmstate_loading =3D true;
+    colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb);
     if (ret < 0) {
         error_setg(errp, "COLO: load device state failed");
diff --git a/migration/ram.c b/migration/ram.c
index 1b3f423351..7bc841d14f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3305,7 +3305,7 @@ static bool postcopy_is_running(void)
  * Flush content of RAM cache into SVM's memory.
  * Only flush the pages that be dirtied by PVM or SVM or both.
  */
-static void colo_flush_ram_cache(void)
+void colo_flush_ram_cache(void)
 {
     RAMBlock *block =3D NULL;
     void *dst_host;
@@ -3576,9 +3576,6 @@ static int ram_load(QEMUFile *f, void *opaque, int =
version_id)
     }
     trace_ram_load_complete(ret, seq_iter);
=20
-    if (!ret  && migration_incoming_in_colo_state()) {
-        colo_flush_ram_cache();
-    }
     return ret;
 }
=20
diff --git a/migration/ram.h b/migration/ram.h
index 5ceaff7cb4..ae14341482 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -67,5 +67,6 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock=
 *rb);
 int colo_init_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
+void colo_flush_ram_cache(void);
=20
 #endif
--=20
2.21.0



