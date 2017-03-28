Received: from eggs.gnu.org ([2001:4830:134:3::10]:39925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvL-0000E8-DJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvJ-0008ON-PM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:19 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:56:06 +0200
Message-Id: <1490691368-32099-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490691368-32099-1-git-send-email-armbru@redhat.com>
References: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 08/10] rbd: Revert -blockdev and
 -drive parameter auth-supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

This reverts half of commit 0a55679.  We're having second thoughts on
the QAPI schema (and thus the external interface), and haven't reached
consensus, yet.  Issues include:

* The implementation uses deprecated rados_conf_set() key
  "auth_supported".  No biggie.

* The implementation makes -drive silently ignore invalid parameters
  "auth" and "auth-supported.*.X" where X isn't "auth".  Fixable (in
  fact I'm going to fix similar bugs around parameter server), so
  again no biggie.

* BlockdevOptionsRbd member @password-secret applies only to
  authentication method cephx.  Should it be a variant member of
  RbdAuthMethod?

* BlockdevOptionsRbd member @user could apply to both methods cephx
  and none, but I'm not sure it's actually used with none.  If it
  isn't, should it be a variant member of RbdAuthMethod?

* The client offers a *set* of authentication methods, not a list.
  Should the methods be optional members of BlockdevOptionsRbd instead
  of members of list @auth-supported?  The latter begs the question
  what multiple entries for the same method mean.  Trivial question
  now that RbdAuthMethod contains nothing but @type, but less so when
  RbdAuthMethod acquires other members, such the ones discussed above.

* How BlockdevOptionsRbd member @auth-supported interacts with
  settings from a configuration file specified with @conf is
  undocumented.  I suspect it's untested, too.

Let's avoid painting ourselves into a corner now, and revert the
feature for 2.9.

Note that users can still configure authentication methods with a
configuration file.  They probably do that anyway if they use Ceph
outside QEMU as well.

Further note that this doesn't affect use of key "auth-supported" in
-drive file=rbd:...:key=value.

qemu_rbd_array_opts()'s parameter @type now must be RBD_MON_HOST,
which is silly.  This will be cleaned up shortly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c          | 31 +++----------------------------
 qapi/block-core.json | 24 ------------------------
 2 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 16ea60a..485cef4 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -320,8 +320,7 @@ static QemuOptsList runtime_opts = {
             .help = "Rados id name",
         },
         /*
-         * server.* and auth-supported.* extracted manually, see
-         * qemu_rbd_array_opts()
+         * server.* extracted manually, see qemu_rbd_array_opts()
          */
         {
             .name = "password-secret",
@@ -356,11 +355,6 @@ static QemuOptsList runtime_opts = {
             .name = "port",
             .type = QEMU_OPT_STRING,
         },
-        {
-            .name = "auth",
-            .type = QEMU_OPT_STRING,
-            .help = "Supported authentication method, either cephx or none",
-        },
         { /* end of list */ }
     },
 };
@@ -512,7 +506,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
 }
 
 #define RBD_MON_HOST          0
-#define RBD_AUTH_SUPPORTED    1
 
 static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
                                  Error **errp)
@@ -527,7 +520,7 @@ static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
     Error *local_err = NULL;
     int i;
 
-    assert(type == RBD_MON_HOST || type == RBD_AUTH_SUPPORTED);
+    assert(type == RBD_MON_HOST);
 
     num_entries = qdict_array_entries(options, prefix);
 
@@ -573,10 +566,9 @@ static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
                 value = strbuf;
             }
         } else {
-            value = qemu_opt_get(opts, "auth");
+            abort();
         }
 
-
         /* each iteration in the for loop will build upon the string, and if
          * rados_str is NULL then it is our first pass */
         if (rados_str) {
@@ -608,7 +600,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     Error *local_err = NULL;
     char *mon_host = NULL;
-    char *auth_supported = NULL;
     int r;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
@@ -619,14 +610,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    auth_supported = qemu_rbd_array_opts(options, "auth-supported.",
-                                         RBD_AUTH_SUPPORTED, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        r = -EINVAL;
-        goto failed_opts;
-    }
-
     mon_host = qemu_rbd_array_opts(options, "server.",
                                    RBD_MON_HOST, &local_err);
     if (local_err) {
@@ -678,13 +661,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (auth_supported) {
-        r = rados_conf_set(s->cluster, "auth_supported", auth_supported);
-        if (r < 0) {
-            goto failed_shutdown;
-        }
-    }
-
     if (qemu_rbd_set_auth(s->cluster, secretid, errp) < 0) {
         r = -EIO;
         goto failed_shutdown;
@@ -735,7 +711,6 @@ failed_shutdown:
 failed_opts:
     qemu_opts_del(opts);
     g_free(mon_host);
-    g_free(auth_supported);
     return r;
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5d2efe4..6a7ca0b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2601,27 +2601,6 @@
 
 
 ##
-# @RbdAuthSupport:
-#
-# An enumeration of RBD auth support
-#
-# Since: 2.9
-##
-{ 'enum': 'RbdAuthSupport',
-  'data': [ 'cephx', 'none' ] }
-
-
-##
-# @RbdAuthMethod:
-#
-# An enumeration of rados auth_supported types
-#
-# Since: 2.9
-##
-{ 'struct': 'RbdAuthMethod',
-  'data': { 'auth': 'RbdAuthSupport' } }
-
-##
 # @BlockdevOptionsRbd:
 #
 # @pool:               Ceph pool name.
@@ -2639,8 +2618,6 @@
 # @server:             Monitor host address and port.  This maps
 #                      to the "mon_host" Ceph option.
 #
-# @auth-supported:     Authentication supported.
-#
 # @password-secret:    The ID of a QCryptoSecret object providing
 #                      the password for the login.
 #
@@ -2653,7 +2630,6 @@
             '*snapshot': 'str',
             '*user': 'str',
             '*server': ['InetSocketAddressBase'],
-            '*auth-supported': ['RbdAuthMethod'],
             '*password-secret': 'str' } }
 
 ##
-- 
2.7.4
