Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD80C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 20:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DD92067B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 20:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DD92067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ20K-0001HU-6p
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 16:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iJ1xW-0006b4-Aw
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 16:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iJ1xV-0001P5-4f
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 16:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iJ1xS-0001Nz-GA; Fri, 11 Oct 2019 16:56:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFA75300C035;
 Fri, 11 Oct 2019 20:56:17 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A56376092F;
 Fri, 11 Oct 2019 20:56:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/4] qemu-img: Support help options for --object
Date: Fri, 11 Oct 2019 22:55:50 +0200
Message-Id: <20191011205551.32149-4-kwolf@redhat.com>
In-Reply-To: <20191011205551.32149-1-kwolf@redhat.com>
References: <20191011205551.32149-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 11 Oct 2019 20:56:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of parsing help options as normal object properties and
returning an error, provide the same help functionality as the system
emulator in qemu-img, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 384c6f38bc..8b03ef8171 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -214,6 +214,14 @@ static QemuOptsList qemu_object_opts =3D {
     },
 };
=20
+static bool qemu_img_object_print_help(const char *type, QemuOpts *opts)
+{
+    if (user_creatable_print_help(type, opts)) {
+        exit(0);
+    }
+    return true;
+}
+
 static QemuOptsList qemu_source_opts =3D {
     .name =3D "source",
     .implied_opt_name =3D "file",
@@ -516,7 +524,7 @@ static int img_create(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         goto fail;
     }
=20
@@ -766,7 +774,7 @@ static int img_check(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         return 1;
     }
=20
@@ -979,7 +987,7 @@ static int img_commit(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         return 1;
     }
=20
@@ -1362,7 +1370,7 @@ static int img_compare(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         ret =3D 2;
         goto out4;
     }
@@ -2210,7 +2218,7 @@ static int img_convert(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         goto fail_getopt;
     }
=20
@@ -2776,7 +2784,7 @@ static int img_info(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         return 1;
     }
=20
@@ -3002,7 +3010,7 @@ static int img_map(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         return 1;
     }
=20
@@ -3154,7 +3162,7 @@ static int img_snapshot(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         return 1;
     }
=20
@@ -3321,7 +3329,7 @@ static int img_rebase(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         return 1;
     }
=20
@@ -3742,7 +3750,7 @@ static int img_resize(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         return 1;
     }
=20
@@ -3986,7 +3994,7 @@ static int img_amend(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         ret =3D -1;
         goto out_no_progress;
     }
@@ -4630,7 +4638,7 @@ static int img_dd(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         ret =3D -1;
         goto out;
     }
@@ -4907,7 +4915,7 @@ static int img_measure(int argc, char **argv)
=20
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
-                          NULL, &error_fatal)) {
+                          qemu_img_object_print_help, &error_fatal)) {
         goto out;
     }
=20
--=20
2.20.1


