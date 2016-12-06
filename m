Received: from eggs.gnu.org ([2001:4830:134:3::10]:56260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cEImg-00049g-K9
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cEImb-0007bg-Jp
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:40:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cEImb-0007bS-9u
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:39:57 -0500
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
	<16bd28b9-2a03-ea05-46ed-9b08f478c9bd@redhat.com>
	<20161206133252.3d5m3dwi7zqtjrfh@grep.be>
From: John Snow <jsnow@redhat.com>
Message-ID: <758af0c4-b4c0-0214-31ff-6579da140282@redhat.com>
Date: Tue, 6 Dec 2016 11:39:53 -0500
MIME-Version: 1.0
In-Reply-To: <20161206133252.3d5m3dwi7zqtjrfh@grep.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Alex Bligh <alex@alex.org.uk>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>



On 12/06/2016 08:32 AM, Wouter Verhelst wrote:
> Hi John
> 
> Sorry for the late reply; weekend was busy, and so was monday.
> 

No problems.

> On Fri, Dec 02, 2016 at 03:39:08PM -0500, John Snow wrote:
>> On 12/02/2016 01:45 PM, Alex Bligh wrote:
>>> John,
>>>
>>>>> +Some storage formats and operations over such formats express a
>>>>> +concept of data dirtiness. Whether the operation is block device
>>>>> +mirroring, incremental block device backup or any other operation with
>>>>> +a concept of data dirtiness, they all share a need to provide a list
>>>>> +of ranges that this particular operation treats as dirty.
>>>>>
>>>>> How can data be 'dirty' if it is static and unchangeable? (I thought)
>>>>>
>>>>
>>>> In a simple case, live IO goes to e.g. hda.qcow2. These writes come from
>>>> the VM and cause the bitmap that QEMU manages to become dirty.
>>>>
>>>> We intend to expose the ability to fleece dirty blocks via NBD. What
>>>> happens in this scenario would be that a snapshot of the data at the
>>>> time of the request is exported over NBD in a read-only manner.
>>>>
>>>> In this way, the drive itself is R/W, but the "view" of it from NBD is
>>>> RO. While a hypothetical backup client is busy copying data out of this
>>>> temporary view, new writes are coming in to the drive, but are not being
>>>> exposed through the NBD export.
>>>>
>>>> (This goes into QEMU-specifics, but those new writes are dirtying a
>>>> version of the bitmap not intended to be exposed via the NBD channel.
>>>> NBD gets effectively a snapshot of both the bitmap AND the data.)
>>>
>>> Thanks. That makes sense - or enough sense for me to carry on commenting!
>>>
>>
>> Whew! I'm glad.
>>
>>>>> I now think what you are talking about backing up a *snapshot* of a disk
>>>>> that's running, where the disk itself was not connected using NBD? IE it's
>>>>> not being 'made dirty' by NBD_CMD_WRITE etc. Rather 'dirtiness' is effectively
>>>>> an opaque state represented in a bitmap, which is binary metadata
>>>>> at some particular level of granularity. It might as well be 'happiness'
>>>>> or 'is coloured blue'. The NBD server would (normally) have no way of
>>>>> manipulating this bitmap.
>>>>>
>>>>> In previous comments, I said 'how come we can set the dirty bit through
>>>>> writes but can't clear it?'. This (my statement) is now I think wrong,
>>>>> as NBD_CMD_WRITE etc. is not defined to set the dirty bit. The
>>>>> state of the bitmap comes from whatever sets the bitmap which is outside
>>>>> the scope of this protocol to transmit it.
>>>>>
>>>>
>>>> You know, this is a fair point. We have not (to my knowledge) yet
>>>> carefully considered the exact bitmap management scenario when NBD is
>>>> involved in retrieving dirty blocks.
>>>>
>>>> Humor me for a moment while I talk about a (completely hypothetical, not
>>>> yet fully discussed) workflow for how I envision this feature.
>>>>
>>>> (1) User sets up a drive in QEMU, a bitmap is initialized, an initial
>>>> backup is made, etc.
>>>>
>>>> (2) As writes come in, QEMU's bitmap is dirtied.
>>>>
>>>> (3) The user decides they want to root around to see what data has
>>>> changed and would like to use NBD to do so, in contrast to QEMU's own
>>>> facilities for dumping dirty blocks.
>>>>
>>>> (4) A command is issued that creates a temporary, lightweight snapshot
>>>> ('fleecing') and exports this snapshot over NBD. The bitmap is
>>>> associated with the NBD export at this point at NBD server startup. (For
>>>> the sake of QEMU discussion, maybe this command is "blockdev-fleece")
>>>>
>>>> (5) At this moment, the snapshot is static and represents the data at
>>>> the time the NBD server was started. The bitmap is also forked and
>>>> represents only this snapshot. The live data and bitmap continue to change.
>>>>
>>>> (6) Dirty blocks are queried and copied out via NBD.
>>>>
>>>> (7) The user closes the NBD instance upon completion of their task,
>>>> whatever it was. (Making a new incremental backup? Just taking a peek at
>>>> some changed data? who knows.)
>>>>
>>>> The point that's interesting here is what do we do with the two bitmaps
>>>> at this point? The data delta can be discarded (this was after all just
>>>> a lightweight read-only point-in-time snapshot) but the bitmap data
>>>> needs to be dealt with.
>>>>
>>>> (A) In the case of "User made a new incremental backup," the bitmap that
>>>> got forked off to serve the NBD read should be discarded.
>>>>
>>>> (B) In the case of "User just wanted to look around," the bitmap should
>>>> be merged back into the bitmap it was forked from.
>>>>
>>>> I don't advise a hybrid where "User copied some data, but not all" where
>>>> we need to partially clear *and* merge, but conceivably this could
>>>> happen, because the things we don't want to happen always will.
>>>>
>>>> At this point maybe it's becoming obvious that actually it would be very
>>>> prudent to allow the NBD client itself to inform QEMU via the NBD
>>>> protocol which extents/blocks/(etc) that it is "done" with.
>>>>
>>>> Maybe it *would* actually be useful if, in NBD allowing us to add a
>>>> "dirty" bit to the specification, we allow users to clear those bits.
>>>>
>>>> Then, whether the user was trying to do (A) or (B) or the unspeakable
>>>> amalgamation of both things, it's up to the user to clear the bits
>>>> desired and QEMU can do the simple task of simply always merging the
>>>> bitmap fork upon the conclusion of the NBD fleecing exercise.
>>>>
>>>> Maybe this would allow the dirty bit to have a bit more concrete meaning
>>>> for the NBD spec: "The bit stays dirty until the user clears it, and is
>>>> set when the matching block/extent/etc is written to."
>>>>
>>>> With an exception that external management may cause the bits to clear.
>>>> (I.e., someone fiddles with the backing store in a way opaque to NBD,
>>>> e.g. someone clears the bitmap directly through QEMU instead of via NBD.)
>>>
>>> There is currently one possible "I've done with the entire bitmap"
>>> signal, which is closing the connection. This has two obvious
>>> problems. Firstly if used, it discards the entire bitmap (not bits).
>>> Secondly, it makes recovery from a broken TCP session difficult
>>> (as either you treat a dirty close as meaning the bitmap needs
>>> to hang around, in which case you have a garbage collection issue,
>>> or you treat it as needing to drop the bitmap, in which case you
>>> can't recover).
>>>
>>
>> In my mind, I wasn't treating closing the connection as the end of the
>> point-in-time snapshot; that would be stopping the export.
>>
>> I wouldn't advocate for a control channel (QEMU, here) clearing the
>> bitmap just because a client disappeared.
>>
>> Either:
>>
>> (A) QEMU clears the bitmap because the NBD export was *stopped*, or
>> (B) QEMU, acting as the NBD server, clears the bitmap as instructed by
>> the NBD client, if we admit a provision to clear bits from the NBD
>> protocol itself.
>>
>> I don't think there's room for the NBD server (QEMU) deciding to clear
>> bits based on connection status. It has to be an explicit decision --
>> either via NBD or QMP.
>>
>>> I think in your plan the block status doesn't change once the bitmap
>>> is forked. In that case, adding some command (optional) to change
>>> the status of the bitmap (or simply to set a given extent to status X)
>>> would be reasonable. Of course whether it's supported could be dependent
>>> on the bitmap.
>>>
>>
>> What I describe as "forking" was kind of a bad description. What really
>> happens when we have a divergence is that the bitmap with data is split
>> into two bitmaps that are related:
>>
>> - A new bitmap that is created takes over for the old bitmap. This new
>> bitmap is empty. It records writes on the live version of the data.
>> - The old bitmap as it existed remains in a read-only state, and
>> describes some point-in-time snapshot view of the data.
>>
>> In the case of an incremental backup, once we've made a backup of the
>> data, that read-only bitmap can actually be discarded without further
>> thought.
>>
>> In the case of a failed incremental backup, or in the case of "I just
>> wanted to look and see what has changed, but wasn't prepared to reset
>> the counter yet," this bitmap gets merged back with the live bitmap as
>> if nothing ever happened.
>>
>> ANYWAY, allowing the NBD client to request bits be cleared has an
>> obvious use case even for QEMU, IMO -- which is, the NBD client itself
>> gains the ability to, without relying on a control plane to the server,
>> decide for itself if it is going to "make a backup" or "just look around."
>>
>> The client gains the ability to leave the bitmap alone (QEMU will
>> re-merge it later once the snapshot is closed) or the ability to clear
>> it ("I made my backup, we're done with this.")
>>
>> That usefulness would allow us to have an explicit dirty bit mechanism
>> directly in NBD, IMO, because:
>>
>> (1) A RW NBD server has enough information to mark a bit dirty
>> (2) Since there exists an in-spec mechanism to reset the bitmap, the
>> dirty bit is meaningful to the server and the client
> 
> While I can see that the ability to manipulate metadata might have
> advantages for certain use cases, I don't think that the ability to
> *inspect* metadata should require the ability to manipulate it in any
> way.
> 
> So I'd like to finish the block_status extension before moving on to
> manipulation :)
> 

Understood. The problem I was trying to correct by admitting that
manipulation of bits may have a purpose in NBD was to attempt to clarify
the exact meaning of the dirty bit.

It had seemed to me that by not specifying (or disallowing) the
manipulation of those bits from within NBD necessarily meant that their
meaning existed entirely out-of-spec for NBD, which could be a show-stopper.

So I was attempting to show that by allowing their manipulation in NBD,
they'd have full in-spec meaning. It all depends on what exactly we name
those bits and how you'd like to define their meaning. There are many
ways we can expose this information in a useful manner, so this was just
another option.

>>>> Having missed most of the discussion on v1/v2, is it a given that we
>>>> want in-band identification of bitmaps?
>>>>
>>>> I guess this might depend very heavily on the nature of the definition
>>>> of the "dirty bit" in the NBD spec.
>>>
>>> I don't think it's a given. I think Wouter & I came up with it at
>>> the same time as a way to abstract the bitmap/extent concept and
>>> remove the need to specify a dirty bit at all (well, that's my excuse
>>> anyway).
>>>
>>
>> OK. We do certainly support multiple bitmaps being active at a time in
>> QEMU, but I had personally always envisioned that you'd associate them
>> one-at-a-time when starting the NBD export of a particular device.
>>
>> I don't have a use case in my head where two distinct bitmaps being
>> exposed simultaneously offer any particular benefit, but maybe there is
>> something. I'm sure there is.
> 
> The ability to do something does not in any way imply the requirement to
> do the same :-)
> 

hence the ask. It's not something QEMU currently needs, but I am a bad
psychic.

> The idea is that the client negotiates one or more forms of metadata
> information from the server that it might be interested in, and then
> asks the server that information for a given extent where it has
> interest.
> 

via the NBD protocol, you mean?

> The protocol spec does not define what that metadata is (beyond the "is
> allocated" one that we define in the spec currently, and possibly
> something else in the future). So if qemu only cares about just one type
> of metadata, there's no reason why it should *have* to export more than
> one type.
> 
>> I will leave this aspect of it more to you NBD folks. I think QEMU could
>> cope with either.
>>
>> (Vladimir, am I wrong? Do you have thoughts on this in particular? I
>> haven't thought through this aspect of it very much.)
>>
>>>> Anyway, I hope I am being useful and just not more confounding. It seems
>>>> to me that we're having difficulty conveying precisely what it is we're
>>>> trying to accomplish, so I hope that I am making a good effort in
>>>> elaborating on our goals/requirements.
>>>
>>> Yes absolutely. I think part of the challenge is that you are quite
>>> reasonably coming at it from the point of view of qemu's particular
>>> need, and I'm coming at it from 'what should the nbd protocol look
>>> like in general' position, having done lots of work on the protocol
>>> docs (though I'm an occasional qemu contributor). So there's necessarily
>>> a gap of approach to be bridged.
>>>
>>
>> Yeah, I understand quite well that we need to make sure the NBD spec is
>> sane and useful in a QEMU-agnostic way, so my goal here is just to help
>> elucidate our needs to enable you to reach a good consensus.
> 
> Right, that's why I was reluctant to merge the original spec as it
> stood.
> 
>>> I'm overdue on a review of Wouter's latest patch (partly because I need
>>> to re-diff it against the version with no NBD_CMD_BLOCK_STATUS in),
>>> but I think it's a bridge worth building.
>>>
>>
>> Same. Thank you for your patience!
> 
> I can do some updates given a few of the suggestions that were made on
> this list (no guarantee when that will happen), but if people are
> interested in reviewing things in the mean time, be my guest...
> 

I'll take a look at your revision(s), thanks.

--js
