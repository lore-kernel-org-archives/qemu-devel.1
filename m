Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D84C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A6E20784
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eH3e8nzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A6E20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU20I-00038q-F1
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n9-0005Bz-LM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n0-0002el-Ee
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1mz-0002cG-0h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+R0g3SOxaPQeFK1/rWiF9DlXvPEAY1ts/Ks+cFfo654=;
 b=eH3e8nzYRKZSLyXMm+Ath55Wa470sNT5uoKxKY+IJ8IzL8eXC6ECmqc1xxXB2qeDqpuIvY
 moljrYBpum8XbBVEdeKnhEJsgGBJOaaoZCMFxOT964TX0hN9w5d1Yzig/K1IFerf+OtlkR
 njLpzjTuwE7uZCjqqorP0CC2TRCtc1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-znPPGqRcN9SFjhFeHnlbcA-1; Thu, 30 Apr 2020 01:31:08 -0400
X-MC-Unique: znPPGqRcN9SFjhFeHnlbcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C05107B267
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1B4D60C18;
 Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E063411358C1; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] qemu-option: Clean up after the previous commit
Date: Thu, 30 Apr 2020 07:30:49 +0200
Message-Id: <20200430053104.32204-6-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200415083048.14339-6-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/qemu-option.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 2784757ef5..0ebfd97a98 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -965,18 +965,16 @@ void qemu_opts_set_defaults(QemuOptsList *list, const=
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
@@ -997,7 +995,7 @@ static void qemu_opts_from_qdict_1(const char *key, QOb=
ject *obj, void *opaque)
         return;
     }
=20
-    qemu_opt_set(state->opts, key, value, state->errp);
+    qemu_opt_set(opts, key, value, errp);
     g_free(tmp);
 }
=20
@@ -1010,7 +1008,6 @@ static void qemu_opts_from_qdict_1(const char *key, Q=
Object *obj, void *opaque)
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
                                Error **errp)
 {
-    OptsFromQDictState state;
     Error *local_err =3D NULL;
     QemuOpts *opts;
     const QDictEntry *entry;
@@ -1024,20 +1021,15 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, =
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
@@ -1056,21 +1048,16 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *=
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


