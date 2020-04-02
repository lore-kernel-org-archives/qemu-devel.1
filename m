Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52AAC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D13A206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoVqnkF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D13A206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5IE-0005in-Po
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0002Ue-VS
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B0-0000QU-Tm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44421
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5B0-0000QA-PN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAHg1jLQ/+hiDQf0/HvgOsrR0/PB04onhEW2w2UkMdw=;
 b=MoVqnkF92RyvpYD7cVWZ3IobtnqSWoIy69jC5PMRivi/rb4u+IINZjSy4RlvXeAepZ9yCX
 0/9tFnpnLbjSNefjEthwC7JBYWFGQpGXqDil/WBaGcVEyFCCgm+ERs3AJCCxHn3Xk0P+Xo
 oLrNDZO4R9NM80ZZxmOP0e3lHLND89g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-zvC6ni4wNgil-SYfJG3PEg-1; Thu, 02 Apr 2020 15:06:52 -0400
X-MC-Unique: zvC6ni4wNgil-SYfJG3PEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0E3100551A
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D0B550BEE;
 Thu,  2 Apr 2020 19:06:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] migration: fix cleanup_bh leak on resume
Date: Thu,  2 Apr 2020 15:06:37 -0400
Message-Id: <20200402190640.1693-13-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Message-Id: <20200325184723.2029630-2-marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/migration.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index c4c9aee15e..187ac0410c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3478,7 +3478,12 @@ void migrate_fd_connect(MigrationState *s, Error *er=
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
2.18.2



