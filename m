Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446C720753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWD2mG2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446C720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZEL-0001EL-DV
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jMZ8i-00016P-Rr
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jMZ8h-0003dJ-IS
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jMZ8h-0003ce-ES
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586446247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D52HEWAzlQgS5JHdsYMyhl6MkozwaRB13MAOJ0BhICM=;
 b=FWD2mG2yDOltLUSxQ/nE/qYDXuxcQ1zoDSfidUFg5ARG00PYJU5yPTbSBYFmVg4J1RWMwg
 VXZsx1NYOz/cPGKWwxf18Q8tNx2r4wwTFGFjAje/IjbjX5c6yL87IDENh9Pe/pvqxSL3Ok
 t+yo3yl0ChL94pZWSG0UwpipCWE/W8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-47Mofi4lOB-d3n35iuaECg-1; Thu, 09 Apr 2020 11:30:45 -0400
X-MC-Unique: 47Mofi4lOB-d3n35iuaECg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC0F8017F3;
 Thu,  9 Apr 2020 15:30:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 378AD5C545;
 Thu,  9 Apr 2020 15:30:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A91E11358B7; Thu,  9 Apr 2020 17:30:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 7/8] qemu-img: Factor out accumulate_options() helper
Date: Thu,  9 Apr 2020 17:30:40 +0200
Message-Id: <20200409153041.17576-8-armbru@redhat.com>
In-Reply-To: <20200409153041.17576-1-armbru@redhat.com>
References: <20200409153041.17576-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-img.c | 59 +++++++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b167376bd7..28b27b738a 100644
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


