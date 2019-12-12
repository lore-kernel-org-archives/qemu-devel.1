Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496A42077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2hNUIbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496A42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTmi-0005F1-Eh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 14:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifTc8-0002nD-KD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifTc4-0000KW-SQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:55:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifTc4-0000Jh-Nz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576176900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAdT6VOY0Ne6iSSofvCt/EzmDvcLOV6lujrEWJJqt2Q=;
 b=X2hNUIbQL3ZJeMJE61Kl4H2TI2pjaEqXHDMocpM6ilXFl1txHNJft704A5ueox0TT0iR/j
 SsC+KO1KSqe2NeWNhdtaurLJdnXrcUbf7JMdLrstxrBa3OdgOFdf4kbIMmG8MeLafw+7y/
 yPEFDo1a+IcKDDjCYD7l0M9PaxYTKQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-fPM9I2JvOlqYmWcLvesSHg-1; Thu, 12 Dec 2019 13:54:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5D3800D41;
 Thu, 12 Dec 2019 18:54:57 +0000 (UTC)
Received: from thuth.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5E1019C4F;
 Thu, 12 Dec 2019 18:54:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 10/10] tests: use g_test_rand_int
Date: Thu, 12 Dec 2019 19:54:24 +0100
Message-Id: <20191212185424.4675-11-thuth@redhat.com>
In-Reply-To: <20191212185424.4675-1-thuth@redhat.com>
References: <20191212185424.4675-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: fPM9I2JvOlqYmWcLvesSHg-1
X-Mimecast-Spam-Score: 0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

g_test_rand_int provides a reproducible random integer number, using a
different number seed every time but allowing reproduction using the
--seed command line option.  It is thus better suited to tests than
g_random_int or random.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1576113478-42926-1-git-send-email-pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ivshmem-test.c | 2 +-
 tests/test-bitmap.c  | 8 ++++----
 tests/test-qga.c     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index be9aa92a61..ecda256472 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -443,7 +443,7 @@ static gchar *mktempshm(int size, int *fd)
     while (true) {
         gchar *name;
=20
-        name =3D g_strdup_printf("/qtest-%u-%u", getpid(), g_random_int())=
;
+        name =3D g_strdup_printf("/qtest-%u-%u", getpid(), g_test_rand_int=
());
         *fd =3D shm_open(name, O_CREAT|O_RDWR|O_EXCL,
                        S_IRWXU|S_IRWXG|S_IRWXO);
         if (*fd > 0) {
diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index 087e02a26c..2f5b71458a 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -22,10 +22,10 @@ static void check_bitmap_copy_with_offset(void)
     bmap2 =3D bitmap_new(BMAP_SIZE);
     bmap3 =3D bitmap_new(BMAP_SIZE);
=20
-    bmap1[0] =3D random();
-    bmap1[1] =3D random();
-    bmap1[2] =3D random();
-    bmap1[3] =3D random();
+    bmap1[0] =3D g_test_rand_int();
+    bmap1[1] =3D g_test_rand_int();
+    bmap1[2] =3D g_test_rand_int();
+    bmap1[3] =3D g_test_rand_int();
     total =3D BITS_PER_LONG * 4;
=20
     /* Shift 115 bits into bmap2 */
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 1ca49bbced..d2b2435bb4 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -143,7 +143,7 @@ static void qmp_assertion_message_error(const char     =
*domain,
 static void test_qga_sync_delimited(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
-    guint32 v, r =3D g_random_int();
+    guint32 v, r =3D g_test_rand_int();
     unsigned char c;
     QDict *ret;
=20
@@ -186,7 +186,7 @@ static void test_qga_sync_delimited(gconstpointer fix)
 static void test_qga_sync(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
-    guint32 v, r =3D g_random_int();
+    guint32 v, r =3D g_test_rand_int();
     QDict *ret;
=20
     /*
--=20
2.18.1


