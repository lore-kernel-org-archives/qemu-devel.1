Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A75C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3148520775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X42Bi01h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3148520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh8w-0003fr-AP
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1q-0007tU-R5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1c-0003u0-8R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1b-0003qe-Mh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRERRyG7fjjzAR2u6+g0KLtZHvTM2XC2r+BKiMNxEbM=;
 b=X42Bi01hNDOYzl+//DTq5vRnNjB7sOI5kDOwvbnJLXps0WlhuL9R5J4KMCwsgikkmziJ3Y
 xDIVKkRPe/f6iUNpmpHjAslga+OrJKgBvKoBpZks9N8YVtnX/Vuzo+Ma3yoRHvsjUbKbwE
 BBf6ESG/tb7NbMYIpSYvlQ8G/D5yPns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-yw2oXDZHOnObayMQd6kKkg-1; Wed, 29 Apr 2020 03:20:53 -0400
X-MC-Unique: yw2oXDZHOnObayMQd6kKkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 268CE1009445
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA1635C1BE;
 Wed, 29 Apr 2020 07:20:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2FC911358C5; Wed, 29 Apr 2020 09:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] qemu-img: Move is_valid_option_list() to qemu-img.c and
 rewrite
Date: Wed, 29 Apr 2020 09:20:25 +0200
Message-Id: <20200429072048.29963-10-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

is_valid_option_list()'s purpose is ensuring qemu-img.c's can safely
join multiple parameter strings separated by ',' like this:

        g_strdup_printf("%s,%s", params1, params2);

How it does that is anything but obvious.  A close reading of the code
reveals that it fails exactly when its argument starts with ',' or
ends with an odd number of ','.  Makes sense, actually, because when
the argument starts with ',', a separating ',' preceding it would get
escaped, and when it ends with an odd number of ',', a separating ','
following it would get escaped.

Move it to qemu-img.c and rewrite it the obvious way.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200415074927.19897-9-armbru@redhat.com>
---
 include/qemu/option.h |  1 -
 qemu-img.c            | 26 ++++++++++++++++++++++++++
 util/qemu-option.c    | 22 ----------------------
 3 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 844587cab3..eb4097889d 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -33,7 +33,6 @@ const char *get_opt_value(const char *p, char **value);
 void parse_option_size(const char *name, const char *value,
                        uint64_t *ret, Error **errp);
 bool has_help_option(const char *param);
-bool is_valid_option_list(const char *param);
=20
 enum QemuOptType {
     QEMU_OPT_STRING =3D 0,  /* no parsing (use string as-is)              =
          */
diff --git a/qemu-img.c b/qemu-img.c
index d36b21b758..cc51db7ed4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -223,6 +223,32 @@ static bool qemu_img_object_print_help(const char *typ=
e, QemuOpts *opts)
     return true;
 }
=20
+/*
+ * Is @optarg safe for accumulate_options()?
+ * It is when multiple of them can be joined together separated by ','.
+ * To make that work, @optarg must not start with ',' (or else a
+ * separating ',' preceding it gets escaped), and it must not end with
+ * an odd number of ',' (or else a separating ',' following it gets
+ * escaped).
+ */
+static bool is_valid_option_list(const char *optarg)
+{
+    size_t len =3D strlen(optarg);
+    size_t i;
+
+    if (optarg[0] =3D=3D ',') {
+        return false;
+    }
+
+    for (i =3D len; i > 0 && optarg[i - 1] =3D=3D ','; i--) {
+    }
+    if ((len - i) % 2) {
+        return false;
+    }
+
+    return true;
+}
+
 static int accumulate_options(char **options, char *optarg)
 {
     char *new_options;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 2d0d24ee27..9542988183 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -165,28 +165,6 @@ void parse_option_size(const char *name, const char *v=
alue,
     *ret =3D size;
 }
=20
-bool is_valid_option_list(const char *p)
-{
-    char *value =3D NULL;
-    bool result =3D false;
-
-    while (*p) {
-        p =3D get_opt_value(p, &value);
-        if ((*p && !*++p) ||
-            (!*value || *value =3D=3D ',')) {
-            goto out;
-        }
-
-        g_free(value);
-        value =3D NULL;
-    }
-
-    result =3D true;
-out:
-    g_free(value);
-    return result;
-}
-
 static const char *opt_type_to_string(enum QemuOptType type)
 {
     switch (type) {
--=20
2.21.1


