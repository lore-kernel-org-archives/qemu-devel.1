Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790EDC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDDB214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDDB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCk4f-0003TL-Go
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0i-0001IG-Ea
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0g-0006sH-58
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0f-0006rM-T7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6654218C8914;
 Tue, 24 Sep 2019 12:33:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D75825C1B2;
 Tue, 24 Sep 2019 12:33:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42B1F1138660; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/37] make check-unit: use after free in test-opts-visitor
Date: Tue, 24 Sep 2019 14:32:59 +0200
Message-Id: <20190924123334.30645-3-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 24 Sep 2019 12:33:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

In the struct OptsVisitor, the 'repeated_opts' member points to a list
in the 'unprocessed_opts' hash table after the list has been destroyed.
A subsequent call to visit_type_int() references the deleted list.
It results in use-after-free issue reproduced by running the test case
under the Valgrind: valgrind tests/test-opts-visitor.
A new mode ListMode::LM_TRAVERSED is declared to mark the list
traversal completed.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <1565024586-387112-1-git-send-email-andrey.shinkevich@virtuoz=
zo.com>
---
 qapi/opts-visitor.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 324b197495..5fe0276c1c 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -24,7 +24,8 @@ enum ListMode
 {
     LM_NONE,             /* not traversing a list of repeated options */
=20
-    LM_IN_PROGRESS,      /* opts_next_list() ready to be called.
+    LM_IN_PROGRESS,      /*
+                          * opts_next_list() ready to be called.
                           *
                           * Generating the next list link will consume t=
he most
                           * recently parsed QemuOpt instance of the repe=
ated
@@ -36,7 +37,8 @@ enum ListMode
                           * LM_UNSIGNED_INTERVAL.
                           */
=20
-    LM_SIGNED_INTERVAL,  /* opts_next_list() has been called.
+    LM_SIGNED_INTERVAL,  /*
+                          * opts_next_list() has been called.
                           *
                           * Generating the next list link will consume t=
he most
                           * recently stored element from the signed inte=
rval,
@@ -48,7 +50,14 @@ enum ListMode
                           * next element of the signed interval.
                           */
=20
-    LM_UNSIGNED_INTERVAL /* Same as above, only for an unsigned interval=
. */
+    LM_UNSIGNED_INTERVAL, /* Same as above, only for an unsigned interva=
l. */
+
+    LM_TRAVERSED          /*
+                           * opts_next_list() has been called.
+                           *
+                           * No more QemuOpt instance in the list.
+                           * The traversal has been completed.
+                           */
 };
=20
 typedef enum ListMode ListMode;
@@ -238,6 +247,8 @@ opts_next_list(Visitor *v, GenericList *tail, size_t =
size)
     OptsVisitor *ov =3D to_ov(v);
=20
     switch (ov->list_mode) {
+    case LM_TRAVERSED:
+        return NULL;
     case LM_SIGNED_INTERVAL:
     case LM_UNSIGNED_INTERVAL:
         if (ov->list_mode =3D=3D LM_SIGNED_INTERVAL) {
@@ -258,6 +269,8 @@ opts_next_list(Visitor *v, GenericList *tail, size_t =
size)
         opt =3D g_queue_pop_head(ov->repeated_opts);
         if (g_queue_is_empty(ov->repeated_opts)) {
             g_hash_table_remove(ov->unprocessed_opts, opt->name);
+            ov->repeated_opts =3D NULL;
+            ov->list_mode =3D LM_TRAVERSED;
             return NULL;
         }
         break;
@@ -289,7 +302,8 @@ opts_end_list(Visitor *v, void **obj)
=20
     assert(ov->list_mode =3D=3D LM_IN_PROGRESS ||
            ov->list_mode =3D=3D LM_SIGNED_INTERVAL ||
-           ov->list_mode =3D=3D LM_UNSIGNED_INTERVAL);
+           ov->list_mode =3D=3D LM_UNSIGNED_INTERVAL ||
+           ov->list_mode =3D=3D LM_TRAVERSED);
     ov->repeated_opts =3D NULL;
     ov->list_mode =3D LM_NONE;
 }
@@ -306,6 +320,10 @@ lookup_scalar(const OptsVisitor *ov, const char *nam=
e, Error **errp)
         list =3D lookup_distinct(ov, name, errp);
         return list ? g_queue_peek_tail(list) : NULL;
     }
+    if (ov->list_mode =3D=3D LM_TRAVERSED) {
+        error_setg(errp, "Fewer list elements than expected");
+        return NULL;
+    }
     assert(ov->list_mode =3D=3D LM_IN_PROGRESS);
     return g_queue_peek_head(ov->repeated_opts);
 }
--=20
2.21.0


