Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78D2C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7767520578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7767520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIxM-0001uO-4s
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjc-0002Tv-Dx
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjY-0003DL-NN
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIjY-0003Cy-Fv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2612307C820;
 Thu, 15 Aug 2019 16:36:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 094A43737;
 Thu, 15 Aug 2019 16:36:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:49 +0100
Message-Id: <20190815163504.18937-19-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 15 Aug 2019 16:36:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/33] migration: extract ram_load_precopy
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

From: Wei Yang <richardw.yang@linux.intel.com>

After cleanup, it would be clear to audience there are two cases
ram_load:

  * precopy
  * postcopy

And it is not necessary to check postcopy_running on each iteration for
precopy.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Message-Id: <20190725002023.2335-3-richardw.yang@linux.intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 73 +++++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6a75aedc91..a44e9c0abc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4318,40 +4318,26 @@ static void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
=20
-static int ram_load(QEMUFile *f, void *opaque, int version_id)
+/**
+ * ram_load_precopy: load pages in precopy case
+ *
+ * Returns 0 for success or -errno in case of error
+ *
+ * Called in precopy mode by ram_load().
+ * rcu_read_lock is taken prior to this being called.
+ *
+ * @f: QEMUFile where to send the data
+ */
+static int ram_load_precopy(QEMUFile *f)
 {
-    int flags =3D 0, ret =3D 0, invalid_flags =3D 0;
-    static uint64_t seq_iter;
-    int len =3D 0;
-    /*
-     * If system is running in postcopy mode, page inserts to host memor=
y must
-     * be atomic
-     */
-    bool postcopy_running =3D postcopy_is_running();
+    int flags =3D 0, ret =3D 0, invalid_flags =3D 0, len =3D 0;
     /* ADVISE is earlier, it shows the source has the postcopy capabilit=
y on */
     bool postcopy_advised =3D postcopy_is_advised();
-
-    seq_iter++;
-
-    if (version_id !=3D 4) {
-        return -EINVAL;
-    }
-
     if (!migrate_use_compression()) {
         invalid_flags |=3D RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
-    /* This RCU critical section can be very long running.
-     * When RCU reclaims in the code start to become numerous,
-     * it will be necessary to reduce the granularity of this
-     * critical section.
-     */
-    rcu_read_lock();
-
-    if (postcopy_running) {
-        ret =3D ram_load_postcopy(f);
-    }
=20
-    while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
+    while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
         void *host =3D NULL;
         uint8_t ch;
@@ -4502,6 +4488,39 @@ static int ram_load(QEMUFile *f, void *opaque, int=
 version_id)
         }
     }
=20
+    return ret;
+}
+
+static int ram_load(QEMUFile *f, void *opaque, int version_id)
+{
+    int ret =3D 0;
+    static uint64_t seq_iter;
+    /*
+     * If system is running in postcopy mode, page inserts to host memor=
y must
+     * be atomic
+     */
+    bool postcopy_running =3D postcopy_is_running();
+
+    seq_iter++;
+
+    if (version_id !=3D 4) {
+        return -EINVAL;
+    }
+
+    /*
+     * This RCU critical section can be very long running.
+     * When RCU reclaims in the code start to become numerous,
+     * it will be necessary to reduce the granularity of this
+     * critical section.
+     */
+    rcu_read_lock();
+
+    if (postcopy_running) {
+        ret =3D ram_load_postcopy(f);
+    } else {
+        ret =3D ram_load_precopy(f);
+    }
+
     ret |=3D wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
--=20
2.21.0


