Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C9C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B607B20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9nENboF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B607B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPVM-0008KL-Jj
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isPUD-0006sk-Ru
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isPUA-0003nY-9v
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isPUA-0003nJ-6I
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579259297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJ0XGVHAE9NIFI5dmtEf0ZRJjpIbSKgQaFzPzi/qAVE=;
 b=V9nENboF8HgCsUadj7en5LDR8HnZehjQVJwpehICtJm0HUVB3XoPsi1yV9ACXbH1UEx+nd
 S7HGSYA722tJgBhSKPMdOLE/c9oI4VlLb0g0l1QOBoM4+vvEhJaM7N+XPn7+9oewV/tbsF
 5b3n7ul0ljCCqiKvBiGxjaShUgqLDSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-0XuAcesuOJObVNPYJ4c6kA-1; Fri, 17 Jan 2020 06:08:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90B5107ACC4;
 Fri, 17 Jan 2020 11:08:11 +0000 (UTC)
Received: from thuth.com (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D337F60F82;
 Fri, 17 Jan 2020 11:08:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/4] tests/qtest/vhost-user-test: Fix memory leaks
Date: Fri, 17 Jan 2020 12:07:57 +0100
Message-Id: <20200117110758.1995-4-thuth@redhat.com>
In-Reply-To: <20200117110758.1995-1-thuth@redhat.com>
References: <20200117110758.1995-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0XuAcesuOJObVNPYJ4c6kA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not allocate resources in case we return early, and make sure
to free dest_cmdline at the end.

Reported-by: Euler Robot <euler.robot@huawei.com>
Reported-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200116140736.9498-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/vhost-user-test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 2324b964ad..9ee0f1e4fd 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -707,9 +707,9 @@ static void test_read_guest_mem(void *obj, void *arg, Q=
GuestAllocator *alloc)
 static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *s =3D arg;
-    TestServer *dest =3D test_server_new("dest");
-    GString *dest_cmdline =3D g_string_new(qos_get_current_command_line())=
;
-    char *uri =3D g_strdup_printf("%s%s", "unix:", dest->mig_path);
+    TestServer *dest;
+    GString *dest_cmdline;
+    char *uri;
     QTestState *to;
     GSource *source;
     QDict *rsp;
@@ -720,6 +720,10 @@ static void test_migrate(void *obj, void *arg, QGuestA=
llocator *alloc)
         return;
     }
=20
+    dest =3D test_server_new("dest");
+    dest_cmdline =3D g_string_new(qos_get_current_command_line());
+    uri =3D g_strdup_printf("%s%s", "unix:", dest->mig_path);
+
     size =3D get_log_size(s);
     g_assert_cmpint(size, =3D=3D, (256 * 1024 * 1024) / (VHOST_LOG_PAGE * =
8));
=20
@@ -778,6 +782,7 @@ static void test_migrate(void *obj, void *arg, QGuestAl=
locator *alloc)
     qtest_quit(to);
     test_server_free(dest);
     g_free(uri);
+    g_string_free(dest_cmdline, true);
 }
=20
 static void wait_for_rings_started(TestServer *s, size_t count)
--=20
2.18.1


