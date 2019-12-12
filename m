Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896F1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4848621556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwajLlna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4848621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWqk-00072i-7o
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpA-0005TP-N7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWp9-00074q-JD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27542
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWp9-000747-Em
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByQvAMQmCsWoiiElun+PKXGZ6EVZVpWv8lR3AkIPyo0=;
 b=KwajLlnaaYmBRaEeQNLC0i24jiQnCS0qrC9Mr1IgMII1SQlJCBBXnZopi8K35fl66Q5WAW
 oTzSUvYe4Os467BBFWSNrxNPfJ3u7Dbs9mFTk0qOi/WKTdwf/wvF7L+LrrfCw0s/lSf+kU
 YH6HEBi3JxwbPO+Wy7tU6jXyGN8p8qU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-KASFoeAsN4S8suekyMWmtg-1; Thu, 12 Dec 2019 17:20:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 845291854CE0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:40 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A78210013A1;
 Thu, 12 Dec 2019 22:20:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] migration-test: Move hide_stderr to common commandline
Date: Thu, 12 Dec 2019 23:20:25 +0100
Message-Id: <20191212222033.1026-3-quintela@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KASFoeAsN4S8suekyMWmtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 9573861ede..372e66c755 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -558,6 +558,7 @@ static int test_migrate_start(QTestState **from, QTestS=
tate **to,
 {
     gchar *cmd_src, *cmd_dst;
     gchar *cmd_source, *cmd_target;
+    const gchar *ignore_stderr;
     char *bootpath =3D NULL;
     char *extra_opts =3D NULL;
     char *shmem_path =3D NULL;
@@ -661,24 +662,19 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
     g_free(extra_opts);
=20
     if (hide_stderr) {
-        gchar *tmp;
-        tmp =3D g_strdup_printf("%s 2>/dev/null", cmd_src);
-        g_free(cmd_src);
-        cmd_src =3D tmp;
-
-        tmp =3D g_strdup_printf("%s 2>/dev/null", cmd_dst);
-        g_free(cmd_dst);
-        cmd_dst =3D tmp;
+        ignore_stderr =3D "2>/dev/null";
+    } else {
+        ignore_stderr =3D "";
     }
=20
-    cmd_source =3D g_strdup_printf("%s %s",
-                                 cmd_src, opts_src);
+    cmd_source =3D g_strdup_printf("%s %s %s",
+                                 cmd_src, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from =3D qtest_init(cmd_source);
     g_free(cmd_source);
=20
-    cmd_target =3D g_strdup_printf("%s %s",
-                                 cmd_dst, opts_dst);
+    cmd_target =3D g_strdup_printf("%s %s %s",
+                                 cmd_dst, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to =3D qtest_init(cmd_target);
     g_free(cmd_target);
--=20
2.21.0


