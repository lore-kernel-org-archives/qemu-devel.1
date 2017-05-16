Received: from eggs.gnu.org ([2001:4830:134:3::10]:48757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAeu1-0000B3-Oz
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAety-0003LB-IS
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:00:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAety-0003KG-AI
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC5E57AE9E
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 16:00:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-3-quintela@redhat.com>
	<87shk4g9yb.fsf@dusky.pond.sub.org> <87o9usdg6e.fsf@secure.mitica>
Date: Tue, 16 May 2017 18:00:10 +0200
In-Reply-To: <87o9usdg6e.fsf@secure.mitica> (Juan Quintela's message of "Tue,
	16 May 2017 16:34:00 +0200")
Message-ID: <87h90kbxmd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Create one capability for block migration and one parameter for
>>> incremental block migration.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
>>>  
>>>      /* The last error that occurred */
>>>      Error *error;
>>> +    /* Do we have to clean up -b/-i from old migrate paramteres */
>>
>> parameters
>
> ok.
>
>
>>> +void migrate_set_block_enabled(bool value, Error **errp)
>>> +{
>>> +    MigrationCapabilityStatusList *cap;
>>> +
>>> +    cap = g_malloc0(sizeof(*cap));
>>> +    cap->value = g_malloc(sizeof(*cap->value));
>>
>> I prefer g_new() for extra type checking.  Your choice.
>
> ok.
>
>
>>> +    cap->value->capability = MIGRATION_CAPABILITY_BLOCK;
>>> +    cap->value->state = value;
>>> +    qmp_migrate_set_capabilities(cap, errp);
>>> +    qapi_free_MigrationCapabilityStatusList(cap);
>>> +}
>>
>> The objective is to set one bit.  The means is building a
>> MigrationCapabilityStatusList.  When you have to build an elaborate data
>> structure just so you can set one bit, your interfaces are likely
>> deficient.  Observation, not change request.
>
> This was Dave suggestion.  The reason for doing this is in the following
> patch when we enable compile disable of block migration to put the ifdef
> in a single place.  Otherwise, I have to put it in two places.
>
>>> +static void migrate_set_block_incremental(MigrationState *s, bool value)
>>> +{
>>> +    s->parameters.block_incremental = value;
>>> +}
>>
>> This is how setting one bit should look like.
>
> See previous comment.
>
>>
>>> +
>>> +static void block_cleanup_parameters(MigrationState *s)
>>> +{
>>> +    if (s->must_remove_block) {
>>> +        migrate_set_block_enabled(false, NULL);
>>
>> NULL ignores errors.  If an error happens, and we ignore it, we're
>> screwed, aren't we?  I suspect we want &error_abort here.
>
> setting to false can't never fail.  It is when we set it to true that it
> can fail because it is compiled out (that will be in next patch).

Sounds like a job for &error_abort to me.

>>> @@ -1229,6 +1267,38 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>>          return;
>>>      }
>>>  
>>> +    if (has_blk && blk) {
>>> +        if (migrate_use_block() || migrate_use_block_incremental()) {
>>> +            error_setg(errp, "You can't use block capability and -b/i");
>>
>> Error message assumes HMP.  In QMP, the thing is called 'blk', not -b.
>> Perhaps we can sidestep the issue like this: "Command options are
>> incompatible with current migration capabilities".
>
> ok.
>
>>
>>> +            return;
>>> +        }
>>> +        migrate_set_block_enabled(true, &local_err);
>>> +        if (local_err) {
>>> +            error_propagate(errp, local_err);
>>> +            return;
>>> +        }
>>> +        block_enabled = true;
>>> +        s->must_remove_block = true;
>>> +    }
>>> +
>>> +    if (has_inc && inc) {
>>> +        if ((migrate_use_block() && !block_enabled)
>>> +            || migrate_use_block_incremental()) {
>>> +            error_setg(errp, "You can't use block capability and -b/i");
>>
>> Likewise.
>>
>> The condition would be slightly simpler if you completed error checking
>> before changing global state.  Matter of taste.
>
> Being bug compatible has this drawbacks.  I also hate that -i implies -b.
>
>>> --- a/qapi-schema.json
>>> +++ b/qapi-schema.json
>>> @@ -894,11 +894,14 @@
>>>  # @release-ram: if enabled, qemu will free the migrated ram pages on the source
>>>  #        during postcopy-ram migration. (since 2.9)
>>>  #
>>> +# @block: enable block migration (Since 2.10)
>>> +#
>>
>> What's "block migration" and why should I care?
>
> "enable migration of block devices.  The granularity is all devices or
> no devices, nothing in the middle."
>
> I will be happy with suggestions.

# @block: If enabled, QEMU will also migrate the contents of all block
#          devices.  Default is disabled.  A possible alternative are
#          mirror jobs to a builtin NBD server on the destination, which
#          are more flexible.
#          (Since 2.10)

>>>  # Since: 1.2
>>>  ##
>>>  { 'enum': 'MigrationCapability',
>>>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
>>> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>>> +           'block' ] }
>>>  
>>>  ##
>>>  # @MigrationCapabilityStatus:
>>> @@ -1009,13 +1012,15 @@
>>>  # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
>>>  #          periodic mode. (Since 2.8)
>>>  #
>>> +# @block-incremental: enable block incremental migration (Since 2.10)
>>> +#
>>
>> What's "block incremental migration" and why should I care?
>
> This is good, I will try.
>
> "block incremental migration assumes that we have a base image in both
> sides, and then we continue writting in one of the sides.  This way we
> need to only migrate the changes since the previous state where it was
> the same in both sides".
>
> I am not sure what to put there, really.

Well, to suggest something, I'd first have to figure out WTF incremental
block migration does.  Your text helps me some, but not enough.  What
exactly is being migrated, and what exactly is assumed to be shared
between source and destination?

Block migration is scandalously underdocumented.

>>>  # Since: 2.4
>>>  ##
>>>  { 'enum': 'MigrationParameter',
>>>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
>>>             'cpu-throttle-initial', 'cpu-throttle-increment',
>>>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>>> -           'downtime-limit', 'x-checkpoint-delay' ] }
>>> +           'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
>>>  
>>>  ##
>>>  # @migrate-set-parameters:
>>> @@ -1082,6 +1087,8 @@
>>>  #
>>>  # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
>>>  #
>>> +# @block-incremental: enable block incremental migration (Since 2.10)
>>> +#
>>>  # Since: 2.4
>>>  ##
>>>  { 'struct': 'MigrationParameters',
>>> @@ -1094,7 +1101,8 @@
>>>              '*tls-hostname': 'str',
>>>              '*max-bandwidth': 'int',
>>>              '*downtime-limit': 'int',
>>> -            '*x-checkpoint-delay': 'int'} }
>>> +            '*x-checkpoint-delay': 'int',
>>> +            '*block-incremental': 'bool' } }
>>>  
>>>  ##
>>>  # @query-migrate-parameters:
>>
>> Can't say I like the split between MigrationCapability and
>> MigrationParameters, but we got to work with what we have.
>
> :-(
>
> And it is still not good enough.  There are parameters that make sense
> to change in middle migration (max-bandwidth for example) and others
> that you shouldn't, like tls-hostname or compression-threads.
>
> Go figure.

Grown, not designed.  It happens.
