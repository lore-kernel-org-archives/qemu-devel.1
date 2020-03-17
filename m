Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F526C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D198120736
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jp3N8vCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D198120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAzz-0002oQ-VG
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoc-0008GA-51
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoZ-0006qO-3b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20109)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoY-0006oM-So
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21luhvS9y0rAMdcbNzOO4uFJBqRLIs1zjLQKrJoDI30=;
 b=Jp3N8vCWprwdzWqkus+/flrr7btsG107v7/ipcMvzMU6e4bplBvzUCkyusPhbF52aVdHpL
 f7EfIsRkBtz/Offti4dVvZy+6I+9hwHGMmTNd36sZcm3illkZoCEs61Uf8D79BLl1QcBmS
 GYejFC4vVHZn+V0wHOPf5sGIZdOvPbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-i-YNyQu_MgWJGlvIQWDFDQ-1; Tue, 17 Mar 2020 07:55:17 -0400
X-MC-Unique: i-YNyQu_MgWJGlvIQWDFDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 028A085EE8E;
 Tue, 17 Mar 2020 11:55:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3706F10027A8;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9862D113525F; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 32/34] qapi: Implement deprecated-input=reject for QMP
 commands
Date: Tue, 17 Mar 2020 12:54:57 +0100
Message-Id: <20200317115459.31821-33-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy rejects deprecated input, and thus permits "testing the
future".  Implement it for QMP commands: make deprecated ones fail.
Example: when QEMU is run with -compat deprecated-input=3Dreject, then

    {"execute": "query-cpus"}

fails like this

    {"error": {"class": "CommandNotFound", "desc": "Deprecated command quer=
y-cpus disabled by policy"}}

When the command is removed, the error will change to

    {"error": {"class": "CommandNotFound", "desc": "The command query-cpus =
has not been found"}}

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h |  1 +
 qapi/qmp-dispatch.c         | 13 +++++++++++++
 tests/test-qmp-cmds.c       | 24 ++++++++++++++++++++++++
 scripts/qapi/commands.py    | 10 +++++++---
 4 files changed, 45 insertions(+), 3 deletions(-)

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
index 57d823c8e1..18d62cd83b 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -130,6 +130,19 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *req=
uest,
                   "The command %s has not been found", command);
         goto out;
     }
+    if (cmd->options & QCO_DEPRECATED) {
+        switch (compat_policy.deprecated_input) {
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
index 82d599630c..a2099fee7d 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -277,6 +277,28 @@ static void test_dispatch_cmd_io(void)
     qobject_unref(ret3);
 }
=20
+static void test_dispatch_cmd_deprecated(void)
+{
+    const char *cmd =3D "{ 'execute': 'test-command-features1' }";
+    QDict *ret;
+
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    /* accept */
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 0);
+    qobject_unref(ret);
+
+    compat_policy.has_deprecated_input =3D true;
+    compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_ACCEPT;
+    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
+    assert(ret && qdict_size(ret) =3D=3D 0);
+    qobject_unref(ret);
+
+    compat_policy.deprecated_input =3D COMPAT_POLICY_INPUT_REJECT;
+    do_qmp_dispatch_error(false, ERROR_CLASS_COMMAND_NOT_FOUND, cmd);
+}
+
 static void test_dispatch_cmd_ret_deprecated(void)
 {
     const char *cmd =3D "{ 'execute': 'test-features0' }";
@@ -375,6 +397,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
     g_test_add_func("/qmp/dispatch_cmd_success_response",
                     test_dispatch_cmd_success_response);
+    g_test_add_func("/qmp/dispatch_cmd_deprecated",
+                    test_dispatch_cmd_deprecated);
     g_test_add_func("/qmp/dispatch_cmd_ret_deprecated",
                     test_dispatch_cmd_ret_deprecated);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 35b79c554d..f628bbf144 100644
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
@@ -302,8 +306,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)=
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
2.21.1


