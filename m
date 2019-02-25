Received: from eggs.gnu.org ([209.51.188.92]:36941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4B-00089G-NF
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4A-0000a1-CK
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:45 +0100
Message-Id: <20190225152053.15976-4-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/71] block/snapshot.c: eliminate use of ID
 input in snapshot operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Daniel Henrique Barboza <danielhb413@gmail.com>

At this moment, QEMU attempts to create/load/delete snapshots
by using either an ID (id_str) or a name. The problem is that the code
isn't consistent of whether the entered argument is an ID or a name,
causing unexpected behaviors.

For example, when creating snapshots via savevm <arg>, what happens is th=
at
"arg" is treated as both name and id_str. In a guest without snapshots, c=
reate
a single snapshot via savevm:

(qemu) savevm 0
(qemu) info snapshots
List of snapshots present on all disks:
ID        TAG                 VM SIZE                DATE       VM CLOCK
--        0                      741M 2018-07-31 13:39:56   00:41:25.313

A snapshot with name "0" is created. ID is hidden from the user, but the
ID is a non-zero integer that starts at "1". Thus, this snapshot has
id_str=3D1, TAG=3D"0". Creating a second snapshot with arg =3D 1, the fir=
st one
is deleted:

(qemu) savevm 1
(qemu) info snapshots
List of snapshots present on all disks:
ID        TAG                 VM SIZE                DATE       VM CLOCK
--        1                      741M 2018-07-31 13:42:14   00:41:55.252

What happened?

- when creating the second snapshot, a verification is done inside
bdrv_all_delete_snapshot to delete any existing snapshots that matches an
string argument. Here, the code calls bdrv_all_delete_snapshot("1", ...);

- bdrv_all_delete_snapshot calls bdrv_snapshot_find(..., "1") for each
BlockDriverState of the guest. And this is where things goes tilting:
bdrv_snapshot_find does a search by both id_str and name. It finds
out that there is a snapshot that has id_str =3D 1, stores a reference
to the snapshot in the sn_info pointer and then returns match found;

- since a match was found, a call to bdrv_snapshot_delete_by_id_or_name()=
 is
made. This function ignores the pointer written by bdrv_snapshot_find. In=
stead,
it deletes the snapshot using bdrv_snapshot_delete() calling it first wit=
h
id_str =3D 1. If it fails to delete, then it calls it again with name =3D=
 1.

- after all that, QEMU creates the new snapshot, that has id_str =3D 1 an=
d
name =3D 1. The user is left wondering that happened with the first snaps=
hot
created. Similar bugs can be triggered when using loadvm and delvm.

Before contemplating discarding the use of ID input in these operations,
I've searched the code of what would be the implications. My findings
are:

- the RBD and Sheepdog drivers don't care. Both uses the 'name' field as
key in their logic, making id_str =3D name when appropriate.
replay-snapshot.c does not make any special use of id_str;

- qcow2 uses id_str as an unique identifier but it is automatically
calculated, not being influenced by user input. Other than that, there ar=
e
no distinguish operations made only with id_str;

- in blockdev.c, the delete operation uses a match of both id_str AND
name. Given that id_str is either a copy of 'name' or auto-generated,
we're fine here.

This gives motivation to not consider ID as a valid user input in HMP
commands - sticking with 'name' input only is more consistent. To
accomplish that, the following changes were made in this patch:

- bdrv_snapshot_find() does not match for id_str anymore, only 'name'. Th=
e
function is called in save_snapshot(), load_snapshot(), bdrv_all_delete_s=
napshot()
and bdrv_all_find_snapshot(). This change makes the search function more
predictable and does not change the behavior of any underlying code that =
uses
these affected functions, which are related to HMP (which is fine) and th=
e
main loop inside vl.c (which doesn't care about it anyways);

- bdrv_all_delete_snapshot() does not call bdrv_snapshot_delete_by_id_or_=
name
anymore. Instead, it uses the pointer returned by bdrv_snapshot_find to
erase the snapshot with the exact match of id_str an name. This function
is called in save_snapshot and hmp_delvm, thus this change  produces the
intended effect;

- documentation changes to reflect the new behavior. I consider this to
be an API fix instead of an API change - the user was already creating
snapshots using 'name', but now he/she will also enjoy a consistent
behavior.

Ideally we would get rid of the id_str field entirely, but this would hav=
e
repercussions on existing snapshots. Another day perhaps.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/snapshot.c |  5 +++--
 hmp-commands.hx  | 32 ++++++++++++++++++++------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index 3218a542df..e371d2243d 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -63,7 +63,7 @@ int bdrv_snapshot_find(BlockDriverState *bs, QEMUSnapsh=
otInfo *sn_info,
     }
     for (i =3D 0; i < nb_sns; i++) {
         sn =3D &sn_tab[i];
-        if (!strcmp(sn->id_str, name) || !strcmp(sn->name, name)) {
+        if (!strcmp(sn->name, name)) {
             *sn_info =3D *sn;
             ret =3D 0;
             break;
@@ -448,7 +448,8 @@ int bdrv_all_delete_snapshot(const char *name, BlockD=
riverState **first_bad_bs,
         aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs) &&
                 bdrv_snapshot_find(bs, snapshot, name) >=3D 0) {
-            ret =3D bdrv_snapshot_delete_by_id_or_name(bs, name, err);
+            ret =3D bdrv_snapshot_delete(bs, snapshot->id_str,
+                                       snapshot->name, err);
         }
         aio_context_release(ctx);
         if (ret < 0) {
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ba71558c25..e5fbc2ca59 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -350,49 +350,57 @@ ETEXI
     {
         .name       =3D "savevm",
         .args_type  =3D "name:s?",
-        .params     =3D "[tag|id]",
-        .help       =3D "save a VM snapshot. If no tag or id are provide=
d, a new snapshot is created",
+        .params     =3D "tag",
+        .help       =3D "save a VM snapshot. If no tag is provided, a ne=
w snapshot is created",
         .cmd        =3D hmp_savevm,
     },
=20
 STEXI
-@item savevm [@var{tag}|@var{id}]
+@item savevm @var{tag}
 @findex savevm
 Create a snapshot of the whole virtual machine. If @var{tag} is
 provided, it is used as human readable identifier. If there is already
-a snapshot with the same tag or ID, it is replaced. More info at
+a snapshot with the same tag, it is replaced. More info at
 @ref{vm_snapshots}.
+
+Since 4.0, savevm stopped allowing the snapshot id to be set, accepting
+only @var{tag} as parameter.
 ETEXI
=20
     {
         .name       =3D "loadvm",
         .args_type  =3D "name:s",
-        .params     =3D "tag|id",
-        .help       =3D "restore a VM snapshot from its tag or id",
+        .params     =3D "tag",
+        .help       =3D "restore a VM snapshot from its tag",
         .cmd        =3D hmp_loadvm,
         .command_completion =3D loadvm_completion,
     },
=20
 STEXI
-@item loadvm @var{tag}|@var{id}
+@item loadvm @var{tag}
 @findex loadvm
 Set the whole virtual machine to the snapshot identified by the tag
-@var{tag} or the unique snapshot ID @var{id}.
+@var{tag}.
+
+Since 4.0, loadvm stopped accepting snapshot id as parameter.
 ETEXI
=20
     {
         .name       =3D "delvm",
         .args_type  =3D "name:s",
-        .params     =3D "tag|id",
-        .help       =3D "delete a VM snapshot from its tag or id",
+        .params     =3D "tag",
+        .help       =3D "delete a VM snapshot from its tag",
         .cmd        =3D hmp_delvm,
         .command_completion =3D delvm_completion,
     },
=20
 STEXI
-@item delvm @var{tag}|@var{id}
+@item delvm @var{tag}
 @findex delvm
-Delete the snapshot identified by @var{tag} or @var{id}.
+Delete the snapshot identified by @var{tag}.
+
+Since 4.0, delvm stopped deleting snapshots by snapshot id, accepting
+only @var{tag} as parameter.
 ETEXI
=20
     {
--=20
2.20.1
