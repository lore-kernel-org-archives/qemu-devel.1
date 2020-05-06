Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205DAC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEE520753
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1Ax3kqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEE520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGoO-00013r-HJ
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhK-0004zx-MY
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhH-0004Ip-7L
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588758632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLvhweL9MM4fO8C2USx4CrswD98agNtloG3GZKunYNo=;
 b=Y1Ax3kqX0lWncYYOpYA1TFgwjgu3f7yjV+1Jaz0VblmjNX1XMERhcAM8IAkv43wMIkSEs6
 1KczJ8R4LL7QcJClmOCTLtQDu/Wnx5t/9P9RVaIdJO4VFk1YiFpcItaoshlmioZXXl1WuX
 5El3LEBMwLvSBRQHEW2CvowJS0txHHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-xu27MMluPju_Nh_onFEfNA-1; Wed, 06 May 2020 05:50:27 -0400
X-MC-Unique: xu27MMluPju_Nh_onFEfNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78CC461;
 Wed,  6 May 2020 09:50:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4A305C1BD;
 Wed,  6 May 2020 09:50:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/17] virtio-balloon: Rip out qemu_balloon_inhibit()
Date: Wed,  6 May 2020 11:49:36 +0200
Message-Id: <20200506094948.76388-6-david@redhat.com>
In-Reply-To: <20200506094948.76388-1-david@redhat.com>
References: <20200506094948.76388-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only remaining special case is postcopy. It cannot handle
concurrent discards yet, which would result in requesting already sent
pages from the source. Special-case it in virtio-balloon instead.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 balloon.c                  | 18 ------------------
 hw/virtio/virtio-balloon.c | 12 +++++++++++-
 include/sysemu/balloon.h   |  2 --
 migration/postcopy-ram.c   | 23 -----------------------
 4 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/balloon.c b/balloon.c
index c49f57c27b..354408c6ea 100644
--- a/balloon.c
+++ b/balloon.c
@@ -36,24 +36,6 @@
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
 static void *balloon_opaque;
-static int balloon_inhibit_count;
-
-bool qemu_balloon_is_inhibited(void)
-{
-    return atomic_read(&balloon_inhibit_count) > 0 ||
-           ram_block_discard_is_broken();
-}
-
-void qemu_balloon_inhibit(bool state)
-{
-    if (state) {
-        atomic_inc(&balloon_inhibit_count);
-    } else {
-        atomic_dec(&balloon_inhibit_count);
-    }
-
-    assert(atomic_read(&balloon_inhibit_count) >=3D 0);
-}
=20
 static bool have_balloon(Error **errp)
 {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..aa5b89fb47 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -29,6 +29,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
+#include "migration/postcopy-ram.h"
=20
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
@@ -63,6 +64,15 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloo=
nedPage *pbp,
     return pbp->base_gpa =3D=3D base_gpa;
 }
=20
+static bool virtio_balloon_inhibited(void)
+{
+    PostcopyState ps =3D postcopy_state_get();
+
+    /* Postcopy cannot deal with concurrent discards (yet), so it's spec=
ial. */
+    return ram_block_discard_is_broken() ||
+           (ps >=3D POSTCOPY_INCOMING_DISCARD && ps < POSTCOPY_INCOMING_=
END);
+}
+
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
                                  PartiallyBalloonedPage *pbp)
@@ -360,7 +370,7 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
=20
             trace_virtio_balloon_handle_output(memory_region_name(sectio=
n.mr),
                                                pa);
-            if (!qemu_balloon_is_inhibited()) {
+            if (!virtio_balloon_inhibited()) {
                 if (vq =3D=3D s->ivq) {
                     balloon_inflate_page(s, section.mr,
                                          section.offset_within_region, &=
pbp);
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index aea0c44985..20a2defe3a 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -23,7 +23,5 @@ typedef void (QEMUBalloonStatus)(void *opaque, BalloonI=
nfo *info);
 int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
                              QEMUBalloonStatus *stat_func, void *opaque)=
;
 void qemu_remove_balloon_handler(void *opaque);
-bool qemu_balloon_is_inhibited(void);
-void qemu_balloon_inhibit(bool state);
=20
 #endif
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a36402722b..b41a9fe2fd 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -27,7 +27,6 @@
 #include "qemu/notify.h"
 #include "qemu/rcu.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/balloon.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/boards.h"
@@ -520,20 +519,6 @@ int postcopy_ram_incoming_init(MigrationIncomingStat=
e *mis)
     return 0;
 }
=20
-/*
- * Manage a single vote to the QEMU balloon inhibitor for all postcopy u=
sage,
- * last caller wins.
- */
-static void postcopy_balloon_inhibit(bool state)
-{
-    static bool cur_state =3D false;
-
-    if (state !=3D cur_state) {
-        qemu_balloon_inhibit(state);
-        cur_state =3D state;
-    }
-}
-
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called=
.
  */
@@ -565,8 +550,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingSt=
ate *mis)
         mis->have_fault_thread =3D false;
     }
=20
-    postcopy_balloon_inhibit(false);
-
     if (enable_mlock) {
         if (os_mlock() < 0) {
             error_report("mlock: %s", strerror(errno));
@@ -1160,12 +1143,6 @@ int postcopy_ram_incoming_setup(MigrationIncomingS=
tate *mis)
     }
     memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
=20
-    /*
-     * Ballooning can mark pages as absent while we're postcopying
-     * that would cause false userfaults.
-     */
-    postcopy_balloon_inhibit(true);
-
     trace_postcopy_ram_enable_notify();
=20
     return 0;
--=20
2.25.3


