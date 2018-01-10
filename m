Received: from eggs.gnu.org ([2001:4830:134:3::10]:50095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rpalethorpe@suse.de>) id 1eZJ6g-0000v1-E5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rpalethorpe@suse.de>) id 1eZJ6d-0008OH-7I
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:20:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:33615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rpalethorpe@suse.de>) id 1eZJ6c-0008LV-To
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:19:59 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
From: Richard Palethorpe <rpalethorpe@suse.de>
Reply-To: rpalethorpe@suse.de
In-reply-to: <fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
Date: Wed, 10 Jan 2018 17:19:53 +0100
Message-ID: <87r2qxk7o6.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, quintela@redhat.com, rpalethorpe@suse.de

Hello Eric & Peter,

Eric Blake writes:

> On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
>> Add QAPI wrapper functions for the existing snapshot functionality. These
>> functions behave the same way as the HMP savevm, loadvm and delvm
>> commands. This will allow applications, such as OpenQA, to programmatically
>> revert the VM to a previous state with no dependence on HMP or qemu-img.
>
> That's already possible; libvirt uses QMP's human-monitor-command to
> access these HMP commands programmatically.

That is what we are currently doing and is an improvement over
programatically using HMP, but I wanted to improve upon
that. Occasionally saving or loading snapshots fails and it is not clear
why.

>
> We've had discussions in the past about what it would take to have
> specific QMP commands for these operations; the biggest problem is that
> these commands promote the use of internal snapshots, and there are
> enough performance and other issues with internal snapshots that we are
> not yet ready to commit to a long-term interface for making their use
> easier.  At this point, our recommendation is to prefer external
> snapshots.

I don't think there are any issues with using external snapshots for the
use case I have in mind, so long as they can contain the CPU & RAM
state. All that is really required is a good clean way of reverting to a
previous state (where the VM is running). I don't see in the
documentation or code that blockdev-snapshot-* or any other command can
save the CPU & RAM state to a file then load it along with a storage
snapshot?

Perhaps instead we could use migrate with exec or fd URIs as Peter
suggests. So we could do a differential migration to a file, then
continue until the guest enters a bad state, then do an incoming
migration to go back to the file.

I don't think that is ideal however, especially from a useability point
of view. Probably many users approaching the problem will just choose to
use loadvm/savevm.

>
> https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg02427.html is
> an example thread that has tried to tackle the QMP-ification of these
> HMP commands in the past; here we are two years later, and I'm still not
> sure we are ready.

Sorry I didn't see that.

>
> I'm worried that taking this commands as-is will bake in an interface
> that we don't want to support in the long term.  In particular, the
> qemu-img counterpart of taking an internal snapshot of an offline guest
> is different from QMP context where the guest is running and would
> always include a snapshot of CPU state in addition to disk state; I'm
> also worried that the command is too broad, compared to doing a
> transaction built on lower-level building blocks (take an internal
> snapshot of disk storage, coupled with take an internal snapshot of cpu
> state to be placed into a particular BDS); the HMP command is a bit hard
> to use because the internal snapshot of CPU state has no user control
> over which BDS will actually hold the state (other than which disk was
> installed/hot-plugged first), whereas at the lower level, we probably do
> want to allow management more fine-grained control over where the
> internal snapshot lands.

Savevm and loadvm are actually very easy to use in our particular use
case. However using a transaction comprised of lower-level commands
should not be too difficult either. Although for the common case it
might be a good idea to have a simpler command which wraps the
transaction. Whether it defaults to an internal location or requires an
external file path is not a problem for me at least. The issue seems to
be just adding a QMP command to take a snapshot of the CPU state,
similar to the blockdev-snapshot commands, and allowing it to be part of
a transaction.

>
> Also, when sending a two-patch series, be sure to include a 0/2 cover
> letter.  More patch submission hints at
> https://wiki.qemu.org/Contribute/SubmitAPatch
>
>>
>> I used the term snapshot instead of VM because I think it is less ambiguous
>> and matches the internal function names.
>>
>> Signed-off-by: Richard Palethorpe <richiejp@f-m.fm>
>> ---
>>  migration/savevm.c | 27 ++++++++++++++++++++++
>>  qapi-schema.json   | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 93 insertions(+)
>>
>
>> +++ b/qapi-schema.json
>> @@ -1125,6 +1125,72 @@
>>  { 'command': 'pmemsave',
>>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>>
>> +##
>> +# @save-snapshot:
>> +#
>> +# Save a snapshot of the entire Virtual Machine
>> +#
>> +# @name: A string identifying the snapshot. This can later be used with
>> +#        @load-snapshot or @delete-snapshot
>> +#
>> +# Since: 2.12.0
>> +#
>> +# Returns: If successful, nothing
>> +#
>> +# Notes: The equivalent HMP command is savevm. This stores all of the virtual
>
> I don't see why we have to document HMP commands in the QMP document.
>
>> +#        machine's current state within the virtual machine's
>> +#        image(s)/storage. If the VM is currently running, this includes the
>> +#        state of the CPU and RAM. Later the VM can be reverted to this state.
>
> How would the VM _not_ be currently running at the point where QMP can
> be executed?
>
>> +#
>> +#        qemu-img can also be used to manipulate snapshots.
>> +#
>> +# Examples:
>> +#
>> +# -> { "execute": "save-snapshot", "arguments": { "name": "lastgood" } }
>> +# <- { "return": {} }
>> +##
>> +{ 'command': 'save-snapshot',
>> +  'data': {'name': 'str'} }
>> +
>> +##
>> +# @load-snapshot:
>> +#
>> +# Load a snapshot of the entire Virtual Machine, completely reverting it to
>> +# that state
>> +#
>> +# Since: 2.12.0
>> +#
>> +# Returns: If successful, nothing
>> +#
>> +# Notes: The equivalent HMP command is loadvm. See the @save-snapshot notes.
>> +#
>> +# Examples:
>> +#
>> +# -> { "execute": "load-snapshot", "arguments": { "name": "lastgood" } }
>> +# <- { "return": {} }
>> +##
>> +{ 'command': 'load-snapshot',
>> +  'data': {'name': 'str'} }
>> +
>> +##
>> +# @delete-snapshot:
>> +#
>> +# Delete a VM snapshot
>> +#
>> +# Since: 2.12.0
>> +#
>> +# Returns: If successful, nothing
>> +#
>> +# Notes: The equivalent HMP command is delvm. See the @save-snapshot notes.
>> +#
>> +# Examples:
>> +#
>> +# -> { "execute": "delete-snapshot", "arguments": { "name": "lastgood" } }
>> +# <- { "return": {} }
>> +##
>> +{ 'command': 'delete-snapshot',
>> +  'data': {'name': 'str'} }
>> +
>>  ##
>>  # @cont:
>>  #
>>


--
Thank you,
Richard.
