Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C89C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4582077B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmuchbaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4582077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5pQ-0004SG-9T
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is5oe-0003tt-Fe
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is5oZ-0002DP-Hp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:08:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is5oZ-0002CO-Dn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579183682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IIl4vIhCzvphxvQp5CpPqa6PsTD+Yz81NsM/TKK9TSU=;
 b=XmuchbaXHwVisGC/jMKPzDCxxjrsdeUY01rQcqJQoHTtxUVthLeYQ0z+i8uRrhJ5FE1cHP
 T7/cQUX+vrF2bBoy74TeQC7cYLsNNycw7s9ZzJ+3MdK5uuKBfQ2DMs9sqvN+E5oSf/2uWL
 /aBnTs1zzvzk4sIgR4NIVh3G7QwG9Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-7AYLYGzDMcq7nr-rJSy3xA-1; Thu, 16 Jan 2020 09:07:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8B410CE78A;
 Thu, 16 Jan 2020 14:07:48 +0000 (UTC)
Received: from thuth.com (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F21569CA3;
 Thu, 16 Jan 2020 14:07:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/vhost-user-test: Fix memory leaks
Date: Thu, 16 Jan 2020 15:07:36 +0100
Message-Id: <20200116140736.9498-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 7AYLYGzDMcq7nr-rJSy3xA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not allocate resources in case we return early, and make sure
to free dest_cmdline at the end.

Reported-by: Euler Robot <euler.robot@huawei.com>
Reported-by: Pan Nengyuan <pannengyuan@huawei.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Based on a similar patch by Pan Nengyuan:
  https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg02183.html
 ... but that was causing some very weird problems in the gitlab CI
 for unknown reasons. This version now works fine in the gitlab CI.
 =20
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


