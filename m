Received: from eggs.gnu.org ([2001:4830:134:3::10]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmneb-0006wV-0l
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmneZ-0007RF-Ps
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:02:32 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<cfcca274-9e3b-a9d5-6470-6c8917085da4@redhat.com>
	<4f3aff4d-7277-3277-985b-27d7e6fdaedd@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7677b7ae-5518-533e-d8ac-d1f6a2490215@redhat.com>
Date: Tue, 29 Aug 2017 17:02:20 -0400
MIME-Version: 1.0
In-Reply-To: <4f3aff4d-7277-3277-985b-27d7e6fdaedd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>



On 08/29/2017 10:30 AM, Eric Blake wrote:
> On 08/28/2017 08:18 PM, John Snow wrote:
>>>> We'd have to develop a new syntax for specifying these resources that
>>>> can be stored in a qcow2 file,
>>>
>>> It's called the json-pseudo-protocol and was developed exactly for this.
>>>
>>
>> That's what I was hinting at for "or otherwise co-opt an existing
>> syntax" but I was unaware that it was intended for "exactly" this.
>>
>> Do we actually use it in any on-disk format, currently? qcow2 only lets
>> you specify simple filenames in the qcow2 metadata, right?
> 
> You can specify json-pseudo backing names both on the command line AND
> embedded in the qcow2 file itself (within the length limits imposed by
> the qcow2 header size).  Yes, this means it is already possible to
> create qcow2 files that can only be opened by qemu (or else teaching
> your alternative program how to parse qemu's json-pseudo-protocol).
> 
>>
>>>>                                or otherwise co-opt an existing syntax
>>>> in-use by QEMU. This syntax would likely be useful only to QEMU, which
>>>> would steer the qcow2 format in a direction not too useful by other
>>>> emulators, and qcow2 is an open format, so we may want to avoid this.
>>>
>>> Storing a file name in the backing link field that cannot be interpreted
>>> by other programs is in my opinion still very much better than not
>>> storing any information whatsoever, because in the former case other
>>> programs can at least say "sorry, I have no idea what this means" (or
>>> maybe they can indeed interpret it, who knows), whereas in the latter
>>> they may not even know that the qcow2 image is incomplete.
>>>
>>
>> I don't disagree personally, but I seem to recall that Kevin was adamant
>> that the qcow2 bitmap extension should remain useful and semantically
>> meaningful to third parties, so I try to keep that in mind. Maybe I
>> should let him chime in instead of try to "concern troll" my own
>> suggestions into the ground.
> 
> We already have that situation today, but you are right to worry about
> whether making it even more prevalent is something we can try to minimize.
> 

Proposal distillate:

(1) Specify relationship on CLI, QCOW becomes a bitmap-child of any
arbitrary node.

Pros: Easy to implement
      Adds bitmap support to literally everything
Cons: Bitmap has no semantic link to data it describes
      Relationship must be re-specified every launch
      Max and Kevin are firmly NACK

(2) Raw file becomes a R/W backing file of the QCOW2, implemented as
either a bitmap-child or a more traditional backing file that can
additionally service writes

Pros: Easy to understand
      relationship between files exists outside of the QEMU process
      Adds bitmap support to just about everything that can be expressed
via JSON
Cons: All but necessitates QEMU-specific syntax in a qcow2 file
      Depending on implementation, possibly messy in bdrv_open
      Adding bitmaps to non-qcow2 files after open makes the launch CLI
invalid for future launches (Not any different to snapshots.)

(3) Add a raw-like mapping mode to QCOW2 instead, skipping the whole affair

Pros: Adds a nice, performant hybrid mode to qcow2
      Solves the problem of "bitmaps for raw" more or less
      Avoids bdrv_open() complications
      Avoids writing qemu-specific jargon in qcow2 files
Cons: Doesn't actually add arbitrary bitmaps to any file format
      Users are still gonna ask for bitmaps for other formats anyway



I think I like 2 or 3 -- or perhaps indeed two AND three. The qcow2-raw
mode sounds like something we ought to have anyway. I'll try to start an
RFC.

--js
