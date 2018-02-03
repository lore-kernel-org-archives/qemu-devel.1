Received: from eggs.gnu.org ([2001:4830:134:3::10]:52669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehxsH-00047D-Ox
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehxsE-0006y1-Kp
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:28:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehxsE-0006xr-Ef
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 08:28:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<87r2qxk7o6.fsf@rpws.prws.suse.cz>
	<cb7ae03d-1249-e772-e7e9-99b777054bb3@redhat.com>
Date: Sat, 03 Feb 2018 14:28:51 +0100
In-Reply-To: <cb7ae03d-1249-e772-e7e9-99b777054bb3@redhat.com> (Eric Blake's
	message of "Wed, 10 Jan 2018 10:48:08 -0600")
Message-ID: <87po5m2odo.fsf@dusky.pond.sub.org>
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
Cc: rpalethorpe@suse.de, Richard Palethorpe <richiejp@f-m.fm>, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

Coming to this thread rather late, sorry.

Eric Blake <eblake@redhat.com> writes:

> On 01/10/2018 10:19 AM, Richard Palethorpe wrote:
>> Hello Eric & Peter,
>> 
>> Eric Blake writes:
>> 
>>> On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
>>>> Add QAPI wrapper functions for the existing snapshot functionality. These
>>>> functions behave the same way as the HMP savevm, loadvm and delvm
>>>> commands. This will allow applications, such as OpenQA, to programmatically
>>>> revert the VM to a previous state with no dependence on HMP or qemu-img.
>>>
>>> That's already possible; libvirt uses QMP's human-monitor-command to
>>> access these HMP commands programmatically.
>> 
>> That is what we are currently doing and is an improvement over
>> programatically using HMP, but I wanted to improve upon
>> that. Occasionally saving or loading snapshots fails and it is not clear
>> why.
>
> Straightforward mapping of the existing HMP commands into QMP without
> any thought about the design won't make the errors any clearer. My
> argument is that any QMP design for managing internal snapshots must be
> well-designed, but that since we discourage internal snapshots, no one
> has been actively working on that design.

savevm and loadvm are HMP only precisely because an exact QMP equivalent
wouldn't be a sane interface, and designing a sane QMP interface would
be work.  Things that won't do for QMP include automatic selection of
the block device receiving the VM state, and synchronous operation.

Building blocks might be a better fit for QMP than a one-size-fits-all
savevm command.

Internal and external snapshots have different advantages.  Because
external snapshots are more flexible, they've received a lot more
attention[*] than internal ones.  I wouldn't let friends use internal
snapshots for production.

You're welcome to put in the work to push internal snapshots to parity
with external ones.  Do not underestimate how much work that's going to
be.  External snapshots' head start is years.

[...]



[*] "All the attention" would be a fair first order approximation, I
think.
