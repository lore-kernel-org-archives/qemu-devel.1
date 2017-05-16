Received: from eggs.gnu.org ([2001:4830:134:3::10]:48654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAdYL-0006YK-79
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAdYH-0004JH-7U
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAdYG-0004IX-V8
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:34:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3BA9BAEC6
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 14:34:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <87shk4g9yb.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 16 May 2017 16:20:12 +0200")
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-3-quintela@redhat.com>
	<87shk4g9yb.fsf@dusky.pond.sub.org>
Reply-To: quintela@redhat.com
Date: Tue, 16 May 2017 16:34:00 +0200
Message-ID: <87o9usdg6e.fsf@secure.mitica>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Create one capability for block migration and one parameter for
>> incremental block migration.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>>  
>>      /* The last error that occurred */
>>      Error *error;
>> +    /* Do we have to clean up -b/-i from old migrate paramteres */
>
> parameters

ok.


>> +void migrate_set_block_enabled(bool value, Error **errp)
>> +{
>> +    MigrationCapabilityStatusList *cap;
>> +
>> +    cap = g_malloc0(sizeof(*cap));
>> +    cap->value = g_malloc(sizeof(*cap->value));
>
> I prefer g_new() for extra type checking.  Your choice.

ok.


>> +    cap->value->capability = MIGRATION_CAPABILITY_BLOCK;
>> +    cap->value->state = value;
>> +    qmp_migrate_set_capabilities(cap, errp);
>> +    qapi_free_MigrationCapabilityStatusList(cap);
>> +}
>
> The objective is to set one bit.  The means is building a
> MigrationCapabilityStatusList.  When you have to build an elaborate data
> structure just so you can set one bit, your interfaces are likely
> deficient.  Observation, not change request.

This was Dave suggestion.  The reason for doing this is in the following
patch when we enable compile disable of block migration to put the ifdef
in a single place.  Otherwise, I have to put it in two places.

>> +static void migrate_set_block_incremental(MigrationState *s, bool value)
>> +{
>> +    s->parameters.block_incremental = value;
>> +}
>
> This is how setting one bit should look like.

See previous comment.

>
>> +
>> +static void block_cleanup_parameters(MigrationState *s)
>> +{
>> +    if (s->must_remove_block) {
>> +        migrate_set_block_enabled(false, NULL);
>
> NULL ignores errors.  If an error happens, and we ignore it, we're
> screwed, aren't we?  I suspect we want &error_abort here.

setting to false can't never fail.  It is when we set it to true that it
can fail because it is compiled out (that will be in next patch).


>> @@ -1229,6 +1267,38 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>          return;
>>      }
>>  
>> +    if (has_blk && blk) {
>> +        if (migrate_use_block() || migrate_use_block_incremental()) {
>> +            error_setg(errp, "You can't use block capability and -b/i");
>
> Error message assumes HMP.  In QMP, the thing is called 'blk', not -b.
> Perhaps we can sidestep the issue like this: "Command options are
> incompatible with current migration capabilities".

ok.

>
>> +            return;
>> +        }
>> +        migrate_set_block_enabled(true, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +        block_enabled = true;
>> +        s->must_remove_block = true;
>> +    }
>> +
>> +    if (has_inc && inc) {
>> +        if ((migrate_use_block() && !block_enabled)
>> +            || migrate_use_block_incremental()) {
>> +            error_setg(errp, "You can't use block capability and -b/i");
>
> Likewise.
>
> The condition would be slightly simpler if you completed error checking
> before changing global state.  Matter of taste.

Being bug compatible has this drawbacks.  I also hate that -i implies -b.

>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -894,11 +894,14 @@
>>  # @release-ram: if enabled, qemu will free the migrated ram pages on the source
>>  #        during postcopy-ram migration. (since 2.9)
>>  #
>> +# @block: enable block migration (Since 2.10)
>> +#
>
> What's "block migration" and why should I care?

"enable migration of block devices.  The granularity is all devices or
no devices, nothing in the middle."

I will be happy with suggestions.

>
>>  # Since: 1.2
>>  ##
>>  { 'enum': 'MigrationCapability',
>>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
>> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>> +           'block' ] }
>>  
>>  ##
>>  # @MigrationCapabilityStatus:
>> @@ -1009,13 +1012,15 @@
>>  # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
>>  #          periodic mode. (Since 2.8)
>>  #
>> +# @block-incremental: enable block incremental migration (Since 2.10)
>> +#
>
> What's "block incremental migration" and why should I care?

This is good, I will try.

"block incremental migration assumes that we have a base image in both
sides, and then we continue writting in one of the sides.  This way we
need to only migrate the changes since the previous state where it was
the same in both sides".

I am not sure what to put there, really.


>
>>  # Since: 2.4
>>  ##
>>  { 'enum': 'MigrationParameter',
>>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
>>             'cpu-throttle-initial', 'cpu-throttle-increment',
>>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>> -           'downtime-limit', 'x-checkpoint-delay' ] }
>> +           'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
>>  
>>  ##
>>  # @migrate-set-parameters:
>> @@ -1082,6 +1087,8 @@
>>  #
>>  # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
>>  #
>> +# @block-incremental: enable block incremental migration (Since 2.10)
>> +#
>>  # Since: 2.4
>>  ##
>>  { 'struct': 'MigrationParameters',
>> @@ -1094,7 +1101,8 @@
>>              '*tls-hostname': 'str',
>>              '*max-bandwidth': 'int',
>>              '*downtime-limit': 'int',
>> -            '*x-checkpoint-delay': 'int'} }
>> +            '*x-checkpoint-delay': 'int',
>> +            '*block-incremental': 'bool' } }
>>  
>>  ##
>>  # @query-migrate-parameters:
>
> Can't say I like the split between MigrationCapability and
> MigrationParameters, but we got to work with what we have.

:-(

And it is still not good enough.  There are parameters that make sense
to change in middle migration (max-bandwidth for example) and others
that you shouldn't, like tls-hostname or compression-threads.

Go figure.

Thanks, Juan.
