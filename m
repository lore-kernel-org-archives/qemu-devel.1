Received: from eggs.gnu.org ([2001:4830:134:3::10]:37107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZg8y-0005bW-Mh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZg8x-0007mQ-Ms
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:55:56 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180111133635.GH8326@redhat.com> (Daniel P. Berrange's message
	of "Thu, 11 Jan 2018 13:36:35 +0000")
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com> <20180111132304.GD2669@work-vm>
	<20180111133635.GH8326@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 11 Jan 2018 17:55:44 +0100
Message-ID: <87efmw9vxr.fsf@secure.laptop>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, armbru@redhat.com, rpalethorpe@suse.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Thu, Jan 11, 2018 at 01:23:05PM +0000, Dr. David Alan Gilbert wrote:
>> * Daniel P. Berrange (berrange@redhat.com) wrote:
>> > On Thu, Jan 11, 2018 at 01:46:38PM +0100, Max Reitz wrote:
>> > > On 2018-01-08 14:52, Eric Blake wrote:
>> > > > On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
>> > > >> Add QAPI wrapper functions for the existing snapshot functionality. These
>> > > >> functions behave the same way as the HMP savevm, loadvm and delvm
>> > > >> commands. This will allow applications, such as OpenQA, to
>> > > >> programmatically
>> > > >> revert the VM to a previous state with no dependence on HMP or qemu-img.
>> > > > 
>> > > > That's already possible; libvirt uses QMP's human-monitor-command to
>> > > > access these HMP commands programmatically.
>> > > > 
>> > > > We've had discussions in the past about what it would take to have
>> > > > specific QMP commands for these operations; the biggest problem is that
>> > > > these commands promote the use of internal snapshots, and there are
>> > > > enough performance and other issues with internal snapshots that we are
>> > > > not yet ready to commit to a long-term interface for making their use
>> > > > easier.  At this point, our recommendation is to prefer external snapshots.
>> > > 
>> > > We already have QMP commands for internal snapshots, though.  Isn't the
>> > > biggest issue that savevm takes too much time to be a synchronous QMP
>> > > command?
>> > 
>> > Ultimately savevm/loadvm are using much of the migration code internally,
>> > but are not exposed as URI schemes. Could we perhaps take advantage of
>> > the internal common layer and define a migration URI scheme
>> > 
>> >    snapshot:<name>
>> > 
>> > where '<name>' is the name of the internal snapshot in the qcow2 file.
>> 
>> I had wondered about that; I'd just thought of doing the migration
>> saving to a block device rather than the rest of the snapshot
>> activity around it;
>> but I guess that's possible.
>
> One possible gotcha is whether the current savevm/loadvm QEMUFile impl
> actually does non-blocking I/O properly. eg same reason why we don't
> support a plain  file:<path> protocol - POSIX I/O on plain files doesn't
> honour O_NONBLOCK.  The block layer does AIO though, so we might be OK,
> depending on which block layer APIs the QEMUFile impl uses. I've not
> looked at the code recently though.

The blocking part is less important (for the write side), because we
have a thread there.  For loading .... it would be great to get one
migration thread also.

>> > Then you could just use the regular migrate QMP commands for loading
>> > and saving snapshots.  Might need a little extra work on the incoming
>> > side, since we need to be able to load snapshots, despite QEMU not
>> > being started with '-incoming defer', but might still be doable ?
>> > This would theoretically give us progress monitoring, cancellation,
>> > etc for free.
>> 
>> What actually stops this working other than the sanity check in
>> migrate_incoming ?
>
> No idea really - not looked closely at the code implications.

It would be a plus for migration code, right now there are _two_
implementations, and savevm/loadvm one gets less love.

And we will check "much more" the way to load migration in a
non-pristine qemu, so ....

Later, Juan.
