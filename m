Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B53C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDFE20578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDFE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIyb-0003zv-9V
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjz-00034H-G2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjv-0003Tj-PD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIjv-0003TG-Ga
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C74B1307CDD1;
 Thu, 15 Aug 2019 16:36:38 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4723737;
 Thu, 15 Aug 2019 16:36:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:57 +0100
Message-Id: <20190815163504.18937-27-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 15 Aug 2019 16:36:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 26/33] migration: add speed limit for multifd
 migration
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <ivanren@tencent.com>

Limit the speed of multifd migration through common speed limitation
qemu file.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Message-Id: <1564464816-21804-3-git-send-email-ivanren@tencent.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index eee68a7991..1179519345 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -922,7 +922,7 @@ struct {
  * false.
  */
=20
-static int multifd_send_pages(void)
+static int multifd_send_pages(RAMState *rs)
 {
     int i;
     static int next_channel;
@@ -954,6 +954,7 @@ static int multifd_send_pages(void)
     multifd_send_state->pages =3D p->pages;
     p->pages =3D pages;
     transferred =3D ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->pac=
ket_len;
+    qemu_file_update_transfer(rs->f, transferred);
     ram_counters.multifd_bytes +=3D transferred;
     ram_counters.transferred +=3D transferred;;
     qemu_mutex_unlock(&p->mutex);
@@ -962,7 +963,7 @@ static int multifd_send_pages(void)
     return 1;
 }
=20
-static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+static int multifd_queue_page(RAMState *rs, RAMBlock *block, ram_addr_t =
offset)
 {
     MultiFDPages_t *pages =3D multifd_send_state->pages;
=20
@@ -981,12 +982,12 @@ static int multifd_queue_page(RAMBlock *block, ram_=
addr_t offset)
         }
     }
=20
-    if (multifd_send_pages() < 0) {
+    if (multifd_send_pages(rs) < 0) {
         return -1;
     }
=20
     if (pages->block !=3D block) {
-        return  multifd_queue_page(block, offset);
+        return  multifd_queue_page(rs, block, offset);
     }
=20
     return 1;
@@ -1054,7 +1055,7 @@ void multifd_save_cleanup(void)
     multifd_send_state =3D NULL;
 }
=20
-static void multifd_send_sync_main(void)
+static void multifd_send_sync_main(RAMState *rs)
 {
     int i;
=20
@@ -1062,7 +1063,7 @@ static void multifd_send_sync_main(void)
         return;
     }
     if (multifd_send_state->pages->used) {
-        if (multifd_send_pages() < 0) {
+        if (multifd_send_pages(rs) < 0) {
             error_report("%s: multifd_send_pages fail", __func__);
             return;
         }
@@ -1083,6 +1084,7 @@ static void multifd_send_sync_main(void)
         p->packet_num =3D multifd_send_state->packet_num++;
         p->flags |=3D MULTIFD_FLAG_SYNC;
         p->pending_job++;
+        qemu_file_update_transfer(rs->f, p->packet_len);
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
@@ -2078,7 +2080,7 @@ static int ram_save_page(RAMState *rs, PageSearchSt=
atus *pss, bool last_stage)
 static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
                                  ram_addr_t offset)
 {
-    if (multifd_queue_page(block, offset) < 0) {
+    if (multifd_queue_page(rs, block, offset) < 0) {
         return -1;
     }
     ram_counters.normal++;
@@ -3447,7 +3449,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
=20
-    multifd_send_sync_main();
+    multifd_send_sync_main(*rsp);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
=20
@@ -3535,7 +3537,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
=20
 out:
-    multifd_send_sync_main();
+    multifd_send_sync_main(rs);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
     ram_counters.transferred +=3D 8;
@@ -3594,7 +3596,7 @@ static int ram_save_complete(QEMUFile *f, void *opa=
que)
=20
     rcu_read_unlock();
=20
-    multifd_send_sync_main();
+    multifd_send_sync_main(rs);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
=20
--=20
2.21.0


