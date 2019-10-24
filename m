Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCF5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7F720679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AP+yPhdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7F720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdtR-0003Ub-Uo
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKk-0003z6-4k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKi-0006BX-1U
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60794
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKh-0006Ay-TV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tH3KRe0Iy3dxA+vLYN3e4E2c91fWMAngW0oeY2mbIt0=;
 b=AP+yPhdhvU4/unFvTnouJJTp9JwABZld2Ebxj617ygwzqaJkyFnYw2D4vbgMFcTkRYnWMu
 bcXpsLYND6inAAAFBzXbG2izGi/pijYAMR4Q6yClNUvJzjGTGc4FWz8Gv9McASs1lIpRNQ
 339vJ4+ABSaZN+uRlv56PCgWBSnxRSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-Gnydq9ogM5CwbGJGAB-4Mw-1; Thu, 24 Oct 2019 08:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49E261800DFC;
 Thu, 24 Oct 2019 12:35:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0FAE52E7;
 Thu, 24 Oct 2019 12:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E5A71130346; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 16/19] qapi: Implement -compat deprecated-input=reject for
 commands
Date: Thu, 24 Oct 2019 14:34:55 +0200
Message-Id: <20191024123458.13505-17-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Gnydq9ogM5CwbGJGAB-4Mw-1
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

This policy makes deprecated commands fail like this:

    ---> {"execute": "query-cpus"}
    <--- {"error": {"class": "CommandNotFound", "desc": "Deprecated command=
 query-cpus disabled by policy"}}

When the command is removed, the error will change to

    <--- {"error": {"class": "CommandNotFound", "desc": "The command query-=
cpus has not been found"}}

The policy thus permits "testing the future".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json            |  4 ++--
 include/qapi/qmp/dispatch.h |  1 +
 qapi/qmp-dispatch.c         | 13 +++++++++++++
 tests/test-qmp-cmds.c       | 23 +++++++++++++++++++++++
 qemu-options.hx             |  4 +++-
 scripts/qapi/commands.py    | 10 +++++++---
 6 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 9fc3e6400c..3e9d12c90f 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -151,7 +151,7 @@
 # Policy for handling "funny" input.
 #
 # @accept: Accept silently
-# TODO @reject: Reject with an error
+# @reject: Reject with an error
 # TODO @crash: abort() the process
 #
 # FIXME Guidance on intended use.
@@ -159,7 +159,7 @@
 # Since: 4.2
 ##
 { 'enum': 'CompatPolicyInput',
-  'data': [ 'accept' ] }
+  'data': [ 'accept', 'reject' ] }
=20
 ##
 # @CompatPolicyOutput:
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 9aa426a398..ef256f2bb7 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -24,6 +24,7 @@ typedef enum QmpCommandOptions
     QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
     QCO_ALLOW_OOB             =3D  (1U << 1),
     QCO_ALLOW_PRECONFIG       =3D  (1U << 2),
+    QCO_DEPRECATED            =3D  (1U << 3),
 } QmpCommandOptions;
=20
 typedef struct QmpCommand
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 8fe59cf54d..b079db85d2 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -132,6 +132,19 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *req=
uest,
                   "The command %s has not been found", command);
         goto out;
     }
+    if (cmd->options & QCO_DEPRECATED) {
+        switch (qapi_compat_policy.deprecated_input) {
+        case COMPAT_POLICY_INPUT_ACCEPT:
+            break;
+        case COMPAT_POLICY_INPUT_REJECT:
+            error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
+                      "Deprecated command %s disabled by policy",
+                      command);
+            goto out;
+        default:
+            abort();
+        }
+    }
     if (!cmd->enabled) {
         error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has been disabled for this instance",
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index cf4fa1a091..005ea24a27 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qapi/compat-policy.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qnum.h"
@@ -235,6 +236,26 @@ static void test_dispatch_cmd_success_response(void)
     qobject_unref(req);
 }
=20
+static void test_dispatch_cmd_deprecated(void)
+{
+    const char *cmd =3D "{ 'execute': 'test-command-features1' }";
+    QDict *ret;
+
+    /* accept */
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 0);
+    qobject_unref(ret);
+
+    qapi_compat_policy.has_deprecated_input =3D true;
+    qapi_compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_ACCEPT;
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 0);
+    qobject_unref(ret);
+
+    qapi_compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_REJECT;
+    do_qmp_dispatch_error(false, ERROR_CLASS_COMMAND_NOT_FOUND, cmd);
+}
+
 /* test commands that involve both input parameters and return values */
 static void test_dispatch_cmd_io(void)
 {
@@ -344,6 +365,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
     g_test_add_func("/qmp/dispatch_cmd_success_response",
                     test_dispatch_cmd_success_response);
+    g_test_add_func("/qmp/dispatch_cmd_deprecated",
+                    test_dispatch_cmd_deprecated);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index c43f768a15..f107a57c81 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3320,7 +3320,7 @@ STEXI
 ETEXI
=20
 DEF("compat", HAS_ARG, QEMU_OPTION_compat,
-    "-compat [deprecated-input=3Daccept][,deprecated-output=3Daccept]\n"
+    "-compat [deprecated-input=3Daccept|reject][,deprecated-output=3Daccep=
t]\n"
     "                Policy for handling deprecated management interfaces\=
n",
     QEMU_ARCH_ALL)
 STEXI
@@ -3331,6 +3331,8 @@ Set policy for handling deprecated management interfa=
ces:
 @table @option
 @item deprecated-input=3Daccept (default)
 Accept deprecated commands
+@item deprecated-input=3Dreject
+Reject deprecated commands
 @item deprecated-output=3Daccept (default)
 Emit deprecated events
 @end table
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 11e9a6c095..df2a132915 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -194,9 +194,13 @@ out:
     return ret
=20
=20
-def gen_register_command(name, success_response, allow_oob, allow_preconfi=
g):
+def gen_register_command(name, features,
+                         success_response, allow_oob, allow_preconfig):
     options =3D []
=20
+    if 'deprecated' in [f.name for f in features]:
+        options +=3D ['QCO_DEPRECATED']
+
     if not success_response:
         options +=3D ['QCO_NO_SUCCESS_RESP']
     if allow_oob:
@@ -295,8 +299,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
;
             self._genh.add(gen_command_decl(name, arg_type, boxed, ret_typ=
e))
             self._genh.add(gen_marshal_decl(name))
             self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-            self._regy.add(gen_register_command(name, success_response,
-                                                allow_oob, allow_preconfig=
))
+            self._regy.add(gen_register_command(
+                name, features, success_response, allow_oob, allow_preconf=
ig))
=20
=20
 def gen_commands(schema, output_dir, prefix):
--=20
2.21.0


