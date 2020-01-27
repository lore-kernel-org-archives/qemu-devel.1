Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02716C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD6A24656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXjzbUxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD6A24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51891 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwD73-0000fe-VG
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwCxU-0000pG-Fr
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwCxT-0003cT-HT
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:34:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwCxT-0003cE-DG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zdg0RPlvvTKFqgPMPnaxb1vkqOzrI0wdQ5muxzWeLcI=;
 b=TXjzbUxo/oMwt0oMkgsFu4OqMBsFuQvBv5iXpEalp8gexwl2IAp6tlr+2oO/JWxuUmibih
 ih8Fd/IEWM+xQReB59FRBIooYtGFK3Q1WJJdcwyJv0EjfH/8M/J6lBE5MjcrBAHV3t8rL/
 tc11nAvpNeFO8y7ygIkthWNj8V29Rq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-QBNS4DAEMmiRCRSwIxOA3g-1; Mon, 27 Jan 2020 17:34:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63B428017CC
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 22:34:12 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 174EA165D3;
 Mon, 27 Jan 2020 22:34:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] multifd: Make multifd_save_setup() get an Error parameter
Date: Mon, 27 Jan 2020 23:33:16 +0100
Message-Id: <20200127223321.2742-15-quintela@redhat.com>
In-Reply-To: <20200127223321.2742-1-quintela@redhat.com>
References: <20200127223321.2742-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QBNS4DAEMmiRCRSwIxOA3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

---

We can't trust that error_in is not NULL.  Create a local_error.
---
 migration/migration.c | 4 +++-
 migration/ram.c       | 2 +-
 migration/ram.h       | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 77768fb2c7..d478f832ea 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3367,6 +3367,7 @@ static void *migration_thread(void *opaque)
=20
 void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
+    Error *local_err =3D NULL;
     int64_t rate_limit;
     bool resume =3D s->state =3D=3D MIGRATION_STATUS_POSTCOPY_PAUSED;
=20
@@ -3415,7 +3416,8 @@ void migrate_fd_connect(MigrationState *s, Error *err=
or_in)
         return;
     }
=20
-    if (multifd_save_setup() !=3D 0) {
+    if (multifd_save_setup(&local_err) !=3D 0) {
+        error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         migrate_fd_cleanup(s);
diff --git a/migration/ram.c b/migration/ram.c
index 12b76b7841..78483247ad 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1252,7 +1252,7 @@ static void multifd_new_send_channel_async(QIOTask *t=
ask, gpointer opaque)
     }
 }
=20
-int multifd_save_setup(void)
+int multifd_save_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
diff --git a/migration/ram.h b/migration/ram.h
index bd0eee79b6..da22a417ea 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -41,7 +41,7 @@ int xbzrle_cache_resize(int64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
=20
-int multifd_save_setup(void);
+int multifd_save_setup(Error **errp);
 void multifd_save_cleanup(void);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
--=20
2.24.1


