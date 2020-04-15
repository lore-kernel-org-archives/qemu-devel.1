Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B8CC3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DC020768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCAFQnkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DC020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdSm-0004TA-VU
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOdRf-0002jJ-A5
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOdRe-0004KQ-5B
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOdRd-0004IZ-Vd
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586939453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvE+iD5Jt+PVv9yVEIP15pNGb4faDFqJ651/njshmzM=;
 b=MCAFQnkZOH+MKdvZz+NbH9ByRVtUTbMCQoceplHBLlZp9v6/NQI+qNQgEBPQzL2/lgQK5M
 JlqtTlFz4QDfUKeQzwXBp2XKOYKYXYXzWQN9HSlzBNCwAsl1x8DoaBzdoCoH/0Qc3+z+eV
 BpIDAncEs5THUBwu9Ou32EROXuF0rEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-wEVozBb1ObOPB2qFld9mCQ-1; Wed, 15 Apr 2020 04:30:51 -0400
X-MC-Unique: wEVozBb1ObOPB2qFld9mCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA2119067E4;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2566260BE0;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EF3311358AF; Wed, 15 Apr 2020 10:30:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 2/5] qobject: Factor out helper json_pretty_newline()
Date: Wed, 15 Apr 2020 10:30:45 +0200
Message-Id: <20200415083048.14339-3-armbru@redhat.com>
In-Reply-To: <20200415083048.14339-1-armbru@redhat.com>
References: <20200415083048.14339-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/qjson.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/qobject/qjson.c b/qobject/qjson.c
index db36101f3b..f3c62711b9 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -159,21 +159,28 @@ typedef struct ToJsonIterState
=20
 static void to_json(const QObject *obj, QString *str, int pretty, int inde=
nt);
=20
+static void json_pretty_newline(QString *str, bool pretty, int indent)
+{
+    int i;
+
+    if (pretty) {
+        qstring_append(str, "\n");
+        for (i =3D 0 ; i < indent ; i++) {
+            qstring_append(str, "    ");
+        }
+    }
+}
+
 static void to_json_dict_iter(const char *key, QObject *obj, void *opaque)
 {
     ToJsonIterState *s =3D opaque;
     QString *qkey;
-    int j;
=20
     if (s->count) {
         qstring_append(s->str, s->pretty ? "," : ", ");
     }
=20
-    if (s->pretty) {
-        qstring_append(s->str, "\n");
-        for (j =3D 0 ; j < s->indent ; j++)
-            qstring_append(s->str, "    ");
-    }
+    json_pretty_newline(s->str, s->pretty, s->indent);
=20
     qkey =3D qstring_from_str(key);
     to_json(QOBJECT(qkey), s->str, s->pretty, s->indent);
@@ -187,17 +194,12 @@ static void to_json_dict_iter(const char *key, QObjec=
t *obj, void *opaque)
 static void to_json_list_iter(QObject *obj, void *opaque)
 {
     ToJsonIterState *s =3D opaque;
-    int j;
=20
     if (s->count) {
         qstring_append(s->str, s->pretty ? "," : ", ");
     }
=20
-    if (s->pretty) {
-        qstring_append(s->str, "\n");
-        for (j =3D 0 ; j < s->indent ; j++)
-            qstring_append(s->str, "    ");
-    }
+    json_pretty_newline(s->str, s->pretty, s->indent);
=20
     to_json(obj, s->str, s->pretty, s->indent);
     s->count++;
@@ -282,12 +284,7 @@ static void to_json(const QObject *obj, QString *str, =
int pretty, int indent)
         s.pretty =3D pretty;
         qstring_append(str, "{");
         qdict_iter(val, to_json_dict_iter, &s);
-        if (pretty) {
-            int j;
-            qstring_append(str, "\n");
-            for (j =3D 0 ; j < indent ; j++)
-                qstring_append(str, "    ");
-        }
+        json_pretty_newline(str, pretty, indent);
         qstring_append(str, "}");
         break;
     }
@@ -301,12 +298,7 @@ static void to_json(const QObject *obj, QString *str, =
int pretty, int indent)
         s.pretty =3D pretty;
         qstring_append(str, "[");
         qlist_iter(val, (void *)to_json_list_iter, &s);
-        if (pretty) {
-            int j;
-            qstring_append(str, "\n");
-            for (j =3D 0 ; j < indent ; j++)
-                qstring_append(str, "    ");
-        }
+        json_pretty_newline(str, pretty, indent);
         qstring_append(str, "]");
         break;
     }
--=20
2.21.1


