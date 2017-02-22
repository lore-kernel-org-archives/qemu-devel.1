Received: from eggs.gnu.org ([2001:4830:134:3::10]:40327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cgeI5-0007yf-DH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cgeI1-0006YI-EP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:17:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cgeI1-0006Y3-4t
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:17:33 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
	<9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
	<f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
From: John Snow <jsnow@redhat.com>
Message-ID: <61a4e9c2-9298-2d62-af90-8057a34b64d6@redhat.com>
Date: Wed, 22 Feb 2017 16:17:30 -0500
MIME-Version: 1.0
In-Reply-To: <f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
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
To: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Christian Theune <ct@flyingcircus.io>



On 02/22/2017 03:45 AM, Peter Lieven wrote:
> 
> Am 21.02.2017 um 22:13 schrieb John Snow:
>>
>> On 02/21/2017 07:43 AM, Peter Lieven wrote:
>>> Hi,
>>>
>>>
>>> is there anyone ever thought about implementing something like VMware
>>> CBT in Qemu?
>>>
>>>
>>> https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1020128
>>>
>>>
>>>
>>> Thanks,
>>> Peter
>>>
>>>
>> A bit outdated now, but:
>> http://wiki.qemu-project.org/Features/IncrementalBackup
>>
>> and also a summary I wrote not too far back (PDF):
>> https://drive.google.com/file/d/0B3CFr1TuHydWalVJaEdPaE5PbFE
>>
>> and I'm sure the Virtuozzo developers could chime in on this subject,
>> but basically we do have something similar in the works, as eblake says.
> 
> Hi John, Hi Erik,
> 
> thanks for your feedback. Are you both the ones working primary on this topic?
> If there is anything to review or help needed, please let me know.
> 

I've been working on incremental backups; Fam and I now co-maintain
block/dirty-bitmap.c.

Vladimir Sementsov-Ogievskiy has been working on bitmap persistence and
migration from Virtuozzo; as well as the NBD specification amendment to
allow us to fleece images with dirty bitmaps.

(Check the wiki and the whitepaper I linked!)

Eric has been guiding the review process for the NBD side of things.

> My 2 cents:
> I thing I had in mind if there is no image fleecing available, but fetching the dirty bitmap
> from external would be a feauture to put a write lock on a block device.
> Write lock means, drain all pending writes and queue all further writes until unlock (as if they
> were throttled to zero). This could help fetch consistent backups from storage device (thinking of iSCSI SAN) without
> the help of the hypervisor to actually transfer data (no load in the frontend network or the host). What would further
> be needed is a write generation for each block, not just only a dirty bitmap.
> 
> In this case something like this via QMP (and external software) should work:
> ---8<---
>  gen =  write generation of last backup (or 0 for full backup)
>  do {
>      nextgen = fetch current write generation (via QMP)

As Eric said, there's a lot of hostility to using QMP as a metadata
transmission protocol.

>      dirtymap = send all block whose write generation is greater than 'gen' (via QMP)
>      dirtycnt = 0
>      foreach block in dirtymap {
>                copy to backup via external software
>                dirtycnt++
>      }
>      gen = nextgen
>  } while (dirtycnt < X)         <--- to achieve this a thorttling or similar might be needed
> 
> fsfreeze (optional)
> write lock (via QMP)
> backupgen = fetch current write generation (via QMP)
> dirtymap = send all block whose write generation is greater than 'gen' (via QMP)
> foreach block in dirtymap {
>                copy to backup via external software
> }
> unlock (via QMP)
> fsthaw (optional)
> --->8---
> 
> As far as I understand CBT in VMware is not just only a dirty bitmap, but also a write generation tracking for blocks (size 64kb or whatever)
> 

I think at the moment I'm worried about getting the basic features out
the door, but I'm not opposed to adding fancier features if there's
justification or demand for them.

> Peter
> 

--js
