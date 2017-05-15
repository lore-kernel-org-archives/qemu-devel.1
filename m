Received: from eggs.gnu.org ([2001:4830:134:3::10]:60752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAKqb-0005B8-FL
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAKqZ-0002x5-R1
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:35:57 -0400
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-2-eblake@redhat.com>
	<20170412094909.GC4955@noname.str.redhat.com>
	<161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
	<7171308e-833e-38a0-8775-9b5a52b8a105@redhat.com>
	<26c745c7-2497-7adf-eee1-3547f1aeb95c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <91600f4a-e265-c353-c688-b220c3e867dd@redhat.com>
Date: Mon, 15 May 2017 20:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <26c745c7-2497-7adf-eee1-3547f1aeb95c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5SJRDTdfr3F3w9IBB1rj34KIe78R0qddw"
Subject: Re: [Qemu-devel] [PATCH v9 01/13] qcow2: Unallocate unmapped zero
 clusters if no backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5SJRDTdfr3F3w9IBB1rj34KIe78R0qddw
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <91600f4a-e265-c353-c688-b220c3e867dd@redhat.com>
Subject: Re: [PATCH v9 01/13] qcow2: Unallocate unmapped zero clusters if no
 backing file
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-2-eblake@redhat.com>
 <20170412094909.GC4955@noname.str.redhat.com>
 <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
 <7171308e-833e-38a0-8775-9b5a52b8a105@redhat.com>
 <26c745c7-2497-7adf-eee1-3547f1aeb95c@redhat.com>
In-Reply-To: <26c745c7-2497-7adf-eee1-3547f1aeb95c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-13 01:00, John Snow wrote:
>=20
>=20
> On 05/12/2017 12:06 PM, Max Reitz wrote:
>> On 2017-05-11 16:56, Eric Blake wrote:
>>> [revisiting this older patch version, even though the final version i=
n
>>> today's pull request changed somewhat from this approach]
>>>
>>> On 04/12/2017 04:49 AM, Kevin Wolf wrote:
>>>> Am 11.04.2017 um 03:17 hat Eric Blake geschrieben:
>>>>> 'qemu-img map' already coalesces information about unallocated
>>>>> clusters (those with status 0) and pure zero clusters (those
>>>>> with status BDRV_BLOCK_ZERO and no offset).  Furthermore, all
>>>>> qcow2 images with no backing file already report all unallocated
>>>>> clusters (in the preallocation sense of clusters with no offset)
>>>>> as BDRV_BLOCK_ZERO, regardless of whether the QCOW_OFLAG_ZERO was
>>>>> set in that L2 entry (QCOW_OFLAG_ZERO also implies a return of
>>>>> BDRV_BLOCK_ALLOCATED, but we intentionally do not expose that bit
>>>>> to external users), thanks to generic block layer code in
>>>>> bdrv_co_get_block_status().
>>>>>
>>>>> So, for an image with no backing file, having bdrv_pwrite_zeroes
>>>>> mark clusters as unallocated (defer to backing file) rather than
>>>>> reads-as-zero (regardless of backing file) makes no difference
>>>>> to normal behavior, but may potentially allow for fewer writes to
>>>>> the L2 table of a freshly-created image where the L2 table is
>>>>> initially written to all-zeroes (although I don't actually know
>>>>> if we skip an L2 update and flush when re-writing the same
>>>>> contents as already present).
>>>>
>>>> I don't get this. Allocating a cluster always involves an L2 update,=
 no
>>>> matter whether it was previously unallocated or a zero cluster.
>>>
>>> On IRC, John, Kevin, and I were discussing the current situation with=

>>> libvirt NBD storage migration.  When libvirt creates a file on the
>>> destination (rather than the user pre-creating it), it currently
>>> defaults to 0.10 [v2] images, even if the source was a 1.1 image [v3]=

>>> (arguably something that could be improved in libvirt, but
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749 was closed as n=
ot a
>>> bug).
>>>
>>> Therefore, the use case of doing a mirror job to a v2 image, and havi=
ng
>>> that image become thick even though the source was thin, is happening=

>>> more than we'd like
>>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749).  While Kevin=
 had
>>> a point that in the common case we ALWAYS want to turn an unallocated=

>>> cluster into a zero cluster (so that we don't have to audit whether a=
ll
>>> callers are properly accounting for the case where a backing image is=

>>> added later), our conversation on IRC today conceded that we may want=
 to
>>> introduce a new BDRV_REQ_READ_ZERO_NOP (or some such name) that
>>> particular callers can use to request that if a cluster already reads=
 as
>>> zeroes, the write zero request does NOT have to change it.  Normal gu=
est
>>> operations would not use the flag, but mirroring IS a case that would=

>>> use the flag, so that we can end up with thinner mirrors even to 0.10=

>>> images.

Reading this again, you could just pass through the write-zero request.
The issue right now is that the qcow2 driver just returns -ENOTSUP for
every write-zero request on v2 images when it could just create a data
cluster and invoke a write-zero request on the data.

Just not suppressing the BDRV_REQ_ZERO_WRITE flag for the generic
fall-back zero write (with bs->supported_write_flags listing it) and
then issuing a bdrv_co_pwrite_zeroes() in qcow2_co_pwritev() works (with
BDRV_REQ_MAY_UNMAP).

(Whether or not to set BDRV_REQ_MAY_UNMAP should be derived from...
Maybe QCOW2_DISCARD_OTHER?)

>>> The other consideration is that on 0.10 images, even if we have to
>>> allocate, right now our allocation is done by way of failing with
>>> -ENOTSUP and falling back to the normal pwrite() of explicit zeroes. =
 It
>>> may be worth teaching the qcow2 layer to explicitly handle write zero=
es,
>>> even on 0.10 images, by allocating a cluster (as needed) but then
>>> telling bs->file to write zeroes (punching a hole as appropriate) so
>>> that the file is still thin.  In fact, it matches the fact that we
>>> already have code that probes whether a qcow2 cluster that reports
>>> BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID then probes bs->file to see i=
f
>>> there is a hole there, at which point it can add BDRV_BLOCK_ZERO to t=
he
>>> bdrv_get_block_status.
>>>
>>> I don't know which one of us will tackle patches along these lines, b=
ut
>>> wanted to at least capture the gist of the IRC conversation in the
>>> archives for a bit more permanence.
>>
>> Just short ideas:
>>
>> (1) I do consider it a bug if v2 images are created. The BZ wasn't
>> closed for a very good reason, but because nobody answered this questi=
on:
>>
>>> is this really a problem?
>>
>> And apparently it is.
>>
>> (2) There is a way of creating zero clusters on v2 images, but we've
>> never done it (yet): You create a single data cluster containing zeroe=
s
>> and then you just point to it whenever you need a zero cluster (until
>> its refcount overflows, at which point you allocate another cluster).
>> Maybe that helps.
>>
>> I'd be really careful with optimizations for v2 images. You have alrea=
dy
>> proven to me that my fears of too much complexity are out of proportio=
ns
>> sometimes, but still. v2 upstream is old legacy and should be treated =
as
>> such, at least IMHO.
>>
>> Max
>>
>>
>=20
> I agree that V2 changes should be limited in nature, but there are
> less-fiddly ways to have thin 0.10 images on sparse filesystems. This
> way feels a little too clever and mostly likely too intrusive for an ol=
d
> format.

Yes.

> I'd also think that it'd probably confuse older copies of qemu-img
> check, so maybe this is too hacky of a solution.

I don't.

Anyway, feel free to convince me by writing a simple patch that allows
the v2 sparseness you need.

Let's again get to the root of the issue: Mirroring to a new v2 qcow2
image does not create a sparse image. There are multiple questions here:

(1) Who does mirroring?
(2) Who uses v2 qcow2 for the destination?
(3) Who needs sparse images?

(1) is clear, everybody does it. (3) is rather clear, it would be nice
to have (but not an absolute catastrophe if we didn't). So what remains
is (2).

=46rom qemu's perspective, qcow2v3 has been the default for quite some
time. So just using qemu, nobody will use v2.

Maybe you're using an old qemu, maybe you're using RHEL 6's qemu which
only supports v2. This is an argument, but I'd very much just recommend
an update. (Bit of an internal question: Are you willing to backport the
upstream changes this would bring to RHEL 6?)

And then there's the case the BZ is about: Maybe you're using a
management tool which forces v2 images. I'd call it a bug in the
management tool because we didn't make v3 the default for nothing. Maybe
there are good reasons why some management tools create v2, but I don't
know any and when the BZ was closed none were given. It was just closed
because there was no apparent reason not to (but there is!).


So I see the following courses of action:

1. Ignore the v2 "issue". It's not an upstream issue, it's a bug in a
management tool, so let's just reopen the BZ and ignore RHEL 6 users.
Also, v2 just is a limited format, there is a reason v3 exists! So I
wouldn't even call it an issue, it's just how it is.

2. Improve v2. Would "fix" the issue at hand while still not letting
RHEL 7's libvirt create v3 images (which might very well come back to
haunt us some other day), and would complicate upstream code for no
upstream reason.

Now, as I said, I'm open to be convinced that (2) is viable: If the
change is simple enough, sure, let's take it, why not. But I don't see
the point still.

Max


--5SJRDTdfr3F3w9IBB1rj34KIe78R0qddw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGfT/EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQG7t
CAC+qmAVmiN7T34cqST5oQlrJZtslGmMsWMUP/Z7Hl7WexrxGzDU3ffo96EuV0bn
ontrEOX29BrRtptjssSgr+pYUIcjctiZ4wvatPjvbK8eMdg+SLEob2WlOtw3e1CO
kYr6zL5eUuqwRhK8MqCknHBEVcqFzzEr5N3kVOGLEC+u5sE4ENYY53inxdsr+9Cu
UTNCOkGll0wVecfYunPrDinV8VtG7zlTjgdNvwEtyJj2m6jsgFu9VilqnPlYGQqJ
ozuXb/0jbL8J9HWgCILl/0NO3PeXB/nhzuIX09RnHR4KgUDoLSTA5Qgog3v5Y89r
paJVeyqavq/I+l8fFcxgxWnq
=zqhx
-----END PGP SIGNATURE-----

--5SJRDTdfr3F3w9IBB1rj34KIe78R0qddw--
