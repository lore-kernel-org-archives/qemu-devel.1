Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60922CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB9120659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5AfRgPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB9120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcri-0000PA-NU
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKi-0003uk-TR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKg-0006Ab-UX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKg-00069r-OY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvbDg2uid4r8KXEHdpf9+S6fn+v4ziyThT6wWQ8hgJE=;
 b=C5AfRgPG34ZiuQQs1yJG4apNNi2/07HxaQ1ME+3bOefZMqBUvfH7P2YcF+Fr+wf0smroAi
 5M23321ZgvDeYwXP37RfiJ2Rhyt1JoClMRpBzEpnS8uHzZVs1zAfZxRgEqYvtskst4iP4s
 L/QoCDLVY5BDFDwUnC4nZQNF7i1tDXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-8aFgEFYgOemLQvXPpADulg-1; Thu, 24 Oct 2019 08:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A66800D4C;
 Thu, 24 Oct 2019 12:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A3BF60161;
 Thu, 24 Oct 2019 12:35:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34A8F113034A; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 18/19] qapi: Include a warning in the response to a
 deprecated command
Date: Thu, 24 Oct 2019 14:34:57 +0200
Message-Id: <20191024123458.13505-19-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 8aFgEFYgOemLQvXPpADulg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks like this

    ---> {"execute": "query-cpus"}
    <--- {"return": [...], "warnings": [{"class": "CommandNotFound", "desc"=
: "command is deprecated"}]}

Management applications may want to log such warnings.

This commit is not for merging as is, because

* docs/interop/qmp-spec.txt needs an update for the new success
  response member "warnings".

* I'd like to see a prospective user before I extend the QMP protocol.
  If you have specific plans to put them to use, let me know.

* The same warning should be included in a deprecated event.

* Emitting the same warning over and over again might be annoying or
  slow.  Perhaps warning just once would be better.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-dispatch.c   |  8 ++++++++
 tests/test-qmp-cmds.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx       |  2 +-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 6436417844..9c17a59f31 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -197,6 +197,14 @@ out:
     } else {
         rsp =3D qdict_new();
         qdict_put_obj(rsp, "return", ret);
+        if (cmd->options & QCO_DEPRECATED) {
+            qdict_put_obj(
+                rsp, "warnings",
+                qobject_from_jsonf_nofail(
+                    "[ { 'class': %s, 'desc': %s } ]",
+                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND),
+                    "command is deprecated"));
+        }
     }
=20
     if (id) {
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 005ea24a27..38d2e5b4a7 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -2,6 +2,7 @@
 #include "qapi/compat-policy.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
@@ -164,6 +165,40 @@ static QObject *do_qmp_dispatch(bool allow_oob, const =
char *template, ...)
     return ret;
 }
=20
+static QObject *do_qmp_dispatch_warning(bool allow_oob, ErrorClass cls,
+                                        const char *template, ...)
+{
+    va_list ap;
+    QDict *req, *resp;
+    QObject *ret;
+    QList *warnings;
+    QDict *warning;
+
+    va_start(ap, template);
+    req =3D qdict_from_vjsonf_nofail(template, ap);
+    va_end(ap);
+
+    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), allow_oob);
+    g_assert(resp);
+    ret =3D qdict_get(resp, "return");
+    g_assert(ret);
+    warnings =3D qdict_get_qlist(resp, "warnings");
+    g_assert(warnings);
+    warning =3D qobject_to(QDict, qlist_peek(warnings));
+    g_assert(warning);
+    g_assert_cmpstr(qdict_get_try_str(warning, "class"),
+                    =3D=3D, QapiErrorClass_str(cls));
+    g_assert(qdict_get_try_str(warning, "desc"));
+    g_assert(qdict_size(warning) =3D=3D 2);
+    g_assert(qlist_size(warnings) =3D=3D 1);
+    g_assert(qdict_size(resp) =3D=3D 2);
+
+    qobject_ref(ret);
+    qobject_unref(resp);
+    qobject_unref(req);
+    return ret;
+}
+
 static void do_qmp_dispatch_error(bool allow_oob, ErrorClass cls,
                                   const char *template, ...)
 {
@@ -242,13 +277,17 @@ static void test_dispatch_cmd_deprecated(void)
     QDict *ret;
=20
     /* accept */
-    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    ret =3D qobject_to(QDict, do_qmp_dispatch_warning(
+        false, ERROR_CLASS_COMMAND_NOT_FOUND,
+        "{ 'execute': 'test-command-features1' }"));
     assert(ret && qdict_size(ret) =3D=3D 0);
     qobject_unref(ret);
=20
     qapi_compat_policy.has_deprecated_input =3D true;
     qapi_compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_ACCEPT;
-    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    ret =3D qobject_to(QDict, do_qmp_dispatch_warning(
+        false, ERROR_CLASS_COMMAND_NOT_FOUND,
+        "{ 'execute': 'test-command-features1' }"));
     assert(ret && qdict_size(ret) =3D=3D 0);
     qobject_unref(ret);
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index 3a740ea7b1..645629457a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3330,7 +3330,7 @@ STEXI
 Set policy for handling deprecated management interfaces:
 @table @option
 @item deprecated-input=3Daccept (default)
-Accept deprecated commands
+Accept deprecated commands with a warning
 @item deprecated-input=3Dreject
 Reject deprecated commands
 @item deprecated-input=3Dcrash
--=20
2.21.0


