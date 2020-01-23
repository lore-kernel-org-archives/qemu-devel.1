Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3842524676
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrgNFDfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842524676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufXb-00059y-J8
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuj-0001vz-Pw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucui-0001Th-FE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucui-0001TT-C2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ejszrz+sWDo4lg8YVhY65tpbtbNsuy8cfAUAhhzXAok=;
 b=DrgNFDfien4jeLLsgWT4I94JjuOlmoIYyyp7v7NY9B88p4+aYjoGTbWejy/08V/QOKqGwJ
 gfhjQZlfazkEwdnPtlZSyn1lHxMQ09IP2l1xIInjjDk9p5rsLbmTj4xwgIz7Kdpo2r/mI9
 pHJaMNHDv+4iMxMexMhzrIB4gwWZv3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-q5E-_50hODqEjioyrtp8LA-1; Thu, 23 Jan 2020 08:52:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8C710110CD
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 998B61CB;
 Thu, 23 Jan 2020 13:52:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 59/59] tests: fix test-qga on macosx
Date: Thu, 23 Jan 2020 14:50:49 +0100
Message-Id: <1579787449-27599-60-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: q5E-_50hODqEjioyrtp8LA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Fix Unix socket connection & skip commands that are not implemented.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  2 +-
 tests/test-qga.c       | 25 ++++++++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c6827ce..87a256c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -119,7 +119,7 @@ check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-secre=
t$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-c=
rypto-tlscredsx509$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-c=
rypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests=
/test-qga$(EXESUF)
+check-unit-$(call land,$(CONFIG_POSIX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests=
/test-qga$(EXESUF)
 endif
 check-unit-y +=3D tests/test-timed-average$(EXESUF)
 check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
diff --git a/tests/test-qga.c b/tests/test-qga.c
index d2b2435..191bfca 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -17,17 +17,17 @@ typedef struct {
=20
 static int connect_qga(char *path)
 {
-    int s, ret, len, i =3D 0;
+    int s, ret, i =3D 0;
     struct sockaddr_un remote;
=20
     s =3D socket(AF_UNIX, SOCK_STREAM, 0);
     g_assert(s !=3D -1);
=20
+    memset(&remote, 0, sizeof(struct sockaddr_un));
     remote.sun_family =3D AF_UNIX;
     do {
-        strcpy(remote.sun_path, path);
-        len =3D strlen(remote.sun_path) + sizeof(remote.sun_family);
-        ret =3D connect(s, (struct sockaddr *)&remote, len);
+        strncpy(remote.sun_path, path, sizeof(remote.sun_path) - 1);
+        ret =3D connect(s, (struct sockaddr *)&remote, sizeof(struct socka=
ddr_un));
         if (ret =3D=3D -1) {
             g_usleep(G_USEC_PER_SEC);
         }
@@ -305,6 +305,7 @@ static void test_qga_info(gconstpointer fix)
     qobject_unref(ret);
 }
=20
+#if defined(CONFIG_LINUX)
 static void test_qga_get_vcpus(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
@@ -324,7 +325,9 @@ static void test_qga_get_vcpus(gconstpointer fix)
=20
     qobject_unref(ret);
 }
+#endif
=20
+#if defined(CONFIG_LINUX)
 static void test_qga_get_fsinfo(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
@@ -348,6 +351,7 @@ static void test_qga_get_fsinfo(gconstpointer fix)
=20
     qobject_unref(ret);
 }
+#endif
=20
 static void test_qga_get_memory_block_info(gconstpointer fix)
 {
@@ -394,6 +398,7 @@ static void test_qga_get_memory_blocks(gconstpointer fi=
x)
     qobject_unref(ret);
 }
=20
+#if defined(CONFIG_LINUX)
 static void test_qga_network_get_interfaces(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
@@ -412,6 +417,7 @@ static void test_qga_network_get_interfaces(gconstpoint=
er fix)
=20
     qobject_unref(ret);
 }
+#endif
=20
 static void test_qga_file_ops(gconstpointer fix)
 {
@@ -682,7 +688,7 @@ static void test_qga_blacklist(gconstpointer data)
     qobject_unref(ret);
=20
     /* check something work */
-    ret =3D qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
+    ret =3D qmp_fd(fix.fd, "{'execute': 'guest-info'}");
     qmp_assert_no_error(ret);
     qobject_unref(ret);
=20
@@ -766,6 +772,7 @@ static void test_qga_config(gconstpointer data)
     g_key_file_free(kf);
 }
=20
+#if defined(CONFIG_LINUX)
 static void test_qga_fsfreeze_status(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
@@ -781,6 +788,7 @@ static void test_qga_fsfreeze_status(gconstpointer fix)
=20
     qobject_unref(ret);
 }
+#endif
=20
 static void test_qga_guest_exec(gconstpointer fix)
 {
@@ -976,12 +984,17 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/sync", &fix, test_qga_sync);
     g_test_add_data_func("/qga/ping", &fix, test_qga_ping);
     g_test_add_data_func("/qga/info", &fix, test_qga_info);
+#if defined(CONFIG_LINUX)
     g_test_add_data_func("/qga/network-get-interfaces", &fix,
                          test_qga_network_get_interfaces);
     if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
         g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
     }
     g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
+    g_test_add_data_func("/qga/fsfreeze-status", &fix,
+                         test_qga_fsfreeze_status);
+#endif
+
     g_test_add_data_func("/qga/get-memory-block-info", &fix,
                          test_qga_get_memory_block_info);
     g_test_add_data_func("/qga/get-memory-blocks", &fix,
@@ -993,8 +1006,6 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob);
     g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
     g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args)=
;
-    g_test_add_data_func("/qga/fsfreeze-status", &fix,
-                         test_qga_fsfreeze_status);
=20
     g_test_add_data_func("/qga/blacklist", NULL, test_qga_blacklist);
     g_test_add_data_func("/qga/config", NULL, test_qga_config);
--=20
1.8.3.1


