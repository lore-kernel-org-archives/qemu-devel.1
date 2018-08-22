Received: from eggs.gnu.org ([2001:4830:134:3::10]:57079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fsbHK-00081U-LN
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fsbHF-00024d-Lj
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:07:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54328
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fsbHF-00024T-FL
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:06:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7MM3XLq060453
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 18:06:56 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m1fxqrqvb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 18:06:56 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 22 Aug 2018 16:06:55 -0600
Date: Wed, 22 Aug 2018 19:06:48 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180821210024.3587-1-danielhb413@gmail.com>
	<20180821210024.3587-2-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821210024.3587-2-danielhb413@gmail.com>
Message-Id: <20180822220648.GB5287@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] block/snapshot.c: eliminate use of
 ID input in snapshot operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Hi, Daniel.

On Tue, Aug 21, 2018 at 06:00:23PM -0300, Daniel Henrique Barboza wrote:
> At this moment, QEMU attempts to create/load/delete snapshots
> by using either an ID (id_str) or a name. The problem is that the code
> isn't consistent of whether the entered argument is an ID or a name,
> causing unexpected behaviors.
> 
> For example, when creating snapshots via savevm <arg>, what happens is that
> "arg" is treated as both name and id_str. In a guest without snapshots, create
> a single snapshot via savevm:
> 
> (qemu) savevm 0
> (qemu) info snapshots
> List of snapshots present on all disks:
> ID        TAG                 VM SIZE                DATE       VM CLOCK
> --        0                      741M 2018-07-31 13:39:56   00:41:25.313
> 
> A snapshot with name "0" is created. ID is hidden from the user, but the
> ID is a non-zero integer that starts at "1". Thus, this snapshot has
> id_str=1, TAG="0". Creating a second snapshot with arg = 1, the first one
> is deleted:
> 
> (qemu) savevm 1
> (qemu) info snapshots
> List of snapshots present on all disks:
> ID        TAG                 VM SIZE                DATE       VM CLOCK
> --        1                      741M 2018-07-31 13:42:14   00:41:55.252
> 
> What happened?
> 
> - when creating the second snapshot, a verification is done inside
> bdrv_all_delete_snapshot to delete any existing snapshots that matches an
> string argument. Here, the code calls bdrv_all_delete_snapshot("1", ...);
> 
> - bdrv_all_delete_snapshot calls bdrv_snapshot_find(..., "1") for each
> BlockDriverState of the guest. And this is where things goes tilting:
> bdrv_snapshot_find does a search by both id_str and name. It finds
> out that there is a snapshot that has id_str = 1, stores a reference
> to the snapshot in the sn_info pointer and then returns match found;
> 
> - since a match was found, a call to bdrv_snapshot_delete_by_id_or_name() is
> made. This function ignores the pointer written by bdrv_snapshot_find. Instead,
> it deletes the snapshot using bdrv_snapshot_delete() calling it first with
> id_str = 1. If it fails to delete, then it calls it again with name = 1.
> 
> - after all that, QEMU creates the new snapshot, that has id_str = 1 and
> name = 1. The user is left wondering that happened with the first snapshot
> created. Similar bugs can be triggered when using loadvm and delvm.
> 
> Before contemplating discarding the use of ID input in these operations,
> I've searched the code of what would be the implications. My findings
> are:
> 
> - the RBD and Sheepdog drivers don't care. Both uses the 'name' field as
> key in their logic, making id_str = name when appropriate.
> replay-snapshot.c does not make any special use of id_str;
> 
> - qcow2 uses id_str as an unique identifier but it is automatically
> calculated, not being influenced by user input. Other than that, there are
> no distinguish operations made only with id_str;
> 
> - in blockdev.c, the delete operation uses a match of both id_str AND
> name. Given that id_str is either a copy of 'name' or auto-generated,
> we're fine here.
> 
> This gives motivation to not consider ID as a valid user input in HMP
> commands - sticking with 'name' input only is more consistent. To
> accomplish that, the following changes were made in this patch:
> 
> - bdrv_snapshot_find() does not match for id_str anymore, only 'name'. The
> function is called in save_snapshot(), load_snapshot(), bdrv_all_delete_snapshot()
> and bdrv_all_find_snapshot(). This change makes the search function more
> predictable and does not change the behavior of any underlying code that uses
> these affected functions, which are related to HMP (which is fine) and the
> main loop inside vl.c (which doesn't care about it anyways);
> 
> - bdrv_all_delete_snapshot() does not call bdrv_snapshot_delete_by_id_or_name
> anymore. Instead, it uses the pointer returned by bdrv_snapshot_find to
> erase the snapshot with the exact match of id_str an name. This function
> is called in save_snapshot and hmp_delvm, thus this change  produces the
> intended effect;
> 
> - documentation changes to reflect the new behavior. I consider this to
> be an API fix instead of an API change - the user was already creating
> snapshots using 'name', but now he/she will also enjoy a consistent
> behavior. Libvirt does not care about this change either, as far as
> I've tested.
> 
> Ideally we would get rid of the id_str field entirely, but this would have
> repercussions on existing snapshots. Another day perhaps.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  block/snapshot.c |  5 +++--
>  hmp-commands.hx  | 20 ++++++++++----------
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/block/snapshot.c b/block/snapshot.c
> index 3218a542df..e371d2243d 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -63,7 +63,7 @@ int bdrv_snapshot_find(BlockDriverState *bs, QEMUSnapshotInfo *sn_info,
>      }
>      for (i = 0; i < nb_sns; i++) {
>          sn = &sn_tab[i];
> -        if (!strcmp(sn->id_str, name) || !strcmp(sn->name, name)) {
> +        if (!strcmp(sn->name, name)) {
>              *sn_info = *sn;
>              ret = 0;
>              break;
> @@ -448,7 +448,8 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
>          aio_context_acquire(ctx);
>          if (bdrv_can_snapshot(bs) &&
>                  bdrv_snapshot_find(bs, snapshot, name) >= 0) {
> -            ret = bdrv_snapshot_delete_by_id_or_name(bs, name, err);
> +            ret = bdrv_snapshot_delete(bs, snapshot->id_str,
> +                                       snapshot->name, err);
>          }
>          aio_context_release(ctx);
>          if (ret < 0) {
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index c1fc747403..e55b889868 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -350,17 +350,17 @@ ETEXI
>      {
>          .name       = "savevm",
>          .args_type  = "name:s?",
> -        .params     = "[tag|id]",
> -        .help       = "save a VM snapshot. If no tag or id are provided, a new snapshot is created",
> +        .params     = "tag",
> +        .help       = "save a VM snapshot. If no tag is provided, a new snapshot is created",
>          .cmd        = hmp_savevm,
>      },
>  
>  STEXI
> -@item savevm [@var{tag}|@var{id}]
> +@item savevm @var{tag}
>  @findex savevm
>  Create a snapshot of the whole virtual machine. If @var{tag} is
>  provided, it is used as human readable identifier. If there is already
> -a snapshot with the same tag or ID, it is replaced. More info at
> +a snapshot with the same tag, it is replaced. More info at
>  @ref{vm_snapshots}.
>  ETEXI
>  
> @@ -368,31 +368,31 @@ ETEXI
>          .name       = "loadvm",
>          .args_type  = "name:s",
>          .params     = "tag|id",

If we go ahead with this, you may want to update .params too.

> -        .help       = "restore a VM snapshot from its tag or id",
> +        .help       = "restore a VM snapshot from its tag",
>          .cmd        = hmp_loadvm,
>          .command_completion = loadvm_completion,
>      },
>  
>  STEXI
> -@item loadvm @var{tag}|@var{id}
> +@item loadvm @var{tag}
>  @findex loadvm
>  Set the whole virtual machine to the snapshot identified by the tag
> -@var{tag} or the unique snapshot ID @var{id}.
> +@var{tag}.
>  ETEXI
>  
>      {
>          .name       = "delvm",
>          .args_type  = "name:s",
>          .params     = "tag|id",

Same here.

> -        .help       = "delete a VM snapshot from its tag or id",
> +        .help       = "delete a VM snapshot from its tag",
>          .cmd        = hmp_delvm,
>          .command_completion = delvm_completion,
>      },
>  
>  STEXI
> -@item delvm @var{tag}|@var{id}
> +@item delvm @var{tag}
>  @findex delvm
> -Delete the snapshot identified by @var{tag} or @var{id}.
> +Delete the snapshot identified by @var{tag}.
>  ETEXI
>  
>      {
> -- 
> 2.17.1
> 
> 

-- 
Murilo
