Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB05C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C0520768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOJfVF1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C0520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcvK-0002pE-Mu
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOcnf-0006PB-GK
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOcnd-0007L4-Qw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:49:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOcnd-0007KC-Lm
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apeeM7s/Me0ShiEgPJBP2dbh22rv4ahsU5BowSbT83U=;
 b=FOJfVF1JN9kcBOFO9N6axD0eTbeA4YDYAE6uPu99FeLZxrHSBo0WTZSzo/B9yTnUxY6jau
 RbFfhXjfUK8TXslw5Sp1gTLUGNUqaSggT9tgSL2Jr+nE+F859ykXCtVrWiUYprH/2THrrV
 SkteINtO3dVMnsgXSbxsrjR9vHq2I0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-d6G9fokbNimV-Va6PpK2Mw-1; Wed, 15 Apr 2020 03:49:31 -0400
X-MC-Unique: d6G9fokbNimV-Va6PpK2Mw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A993B10CE783;
 Wed, 15 Apr 2020 07:49:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A83BA0983;
 Wed, 15 Apr 2020 07:49:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4F9811358B7; Wed, 15 Apr 2020 09:49:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 for-5.1 7/9] qemu-img: Factor out accumulate_options()
 helper
Date: Wed, 15 Apr 2020 09:49:25 +0200
Message-Id: <20200415074927.19897-8-armbru@redhat.com>
In-Reply-To: <20200415074927.19897-1-armbru@redhat.com>
References: <20200415074927.19897-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 59 +++++++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 821cbf610e..d36b21b758 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -223,6 +223,25 @@ static bool qemu_img_object_print_help(const char *typ=
e, QemuOpts *opts)
     return true;
 }
=20
+static int accumulate_options(char **options, char *optarg)
+{
+    char *new_options;
+
+    if (!is_valid_option_list(optarg)) {
+        error_report("Invalid option list: %s", optarg);
+        return -1;
+    }
+
+    if (!*options) {
+        *options =3D g_strdup(optarg);
+    } else {
+        new_options =3D g_strdup_printf("%s,%s", *options, optarg);
+        g_free(*options);
+        *options =3D new_options;
+    }
+    return 0;
+}
+
 static QemuOptsList qemu_source_opts =3D {
     .name =3D "source",
     .implied_opt_name =3D "file",
@@ -482,17 +501,9 @@ static int img_create(int argc, char **argv)
             fmt =3D optarg;
             break;
         case 'o':
-            if (!is_valid_option_list(optarg)) {
-                error_report("Invalid option list: %s", optarg);
+            if (accumulate_options(&options, optarg) < 0) {
                 goto fail;
             }
-            if (!options) {
-                options =3D g_strdup(optarg);
-            } else {
-                char *old_options =3D options;
-                options =3D g_strdup_printf("%s,%s", options, optarg);
-                g_free(old_options);
-            }
             break;
         case 'q':
             quiet =3D true;
@@ -2127,17 +2138,9 @@ static int img_convert(int argc, char **argv)
             s.compressed =3D true;
             break;
         case 'o':
-            if (!is_valid_option_list(optarg)) {
-                error_report("Invalid option list: %s", optarg);
+            if (accumulate_options(&options, optarg) < 0) {
                 goto fail_getopt;
             }
-            if (!options) {
-                options =3D g_strdup(optarg);
-            } else {
-                char *old_options =3D options;
-                options =3D g_strdup_printf("%s,%s", options, optarg);
-                g_free(old_options);
-            }
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
@@ -3953,18 +3956,10 @@ static int img_amend(int argc, char **argv)
             help();
             break;
         case 'o':
-            if (!is_valid_option_list(optarg)) {
-                error_report("Invalid option list: %s", optarg);
+            if (accumulate_options(&options, optarg) < 0) {
                 ret =3D -1;
                 goto out_no_progress;
             }
-            if (!options) {
-                options =3D g_strdup(optarg);
-            } else {
-                char *old_options =3D options;
-                options =3D g_strdup_printf("%s,%s", options, optarg);
-                g_free(old_options);
-            }
             break;
         case 'f':
             fmt =3D optarg;
@@ -4855,17 +4850,9 @@ static int img_measure(int argc, char **argv)
             out_fmt =3D optarg;
             break;
         case 'o':
-            if (!is_valid_option_list(optarg)) {
-                error_report("Invalid option list: %s", optarg);
+            if (accumulate_options(&options, optarg) < 0) {
                 goto out;
             }
-            if (!options) {
-                options =3D g_strdup(optarg);
-            } else {
-                char *old_options =3D options;
-                options =3D g_strdup_printf("%s,%s", options, optarg);
-                g_free(old_options);
-            }
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
--=20
2.21.1


