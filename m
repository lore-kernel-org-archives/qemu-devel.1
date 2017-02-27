Received: from eggs.gnu.org ([2001:4830:134:3::10]:35985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciS5L-0000SL-8K
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciS5H-00037b-Ac
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:39:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ciS5H-00037X-1t
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:39:51 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
	<9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
	<f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
	<c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
	<2b0840d7-7540-d732-36ac-af7a512d2c8f@kamp.de>
	<b59eb68b-5dac-b18b-c2f7-1ea820f4d747@redhat.com>
	<589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e3e6c37b-26b9-e02f-fd67-9fe5cf1b1d6c@redhat.com>
Date: Mon, 27 Feb 2017 15:39:50 -0500
MIME-Version: 1.0
In-Reply-To: <589533ff-2e7d-0ffb-e0b9-5b2e055813b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Christian Theune <ct@flyingcircus.io>



On 02/24/2017 04:44 PM, Eric Blake wrote:
> On 02/24/2017 03:31 PM, John Snow wrote:
>>>
>>> But the Backup Server could instead connect to the NAS directly avoiding
>>> load on the frontent LAN
>>> and the Qemu Node.
>>>
>>
>> In a live backup I don't see how you will be removing QEMU from the data
>> transfer loop. QEMU is the only process that knows what the correct view
>> of the image is, and needs to facilitate.
>>
>> It's not safe to copy the blocks directly without QEMU's mediation.
> 
> Although we may already have enough tools in place to help achieve that:
> create a temporary qcow2 wrapper around the primary image via external
> snapshot, so that the primary image is now read-only in qemu; then use
> whatever block-status mechanism (whether the NBD block status extension,
> or directly reading from a persistent bitmap) to facilitate whatever
> more efficient offline transfer of just the relevant portions of that
> main file, then live block-commit to get qemu to start writing to the
> file again.
> 

Right, really good point. We can just turn the "live" backup into a
not-live one (kind of!) to work around the constraint.

In this case, creating the external snapshot should probably create a
"new" bitmap on the root, leaving the old one behind on the backing
file. This avoids spurious copies of data that hasn't changed in the
backing file, and makes clearing the bitmap on success easier for us.
Once the snapshots are re-merged, we can merge their respective bitmaps
again.

This can work in some scenarios, sure! We may have to be careful about
how exactly bitmaps fork when you create new external snapshots, but
that does seem workable and (possibly) the most performant, if that's a
concern.

--js

> In other words, any time your algorithm wants to cause an I/O freeze to
> a particular file, the solution is to add a qcow2 external snapshot
> followed by a live commit.
> 
> So tweaking the proposal a few mails ago:
> 
> fsfreeze (optional)
> create qcow2 snapshot wrapper as a write lock (via QMP)
> fsthaw - now with no risk of violating guest timing constraints
> dirtymap = find all blocks that are dirty since last backup (via named
> bitmap/NBD block status)
> foreach block in dirtymap {
>                copy to backup via external software
> }
> live commit image (via QMP)
> 
> The window where guest I/O is frozen is small (the freeze/snapshot
> create/thaw steps can be done in less than a second), while the window
> where you are extracting incremental backup data is longer (during that
> time, guest I/O is happening into a wrapper qcow2 file).
> 
