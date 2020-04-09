Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9806EC2BB86
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64825206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3lIetz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64825206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZCP-0006s0-HB
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jMZ8j-00016X-Gn
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jMZ8i-0003eo-2F
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jMZ8h-0003as-U6
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586446245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4StbKGvjqHRcrZFfc5OaMe1Xocyuir9bg9VtEJzmWo=;
 b=Y3lIetz+gwRQ9hfBptPFI0JhPaB606UCMhGZugEM0l+30XUlPZd9ifoL+bb+cADge6Rdk+
 MHVKFI4eEEITPzHTVoXBcyPoWQf7/gjmyHp9uvsvozOKsgttXRoupobQUZThf9PztTUfU9
 EDKFJuuChz0Q3VXZY/A+b+/0ybCR+uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-h4y8APE3NO-j_PAQfdL1Vg-1; Thu, 09 Apr 2020 11:30:43 -0400
X-MC-Unique: h4y8APE3NO-j_PAQfdL1Vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7A56107ACC4;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4F2A9D348;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A06611358AF; Thu,  9 Apr 2020 17:30:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 2/8] qemu-options: Factor out get_opt_name_value()
 helper
Date: Thu,  9 Apr 2020 17:30:35 +0200
Message-Id: <20200409153041.17576-3-armbru@redhat.com>
In-Reply-To: <20200409153041.17576-1-armbru@redhat.com>
References: <20200409153041.17576-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

The next commits will put it to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-option.c | 102 +++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 97172b5eaa..f08f4bc458 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -805,61 +805,71 @@ void qemu_opts_print(QemuOpts *opts, const char *sepa=
rator)
     }
 }
=20
+static const char *get_opt_name_value(const char *params,
+                                      const char *firstname,
+                                      char **name, char **value)
+{
+    const char *p, *pe, *pc;
+
+    pe =3D strchr(params, '=3D');
+    pc =3D strchr(params, ',');
+
+    if (!pe || (pc && pc < pe)) {
+        /* found "foo,more" */
+        if (firstname) {
+            /* implicitly named first option */
+            *name =3D g_strdup(firstname);
+            p =3D get_opt_value(params, value);
+        } else {
+            /* option without value, must be a flag */
+            p =3D get_opt_name(params, name, ',');
+            if (strncmp(*name, "no", 2) =3D=3D 0) {
+                memmove(*name, *name + 2, strlen(*name + 2) + 1);
+                *value =3D g_strdup("off");
+            } else {
+                *value =3D g_strdup("on");
+            }
+        }
+    } else {
+        /* found "foo=3Dbar,more" */
+        p =3D get_opt_name(params, name, '=3D');
+        assert(*p =3D=3D '=3D');
+        p++;
+        p =3D get_opt_value(p, value);
+    }
+
+    assert(!*p || *p =3D=3D ',');
+    if (*p =3D=3D ',') {
+        p++;
+    }
+    return p;
+}
+
 static void opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend,
                           bool *invalidp, Error **errp)
 {
-    char *option =3D NULL;
-    char *value =3D NULL;
-    const char *p,*pe,*pc;
     Error *local_err =3D NULL;
+    char *option, *value;
+    const char *p;
=20
-    for (p =3D params; *p !=3D '\0'; p++) {
-        pe =3D strchr(p, '=3D');
-        pc =3D strchr(p, ',');
-        if (!pe || (pc && pc < pe)) {
-            /* found "foo,more" */
-            if (p =3D=3D params && firstname) {
-                /* implicitly named first option */
-                option =3D g_strdup(firstname);
-                p =3D get_opt_value(p, &value);
-            } else {
-                /* option without value, probably a flag */
-                p =3D get_opt_name(p, &option, ',');
-                if (strncmp(option, "no", 2) =3D=3D 0) {
-                    memmove(option, option+2, strlen(option+2)+1);
-                    value =3D g_strdup("off");
-                } else {
-                    value =3D g_strdup("on");
-                }
-            }
-        } else {
-            /* found "foo=3Dbar,more" */
-            p =3D get_opt_name(p, &option, '=3D');
-            assert(*p =3D=3D '=3D');
-            p++;
-            p =3D get_opt_value(p, &value);
-        }
-        if (strcmp(option, "id") !=3D 0) {
-            /* store and parse */
-            opt_set(opts, option, value, prepend, invalidp, &local_err);
-            value =3D NULL;
-            if (local_err) {
-                error_propagate(errp, local_err);
-                goto cleanup;
-            }
-        }
-        if (*p !=3D ',') {
-            break;
+    for (p =3D params; *p;) {
+        p =3D get_opt_name_value(p, firstname, &option, &value);
+        firstname =3D NULL;
+
+        if (!strcmp(option, "id")) {
+            g_free(option);
+            g_free(value);
+            continue;
         }
+
+        opt_set(opts, option, value, prepend, invalidp, &local_err);
         g_free(option);
-        g_free(value);
-        option =3D value =3D NULL;
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
-
- cleanup:
-    g_free(option);
-    g_free(value);
 }
=20
 /**
--=20
2.21.1


