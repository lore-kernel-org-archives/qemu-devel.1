Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dlEub-0004Si-TU
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dlEuZ-0003ih-JI
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:44:37 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
Date: Fri, 25 Aug 2017 15:44:14 +0200
MIME-Version: 1.0
In-Reply-To: <0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PlQpIaEpUQ1citMbnqAel9h0Trh6fwUjN"
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PlQpIaEpUQ1citMbnqAel9h0Trh6fwUjN
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
 <a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
 <cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
 <0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
In-Reply-To: <0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-25 02:55, John Snow wrote:
> Sorry in advance for :words: ...
>=20
> On 08/23/2017 02:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 23.08.2017 11:59, Vladimir Sementsov-Ogievskiy wrote:
>>> 22.08.2017 22:07, John Snow wrote:
>>>> Well, we knew we'd want this sooner or later. I've got some pings
>>>> downstream over whether or not we support persistent bitmaps for
>>>> non-qcow2 formats.
>>>>
>>>> Currently: no, we don't.
>>>>
>>>> We tried two different ideas for storage agnostic bitmap persistence=
:
>>>>
>>>>
>>>> (1) Using qcow2 as a storage container format (similar to VM save
>>>> states) for information not associated with that particular drive.
>>>>
>>>> This didn't go over so well; we decided it was too messy logisticall=
y to
>>>> manage data in any meaningful sense in a file that didn't share any
>>>> semantic relationship to the qcow2 in question.
>>>>
>>>> Well, "We" decided is more like "Kevin and Max" decided. They are ri=
ght,
>>>> though.
>>>>
>>>>
>>>> (2) Using a new proto-wrapper format that Fam Zheng designed that se=
rves
>>>> as a simple top-layer redirect for metadata that allows us to associ=
ate
>>>> raw bitmap data with an arbitrary backing image.
>>>>
>>>> This also didn't go over so well, the desire for a "new format" was
>>>> pretty thin, even if it was only a pseudo-format.
>>>>
>>>>
>>>> We'd still like to be able to use bitmaps with non-qcow2 formats
>>>> however, and people are going to keep asking. So here's a third thou=
ght:
>>>>
>>>>
>>>> (3) Add either a new flag that turns qcow2's backing file into a ful=
l
>>>> R/W backing file, or add a new extension to qcow2 entirely (bypassin=
g
>>>> the traditional backing file mechanism to avoid confusion for older
>>>> tooling) that adds a new read-write backing file field.
>>>>
>>>> This RW backing file field will be used for all reads AND writes; th=
e
>>>> qcow2 in question becomes a metadata container on top of the BDS cha=
in.
>>>> We can re-use Vladimir's bitmap persistence extension to save bitmap=
s in
>>>> a qcow2 shell.
>>>>
>>>> The qcow2 becomes effectively a metadata cache for a new (essentiall=
y)
>>>> filter node that handles features such as bitmaps. This could also b=
e
>>>> used to provide allocation map data for RAW files and other goodies =
down
>>>> the road.
>>>>
>>>> Hopefully this achieves our desire to not create new formats AND our=

>>>> desire to concentrate features (and debugging, testing, etc) into qc=
ow2,
>>>> while allowing users to "have bitmaps with raw files."
>>>>
>>>> Of course, in this scenario, users now have two files: a qcow2 wrapp=
er
>>>> and the actual raw file in question; but regardless of how we were g=
oing
>>>> to solve this, a raw file necessitates an external file of some sort=
,
>>>> else we give up the idea that it was a raw file.
>>>>
>>>>
>>>> Sound good?
>>>
>>> Looks interesting. It is a clean reusing of qcow2-bitmaps without any=

>>> modifications to them.
>>>
>>> Should there be some problems with internal snapshots and other thing=
s?

I'd suspect you get exactly the same problems when using internal
snapshots together with backing files.  Imagine a newly created overlay
file and taking a snapshot.  This should give you exactly the same
issue, doesn't it?

>>>
>>>
>>>
>> Hm. looks like that this backing file should not only receive all read=
s
>> and writes, but almost everything ->bdrv_ handlers, except bitmap
>> related of course.

How so?  Shouldn't it just work like a backing file, except it also
receives writes instead of just reads?

>>                    This doesn't seems simple to implement. Especially =
if
>> imaging some not-raw feature-full format under this thin qcow2 layer..=

>> Or we can restrict this RW backing file to be raw-only?
>>
>>
>=20
> The idea would really be to support any arbitrary data store, so I
> wouldn't want to restrict it to just raw.
>=20
> You're right though, this might be a kind of messy approach.
>=20
> [From your other mail:]
>=20
>>
>> So, anyway, I see only two differences (from the outside) between this=
 approach and just a separate bitmap-only qcow2 without a data:
>>
>=20
> It's very delicately similar, yes.
>=20
>> 1. in RW-backing approach qcow2-bitmap file has a link to data file (a=
s a backing). It looks good.

And this is rather important to me.

> Right. The information necessary to establish a link between the bitmap=

> data and the data being described is fully contained within a file full=
y
> specified by the QCOW2 spec.
>=20
>> 2. in RW-backing approach qcow2-bitmap file is a top of the virtual di=
sk, in separate-file approach it is an option of the real data drive. In =
my opinion the second is more clean for users ("to add this feature you s=
hould use other file as your disk" vs "to add this feature you should add=
 an option to your disk description")

I'd argue it's rather: "You cannot use this feature unless your format
supports it.  The only format supporting persistent bitmaps currently is
qcow2.  To use persistent bitmaps with other formats you can attach them
as R/W backing files to an empty qcow2 file, though."

So the difference is that you are saying it's a feature that is added to
a non-qcow2 image whereas I'm saying it's a feature that only a qcow2
image can provide (currently).

> This puts us a little closer to the original idea that was rejected by
> Kevin at the time. To recap:
>=20
> "1": Use qcow2 as a container. This was rejected because we didn't want=

> qcow2 containing data with no semantic relationship to the qcow2
> container or to each other. The way it sounds like you're proposing it,=

> though, it would be one-qcow2-with-bitmaps-per-drive, so the data would=

> at least stay strictly related, but it would be meaningless outside of
> QEMU itself. I think this is something that Kevin wanted to avoid, but =
I
> can't speak for him.
>=20
> It's certainly not beyond the realm of management software to remember
> to correlate a qcow2 metadata file alongside its actual data stores
> whenever it needed to do so, but it does mean the introduction of a
> feature that essentially requires the use of management software, which=

> sees resistance in the community at times.
>=20
> In this model, you'd probably have the raw drive at the top, with the
> qcow2-with-bitmaps as a child node with some kind of new named child
> relationship. All IO stays at the root node, but the bitmap method
> handlers would know to look for this special bitmap-child. It shouldn't=

> be too hard to implement.

I'd still like to throw in how much I dislike this approach, and I can't
really think of a way to make it palatable to me.  Not even "just write
the file name of the image the bitmaps cover into the qcow2 file" sounds
good to me, because then it still is basically unrelated data.

The only approach that I might see myself liking is to indeed add a flag
or whatever to say a qcow2 backing image is supposed to be R/W; and then
(after somehow verifying that the qcow2 image itself is empty) just make
qemu interpret this as "load the backing file as the real disk and
attach the qcow2 image as a 'metadata' child" or whatever.  But I fear
this gets uglier and uglier because how qemu loads the files will then
depend on whether the overlay is empty or not, and this may be very
confusing.

>> I think (may be I'm not right) loading bitmaps from additional qcow2-o=
nly-bitmaps file is simpler to implement (it will be specified in command=
 line in drive options, like bitmaps_file=3D/path/to/it and then attached=
 directly to BlockDriverState). The only drawback of simple qcow2-bitmap =
file  is that it has not a link inside it to the data file (like backing)=
=2E We can ignore it, or we can implement this link as a separate extensi=
on to qcow2.
>=20
> Yes, definitely easier to implement as you say.
>=20
> The hard part is going to come in defining that semantic link. At this
> point, the only difference between the approaches is whether or not we
> allow the qcow2 to point to the implementation of the data;
>=20
> (1) The qcow2 is referenced by name from the CLI as an option to the
> other drive.
>=20
> (2) The qcow2 is referenced by name on the CLI, and its backing file
> field intuits the location of the implementation storage.
>=20
>=20
> In (1), we avoid saving or specifying the relationship between these tw=
o
> data stores in any way. This is certainly easy to do, and will save us
> some headache on the CLI. As a downside, we now have random orphaned
> files that aren't very interesting or useful on their own. The
> likelihood for desync between metadata and data increases. The use of
> management software is all but necessitated.
>=20
> In (2) We have to now specify, with a dizzying long list of
> possibilities, the location of the implementation data. qcow2 only has =
a
> filename for backing files presently, but this is likely inadequate.
> What if the data store isn't a locally kept file? What if it's a socket=
,
> or a stream, or literally anything else?

I don't see the difference.  In (1), your data image gets a "bitmap" or
"metadata" child.  In (2), your qcow2 image gets the usual "backing"
child, or maybe call it "passthrough" or whatever, if you want to make
the difference more explicit than just passing an option to the qcow2
image to pass writes to its backing file.

> We'd have to develop a new syntax for specifying these resources that
> can be stored in a qcow2 file,

It's called the json-pseudo-protocol and was developed exactly for this.

>                                or otherwise co-opt an existing syntax
> in-use by QEMU. This syntax would likely be useful only to QEMU, which
> would steer the qcow2 format in a direction not too useful by other
> emulators, and qcow2 is an open format, so we may want to avoid this.

Storing a file name in the backing link field that cannot be interpreted
by other programs is in my opinion still very much better than not
storing any information whatsoever, because in the former case other
programs can at least say "sorry, I have no idea what this means" (or
maybe they can indeed interpret it, who knows), whereas in the latter
they may not even know that the qcow2 image is incomplete.

Also note that we are making an effort to be able to generate plain file
names (such as URLs which should be usable by other programs) whenever
possible.

> I feel like what will make the difference between heading down either
> path would be helped along by answers to these questions:
>=20
> - What type of data stores do we wish to support with bitmaps? Simple
> file-based ones, or the full spectrum of all types? Only qcow2, and to
> hell with people who ask for otherwise?

I don't really know how this question relates to the issue other than
"If we only want to support qcow2, the whole discussion is moot; since
this discussion exists, we apparently do want to support something other
than qcow2 at some point."

Well, OK.  The main argument against supporting anything but qcow2 is
"if you want features, use qcow2; and we are working on making qcow2 as
fast as possible."  I think that's a very good argument still.  At some
point I (and probably others, too) had the idea of making qcow2 files in
raw layout: Have the data as a blob, just like a raw file, padded by
metadata around it.  An autoclear flag would specify that the qcow2 file
is in this format, and if so, you could simply access it like a raw file
and should have exactly the same speed as a raw file.  Maybe that would
solve this whole issue, too?

And as for non-file based backing files, see above.

> - How important is it that the qcow2 remains a fully independent file
> capable of describing its own relationship to the data?

Technically not important.  To me, very important.

> - Is it OK to allow robust, QEMU-specific data descriptors in a qcow2 f=
ile?

Depends.  At least Red Hat's QA does use json file names, so there's
already that.

I think QEMU-specific is OK as long as it still makes sense, as long as
there is no other way, and as long as there is some kind of
documentation still.

Technically, you can always put QEMU-specific stuff into the qcow2
specification and thus make it generic.

> Where I sit:

[...]

> - I don't think Kevin will like the idea of us using qcow2 as a
> container that does not get treated as a first class citizen in the
> backing chain, but it's the easiest option to implement and avoids a lo=
t
> of the syntax-of-backing-storage questions.

I'd like to throw in that I was not at all opposed to Fam's approach of
having an independent format (tar, wasn't it?) just for storing bitmaps.
 I know Kevin was, but I don't quite remember why.  Probably because it
was a real format, but a very strange one, and then implementing it
through the block layer was weird...?

OTOH, there is one issue I have with the R/W backing approach: Every
request to the raw file has to go through the qcow2 layer.  And since
you probably want to use raw because of the speed, this is not so nice.

Max


--PlQpIaEpUQ1citMbnqAel9h0Trh6fwUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmgKa4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALMgH/1+Pdv3/yU7jVZSe1KNFg1rG/Ou3aBwf
J1V5qKg6uuSZPDQY9ku++qcB8yZkBxamNgm12nEH+Jtx7kmVStWxgHxwf+6FeTs4
voABH04J/Kh35lF9BJDRjNi4aYZGVvCbERuN9AmNo0thMFxpZrFASe+kAZZYA9sX
Ejvc+9r3Xqlth+uKAssfs/jmSL79hI/Dv7na3sd31F5xBL6OdL2XU1NQ3BBt8y/Y
fd+uZ67zp0SOLHI1wMAcO5/QYR36r4tU6bIT/fsxVCHh/52PWU8AO10EOuWq+3yp
iSAiNQw753u6dNmp3XfySez+Rct6s/1+ehuHEpKdRI7Te+KQChSyZuc=
=x0zf
-----END PGP SIGNATURE-----

--PlQpIaEpUQ1citMbnqAel9h0Trh6fwUjN--
