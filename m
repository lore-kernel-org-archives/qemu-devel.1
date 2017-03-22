Received: from eggs.gnu.org ([2001:4830:134:3::10]:52695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkNA-0007uW-Md
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0001NU-Ob
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:27 +0100
Message-Id: <1490204908-26567-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-1-git-send-email-armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 for-2.9 16/17] qom: Avoid unvisited
 'id'/'qom-type' in user_creatable_add_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org

From: Eric Blake <eblake@redhat.com>

A regression in commit 15c2f669e caused us to silently ignore
excess input to the QemuOpts visitor.  Later, commit ea4641
accidentally abused that situation, by removing "qom-type" and
"id" from the corresponding QDict but leaving them defined in
the QemuOpts, when using the pair of containers to create a
user-defined object. Note that since we are already traversing
two separate items (a QDict and a QemuOpts), we are already
able to flag bogus arguments, as in:

$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio -object memory-backend-ram,id=mem1,size=4k,bogus=huh
qemu-system-x86_64: -object memory-backend-ram,id=mem1,size=4k,bogus=huh: Property '.bogus' not found

So the only real concern is that when we re-enable strict checking
in the QemuOpts visitor, we do not want to start flagging the two
leftover keys as unvisited.  Rearrange the code to clean out the
QemuOpts listing in advance, rather than removing items from the
QDict.  Since "qom-type" is usually an automatic implicit default,
we don't have to restore it (this does mean that once instantiated,
QemuOpts is not necessarily an accurate representation of the
original command line - but this is not the first place to do that);
however "id" has to be put back (requiring us to cast away a const).

[As a side note, hmp_object_add() turns a QDict into a QemuOpts,
then calls user_creatable_add_opts() which converts QemuOpts into
a new QDict. There are probably a lot of wasteful conversions like
this, but cleaning them up is a much bigger task than the immediate
regression fix.]

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170322144525.18964-3-eblake@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object_interfaces.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 03a95c3..cc9a694 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -114,7 +114,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
     QDict *pdict;
     Object *obj;
     const char *id = qemu_opts_id(opts);
-    const char *type = qemu_opt_get(opts, "qom-type");
+    char *type = qemu_opt_get_del(opts, "qom-type");
 
     if (!type) {
         error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
@@ -125,14 +125,15 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
+    qemu_opts_set_id(opts, NULL);
     pdict = qemu_opts_to_qdict(opts, NULL);
-    qdict_del(pdict, "qom-type");
-    qdict_del(pdict, "id");
 
     v = opts_visitor_new(opts);
     obj = user_creatable_add_type(type, id, pdict, v, errp);
     visit_free(v);
 
+    qemu_opts_set_id(opts, (char *) id);
+    g_free(type);
     QDECREF(pdict);
     return obj;
 }
-- 
2.7.4
