Received: from eggs.gnu.org ([2001:4830:134:3::10]:45613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsDli-0003Ce-4V
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsDlf-0005jZ-1N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:00:50 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fsDle-0005j3-QD
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:00:46 -0400
Received: by mail-qt0-x241.google.com with SMTP id t5-v6so21949456qtn.3
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 14:00:46 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 21 Aug 2018 18:00:24 -0300
Message-Id: <20180821210024.3587-3-danielhb413@gmail.com>
In-Reply-To: <20180821210024.3587-1-danielhb413@gmail.com>
References: <20180821210024.3587-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/2] qcow2-snapshot: remove redundant
 find_snapshot_by_id_and_name call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

In qcow2_snapshot_create there is the following code block:

    /* Generate an ID */
    find_new_snapshot_id(bs, sn_info->id_str, sizeof(sn_info->id_str));

    /* Check that the ID is unique */
    if (find_snapshot_by_id_and_name(bs, sn_info->id_str, NULL) >= 0) {
        return -EEXIST;
    }

find_new_snapshot_id cycles through all snapshots, getting the id_str
as an unsigned long int, calculating the max id_max value of all the
existing id_strs and writing in the id_str pointer id_max + 1:

    for(i = 0; i < s->nb_snapshots; i++) {
        sn = s->snapshots + i;
        id = strtoul(sn->id_str, NULL, 10);
        if (id > id_max)
            id_max = id;
    }
    snprintf(id_str, id_str_size, "%lu", id_max + 1);

Here, sn_info->id_str will have the unique value id_max + 1. Right
after that, find_snapshot_by_id_and_name is called with
id = sn_info->id_str and name = NULL. This will cause the function
to execute the following:

    } else if (id) {
        for (i = 0; i < s->nb_snapshots; i++) {
            if (!strcmp(s->snapshots[i].id_str, id)) {
                return i;
            }
        }
    }

In short, we're searching the existing snapshots to see if sn_info->id_str
matches any existing id, right after we set in the previous line a
sn_info->id_str value that is already unique.

The first code block goes way back to commit 585f8587ad, a 2006 commit from
Fabrice Bellard that simply says "new qcow2 disk image format". No more
info is provided about this logic in any subsequent commits that moved
this code block around.

I can't say about the original design, but the current logic is redundant.
bdrv_snapshot_create is called in aio_context lock, forbidding any
concurrent call to accidentally create a new snapshot between
the find_new_snapshot_id and find_snapshot_by_id_and_name calls. What
we're ending up doing is to cycle through the snapshots two times
for no viable reason.

This patch eliminates the redundancy by removing the 'id is unique'
check that calls find_snapshot_by_id_and_name.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/qcow2-snapshot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index bb6a5b7516..20e8472191 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -358,11 +358,6 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     /* Generate an ID */
     find_new_snapshot_id(bs, sn_info->id_str, sizeof(sn_info->id_str));
 
-    /* Check that the ID is unique */
-    if (find_snapshot_by_id_and_name(bs, sn_info->id_str, NULL) >= 0) {
-        return -EEXIST;
-    }
-
     /* Populate sn with passed data */
     sn->id_str = g_strdup(sn_info->id_str);
     sn->name = g_strdup(sn_info->name);
-- 
2.17.1
