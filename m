Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78671C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFEC21850
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFEC21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0vd-0005bu-U7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hr0vA-0003zV-Kb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hr0v9-0007kr-7V
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:10:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hr0v6-0007gS-0w; Fri, 26 Jul 2019 10:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4952C30BC590;
 Fri, 26 Jul 2019 14:10:03 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEA785C6E0;
 Fri, 26 Jul 2019 14:10:01 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 26 Jul 2019 16:09:54 +0200
Message-Id: <20190726140954.31921-3-ptoscano@redhat.com>
In-Reply-To: <20190726140954.31921-1-ptoscano@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 26 Jul 2019 14:10:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] ssh: implement private key authentication
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

Add a 'private-key' option which represents the path of a private key
to use for authentication, and 'private-key-secret' as the name of an
object with its passphrase.

Signed-off-by: Pino Toscano <ptoscano@redhat.com>
---
 block/ssh.c                  | 98 ++++++++++++++++++++++++++++++++++++
 block/trace-events           |  1 +
 docs/qemu-block-drivers.texi | 12 ++++-
 qapi/block-core.json         |  9 +++-
 4 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 04ae223282..1b7c1f4108 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -500,6 +500,89 @@ static int check_host_key(BDRVSSHState *s, SshHostKe=
yCheck *hkc, Error **errp)
     return -EINVAL;
 }
=20
+static int authenticate_privkey(BDRVSSHState *s, BlockdevOptionsSsh *opt=
s,
+                                Error **errp)
+{
+    int err;
+    int ret;
+    char *pubkey_file =3D NULL;
+    ssh_key public_key =3D NULL;
+    ssh_key private_key =3D NULL;
+    char *passphrase;
+
+    pubkey_file =3D g_strdup_printf("%s.pub", opts->private_key);
+
+    /* load the private key */
+    trace_ssh_auth_key_passphrase(opts->private_key_secret, opts->privat=
e_key);
+    passphrase =3D qcrypto_secret_lookup_as_utf8(opts->private_key_secre=
t, errp);
+    if (!passphrase) {
+        err =3D SSH_AUTH_ERROR;
+        goto error;
+    }
+    ret =3D ssh_pki_import_privkey_file(opts->private_key, passphrase,
+                                      NULL, NULL, &private_key);
+    g_free(passphrase);
+    if (ret =3D=3D SSH_EOF) {
+        error_setg(errp, "Cannot read private key '%s'", opts->private_k=
ey);
+        err =3D SSH_AUTH_ERROR;
+        goto error;
+    } else if (ret =3D=3D SSH_ERROR) {
+        error_setg(errp,
+                   "Cannot open private key '%s', maybe the passphrase i=
s "
+                   "wrong",
+                   opts->private_key);
+        err =3D SSH_AUTH_ERROR;
+        goto error;
+    }
+
+    /* try to open the public part of the private key */
+    ret =3D ssh_pki_import_pubkey_file(pubkey_file, &public_key);
+    if (ret =3D=3D SSH_ERROR) {
+        error_setg(errp, "Cannot read public key '%s'", pubkey_file);
+        err =3D SSH_AUTH_ERROR;
+        goto error;
+    } else if (ret =3D=3D SSH_EOF) {
+        /* create the public key from the private key */
+        ret =3D ssh_pki_export_privkey_to_pubkey(private_key, &public_ke=
y);
+        if (ret =3D=3D SSH_ERROR) {
+            error_setg(errp,
+                       "Cannot export the public key from the private ke=
y "
+                       "'%s'",
+                       opts->private_key);
+            err =3D SSH_AUTH_ERROR;
+            goto error;
+        }
+    }
+
+    ret =3D ssh_userauth_try_publickey(s->session, NULL, public_key);
+    if (ret !=3D SSH_AUTH_SUCCESS) {
+        err =3D SSH_AUTH_DENIED;
+        goto error;
+    }
+
+    ret =3D ssh_userauth_publickey(s->session, NULL, private_key);
+    if (ret !=3D SSH_AUTH_SUCCESS) {
+        err =3D SSH_AUTH_DENIED;
+        goto error;
+    }
+
+    ssh_key_free(private_key);
+    ssh_key_free(public_key);
+    g_free(pubkey_file);
+
+    return SSH_AUTH_SUCCESS;
+
+ error:
+    if (private_key) {
+        ssh_key_free(private_key);
+    }
+    if (public_key) {
+        ssh_key_free(public_key);
+    }
+    g_free(pubkey_file);
+    return err;
+}
+
 static int authenticate(BDRVSSHState *s, BlockdevOptionsSsh *opts,
                         Error **errp)
 {
@@ -538,6 +621,21 @@ static int authenticate(BDRVSSHState *s, BlockdevOpt=
ionsSsh *opts,
             ret =3D 0;
             goto out;
         }
+
+        /*
+         * Try to authenticate with private key, if available.
+         */
+        if (opts->has_private_key && opts->has_private_key_secret) {
+            r =3D authenticate_privkey(s, opts, errp);
+            if (r =3D=3D SSH_AUTH_ERROR) {
+                ret =3D -EINVAL;
+                goto out;
+            } else if (r =3D=3D SSH_AUTH_SUCCESS) {
+                /* Authenticated! */
+                ret =3D 0;
+                goto out;
+            }
+        }
     }
=20
     /*
diff --git a/block/trace-events b/block/trace-events
index 391aae03e6..ccb51b9992 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -187,6 +187,7 @@ ssh_seek(int64_t offset) "seeking to offset=3D%" PRIi=
64
 ssh_auth_methods(int methods) "auth methods=3D0x%x"
 ssh_server_status(int status) "server status=3D%d"
 ssh_option_secret_object(const char *path) "using password from object %=
s"
+ssh_auth_key_passphrase(const char *path, const char *key) "using passph=
rase from object %s for private key %s"
=20
 # curl.c
 curl_timer_cb(long timeout_ms) "timer callback timeout_ms %ld"
diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
index c77ef2dd69..5513bf261c 100644
--- a/docs/qemu-block-drivers.texi
+++ b/docs/qemu-block-drivers.texi
@@ -774,8 +774,16 @@ tools only use MD5 to print fingerprints).
 The optional @var{password-secret} parameter provides the ID of a
 @code{secret} object that contains the password for authenticating.
=20
-Currently authentication must be done using ssh-agent, or providing a
-password.  Other authentication methods may be supported in future.
+The optional @var{private-key} parameter provides the path to the
+private key for authenticating.
+
+The optional @var{private-key-secret} parameter provides the ID of a
+@code{secret} object that contains the passphrase of the private key
+specified as @var{private-key} for authenticating.
+
+Currently authentication must be done using ssh-agent, providing a
+private key with its passphrase, or providing a password.
+Other authentication methods may be supported in future.
=20
 Note: Many ssh servers do not support an @code{fsync}-style operation.
 The ssh driver cannot guarantee that disk flush requests are
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1244562c7b..e873f8934d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3226,6 +3226,11 @@
 # @password-secret:     ID of a QCryptoSecret object providing a passwor=
d
 #                       for authentication (since 4.2)
 #
+# @private-key:         path to the private key (since 4.2)
+#
+# @private-key-secret:  ID of a QCryptoSecret object providing the passp=
hrase
+#                       for 'private-key' (since 4.2)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsSsh',
@@ -3233,7 +3238,9 @@
             'path': 'str',
             '*user': 'str',
             '*host-key-check': 'SshHostKeyCheck',
-            '*password-secret': 'str' } }
+            '*password-secret': 'str',
+            '*private-key': 'str',
+            '*private-key-secret': 'str' } }
=20
=20
 ##
--=20
2.21.0


