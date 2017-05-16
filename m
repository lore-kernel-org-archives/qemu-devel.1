Received: from eggs.gnu.org ([2001:4830:134:3::10]:38358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAWIr-0004RQ-4H
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAWIo-0007pd-3o
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAWIn-0007my-QS
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E35EF7AE98
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 06:49:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-2-quintela@redhat.com>
	<0bbb5f93-83bb-47b9-e7dd-d0824f3d8b61@redhat.com>
	<87pofafoek.fsf@secure.mitica> <20170515094655.GC2089@work-vm>
	<6ad3d1a1-ae63-b01d-b6a0-72a017b343aa@redhat.com>
	<87r2zqqged.fsf@dusky.pond.sub.org> <87inl2drzj.fsf@secure.mitica>
Date: Tue, 16 May 2017 08:49:37 +0200
In-Reply-To: <87inl2drzj.fsf@secure.mitica> (Juan Quintela's message of "Mon,
	15 May 2017 18:06:40 +0200")
Message-ID: <87bmqtjny6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Create block capabilities
 for shared and enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com, qemu-devel@nongnu.org

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 05/15/2017 04:46 AM, Dr. David Alan Gilbert wrote:
>>>> * Juan Quintela (quintela@redhat.com) wrote:
>>>>> Eric Blake <eblake@redhat.com> wrote:
>>>>>> On 05/11/2017 11:32 AM, Juan Quintela wrote:
>>>>>>> Those two capabilities were added through the command line.  Notice that
>>>>>>> we just created them.  This is just the boilerplate.
>>>>>>>
>>>>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>>>>
>>>>>>> --
>>>>>>>
>>>>>>> Make migrate_set_block_* take a boolean argument.
>>>>>>
>>>>>> Question - do we support the orthogonal selection of all 4 combinations
>>>>>> under HMP 'migrate' (no argument, -b alone, -i alone, -b and -i
>>>>>> together), or are there only 3 actual states? If the latter, should we
>>>>>> represent this as a single enum-valued property, rather than as two
>>>>>> independent boolean properties?
>>>>>
>>>>> { 'enum': 'MigrationCapability',
>>>>>   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>>>>            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
>>>>>
>>>>>
>>>>> My understanding is that we can only have boolean capabilities here.
>>>>> Or, how could we put a non-boolean capability?
>>>
>>> If we want a non-boolean, then we make it a migration parameter rather
>>> than a migration capability.  There may be other advantages to using
>>> MigrationParameter instead of MigrationCapability (such as making it
>>> easier to figure out whether the parameter settings are persistent or
>>> apply per-migration).
>>
>> What makes a migration knob a MigrationCapability rather than a
>> MigrationParameter?  Type bool, or is there more to it?
>
> I didn't started this, but *my* undersanding:
>
> Migration capability: we have to set this up before migration starts.
> It is like a property that we can't change later.  We can't add a
> compression thread in the middle of migration (notice that we "could"
> but current code can't).
>
> So, block enabled migration is a capability.
>
> Block shared on the other hand is weird.  *My* understading of the code
> is that we have a qcow2 overlay on top of the base image, and:
>
> - without shared: we migrate all the block device
> - with shared: we migrate only the top overlay

Plausible.  The thing that's "shared" is the backing file, between
migration source and destination.

However, we can't change "shared" in the middle of migration, either.

> So, thisk could be a parameter of block migration.  If anyone understand
> better than me, please stand up.
>
>>>> Lets keep this simple and stick with the booleans.
>>>> 
>>>> Dave
>>>> 
>>>>> There are three states as far as I can see.
>>
>> Begs the question how the fourth state behaves.  Documentation is of no
>> help:
>>
>>     diff --git a/qapi-schema.json b/qapi-schema.json
>>     index 5728b7f..109852e 100644
>>     --- a/qapi-schema.json
>>     +++ b/qapi-schema.json
>>     @@ -894,11 +894,16 @@
>>      # @release-ram: if enabled, qemu will free the migrated ram pages on the source
>>      #        during postcopy-ram migration. (since 2.9)
>>      #
>>     +# @block-enabled: enable block migration (Since 2.10)
>>     +#
>>     +# @block-shared: enable block shared migration (Since 2.10)
>>     +#
>>      # Since: 1.2
>>      ##
>>
>> Please explain all four states clearly there.
>
> Is the previous explanation enough?

The new comments can serve as reminders for readers who already know
what "block migration" and "block shared migration" is.  Surely we can
do better for readers who don't, and I'd like you to try.

Note that the comments aren't just for QAPI schema readers, but also for
QMP documentation readers (generated docs/qemu-qmp-ref.*).

>>> I'll leave it up to you as maintainers which way you prefer, I'm just
>>> offering the potential design tradeoffs for simplicity of booleans (but
>>> complexity in an unused state) vs. simplicity of design (but complexity
>>> in code).
>>
>> For what it's worth, I dislike entangled booleans.
>
> Some here, but except if we put shared as a migration parameter, I don't
> know what to do here.
>
> { 'enum': 'MigrationParameter',
>   'data': ['compress-level', 'compress-threads', 'decompress-threads',
>            'cpu-throttle-initial', 'cpu-throttle-increment',
>            'tls-creds', 'tls-hostname', 'max-bandwidth',
>            'downtime-limit', 'x-checkpoint-delay' ] }
>
>
> I don't see either how to define that block_shared will be a boolean parameter.

Here:

  { 'struct': 'MigrationParameters',
    'data': { '*compress-level': 'int',
              '*compress-threads': 'int',
              '*decompress-threads': 'int',
              '*cpu-throttle-initial': 'int',
              '*cpu-throttle-increment': 'int',
              '*tls-creds': 'str',
              '*tls-hostname': 'str',
              '*max-bandwidth': 'int',
              '*downtime-limit': 'int',
              '*x-checkpoint-delay': 'int'} }

How enum MigrationParameter shadows the member names of
MigrationParameters is weird.  Wouldn't be necessary if QAPI provided
object type introspection to C (it provides it to QMP).

MigrationParameter is used only for HMP commands "migrate_set_parameter"
and "info migrate_parameters".  The way they're coded doesn't really
profit from QAPI; string literals would be simpler.  Yes, they'd have to
shadow MigrationParameters, but since they'd replace MigrationParameter,
we'd be roughly even.
