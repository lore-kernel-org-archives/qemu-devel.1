Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79881C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B8520866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B8520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb11y-00051x-Jk
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 07:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hb0sr-0007yD-KI
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hb0sp-0004ie-Gx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hb0sp-0004i7-AT
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82E663083392
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
 [10.36.116.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8D453786;
 Wed, 12 Jun 2019 10:53:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 12:53:19 +0200
Message-Id: <20190612105323.7051-3-quintela@redhat.com>
In-Reply-To: <20190612105323.7051-1-quintela@redhat.com>
References: <20190612105323.7051-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 12 Jun 2019 10:53:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 2/6] migration: Make multifd_save_setup()
 get an Error parameter
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
index 2865ae3fa9..0ac504be3c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3336,7 +3336,7 @@ void migrate_fd_connect(MigrationState *s, Error *e=
rror_in)
         return;
     }
=20
-    if (multifd_save_setup() !=3D 0) {
+    if (multifd_save_setup(&error_in) !=3D 0) {
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         migrate_fd_cleanup(s);
diff --git a/migration/ram.c b/migration/ram.c
index 89eec7ee9d..4b65d22cb1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1172,7 +1172,7 @@ static void multifd_new_send_channel_async(QIOTask =
*task, gpointer opaque)
     }
 }
=20
-int multifd_save_setup(void)
+int multifd_save_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
diff --git a/migration/ram.h b/migration/ram.h
index 936177b3e9..09feaad55b 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -42,7 +42,7 @@ int xbzrle_cache_resize(int64_t new_size, Error **errp)=
;
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
=20
-int multifd_save_setup(void);
+int multifd_save_setup(Error **errp);
 void multifd_save_cleanup(void);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
--=20
2.21.0


