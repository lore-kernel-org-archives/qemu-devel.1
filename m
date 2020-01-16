Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82954C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8B3206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4S2VnK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8B3206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7OL-0005qy-QJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1is7M0-0003WA-R5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1is7Lz-0004Qv-J5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:46:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1is7Lz-0004Qd-Fd
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579189599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7TbmKAO+qFgSmtlxFGIwAxHJL5XNPm1Zu+2yWXyqKA=;
 b=T4S2VnK6HT+jAeaebX4CD+Y8arLxTmrlfHDFfr65dPl3TbP51C3GX7ezYmt+BnRcmfeNeX
 UzH1nnHig6Ai7eB0kf9Dy1ENfbzc1i/+Qrp+0akk4+N9+mgS6QUwu471fIcfM7+7AOLXWj
 qTuaRt7SE/6k/cbkTHSU7LImN0qVEvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-JO21ZPcOMCOvKh7cskv3DA-1; Thu, 16 Jan 2020 10:46:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EC69190B2D8
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 15:46:36 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3015863148;
 Thu, 16 Jan 2020 15:46:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] migration: Create MigrationState active field
Date: Thu, 16 Jan 2020 16:46:13 +0100
Message-Id: <20200116154616.11569-3-quintela@redhat.com>
In-Reply-To: <20200116154616.11569-1-quintela@redhat.com>
References: <20200116154616.11569-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JO21ZPcOMCOvKh7cskv3DA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now, there is no easy way to dectect if we have already
cancelled/finished/failed a migration.  This field is setup to true
when we start a migration, and it is set to false as soon as we stop
it.

It fixes a real bug, in ram_save_iterate() we call functions that
wrote to the channel even if we know that migration has stopped for
any reason.  This gives problems with multifd because we need to
synchronize various semoaphores that we don't want to take.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 5 +++++
 migration/migration.h | 5 +++++
 migration/ram.c       | 2 +-
 migration/savevm.c    | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 990bff00c0..60bc8710b6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1583,6 +1583,8 @@ static void migrate_fd_cancel(MigrationState *s)
     QEMUFile *f =3D migrate_get_current()->to_dst_file;
     trace_migrate_fd_cancel();
=20
+    s->active =3D false;
+
     if (s->rp_state.from_dst_file) {
         /* shutdown the rp socket, so causing the rp thread to shutdown */
         qemu_file_shutdown(s->rp_state.from_dst_file);
@@ -2834,6 +2836,7 @@ static void migration_completion(MigrationState *s)
     }
=20
     if (!migrate_colo_enabled()) {
+        s->active =3D false;
         migrate_set_state(&s->state, current_active_state,
                           MIGRATION_STATUS_COMPLETED);
     }
@@ -2859,6 +2862,7 @@ fail_invalidate:
     }
=20
 fail:
+    s->active =3D false;
     migrate_set_state(&s->state, current_active_state,
                       MIGRATION_STATUS_FAILED);
 }
@@ -3289,6 +3293,7 @@ static void *migration_thread(void *opaque)
     }
=20
     qemu_savevm_state_setup(s->to_dst_file);
+    s->active =3D true;
=20
     if (qemu_savevm_nr_failover_devices()) {
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/migration.h b/migration/migration.h
index aa9ff6f27b..e0386efe95 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -169,6 +169,11 @@ struct MigrationState
=20
     int state;
=20
+    /* Is the migration channel still open.  When migration finish,
+     * gets an error or is cancelled this becomes false.
+     */
+
+    bool active;
     /* State related to return path */
     struct {
         QEMUFile     *from_dst_file;
diff --git a/migration/ram.c b/migration/ram.c
index 8f9f3bba5b..44ca56e1ea 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3521,7 +3521,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque=
)
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
=20
 out:
-    if (ret >=3D 0) {
+    if (ret >=3D 0 && migrate_get_current()->active) {
         multifd_send_sync_main(rs);
         qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
         qemu_fflush(f);
diff --git a/migration/savevm.c b/migration/savevm.c
index adfdca26ac..3efde5b3dd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1550,6 +1550,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **err=
p)
     qemu_mutex_unlock_iothread();
     qemu_savevm_state_header(f);
     qemu_savevm_state_setup(f);
+    ms->active =3D true;
     qemu_mutex_lock_iothread();
=20
     while (qemu_file_get_error(f) =3D=3D 0) {
@@ -1574,6 +1575,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **err=
p)
         status =3D MIGRATION_STATUS_COMPLETED;
     }
     migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
+    ms->active =3D false;
=20
     /* f is outer parameter, it should not stay in global migration state =
after
      * this function finished */
--=20
2.24.1


