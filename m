Received: from eggs.gnu.org ([2001:4830:134:3::10]:42063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfX0-0000QF-22
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfWw-0003Et-TB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:54 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 19:01:26 +0100
Message-Id: <20171114180128.17076-5-mreitz@redhat.com>
In-Reply-To: <20171114180128.17076-1-mreitz@redhat.com>
References: <20171114180128.17076-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11? v7 4/6] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Currently, bdrv_reopen_prepare() assumes that all BDS options are
strings. However, this is not the case if the BDS has been created
through the json: pseudo-protocol or blockdev-add.

Note that the user-invokable reopen command is an HMP command, so you
can only specify strings there. Therefore, specifying a non-string
option with the "same" value as it was when originally created will now
return an error because the values are supposedly similar (and there is
no way for the user to circumvent this but to just not specify the
option again -- however, this is still strictly better than just
crashing).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 684cb018da..28889a2690 100644
--- a/block.c
+++ b/block.c
@@ -3069,19 +3069,26 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         const QDictEntry *entry = qdict_first(reopen_state->options);
 
         do {
-            QString *new_obj = qobject_to_qstring(entry->value);
-            const char *new = qstring_get_str(new_obj);
+            QObject *new = entry->value;
+            QObject *old = qdict_get(reopen_state->bs->options, entry->key);
+
             /*
-             * Caution: while qdict_get_try_str() is fine, getting
-             * non-string types would require more care.  When
-             * bs->options come from -blockdev or blockdev_add, its
-             * members are typed according to the QAPI schema, but
-             * when they come from -drive, they're all QString.
+             * TODO: When using -drive to specify blockdev options, all values
+             * will be strings; however, when using -blockdev, blockdev-add or
+             * filenames using the json:{} pseudo-protocol, they will be
+             * correctly typed.
+             * In contrast, reopening options are (currently) always strings
+             * (because you can only specify them through qemu-io; all other
+             * callers do not specify any options).
+             * Therefore, when using anything other than -drive to create a BDS,
+             * this cannot detect non-string options as unchanged, because
+             * qobject_is_equal() always returns false for objects of different
+             * type.  In the future, this should be remedied by correctly typing
+             * all options.  For now, this is not too big of an issue because
+             * the user can simply omit options which cannot be changed anyway,
+             * so they will stay unchanged.
              */
-            const char *old = qdict_get_try_str(reopen_state->bs->options,
-                                                entry->key);
-
-            if (!old || strcmp(new, old)) {
+            if (!qobject_is_equal(new, old)) {
                 error_setg(errp, "Cannot change the option '%s'", entry->key);
                 ret = -EINVAL;
                 goto error;
-- 
2.13.6
