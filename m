Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E5DC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C13C20777
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3k8O6nT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C13C20777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfJT-0005e8-5A
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jEfEz-0006sg-Oh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jEfEy-0002Lv-JI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:24:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jEfEy-0002KT-FK
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584563073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9lbwOKLskc4XpV5HM+gjc7F18xWnZPhhhsdSKTCVGE=;
 b=L3k8O6nTgtjKvMdTlQqapzVPYStWrDtpbyPisQTMGiURiFeyStgrtpYOlkk7JJ+4OeC+yJ
 geUZZMoqQqAyB7ar/alPJfiX2ZhRoMeG0PwnY/1L2yAe014SmVXNDrwPRe7pUMaOgk4Cyg
 u6CAXzMHPNtsnCcMQXr62rLNCE9JZSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-rNHVvXVtMCy7NZ3bjgOG1g-1; Wed, 18 Mar 2020 16:24:30 -0400
X-MC-Unique: rNHVvXVtMCy7NZ3bjgOG1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D3C78024DA;
 Wed, 18 Mar 2020 20:24:27 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D31FB6106D;
 Wed, 18 Mar 2020 20:24:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, jsnow@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 01/11] build: Silence clang warning on older glib autoptr
 usage
Date: Wed, 18 Mar 2020 16:23:31 -0400
Message-Id: <20200318202341.6961-2-jsnow@redhat.com>
In-Reply-To: <20200318202341.6961-1-jsnow@redhat.com>
References: <20200318202341.6961-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

glib's G_DEFINE_AUTOPTR_CLEANUP_FUNC() macro defines several static
inline functions, often with some of them unused, but prior to 2.57.2
did not mark the functions as such.  As a result, clang (but not gcc)
fails to build with older glib unless -Wno-unused-function is enabled.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200317175534.196295-1-eblake@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configure b/configure
index 06fcd070fb..479336bf6e 100755
--- a/configure
+++ b/configure
@@ -3851,6 +3851,26 @@ if ! compile_prog "$glib_cflags -Werror" "$glib_libs=
" ; then
     fi
 fi
=20
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
=20
--=20
2.21.1


