Received: from eggs.gnu.org ([2001:4830:134:3::10]:47630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dl2uP-0000BP-9K
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 20:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dl2uN-0004Yi-Iz
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 20:55:37 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
Date: Thu, 24 Aug 2017 20:55:20 -0400
MIME-Version: 1.0
In-Reply-To: <cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Sorry in advance for :words: ...

On 08/23/2017 02:04 PM, Vladimir Sementsov-Ogievskiy wrote:
> 23.08.2017 11:59, Vladimir Sementsov-Ogievskiy wrote:
>> 22.08.2017 22:07, John Snow wrote:
>>> Well, we knew we'd want this sooner or later. I've got some pings
>>> downstream over whether or not we support persistent bitmaps for
>>> non-qcow2 formats.
>>>
>>> Currently: no, we don't.
>>>
>>> We tried two different ideas for storage agnostic bitmap persistence:
>>>
>>>
>>> (1) Using qcow2 as a storage container format (similar to VM save
>>> states) for information not associated with that particular drive.
>>>
>>> This didn't go over so well; we decided it was too messy logistically to
>>> manage data in any meaningful sense in a file that didn't share any
>>> semantic relationship to the qcow2 in question.
>>>
>>> Well, "We" decided is more like "Kevin and Max" decided. They are right,
>>> though.
>>>
>>>
>>> (2) Using a new proto-wrapper format that Fam Zheng designed that serves
>>> as a simple top-layer redirect for metadata that allows us to associate
>>> raw bitmap data with an arbitrary backing image.
>>>
>>> This also didn't go over so well, the desire for a "new format" was
>>> pretty thin, even if it was only a pseudo-format.
>>>
>>>
>>> We'd still like to be able to use bitmaps with non-qcow2 formats
>>> however, and people are going to keep asking. So here's a third thought:
>>>
>>>
>>> (3) Add either a new flag that turns qcow2's backing file into a full
>>> R/W backing file, or add a new extension to qcow2 entirely (bypassing
>>> the traditional backing file mechanism to avoid confusion for older
>>> tooling) that adds a new read-write backing file field.
>>>
>>> This RW backing file field will be used for all reads AND writes; the
>>> qcow2 in question becomes a metadata container on top of the BDS chain.
>>> We can re-use Vladimir's bitmap persistence extension to save bitmaps in
>>> a qcow2 shell.
>>>
>>> The qcow2 becomes effectively a metadata cache for a new (essentially)
>>> filter node that handles features such as bitmaps. This could also be
>>> used to provide allocation map data for RAW files and other goodies down
>>> the road.
>>>
>>> Hopefully this achieves our desire to not create new formats AND our
>>> desire to concentrate features (and debugging, testing, etc) into qcow2,
>>> while allowing users to "have bitmaps with raw files."
>>>
>>> Of course, in this scenario, users now have two files: a qcow2 wrapper
>>> and the actual raw file in question; but regardless of how we were going
>>> to solve this, a raw file necessitates an external file of some sort,
>>> else we give up the idea that it was a raw file.
>>>
>>>
>>> Sound good?
>>
>> Looks interesting. It is a clean reusing of qcow2-bitmaps without any
>> modifications to them.
>>
>> Should there be some problems with internal snapshots and other things?
>>
>>
>>
> Hm. looks like that this backing file should not only receive all reads
> and writes, but almost everything ->bdrv_ handlers, except bitmap
> related of course. This doesn't seems simple to implement. Especially if
> imaging some not-raw feature-full format under this thin qcow2 layer..
> Or we can restrict this RW backing file to be raw-only?
> 
> 

The idea would really be to support any arbitrary data store, so I
wouldn't want to restrict it to just raw.

You're right though, this might be a kind of messy approach.

[From your other mail:]

> 
> So, anyway, I see only two differences (from the outside) between this approach and just a separate bitmap-only qcow2 without a data:
> 

It's very delicately similar, yes.

> 1. in RW-backing approach qcow2-bitmap file has a link to data file (as a backing). It looks good.
> 

Right. The information necessary to establish a link between the bitmap
data and the data being described is fully contained within a file fully
specified by the QCOW2 spec.

> 2. in RW-backing approach qcow2-bitmap file is a top of the virtual disk, in separate-file approach it is an option of the real data drive. In my opinion the second is more clean for users ("to add this feature you should use other file as your disk" vs "to add this feature you should add an option to your disk description")

This puts us a little closer to the original idea that was rejected by
Kevin at the time. To recap:

"1": Use qcow2 as a container. This was rejected because we didn't want
qcow2 containing data with no semantic relationship to the qcow2
container or to each other. The way it sounds like you're proposing it,
though, it would be one-qcow2-with-bitmaps-per-drive, so the data would
at least stay strictly related, but it would be meaningless outside of
QEMU itself. I think this is something that Kevin wanted to avoid, but I
can't speak for him.

It's certainly not beyond the realm of management software to remember
to correlate a qcow2 metadata file alongside its actual data stores
whenever it needed to do so, but it does mean the introduction of a
feature that essentially requires the use of management software, which
sees resistance in the community at times.

In this model, you'd probably have the raw drive at the top, with the
qcow2-with-bitmaps as a child node with some kind of new named child
relationship. All IO stays at the root node, but the bitmap method
handlers would know to look for this special bitmap-child. It shouldn't
be too hard to implement.

> 
> 
> I think (may be I'm not right) loading bitmaps from additional qcow2-only-bitmaps file is simpler to implement (it will be specified in command line in drive options, like bitmaps_file=/path/to/it and then attached directly to BlockDriverState). The only drawback of simple qcow2-bitmap file  is that it has not a link inside it to the data file (like shabacking). We can ignore it, or we can implement this link as a separate extension to qcow2.

Yes, definitely easier to implement as you say.

The hard part is going to come in defining that semantic link. At this
point, the only difference between the approaches is whether or not we
allow the qcow2 to point to the implementation of the data;

(1) The qcow2 is referenced by name from the CLI as an option to the
other drive.

(2) The qcow2 is referenced by name on the CLI, and its backing file
field intuits the location of the implementation storage.


In (1), we avoid saving or specifying the relationship between these two
data stores in any way. This is certainly easy to do, and will save us
some headache on the CLI. As a downside, we now have random orphaned
files that aren't very interesting or useful on their own. The
likelihood for desync between metadata and data increases. The use of
management software is all but necessitated.

In (2) We have to now specify, with a dizzying long list of
possibilities, the location of the implementation data. qcow2 only has a
filename for backing files presently, but this is likely inadequate.
What if the data store isn't a locally kept file? What if it's a socket,
or a stream, or literally anything else?

We'd have to develop a new syntax for specifying these resources that
can be stored in a qcow2 file, or otherwise co-opt an existing syntax
in-use by QEMU. This syntax would likely be useful only to QEMU, which
would steer the qcow2 format in a direction not too useful by other
emulators, and qcow2 is an open format, so we may want to avoid this.





I feel like what will make the difference between heading down either
path would be helped along by answers to these questions:

- What type of data stores do we wish to support with bitmaps? Simple
file-based ones, or the full spectrum of all types? Only qcow2, and to
hell with people who ask for otherwise?

- How important is it that the qcow2 remains a fully independent file
capable of describing its own relationship to the data?

- Is it OK to allow robust, QEMU-specific data descriptors in a qcow2 file?


Where I sit:

- I'd like to support truly arbitrary protocols and formats. We can add
transient / non-persistent bitmaps to any of these today, so I'd like to
maintain that flexibility.

- I think it will be difficult or impossible to agree upon a
specification for the syntax to store the backing storage identifier in
the qcow2 itself, because we'd like to let third party tools make use of
qcow2 files.

- I don't think Kevin will like the idea of us using qcow2 as a
container that does not get treated as a first class citizen in the
backing chain, but it's the easiest option to implement and avoids a lot
of the syntax-of-backing-storage questions.

- There's a definite usability factor to having the qcow2 just specify
where the rest of the data sits like it does for normal backing files,
but with what I am proposing, this complicates the open() call
considerably, not to mention the syntactic issues addressed above.



I guess I've talked myself out of wanting a "RW backing file" because it
seems hard to implement, spec-wise ...

--js
