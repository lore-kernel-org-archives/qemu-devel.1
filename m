Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C6EC3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B4D20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ivt0UPcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B4D20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdSs-0004jD-EU
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOdRg-0002lS-Uf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOdRf-0004MJ-Gv
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOdRf-0004Lk-D3
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586939455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DMj6mUgVt3lh8Q84Xn5/zF+wOO0RHaX6INNcoeNAV0=;
 b=Ivt0UPcHou5iw1vOhUgITrdFwkSI8pJi7DbaXALG1d38scjCY51mUtl4zUEqKaEUBIkR7c
 VAcN4/p9+ipgA5AOBGGrADvYGndehuURg+8s+WQBHICbj33svsngguHGY16TopqFAftY1q
 JfuM6sZ1OvKy5EAQVnIdVVfUU4H3raA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-Pi_7GKJGNFu4t0WzwTKFUw-1; Wed, 15 Apr 2020 04:30:51 -0400
X-MC-Unique: Pi_7GKJGNFu4t0WzwTKFUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86D0819067E5;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E57119C69;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A596411358B1; Wed, 15 Apr 2020 10:30:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 4/5] qobject: Eliminate qdict_iter(), use qdict_first(),
 qdict_next()
Date: Wed, 15 Apr 2020 10:30:47 +0200
Message-Id: <20200415083048.14339-5-armbru@redhat.com>
In-Reply-To: <20200415083048.14339-1-armbru@redhat.com>
References: <20200415083048.14339-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qdict_iter() has just three uses and no test coverage.  Replace by
qdict_first(), qdict_next() for more concise code and less type
punning.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qdict.h     |  3 --
 qapi/qobject-input-visitor.c | 21 +++++++-------
 qobject/qdict.c              | 19 -------------
 qobject/qjson.c              | 54 +++++++++++++-----------------------
 util/qemu-option.c           | 10 ++++++-
 5 files changed, 40 insertions(+), 67 deletions(-)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 7f3ec10a10..da942347a7 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -40,9 +40,6 @@ void qdict_del(QDict *qdict, const char *key);
 int qdict_haskey(const QDict *qdict, const char *key);
 QObject *qdict_get(const QDict *qdict, const char *key);
 bool qdict_is_equal(const QObject *x, const QObject *y);
-void qdict_iter(const QDict *qdict,
-                void (*iter)(const char *key, QObject *obj, void *opaque),
-                void *opaque);
 const QDictEntry *qdict_first(const QDict *qdict);
 const QDictEntry *qdict_next(const QDict *qdict, const QDictEntry *entry);
 void qdict_destroy_obj(QObject *obj);
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 32236cbcb1..5ce3ec2e5f 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -203,31 +203,32 @@ static const char *qobject_input_get_keyval(QObjectIn=
putVisitor *qiv,
     return qstring_get_str(qstr);
 }
=20
-static void qdict_add_key(const char *key, QObject *obj, void *opaque)
-{
-    GHashTable *h =3D opaque;
-    g_hash_table_insert(h, (gpointer) key, NULL);
-}
-
 static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
                                             const char *name,
                                             QObject *obj, void *qapi)
 {
     GHashTable *h;
     StackObject *tos =3D g_new0(StackObject, 1);
+    QDict *qdict =3D qobject_to(QDict, obj);
+    QList *qlist =3D qobject_to(QList, obj);
+    const QDictEntry *entry;
=20
     assert(obj);
     tos->name =3D name;
     tos->obj =3D obj;
     tos->qapi =3D qapi;
=20
-    if (qobject_type(obj) =3D=3D QTYPE_QDICT) {
+    if (qdict) {
         h =3D g_hash_table_new(g_str_hash, g_str_equal);
-        qdict_iter(qobject_to(QDict, obj), qdict_add_key, h);
+        for (entry =3D qdict_first(qdict);
+             entry;
+             entry =3D qdict_next(qdict, entry)) {
+            g_hash_table_insert(h, (void *)qdict_entry_key(entry), NULL);
+        }
         tos->h =3D h;
     } else {
-        assert(qobject_type(obj) =3D=3D QTYPE_QLIST);
-        tos->entry =3D qlist_first(qobject_to(QList, obj));
+        assert(qlist);
+        tos->entry =3D qlist_first(qlist);
         tos->index =3D -1;
     }
=20
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 3d8c2f7bbc..526de54ceb 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -298,25 +298,6 @@ const char *qdict_get_try_str(const QDict *qdict, cons=
t char *key)
     return qstr ? qstring_get_str(qstr) : NULL;
 }
=20
-/**
- * qdict_iter(): Iterate over all the dictionary's stored values.
- *
- * This function allows the user to provide an iterator, which will be
- * called for each stored value in the dictionary.
- */
-void qdict_iter(const QDict *qdict,
-                void (*iter)(const char *key, QObject *obj, void *opaque),
-                void *opaque)
-{
-    int i;
-    QDictEntry *entry;
-
-    for (i =3D 0; i < QDICT_BUCKET_MAX; i++) {
-        QLIST_FOREACH(entry, &qdict->table[i], next)
-            iter(entry->key, entry->value, opaque);
-    }
-}
-
 static QDictEntry *qdict_next_entry(const QDict *qdict, int first_bucket)
 {
     int i;
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 10050354a0..2a3336e459 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -149,14 +149,6 @@ QDict *qdict_from_jsonf_nofail(const char *string, ...=
)
     return qdict;
 }
=20
-typedef struct ToJsonIterState
-{
-    int indent;
-    int pretty;
-    int count;
-    QString *str;
-} ToJsonIterState;
-
 static void to_json(const QObject *obj, QString *str, int pretty, int inde=
nt);
=20
 static void json_pretty_newline(QString *str, bool pretty, int indent)
@@ -171,26 +163,6 @@ static void json_pretty_newline(QString *str, bool pre=
tty, int indent)
     }
 }
=20
-static void to_json_dict_iter(const char *key, QObject *obj, void *opaque)
-{
-    ToJsonIterState *s =3D opaque;
-    QString *qkey;
-
-    if (s->count) {
-        qstring_append(s->str, s->pretty ? "," : ", ");
-    }
-
-    json_pretty_newline(s->str, s->pretty, s->indent);
-
-    qkey =3D qstring_from_str(key);
-    to_json(QOBJECT(qkey), s->str, s->pretty, s->indent);
-    qobject_unref(qkey);
-
-    qstring_append(s->str, ": ");
-    to_json(obj, s->str, s->pretty, s->indent);
-    s->count++;
-}
-
 static void to_json(const QObject *obj, QString *str, int pretty, int inde=
nt)
 {
     switch (qobject_type(obj)) {
@@ -261,15 +233,29 @@ static void to_json(const QObject *obj, QString *str,=
 int pretty, int indent)
         break;
     }
     case QTYPE_QDICT: {
-        ToJsonIterState s;
         QDict *val =3D qobject_to(QDict, obj);
+        const char *comma =3D pretty ? "," : ", ";
+        const char *sep =3D "";
+        const QDictEntry *entry;
+        QString *qkey;
=20
-        s.count =3D 0;
-        s.str =3D str;
-        s.indent =3D indent + 1;
-        s.pretty =3D pretty;
         qstring_append(str, "{");
-        qdict_iter(val, to_json_dict_iter, &s);
+
+        for (entry =3D qdict_first(val);
+             entry;
+             entry =3D qdict_next(val, entry)) {
+            qstring_append(str, sep);
+            json_pretty_newline(str, pretty, indent + 1);
+
+            qkey =3D qstring_from_str(qdict_entry_key(entry));
+            to_json(QOBJECT(qkey), str, pretty, indent + 1);
+            qobject_unref(qkey);
+
+            qstring_append(str, ": ");
+            to_json(qdict_entry_value(entry), str, pretty, indent + 1);
+            sep =3D comma;
+        }
+
         json_pretty_newline(str, pretty, indent);
         qstring_append(str, "}");
         break;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 97172b5eaa..3fabfd157d 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1015,6 +1015,7 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, co=
nst QDict *qdict,
     OptsFromQDictState state;
     Error *local_err =3D NULL;
     QemuOpts *opts;
+    const QDictEntry *entry;
=20
     opts =3D qemu_opts_create(list, qdict_get_try_str(qdict, "id"), 1,
                             &local_err);
@@ -1027,7 +1028,14 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, c=
onst QDict *qdict,
=20
     state.errp =3D &local_err;
     state.opts =3D opts;
-    qdict_iter(qdict, qemu_opts_from_qdict_1, &state);
+
+    for (entry =3D qdict_first(qdict);
+         entry;
+         entry =3D qdict_next(qdict, entry)) {
+        qemu_opts_from_qdict_1(qdict_entry_key(entry),
+                               qdict_entry_value(entry),
+                               &state);
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         qemu_opts_del(opts);
--=20
2.21.1


