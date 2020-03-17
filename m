Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF62C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7092020735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZCTNYJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7092020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGdO-000859-Jg
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEGRL-0000Ll-GW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEGRK-000627-31
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:55:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36603)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEGRJ-0005uz-Tg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584467741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bMK6XfK9vehRdbJFxq/pHg1LB0t8hDi00V1bAJFLWdU=;
 b=GZCTNYJH6ZeWE1ToadYOBpdQBx1xDpSB4RFWss00J7Z/AmmLey60xJ8OKXTA1Pz1xYSA9g
 gHLxaICkNoK9RwzB5TsDWv5gmM63JFCUbBVJC3GmWtYv6aUsS/PFCrVomAIG5xpFG6S02u
 xThyxruE+QsjAMAfqSADxFG+Qo9GX6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-kAxLUTOPPyGcD71T3T5G4A-1; Tue, 17 Mar 2020 13:55:39 -0400
X-MC-Unique: kAxLUTOPPyGcD71T3T5G4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF18101FC60;
 Tue, 17 Mar 2020 17:55:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF7735DA7C;
 Tue, 17 Mar 2020 17:55:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build: Silence clang warning on older glib autoptr usage
Date: Tue, 17 Mar 2020 12:55:34 -0500
Message-Id: <20200317175534.196295-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: berrange@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

glib's G_DEFINE_AUTOPTR_CLEANUP_FUNC() macro defines several static
inline functions, often with some of them unused, but prior to 2.57.2
did not mark the functions as such.  As a result, clang (but not gcc)
fails to build with older glib unless -Wno-unused-function is enabled.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

Half-tested: I proved to myself that this does NOT enable
-Wno-unused-function on my setup of glib 2.62.5 and gcc 9.2.1 (Fedora
31), but would do so if I introduced an intentional compile error into
the sample program; but Iwas unable to test that it would prevent the
build failure encountered by Peter on John's pull request (older glib
but exact version unknown, clang, on NetBSD).

 configure | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configure b/configure
index eb49bb6680c1..57a72f120aa9 100755
--- a/configure
+++ b/configure
@@ -3832,6 +3832,26 @@ if ! compile_prog "$glib_cflags -Werror" "$glib_libs=
" ; then
     fi
 fi

+# Silence clang warnings triggered by glib < 2.57.2
+cat > $TMPC << EOF
+#include <glib.h>
+typedef struct Foo {
+    int i;
+} Foo;
+static void foo_free(Foo *f)
+{
+    g_free(f);
+}
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free);
+int main(void) { return 0; }
+EOF
+if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
+    if cc_has_warning_flag "-Wno-unused-function"; then
+        glib_cflags=3D"$glib_cflags -Wno-unused-function"
+        CFLAGS=3D"$CFLAGS -Wno-unused-function"
+    fi
+fi
+
 #########################################
 # zlib check

--=20
2.25.1


