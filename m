Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF08C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0823A22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0823A22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UWT-00078b-SH
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPS-0006X4-Rh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPR-0005AB-PM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPR-000592-Jw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EED7F191C687
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:32 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E990260F88;
 Wed, 21 Aug 2019 17:28:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:12 +0200
Message-Id: <1566408501-48680-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 21 Aug 2019 17:28:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/13] module: return success on module load
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

Let the caller know of load success.

Note that this also changes slightly the behaviour of the function to
try loading on subsequent calls if the previous ones failed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/module.h |  2 +-
 util/module.c         | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index db30653..65ba596 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -65,6 +65,6 @@ void register_module_init(void (*fn)(void), module_init=
_type type);
 void register_dso_module_init(void (*fn)(void), module_init_type type);
=20
 void module_call_init(module_init_type type);
-void module_load_one(const char *prefix, const char *lib_name);
+bool module_load_one(const char *prefix, const char *lib_name);
=20
 #endif
diff --git a/util/module.c b/util/module.c
index ca9885c..e9fe3e5 100644
--- a/util/module.c
+++ b/util/module.c
@@ -156,8 +156,10 @@ out:
 }
 #endif
=20
-void module_load_one(const char *prefix, const char *lib_name)
+bool module_load_one(const char *prefix, const char *lib_name)
 {
+    bool success =3D false;
+
 #ifdef CONFIG_MODULES
     char *fname =3D NULL;
     char *exec_dir;
@@ -170,7 +172,7 @@ void module_load_one(const char *prefix, const char *=
lib_name)
=20
     if (!g_module_supported()) {
         fprintf(stderr, "Module is not supported by system.\n");
-        return;
+        return false;
     }
=20
     if (!loaded_modules) {
@@ -181,7 +183,7 @@ void module_load_one(const char *prefix, const char *=
lib_name)
=20
     if (!g_hash_table_add(loaded_modules, module_name)) {
         g_free(module_name);
-        return;
+        return true;
     }
=20
     exec_dir =3D qemu_get_exec_dir();
@@ -205,13 +207,19 @@ void module_load_one(const char *prefix, const char=
 *lib_name)
         fname =3D NULL;
         /* Try loading until loaded a module file */
         if (!ret) {
+            success =3D true;
             break;
         }
     }
=20
+    if (!success) {
+        g_hash_table_remove(loaded_modules, module_name);
+    }
+
     for (i =3D 0; i < n_dirs; i++) {
         g_free(dirs[i]);
     }
=20
 #endif
+    return success;
 }
--=20
1.8.3.1



