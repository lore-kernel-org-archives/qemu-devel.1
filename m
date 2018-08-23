Received: from eggs.gnu.org ([2001:4830:134:3::10]:53097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsw5G-0007jZ-U3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsw5F-0003im-OD
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:19:58 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:35517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fsw5F-0003ig-Ho
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:19:57 -0400
Received: by mail-qt0-x230.google.com with SMTP id f19-v6so6348146qtf.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 13:19:57 -0700 (PDT)
References: <20180821210024.3587-1-danielhb413@gmail.com>
	<20180821210024.3587-2-danielhb413@gmail.com>
	<20180823192713.GA2061@kermit-br-ibm-com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <ae0c47eb-ec54-78db-f65a-5be3d7263e61@gmail.com>
Date: Thu, 23 Aug 2018 17:19:52 -0300
MIME-Version: 1.0
In-Reply-To: <20180823192713.GA2061@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com



On 08/23/2018 04:27 PM, Murilo Opsfelder Araujo wrote:
> Hi, Daniel.
>
> On Tue, Aug 21, 2018 at 06:00:23PM -0300, Daniel Henrique Barboza wrote:
>> At this moment, QEMU attempts to create/load/delete snapshots
>> by using either an ID (id_str) or a name. The problem is that the code
>> isn't consistent of whether the entered argument is an ID or a name,
>> causing unexpected behaviors.
>>
>> For example, when creating snapshots via savevm <arg>, what happens is that
>> "arg" is treated as both name and id_str. In a guest without snapshots, create
>> a single snapshot via savevm:
>>
>> (qemu) savevm 0
>> (qemu) info snapshots
>> List of snapshots present on all disks:
>> ID        TAG                 VM SIZE                DATE       VM CLOCK
>> --        0                      741M 2018-07-31 13:39:56   00:41:25.313
>>
>> A snapshot with name "0" is created. ID is hidden from the user, but the
>> ID is a non-zero integer that starts at "1". Thus, this snapshot has
>> id_str=1, TAG="0". Creating a second snapshot with arg = 1, the first one
>> is deleted:
>>
>> (qemu) savevm 1
>> (qemu) info snapshots
>> List of snapshots present on all disks:
>> ID        TAG                 VM SIZE                DATE       VM CLOCK
>> --        1                      741M 2018-07-31 13:42:14   00:41:55.252
>>
>> What happened?
>>
>> - when creating the second snapshot, a verification is done inside
>> bdrv_all_delete_snapshot to delete any existing snapshots that matches an
>> string argument. Here, the code calls bdrv_all_delete_snapshot("1", ...);
>>
>> - bdrv_all_delete_snapshot calls bdrv_snapshot_find(..., "1") for each
>> BlockDriverState of the guest. And this is where things goes tilting:
>> bdrv_snapshot_find does a search by both id_str and name. It finds
>> out that there is a snapshot that has id_str = 1, stores a reference
>> to the snapshot in the sn_info pointer and then returns match found;
>>
>> - since a match was found, a call to bdrv_snapshot_delete_by_id_or_name() is
>> made. This function ignores the pointer written by bdrv_snapshot_find. Instead,
>> it deletes the snapshot using bdrv_snapshot_delete() calling it first with
>> id_str = 1. If it fails to delete, then it calls it again with name = 1.
>>
>> - after all that, QEMU creates the new snapshot, that has id_str = 1 and
>> name = 1. The user is left wondering that happened with the first snapshot
>> created. Similar bugs can be triggered when using loadvm and delvm.
>>
>> Before contemplating discarding the use of ID input in these operations,
>> I've searched the code of what would be the implications. My findings
>> are:
>>
>> - the RBD and Sheepdog drivers don't care. Both uses the 'name' field as
>> key in their logic, making id_str = name when appropriate.
>> replay-snapshot.c does not make any special use of id_str;
>>
>> - qcow2 uses id_str as an unique identifier but it is automatically
>> calculated, not being influenced by user input. Other than that, there are
>> no distinguish operations made only with id_str;
>>
>> - in blockdev.c, the delete operation uses a match of both id_str AND
>> name. Given that id_str is either a copy of 'name' or auto-generated,
>> we're fine here.
>>
>> This gives motivation to not consider ID as a valid user input in HMP
>> commands - sticking with 'name' input only is more consistent. To
>> accomplish that, the following changes were made in this patch:
>>
>> - bdrv_snapshot_find() does not match for id_str anymore, only 'name'. The
>> function is called in save_snapshot(), load_snapshot(), bdrv_all_delete_snapshot()
>> and bdrv_all_find_snapshot(). This change makes the search function more
>> predictable and does not change the behavior of any underlying code that uses
>> these affected functions, which are related to HMP (which is fine) and the
>> main loop inside vl.c (which doesn't care about it anyways);
>>
>> - bdrv_all_delete_snapshot() does not call bdrv_snapshot_delete_by_id_or_name
>> anymore. Instead, it uses the pointer returned by bdrv_snapshot_find to
>> erase the snapshot with the exact match of id_str an name. This function
>> is called in save_snapshot and hmp_delvm, thus this change  produces the
>> intended effect;
>>
>> - documentation changes to reflect the new behavior. I consider this to
>> be an API fix instead of an API change - the user was already creating
>> snapshots using 'name', but now he/she will also enjoy a consistent
>> behavior. Libvirt does not care about this change either, as far as
>> I've tested.
>>
>> Ideally we would get rid of the id_str field entirely, but this would have
>> repercussions on existing snapshots. Another day perhaps.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   block/snapshot.c |  5 +++--
>>   hmp-commands.hx  | 20 ++++++++++----------
>>   2 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index 3218a542df..e371d2243d 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -63,7 +63,7 @@ int bdrv_snapshot_find(BlockDriverState *bs, QEMUSnapshotInfo *sn_info,
>>       }
>>       for (i = 0; i < nb_sns; i++) {
>>           sn = &sn_tab[i];
>> -        if (!strcmp(sn->id_str, name) || !strcmp(sn->name, name)) {
>> +        if (!strcmp(sn->name, name)) {
>>               *sn_info = *sn;
>>               ret = 0;
>>               break;
>> @@ -448,7 +448,8 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
>>           aio_context_acquire(ctx);
>>           if (bdrv_can_snapshot(bs) &&
>>                   bdrv_snapshot_find(bs, snapshot, name) >= 0) {
>> -            ret = bdrv_snapshot_delete_by_id_or_name(bs, name, err);
>> +            ret = bdrv_snapshot_delete(bs, snapshot->id_str,
>> +                                       snapshot->name, err);
> I see there is another use of bdrv_snapshot_delete_by_id_or_name() in
> qemu-img.c.  Don't we want the same behavior there too?

Yeah, I've considered changing the behavior there as well. Need to
check in detail how qemu-img parses the command line arguments.


>
> If we remove these two uses, we can perhaps get rid of this function thoroughly.
>
>>           }
>>           aio_context_release(ctx);
>>           if (ret < 0) {
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index c1fc747403..e55b889868 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -350,17 +350,17 @@ ETEXI
>>       {
>>           .name       = "savevm",
>>           .args_type  = "name:s?",
>> -        .params     = "[tag|id]",
>> -        .help       = "save a VM snapshot. If no tag or id are provided, a new snapshot is created",
>> +        .params     = "tag",
>> +        .help       = "save a VM snapshot. If no tag is provided, a new snapshot is created",
>>           .cmd        = hmp_savevm,
>>       },
>>   
>>   STEXI
>> -@item savevm [@var{tag}|@var{id}]
>> +@item savevm @var{tag}
>>   @findex savevm
>>   Create a snapshot of the whole virtual machine. If @var{tag} is
>>   provided, it is used as human readable identifier. If there is already
>> -a snapshot with the same tag or ID, it is replaced. More info at
>> +a snapshot with the same tag, it is replaced. More info at
>>   @ref{vm_snapshots}.
>>   ETEXI
>>   
>> @@ -368,31 +368,31 @@ ETEXI
>>           .name       = "loadvm",
>>           .args_type  = "name:s",
>>           .params     = "tag|id",
>> -        .help       = "restore a VM snapshot from its tag or id",
>> +        .help       = "restore a VM snapshot from its tag",
>>           .cmd        = hmp_loadvm,
>>           .command_completion = loadvm_completion,
>>       },
>>   
>>   STEXI
>> -@item loadvm @var{tag}|@var{id}
>> +@item loadvm @var{tag}
>>   @findex loadvm
>>   Set the whole virtual machine to the snapshot identified by the tag
>> -@var{tag} or the unique snapshot ID @var{id}.
>> +@var{tag}.
>>   ETEXI
>>   
>>       {
>>           .name       = "delvm",
>>           .args_type  = "name:s",
>>           .params     = "tag|id",
>> -        .help       = "delete a VM snapshot from its tag or id",
>> +        .help       = "delete a VM snapshot from its tag",
>>           .cmd        = hmp_delvm,
>>           .command_completion = delvm_completion,
>>       },
>>   
>>   STEXI
>> -@item delvm @var{tag}|@var{id}
>> +@item delvm @var{tag}
>>   @findex delvm
>> -Delete the snapshot identified by @var{tag} or @var{id}.
>> +Delete the snapshot identified by @var{tag}.
>>   ETEXI
>>   
>>       {
>> -- 
>> 2.17.1
>>
>>
