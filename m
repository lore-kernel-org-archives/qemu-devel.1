Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7E5C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1D420768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV3BpKP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1D420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdSr-0004fD-Sy
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOdRh-0002mw-Vu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOdRg-0004NP-SW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOdRg-0004N1-Ov
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586939456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RhYhE4o65MxagfGEHae2s2haeSOzIgE6d1jL7M1ikM=;
 b=gV3BpKP4bu1lj9N9EVTkqo1i12PudAJyK2fl03bBZ46giz5qeL6l7y7gpXrwTI2/y6J6lI
 jV4pND6ndhLOOeRc2xSQlHsB4nLBt4TSODtNyu1LP+gT5zZKF7uWQ9MqRWvgQtSfYpSxbH
 Tgj7KbgLHDbww05O/Tvcg8hiWIMQV1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-q4b62mXwMlOhbGPD5n51Qg-1; Wed, 15 Apr 2020 04:30:52 -0400
X-MC-Unique: q4b62mXwMlOhbGPD5n51Qg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA6A5107ACC7;
 Wed, 15 Apr 2020 08:30:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98CDC10372C2;
 Wed, 15 Apr 2020 08:30:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8CD911358B2; Wed, 15 Apr 2020 10:30:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 5/5] qemu-option: Clean up after the previous commit
Date: Wed, 15 Apr 2020 10:30:48 +0200
Message-Id: <20200415083048.14339-6-armbru@redhat.com>
In-Reply-To: <20200415083048.14339-1-armbru@redhat.com>
References: <20200415083048.14339-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-option.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 3fabfd157d..123c52bf07 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -967,18 +967,16 @@ void qemu_opts_set_defaults(QemuOptsList *list, const=
 char *params,
     assert(opts);
 }
=20
-typedef struct OptsFromQDictState {
-    QemuOpts *opts;
-    Error **errp;
-} OptsFromQDictState;
-
-static void qemu_opts_from_qdict_1(const char *key, QObject *obj, void *op=
aque)
+static void qemu_opts_from_qdict_entry(QemuOpts *opts,
+                                       const QDictEntry *entry,
+                                       Error **errp)
 {
-    OptsFromQDictState *state =3D opaque;
+    const char *key =3D qdict_entry_key(entry);
+    QObject *obj =3D qdict_entry_value(entry);
     char buf[32], *tmp =3D NULL;
     const char *value;
=20
-    if (!strcmp(key, "id") || *state->errp) {
+    if (!strcmp(key, "id")) {
         return;
     }
=20
@@ -999,7 +997,7 @@ static void qemu_opts_from_qdict_1(const char *key, QOb=
ject *obj, void *opaque)
         return;
     }
=20
-    qemu_opt_set(state->opts, key, value, state->errp);
+    qemu_opt_set(opts, key, value, errp);
     g_free(tmp);
 }
=20
@@ -1012,7 +1010,6 @@ static void qemu_opts_from_qdict_1(const char *key, Q=
Object *obj, void *opaque)
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
                                Error **errp)
 {
-    OptsFromQDictState state;
     Error *local_err =3D NULL;
     QemuOpts *opts;
     const QDictEntry *entry;
@@ -1026,20 +1023,15 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, =
const QDict *qdict,
=20
     assert(opts !=3D NULL);
=20
-    state.errp =3D &local_err;
-    state.opts =3D opts;
-
     for (entry =3D qdict_first(qdict);
          entry;
          entry =3D qdict_next(qdict, entry)) {
-        qemu_opts_from_qdict_1(qdict_entry_key(entry),
-                               qdict_entry_value(entry),
-                               &state);
-    }
-    if (local_err) {
-        error_propagate(errp, local_err);
-        qemu_opts_del(opts);
-        return NULL;
+        qemu_opts_from_qdict_entry(opts, entry, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            qemu_opts_del(opts);
+            return NULL;
+        }
     }
=20
     return opts;
@@ -1058,21 +1050,16 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *=
qdict, Error **errp)
=20
     while (entry !=3D NULL) {
         Error *local_err =3D NULL;
-        OptsFromQDictState state =3D {
-            .errp =3D &local_err,
-            .opts =3D opts,
-        };
=20
         next =3D qdict_next(qdict, entry);
=20
         if (find_desc_by_name(opts->list->desc, entry->key)) {
-            qemu_opts_from_qdict_1(entry->key, entry->value, &state);
+            qemu_opts_from_qdict_entry(opts, entry, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
                 return;
-            } else {
-                qdict_del(qdict, entry->key);
             }
+            qdict_del(qdict, entry->key);
         }
=20
         entry =3D next;
--=20
2.21.1


