Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800B6C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C82E2076F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOzs0fEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C82E2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHB7T-0006fS-Ec
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 14:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jHB3w-00023z-Ph
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jHB3v-0003do-OJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:47:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jHB3v-0003dc-K8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585162055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z41bJn5B0sKkbJNUSwdEnkMO1h3qMJLWpIO+ZqC84os=;
 b=bOzs0fEc1+rXm0pCNxTWYmKR2229xoZc1fMHzX/LxzZdRIm9Hde6cfv2YTxYCxXsLJ8MRy
 G/0gXwZK03V7zbhrHlboR32I5b4MyTRr6AHMiVnuwLlheoplxYyKV9Bvw1o4W4h0Ynp85U
 gan5rqj7SxNwEGEG4ljreKt+mWRfCsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-uGAW66vtMnyQ_pGfbPjzrg-1; Wed, 25 Mar 2020 14:47:33 -0400
X-MC-Unique: uGAW66vtMnyQ_pGfbPjzrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E0EF8017DF;
 Wed, 25 Mar 2020 18:47:32 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3AB160BF3;
 Wed, 25 Mar 2020 18:47:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 1/3] migration: fix cleanup_bh leak on resume
Date: Wed, 25 Mar 2020 19:47:21 +0100
Message-Id: <20200325184723.2029630-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200325184723.2029630-1-marcandre.lureau@redhat.com>
References: <20200325184723.2029630-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 8c6b0356b53977bcfdea5299db07884915425b0c ("util/async:
make bh_aio_poll() O(1)"), migration-test reveals a leak:

QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
tests/qtest/migration-test  -p /x86_64/migration/postcopy/recovery
tests/qtest/libqtest.c:140: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D2082571=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f25971dfc58 in __interceptor_malloc (/lib64/libasan.so.5+0x10dc58=
)
    #1 0x7f2596d08358 in g_malloc (/lib64/libglib-2.0.so.0+0x57358)
    #2 0x560970d006f8 in qemu_bh_new /home/elmarco/src/qemu/util/main-loop.=
c:532
    #3 0x5609704afa02 in migrate_fd_connect
/home/elmarco/src/qemu/migration/migration.c:3407
    #4 0x5609704b6b6f in migration_channel_connect
/home/elmarco/src/qemu/migration/channel.c:92
    #5 0x5609704b2bfb in socket_outgoing_migration
/home/elmarco/src/qemu/migration/socket.c:108
    #6 0x560970b9bd6c in qio_task_complete /home/elmarco/src/qemu/io/task.c=
:196
    #7 0x560970b9aa97 in qio_task_thread_result
/home/elmarco/src/qemu/io/task.c:111
    #8 0x7f2596cfee3a  (/lib64/libglib-2.0.so.0+0x4de3a)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/migration.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index c1d88ace7f..fa8cca14c7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3477,7 +3477,12 @@ void migrate_fd_connect(MigrationState *s, Error *er=
ror_in)
     bool resume =3D s->state =3D=3D MIGRATION_STATUS_POSTCOPY_PAUSED;
=20
     s->expected_downtime =3D s->parameters.downtime_limit;
-    s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup_bh, s);
+    if (resume) {
+        assert(s->cleanup_bh);
+    } else {
+        assert(!s->cleanup_bh);
+        s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup_bh, s);
+    }
     if (error_in) {
         migrate_fd_error(s, error_in);
         migrate_fd_cleanup(s);
--=20
2.26.0.rc2.42.g98cedd0233


