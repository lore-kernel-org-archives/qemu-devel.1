Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABEEC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9458021850
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9458021850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0va-0005O5-Ad
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37237)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hr0v8-0003rN-Ty
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hr0v7-0007iQ-J8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:10:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hr0v4-0007df-BD; Fri, 26 Jul 2019 10:10:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8093E30B259D;
 Fri, 26 Jul 2019 14:10:01 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 074756012D;
 Fri, 26 Jul 2019 14:09:59 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 26 Jul 2019 16:09:53 +0200
Message-Id: <20190726140954.31921-2-ptoscano@redhat.com>
In-Reply-To: <20190726140954.31921-1-ptoscano@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 26 Jul 2019 14:10:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] ssh: implement password authentication
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
Cc: kwolf@redhat.com, ptoscano@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a 'password-secret' option which represents the name of an object
with the password of the user.

Signed-off-by: Pino Toscano <ptoscano@redhat.com>
---
 block/ssh.c                  | 35 ++++++++++++++++++++++++++++++++---
 block/trace-events           |  1 +
 docs/qemu-block-drivers.texi |  7 +++++--
 qapi/block-core.json         |  6 +++++-
 tests/qemu-iotests/207.out   |  2 +-
 5 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 501933b855..04ae223282 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -43,6 +43,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
+#include "crypto/secret.h"
 #include "trace.h"
=20
 /*
@@ -499,7 +500,8 @@ static int check_host_key(BDRVSSHState *s, SshHostKey=
Check *hkc, Error **errp)
     return -EINVAL;
 }
=20
-static int authenticate(BDRVSSHState *s, Error **errp)
+static int authenticate(BDRVSSHState *s, BlockdevOptionsSsh *opts,
+                        Error **errp)
 {
     int r, ret;
     int method;
@@ -538,9 +540,35 @@ static int authenticate(BDRVSSHState *s, Error **err=
p)
         }
     }
=20
+    /*
+     * Try to authenticate with password, if available.
+     */
+    if (method & SSH_AUTH_METHOD_PASSWORD && opts->has_password_secret) =
{
+        char *password;
+
+        trace_ssh_option_secret_object(opts->password_secret);
+        password =3D qcrypto_secret_lookup_as_utf8(opts->password_secret=
, errp);
+        if (!password) {
+            ret =3D -EINVAL;
+            goto out;
+        }
+        r =3D ssh_userauth_password(s->session, NULL, password);
+        g_free(password);
+        if (r =3D=3D SSH_AUTH_ERROR) {
+            ret =3D -EINVAL;
+            session_error_setg(errp, s, "failed to authenticate using "
+                                        "password authentication");
+            goto out;
+        } else if (r =3D=3D SSH_AUTH_SUCCESS) {
+            /* Authenticated! */
+            ret =3D 0;
+            goto out;
+        }
+    }
+
     ret =3D -EPERM;
     error_setg(errp, "failed to authenticate using publickey authenticat=
ion "
-               "and the identities held by your ssh-agent");
+               "and the identities held by your ssh-agent, or using pass=
word");
=20
  out:
     return ret;
@@ -785,7 +813,7 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOp=
tionsSsh *opts,
     }
=20
     /* Authenticate. */
-    ret =3D authenticate(s, errp);
+    ret =3D authenticate(s, opts, errp);
     if (ret < 0) {
         goto err;
     }
@@ -1376,6 +1404,7 @@ static const char *const ssh_strong_runtime_opts[] =
=3D {
     "user",
     "host_key_check",
     "server.",
+    "password-secret",
=20
     NULL
 };
diff --git a/block/trace-events b/block/trace-events
index d724df0117..391aae03e6 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -186,6 +186,7 @@ ssh_write_return(ssize_t ret, int sftp_err) "sftp_wri=
te returned %zd (sftp error
 ssh_seek(int64_t offset) "seeking to offset=3D%" PRIi64
 ssh_auth_methods(int methods) "auth methods=3D0x%x"
 ssh_server_status(int status) "server status=3D%d"
+ssh_option_secret_object(const char *path) "using password from object %=
s"
=20
 # curl.c
 curl_timer_cb(long timeout_ms) "timer callback timeout_ms %ld"
diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
index 91ab0eceae..c77ef2dd69 100644
--- a/docs/qemu-block-drivers.texi
+++ b/docs/qemu-block-drivers.texi
@@ -771,8 +771,11 @@ matches a specific fingerprint:
 (@code{sha1:} can also be used as a prefix, but note that OpenSSH
 tools only use MD5 to print fingerprints).
=20
-Currently authentication must be done using ssh-agent.  Other
-authentication methods may be supported in future.
+The optional @var{password-secret} parameter provides the ID of a
+@code{secret} object that contains the password for authenticating.
+
+Currently authentication must be done using ssh-agent, or providing a
+password.  Other authentication methods may be supported in future.
=20
 Note: Many ssh servers do not support an @code{fsync}-style operation.
 The ssh driver cannot guarantee that disk flush requests are
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..1244562c7b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3223,13 +3223,17 @@
 # @host-key-check:      Defines how and what to check the host key again=
st
 #                       (default: known_hosts)
 #
+# @password-secret:     ID of a QCryptoSecret object providing a passwor=
d
+#                       for authentication (since 4.2)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsSsh',
   'data': { 'server': 'InetSocketAddress',
             'path': 'str',
             '*user': 'str',
-            '*host-key-check': 'SshHostKeyCheck' } }
+            '*host-key-check': 'SshHostKeyCheck',
+            '*password-secret': 'str' } }
=20
=20
 ##
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 1239d9d648..5bfdf626b9 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -74,7 +74,7 @@ Job failed: failed to open remote file '/this/is/not/an=
/existing/path': SFTP ser
=20
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "none"}, "pat=
h": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}, =
"user": "invalid user"}, "size": 4194304}}}
 {"return": {}}
-Job failed: failed to authenticate using publickey authentication and th=
e identities held by your ssh-agent
+Job failed: failed to authenticate using publickey authentication and th=
e identities held by your ssh-agent, or using password
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
--=20
2.21.0


