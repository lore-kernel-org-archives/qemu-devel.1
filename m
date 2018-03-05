Received: from eggs.gnu.org ([2001:4830:134:3::10]:42355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rpalethorpe@suse.de>) id 1ess7c-0004zM-B5
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rpalethorpe@suse.de>) id 1ess7Z-0002kt-JX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:33:52 -0500
References: <20180227115651.30762-1-rpalethorpe@suse.com>
	<20180227115651.30762-2-rpalethorpe@suse.com>
	<20180301165859.GJ2994@work-vm>
From: Richard Palethorpe <rpalethorpe@suse.de>
Reply-To: rpalethorpe@suse.de
In-reply-to: <20180301165859.GJ2994@work-vm>
Date: Mon, 05 Mar 2018 16:33:37 +0100
Message-ID: <87efkywn8u.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] migrate: Allow incoming migration
 without defer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: " Dr. David Alan Gilbert " <dgilbert@redhat.com>
Cc: rpalethorpe@suse.de, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com, mreitz@redhat.com, quintela@redhat.com

hello David,

Dr. David Alan Gilbert writes:

> * Richard Palethorpe (rpalethorpe@suse.com) wrote:
>> Allow a QEMU instance which has been started and used without the "-incoming"
>> flag to accept an incoming migration with the "migrate-incoming" QMP
>> command. This allows the user to dump the VM state to an external file then
>> revert to that state at a later time without restarting QEMU.
>> ---
>>  migration/migration.c | 12 +++++-------
>>  vl.c                  |  2 ++
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 0aa596f867..05595a4cec 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1321,14 +1321,14 @@ void migrate_del_blocker(Error *reason)
>>  void qmp_migrate_incoming(const char *uri, Error **errp)
>>  {
>>      Error *local_err = NULL;
>> -    static bool once = true;
>>
>> -    if (!deferred_incoming) {
>> -        error_setg(errp, "For use with '-incoming defer'");
>> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
>> +        error_setg(errp, "The incoming migration has already been started");
>>          return;
>>      }
>> -    if (!once) {
>> -        error_setg(errp, "The incoming migration has already been started");
>> +
>> +    if (!deferred_incoming) {
>> +        vm_stop(RUN_STATE_INMIGRATE);
>>      }
>>
>>      qemu_start_incoming_migration(uri, &local_err);
>> @@ -1337,8 +1337,6 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
>>          error_propagate(errp, local_err);
>>          return;
>>      }
>> -
>> -    once = false;
>>  }
>
> That's...interesting.  I think it will work, but I bet there's a whole
> bunch of corner cases [many of which loadvm will hit as well!].

It wouldn't surprise me if we have hit some of those corner cases with
our extensive use of loadvm :-) Unfortunately I don't have much data to
show what went wrong though.

> For starters there's probably devices that are active and still looking
> at RAM, even though vm_stop is in place (hopefully none of them are
> writing to it, but I wouldn't actually trust them).

I suppose that might be a showstopper.

> Also, you probably
> need to inactivate the block devices?

They are at least flushed by vm_stop. I would expect the user to
recreate them, or at least recreate the active layer before starting the
migration.

>
> Also, I think this means there's no protection against this happening
> during an outgoing migration (which has an existing check to make sure
> you can't start an outgoing migration while an incoming one is waiting).
>
>>  bool migration_is_blocked(Error **errp)
>> diff --git a/vl.c b/vl.c
>> index 9e7235df6d..a91eda039e 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -634,6 +634,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
>> +    { RUN_STATE_PAUSED, RUN_STATE_INMIGRATE },
>>
>>      { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
>>      { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
>> @@ -665,6 +666,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_RUNNING, RUN_STATE_WATCHDOG },
>>      { RUN_STATE_RUNNING, RUN_STATE_GUEST_PANICKED },
>>      { RUN_STATE_RUNNING, RUN_STATE_COLO},
>> +    { RUN_STATE_RUNNING, RUN_STATE_INMIGRATE },
>
> Experience suggests that you'll find out the hard way that there's other
> states you'll need to allow or check for.
> For example, do you want to be able to loadvm from a GUEST_PANICKED or
> PRELAUNCH state?

Yes, I would add GUEST_PANICKED at least.

>
> Dave
>
>>      { RUN_STATE_SAVE_VM, RUN_STATE_RUNNING },
>>
>> --
>> 2.16.2
>>


--
Thank you,
Richard.
