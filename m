Received: from eggs.gnu.org ([2001:4830:134:3::10]:34558)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cguMu-0003C5-7z
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cguMq-0006tK-9v
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:27:40 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:57936 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cguMq-0006t8-0X
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:27:36 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
	<9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
	<f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
	<c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <2b0840d7-7540-d732-36ac-af7a512d2c8f@kamp.de>
Date: Thu, 23 Feb 2017 15:27:32 +0100
MIME-Version: 1.0
In-Reply-To: <c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Christian Theune <ct@flyingcircus.io>

Am 22.02.2017 um 13:32 schrieb Eric Blake:
> On 02/22/2017 02:45 AM, Peter Lieven wrote:
>>> A bit outdated now, but:
>>> http://wiki.qemu-project.org/Features/IncrementalBackup
>>>
>>> and also a summary I wrote not too far back (PDF):
>>> https://drive.google.com/file/d/0B3CFr1TuHydWalVJaEdPaE5PbFE
>>>
>>> and I'm sure the Virtuozzo developers could chime in on this subject,
>>> but basically we do have something similar in the works, as eblake says.
>> Hi John, Hi Erik,
> It's Eric, but you're not the first to make that typo :)
>
>> thanks for your feedback. Are you both the ones working primary on this topic?
>> If there is anything to review or help needed, please let me know.
>>
>> My 2 cents:
>> I thing I had in mind if there is no image fleecing available, but fetching the dirty bitmap
>> from external would be a feauture to put a write lock on a block device.
> The whole idea is to use a dirty bitmap coupled with image fleecing,
> where the point-in-time of the image fleecing is done at a window where
> the guest I/O is quiescent in order to get a stable fleecing point.  We
> already support write locks (guest quiesence) using qga to do fsfreeze.
> You want the time that guest I/O is frozen to be as small as possible
> (in particular, the Windows implementation of quiescence will fail if
> you hold things frozen for more than a couple of seconds).
>
> Right now, the qcow2 image format does not track write generations, and
> I don't think we plan on adding that directly into qcow2.  However, you
> can externally simulate write generations by keeping track of how many
> image fleecing points you have created (each fleecing point is another
> write generation).
>
>
>> In this case something like this via QMP (and external software) should work:
>> ---8<---
>>   gen =  write generation of last backup (or 0 for full backup)
>>   do {
>>       nextgen = fetch current write generation (via QMP)
>>       dirtymap = send all block whose write generation is greater than 'gen' (via QMP)
> No, we are NOT going to send dirty information via QMP.  Rather, we are
> going to send it via NBD's extension NBD_CMD_BLOCK_STATUS.  The idea is
> that a client connects and asks which qemu blocks are dirty, then uses
> that information to read only the dirty blocks.

I understand, that for the case of local storage connecting via NBD to Qemu to grep a snapshot
might be a good idea, but consider that you have a NAS for your vServer images. May it be NFS,
iSCSI, CEPH or whatever. In an enterprise scenario I would generally except to have a NAS rather
than local storage.

When you are going to backup your vServer (full or incremental) you shuffle all the traffic through
Qemu and your Node running the vServer. In this case you run all the traffic over the wire twice.

NAS -> Node -> Qemu - > Backup Server

But the Backup Server could instead connect to the NAS directly avoiding load on the frontent LAN
and the Qemu Node.

I would like to find a nice solution for this scenario. If not in the first step it would maybe be good to
have this in mind when implementing a dirty block tracking.

Peter
