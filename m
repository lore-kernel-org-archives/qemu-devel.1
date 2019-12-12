Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1493F2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtZH7GZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1493F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTjv-0002b4-Rh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 14:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifTbx-0002Zs-VW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifTbw-00005e-FZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifTbw-00004s-Be
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576176891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMjt1IjbfyX/nQoPLOurZbh02AtyemNcphkPWo8n5nw=;
 b=FtZH7GZVfuN+tdUNpbKs5J08BJEo40kVECTcAHZFlUqxjMM7bPjiuhk6pga3fYnCePm9lq
 Bu3fP/rJN2StcVgn1xDEdQedMFkXJiNTpJEXu4pFwLyWPu/2E3QhkYLO3Kiv6wnDktKFNQ
 erVwb6j8e5/oc5WUtX4R1lYWQwx3cGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-RQoiUE3oN9eWYVF7g51UNQ-1; Thu, 12 Dec 2019 13:54:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12CAD800D41;
 Thu, 12 Dec 2019 18:54:49 +0000 (UTC)
Received: from thuth.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D58419C4F;
 Thu, 12 Dec 2019 18:54:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/10] glib: use portable g_setenv()
Date: Thu, 12 Dec 2019 19:54:22 +0100
Message-Id: <20191212185424.4675-9-thuth@redhat.com>
In-Reply-To: <20191212185424.4675-1-thuth@redhat.com>
References: <20191212185424.4675-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RQoiUE3oN9eWYVF7g51UNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

We have a setenv() wrapper in os-win32.c that no one is actually using.
Drop it and change to g_setenv() uniformly.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1576074210-52834-7-git-send-email-pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/os-win32.h        |  2 --
 os-win32.c                       | 22 ----------------------
 tests/libqtest.c                 |  2 +-
 tests/test-crypto-tlscredsx509.c |  2 +-
 tests/test-crypto-tlssession.c   |  2 +-
 tests/test-io-channel-tls.c      |  2 +-
 tests/test-vmstate.c             |  2 +-
 ui/sdl2.c                        |  2 +-
 8 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index ff18b23db1..d8978e28c0 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -67,8 +67,6 @@ int getpagesize(void);
 # define EPROTONOSUPPORT EINVAL
 #endif
=20
-int setenv(const char *name, const char *value, int overwrite);
-
 typedef struct {
     long tv_sec;
     long tv_usec;
diff --git a/os-win32.c b/os-win32.c
index 1336cd34f0..6b86e022f0 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -30,28 +30,6 @@
 #include "qemu-options.h"
 #include "sysemu/runstate.h"
=20
-/***********************************************************/
-/* Functions missing in mingw */
-
-int setenv(const char *name, const char *value, int overwrite)
-{
-    int result =3D 0;
-    if (overwrite || !getenv(name)) {
-        size_t length =3D strlen(name) + strlen(value) + 2;
-        char *string =3D g_malloc(length);
-        snprintf(string, length, "%s=3D%s", name, value);
-        result =3D putenv(string);
-
-        /* Windows takes a copy and does not continue to use our string.
-         * Therefore it can be safely freed on this platform.  POSIX code
-         * typically has to leak the string because according to the spec =
it
-         * becomes part of the environment.
-         */
-        g_free(string);
-    }
-    return result;
-}
-
 static BOOL WINAPI qemu_ctrl_handler(DWORD type)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_SIGNAL);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 91e9cb220c..f36e30a4de 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -254,7 +254,7 @@ QTestState *qtest_init_without_qmp_handshake(const char=
 *extra_args)
     s->expected_status =3D 0;
     s->qemu_pid =3D fork();
     if (s->qemu_pid =3D=3D 0) {
-        setenv("QEMU_AUDIO_DRV", "none", true);
+        g_setenv("QEMU_AUDIO_DRV", "none", true);
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
     }
diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscredsx=
509.c
index a27efb7540..f487349c32 100644
--- a/tests/test-crypto-tlscredsx509.c
+++ b/tests/test-crypto-tlscredsx509.c
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
=20
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
-    setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
+    g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
=20
     mkdir(WORKDIR, 0700);
=20
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.=
c
index 6560d7134f..8b2453fa79 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -398,7 +398,7 @@ int main(int argc, char **argv)
=20
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
-    setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
+    g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
=20
     mkdir(WORKDIR, 0700);
=20
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 3c9ef6f941..ad7554c534 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -273,7 +273,7 @@ int main(int argc, char **argv)
=20
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
-    setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
+    g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
=20
     mkdir(WORKDIR, 0700);
=20
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 1e5be1d4ff..8f184f3556 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -1325,7 +1325,7 @@ int main(int argc, char **argv)
=20
     module_call_init(MODULE_INIT_QOM);
=20
-    setenv("QTEST_SILENT_ERRORS", "1", 1);
+    g_setenv("QTEST_SILENT_ERRORS", "1", 1);
=20
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/vmstate/simple/primitive", test_simple_primitive);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4e73661d..9030f1c42e 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -772,7 +772,7 @@ static void sdl2_display_init(DisplayState *ds, Display=
Options *o)
      * This is a bit hackish but saves us from bigger problem.
      * Maybe it's a good idea to fix this in SDL instead.
      */
-    setenv("SDL_VIDEODRIVER", "x11", 0);
+    g_setenv("SDL_VIDEODRIVER", "x11", 0);
 #endif
=20
     if (SDL_Init(SDL_INIT_VIDEO)) {
--=20
2.18.1


