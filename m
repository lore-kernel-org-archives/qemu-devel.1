Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC7EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA24921582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGyuN4/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA24921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOjb-0000Hq-QJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOem-00031u-JE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOek-0005lX-9j
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOek-0005gR-5Y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvvZhu/xFvz1U3Hf+/Yigdo8O7qRPkr3UgL8NVTZMng=;
 b=iGyuN4/8Ys5k5Xv79oJxTnsBOp1cEZ6WRzTDF8vk1cVUaLqoyfq5kaMarRptJyQh6pWTHo
 doH9Z7OEFb822JAVAZpXV98jVK1LfOz/tDY/W8ip3MA+G7ifaIhwSkpS51qRx1cdQFFsB3
 EQvLfYg+6gVOkaMPH2Udu8+rWQWuEIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-dB8nvs-CMRKPZv6uDflWKg-1; Tue, 17 Dec 2019 21:01:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50715107ACC4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:01:33 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1265619C58;
 Wed, 18 Dec 2019 02:01:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/10] migration: Make multifd_save_setup() get an Error
 parameter
Date: Wed, 18 Dec 2019 03:01:13 +0100
Message-Id: <20191218020119.3776-5-quintela@redhat.com>
In-Reply-To: <20191218020119.3776-1-quintela@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dB8nvs-CMRKPZv6uDflWKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 +-
 migration/ram.c       | 2 +-
 migration/ram.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e7f707e033..5a56bd0c91 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3400,7 +3400,7 @@ void migrate_fd_connect(MigrationState *s, Error *err=
or_in)
         return;
     }
=20
-    if (multifd_save_setup() !=3D 0) {
+    if (multifd_save_setup(&error_in) !=3D 0) {
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         migrate_fd_cleanup(s);
diff --git a/migration/ram.c b/migration/ram.c
index 38070f1bb2..1f364cc23d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1208,7 +1208,7 @@ static void multifd_new_send_channel_async(QIOTask *t=
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
2.23.0


