Received: from eggs.gnu.org ([2001:4830:134:3::10]:53539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXi1-0001gF-8h
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhw-0001cV-VG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 21:14:42 +0200
Message-Id: <20180614191443.14361-18-armbru@redhat.com>
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/18] rbd: New parameter
 auth-client-required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Parameter auth-client-required lets you configure authentication
methods.  We tried to provide that in v2.9.0, but backed out due to
interface design doubts (commit 464444fcc16).

This commit is similar to what we backed out, but simpler: we use a
list of enumeration values instead of a list of objects with a member
of enumeration type.

Let's review our reasons for backing out the first try, as stated in
the commit message:

    * The implementation uses deprecated rados_conf_set() key
      "auth_supported".  No biggie.

Fixed: we use "auth-client-required".

    * The implementation makes -drive silently ignore invalid parameters
      "auth" and "auth-supported.*.X" where X isn't "auth".  Fixable (in
      fact I'm going to fix similar bugs around parameter server), so
      again no biggie.

That fix is commit 2836284db60.  This commit doesn't bring the bugs
back.

    * BlockdevOptionsRbd member @password-secret applies only to
      authentication method cephx.  Should it be a variant member of
      RbdAuthMethod?

We've had time to ponder, and we decided to stick to the way Ceph
configuration works: the key configured separately, and silently
ignored if the authentication method doesn't use it.

    * BlockdevOptionsRbd member @user could apply to both methods cephx
      and none, but I'm not sure it's actually used with none.  If it
      isn't, should it be a variant member of RbdAuthMethod?

Likewise.

    * The client offers a *set* of authentication methods, not a list.
      Should the methods be optional members of BlockdevOptionsRbd instead
      of members of list @auth-supported?  The latter begs the question
      what multiple entries for the same method mean.  Trivial question
      now that RbdAuthMethod contains nothing but @type, but less so when
      RbdAuthMethod acquires other members, such the ones discussed above.

Again, we decided to stick to the way Ceph configuration works, except
we make auth-client-required a list of enumeration values instead of a
string containing keywords separated by delimiters.

    * How BlockdevOptionsRbd member @auth-supported interacts with
      settings from a configuration file specified with @conf is
      undocumented.  I suspect it's untested, too.

Not actually true, the documentation for @conf says "Values in the
configuration file will be overridden by options specified via QAPI",
and we've tested this.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c          | 42 ++++++++++++++++++++++++++++++++----------
 qapi/block-core.json | 13 +++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 82346a2a5e..ea0575d068 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -240,20 +240,42 @@ static void qemu_rbd_refresh_limits(BlockDriverState *bs, Error **errp)
 
 
 static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
+                             BlockdevOptionsRbd *opts,
                              Error **errp)
 {
-    if (secretid == 0) {
-        return 0;
-    }
+    char *acr;
+    int r;
+    GString *accu;
+    RbdAuthModeList *auth;
+
+    if (secretid) {
+        gchar *secret = qcrypto_secret_lookup_as_base64(secretid,
+                                                        errp);
+        if (!secret) {
+            return -1;
+        }
 
-    gchar *secret = qcrypto_secret_lookup_as_base64(secretid,
-                                                    errp);
-    if (!secret) {
-        return -1;
+        rados_conf_set(cluster, "key", secret);
+        g_free(secret);
     }
 
-    rados_conf_set(cluster, "key", secret);
-    g_free(secret);
+    if (opts->has_auth_client_required) {
+        accu = g_string_new("");
+        for (auth = opts->auth_client_required; auth; auth = auth->next) {
+            if (accu->str[0]) {
+                g_string_append_c(accu, ';');
+            }
+            g_string_append(accu, RbdAuthMode_str(auth->value));
+        }
+        acr = g_string_free(accu, FALSE);
+        r = rados_conf_set(cluster, "auth_client_required", acr);
+        g_free(acr);
+        if (r < 0) {
+            error_setg_errno(errp, -r,
+                             "Could not set 'auth_client_required'");
+            return r;
+        }
+    }
 
     return 0;
 }
@@ -585,7 +607,7 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
         }
     }
 
-    if (qemu_rbd_set_auth(*cluster, secretid, errp) < 0) {
+    if (qemu_rbd_set_auth(*cluster, secretid, opts, errp) < 0) {
         r = -EIO;
         goto failed_shutdown;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fff23fc82b..0f68ca56f3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3177,6 +3177,14 @@
             '*timeout': 'int' } }
 
 
+##
+# @RbdAuthMode:
+#
+# Since: 3.0
+##
+{ 'enum': 'RbdAuthMode',
+  'data': [ 'cephx', 'none' ] }
+
 ##
 # @BlockdevOptionsRbd:
 #
@@ -3192,6 +3200,10 @@
 #
 # @user:               Ceph id name.
 #
+# @auth-client-required: Acceptable authentication modes.
+#                      This maps to Ceph configuration option
+#                      "auth_client_required".  (Since 3.0)
+#
 # @server:             Monitor host address and port.  This maps
 #                      to the "mon_host" Ceph option.
 #
@@ -3203,6 +3215,7 @@
             '*conf': 'str',
             '*snapshot': 'str',
             '*user': 'str',
+            '*auth-client-required': ['RbdAuthMode'],
             '*server': ['InetSocketAddressBase'] } }
 
 ##
-- 
2.17.1
