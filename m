Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7308FC388F3
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5409C20863
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5409C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEHf9-0001t1-9P
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 14:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iEHd6-0008PY-57
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iEHd3-0003pH-Kx
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iEHd3-0003ny-EA
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ADF1F20FC
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:39:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D25260852;
 Sat, 28 Sep 2019 18:39:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B750113865F; Sat, 28 Sep 2019 20:39:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/27] qmp-dispatch: Use CommandNotFound error for disabled
 commands
Date: Sat, 28 Sep 2019 20:39:08 +0200
Message-Id: <20190928183934.12459-2-armbru@redhat.com>
In-Reply-To: <20190928183934.12459-1-armbru@redhat.com>
References: <20190928183934.12459-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Sat, 28 Sep 2019 18:39:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Michal Privoznik <mprivozn@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

If a command is disabled an error is reported.  But due to usage of
error_setg() the class of the error is GenericError which does not
help callers in distinguishing this case from a case where a qmp
command fails regularly due to other reasons.

We used to use class CommandDisabled until the great error
simplification (commit de253f1491 for QMP and commit 93b91c59db for
qemu-ga, both v1.2.0).

Use CommandNotFound error class, which is close enough.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-Id: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mpri=
vozn@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Test update squashed in, commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-dispatch.c | 5 +++--
 tests/test-qga.c    | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 3037d353a4..bc264b3c9b 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -104,8 +104,9 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
         return NULL;
     }
     if (!cmd->enabled) {
-        error_setg(errp, "The command %s has been disabled for this inst=
ance",
-                   command);
+        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                  "The command %s has been disabled for this instance",
+                  command);
         return NULL;
     }
     if (oob && !(cmd->options & QCO_ALLOW_OOB)) {
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 891aa3d322..1ca49bbced 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -668,7 +668,7 @@ static void test_qga_blacklist(gconstpointer data)
     error =3D qdict_get_qdict(ret, "error");
     class =3D qdict_get_try_str(error, "class");
     desc =3D qdict_get_try_str(error, "desc");
-    g_assert_cmpstr(class, =3D=3D, "GenericError");
+    g_assert_cmpstr(class, =3D=3D, "CommandNotFound");
     g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
     qobject_unref(ret);
=20
@@ -677,7 +677,7 @@ static void test_qga_blacklist(gconstpointer data)
     error =3D qdict_get_qdict(ret, "error");
     class =3D qdict_get_try_str(error, "class");
     desc =3D qdict_get_try_str(error, "desc");
-    g_assert_cmpstr(class, =3D=3D, "GenericError");
+    g_assert_cmpstr(class, =3D=3D, "CommandNotFound");
     g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
     qobject_unref(ret);
=20
--=20
2.21.0


