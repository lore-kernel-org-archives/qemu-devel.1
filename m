Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D59C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC0220768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atzNDVsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC0220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdUl-0007pC-Gf
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOdRf-0002jQ-Bc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOdRe-0004JR-06
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOdRd-0004Id-NY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586939453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohbULlm42YU87XT+WjpnvqgnMQHkG5kcCg6Ur2P950Y=;
 b=atzNDVszz3WTIfnO9NpEfOKhtAdIwnmKVCZEraIkTE9ji/C4Nkqvqfz9MdDReTsjb5tqac
 DqpL1Z45JMRTXxZQEWaOsKEVNBjM0NhfGYbS+JP8GTPp+r0/fIyWxhJD4arofMMYOv5gnS
 BvrhQZOOJQ1suwIm62N0M6ozyIMnye0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-JdXPIc6bNDW6j_vSnuw60g-1; Wed, 15 Apr 2020 04:30:51 -0400
X-MC-Unique: JdXPIc6bNDW6j_vSnuw60g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 801C61005510;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A8835E037;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A24BA11358B0; Wed, 15 Apr 2020 10:30:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 3/5] qobject: Eliminate qlist_iter(),
 use QLIST_FOREACH_ENTRY() instead
Date: Wed, 15 Apr 2020 10:30:46 +0200
Message-Id: <20200415083048.14339-4-armbru@redhat.com>
In-Reply-To: <20200415083048.14339-1-armbru@redhat.com>
References: <20200415083048.14339-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

qlist_iter() has just three uses outside tests/.  Replace by
QLIST_FOREACH_ENTRY() for more concise code and less type punning.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlist.h |  2 --
 qobject/qjson.c          | 31 ++++++++++------------------
 qobject/qlist.c          | 44 +++++++++++-----------------------------
 tests/check-qlist.c      | 37 +++++++++++++--------------------
 4 files changed, 37 insertions(+), 77 deletions(-)

diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 07ecae81e4..595b7943e1 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -47,8 +47,6 @@ static inline QObject *qlist_entry_obj(const QListEntry *=
entry)
 QList *qlist_new(void);
 QList *qlist_copy(QList *src);
 void qlist_append_obj(QList *qlist, QObject *obj);
-void qlist_iter(const QList *qlist,
-                void (*iter)(QObject *obj, void *opaque), void *opaque);
 QObject *qlist_pop(QList *qlist);
 QObject *qlist_peek(QList *qlist);
 int qlist_empty(const QList *qlist);
diff --git a/qobject/qjson.c b/qobject/qjson.c
index f3c62711b9..10050354a0 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -191,20 +191,6 @@ static void to_json_dict_iter(const char *key, QObject=
 *obj, void *opaque)
     s->count++;
 }
=20
-static void to_json_list_iter(QObject *obj, void *opaque)
-{
-    ToJsonIterState *s =3D opaque;
-
-    if (s->count) {
-        qstring_append(s->str, s->pretty ? "," : ", ");
-    }
-
-    json_pretty_newline(s->str, s->pretty, s->indent);
-
-    to_json(obj, s->str, s->pretty, s->indent);
-    s->count++;
-}
-
 static void to_json(const QObject *obj, QString *str, int pretty, int inde=
nt)
 {
     switch (qobject_type(obj)) {
@@ -289,15 +275,20 @@ static void to_json(const QObject *obj, QString *str,=
 int pretty, int indent)
         break;
     }
     case QTYPE_QLIST: {
-        ToJsonIterState s;
         QList *val =3D qobject_to(QList, obj);
+        const char *comma =3D pretty ? "," : ", ";
+        const char *sep =3D "";
+        QListEntry *entry;
=20
-        s.count =3D 0;
-        s.str =3D str;
-        s.indent =3D indent + 1;
-        s.pretty =3D pretty;
         qstring_append(str, "[");
-        qlist_iter(val, (void *)to_json_list_iter, &s);
+
+        QLIST_FOREACH_ENTRY(val, entry) {
+            qstring_append(str, sep);
+            json_pretty_newline(str, pretty, indent + 1);
+            to_json(qlist_entry_obj(entry), str, pretty, indent + 1);
+            sep =3D comma;
+        }
+
         json_pretty_newline(str, pretty, indent);
         qstring_append(str, "]");
         break;
diff --git a/qobject/qlist.c b/qobject/qlist.c
index b3274af88b..1be95367d1 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -34,20 +34,17 @@ QList *qlist_new(void)
     return qlist;
 }
=20
-static void qlist_copy_elem(QObject *obj, void *opaque)
-{
-    QList *dst =3D opaque;
-
-    qobject_ref(obj);
-    qlist_append_obj(dst, obj);
-}
-
 QList *qlist_copy(QList *src)
 {
     QList *dst =3D qlist_new();
+    QListEntry *entry;
+    QObject *elt;
=20
-    qlist_iter(src, qlist_copy_elem, dst);
-
+    QLIST_FOREACH_ENTRY(src, entry) {
+        elt =3D qlist_entry_obj(entry);
+        qobject_ref(elt);
+        qlist_append_obj(dst, elt);
+    }
     return dst;
 }
=20
@@ -86,21 +83,6 @@ void qlist_append_null(QList *qlist)
     qlist_append(qlist, qnull());
 }
=20
-/**
- * qlist_iter(): Iterate over all the list's stored values.
- *
- * This function allows the user to provide an iterator, which will be
- * called for each stored value in the list.
- */
-void qlist_iter(const QList *qlist,
-                void (*iter)(QObject *obj, void *opaque), void *opaque)
-{
-    QListEntry *entry;
-
-    QTAILQ_FOREACH(entry, &qlist->head, next)
-        iter(entry->value, opaque);
-}
-
 QObject *qlist_pop(QList *qlist)
 {
     QListEntry *entry;
@@ -137,16 +119,14 @@ int qlist_empty(const QList *qlist)
     return QTAILQ_EMPTY(&qlist->head);
 }
=20
-static void qlist_size_iter(QObject *obj, void *opaque)
-{
-    size_t *count =3D opaque;
-    (*count)++;
-}
-
 size_t qlist_size(const QList *qlist)
 {
     size_t count =3D 0;
-    qlist_iter(qlist, qlist_size_iter, &count);
+    QListEntry *entry;
+
+    QLIST_FOREACH_ENTRY(qlist, entry) {
+        count++;
+    }
     return count;
 }
=20
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index ece83e293d..3cd0ccbf19 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -61,40 +61,31 @@ static void qobject_to_qlist_test(void)
     qobject_unref(qlist);
 }
=20
-static int iter_called;
-static const int iter_max =3D 42;
-
-static void iter_func(QObject *obj, void *opaque)
-{
-    QNum *qi;
-    int64_t val;
-
-    g_assert(opaque =3D=3D NULL);
-
-    qi =3D qobject_to(QNum, obj);
-    g_assert(qi !=3D NULL);
-
-    g_assert(qnum_get_try_int(qi, &val));
-    g_assert_cmpint(val, >=3D, 0);
-    g_assert_cmpint(val, <=3D, iter_max);
-
-    iter_called++;
-}
-
 static void qlist_iter_test(void)
 {
+    const int iter_max =3D 42;
     int i;
     QList *qlist;
+    QListEntry *entry;
+    QNum *qi;
+    int64_t val;
=20
     qlist =3D qlist_new();
=20
     for (i =3D 0; i < iter_max; i++)
         qlist_append_int(qlist, i);
=20
-    iter_called =3D 0;
-    qlist_iter(qlist, iter_func, NULL);
+    i =3D 0;
+    QLIST_FOREACH_ENTRY(qlist, entry) {
+        qi =3D qobject_to(QNum, qlist_entry_obj(entry));
+        g_assert(qi !=3D NULL);
=20
-    g_assert(iter_called =3D=3D iter_max);
+        g_assert(qnum_get_try_int(qi, &val));
+        g_assert_cmpint(val, =3D=3D, i);
+        i++;
+    }
+
+    g_assert(i =3D=3D iter_max);
=20
     qobject_unref(qlist);
 }
--=20
2.21.1


