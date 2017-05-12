Received: from eggs.gnu.org ([2001:4830:134:3::10]:51720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9D5t-0007un-Nl
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9D5r-0003W6-2W
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:07:05 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-2-eblake@redhat.com>
	<20170412094909.GC4955@noname.str.redhat.com>
	<161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
Message-ID: <7171308e-833e-38a0-8775-9b5a52b8a105@redhat.com>
Date: Fri, 12 May 2017 18:06:45 +0200
MIME-Version: 1.0
In-Reply-To: <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hk5fH7M1QQx0J658MOvsTH25bMBMSB67w"
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
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hk5fH7M1QQx0J658MOvsTH25bMBMSB67w
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Message-ID: <7171308e-833e-38a0-8775-9b5a52b8a105@redhat.com>
Subject: Re: [PATCH v9 01/13] qcow2: Unallocate unmapped zero clusters if no
 backing file
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-2-eblake@redhat.com>
 <20170412094909.GC4955@noname.str.redhat.com>
 <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
In-Reply-To: <161300e8-fefb-f2c6-09cd-afd16d14bca0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-11 16:56, Eric Blake wrote:
> [revisiting this older patch version, even though the final version in
> today's pull request changed somewhat from this approach]
>=20
> On 04/12/2017 04:49 AM, Kevin Wolf wrote:
>> Am 11.04.2017 um 03:17 hat Eric Blake geschrieben:
>>> 'qemu-img map' already coalesces information about unallocated
>>> clusters (those with status 0) and pure zero clusters (those
>>> with status BDRV_BLOCK_ZERO and no offset).  Furthermore, all
>>> qcow2 images with no backing file already report all unallocated
>>> clusters (in the preallocation sense of clusters with no offset)
>>> as BDRV_BLOCK_ZERO, regardless of whether the QCOW_OFLAG_ZERO was
>>> set in that L2 entry (QCOW_OFLAG_ZERO also implies a return of
>>> BDRV_BLOCK_ALLOCATED, but we intentionally do not expose that bit
>>> to external users), thanks to generic block layer code in
>>> bdrv_co_get_block_status().
>>>
>>> So, for an image with no backing file, having bdrv_pwrite_zeroes
>>> mark clusters as unallocated (defer to backing file) rather than
>>> reads-as-zero (regardless of backing file) makes no difference
>>> to normal behavior, but may potentially allow for fewer writes to
>>> the L2 table of a freshly-created image where the L2 table is
>>> initially written to all-zeroes (although I don't actually know
>>> if we skip an L2 update and flush when re-writing the same
>>> contents as already present).
>>
>> I don't get this. Allocating a cluster always involves an L2 update, n=
o
>> matter whether it was previously unallocated or a zero cluster.
>=20
> On IRC, John, Kevin, and I were discussing the current situation with
> libvirt NBD storage migration.  When libvirt creates a file on the
> destination (rather than the user pre-creating it), it currently
> defaults to 0.10 [v2] images, even if the source was a 1.1 image [v3]
> (arguably something that could be improved in libvirt, but
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749 was closed as not=
 a
> bug).
>=20
> Therefore, the use case of doing a mirror job to a v2 image, and having=

> that image become thick even though the source was thin, is happening
> more than we'd like
> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1371749).  While Kevin h=
ad
> a point that in the common case we ALWAYS want to turn an unallocated
> cluster into a zero cluster (so that we don't have to audit whether all=

> callers are properly accounting for the case where a backing image is
> added later), our conversation on IRC today conceded that we may want t=
o
> introduce a new BDRV_REQ_READ_ZERO_NOP (or some such name) that
> particular callers can use to request that if a cluster already reads a=
s
> zeroes, the write zero request does NOT have to change it.  Normal gues=
t
> operations would not use the flag, but mirroring IS a case that would
> use the flag, so that we can end up with thinner mirrors even to 0.10
> images.
>=20
> The other consideration is that on 0.10 images, even if we have to
> allocate, right now our allocation is done by way of failing with
> -ENOTSUP and falling back to the normal pwrite() of explicit zeroes.  I=
t
> may be worth teaching the qcow2 layer to explicitly handle write zeroes=
,
> even on 0.10 images, by allocating a cluster (as needed) but then
> telling bs->file to write zeroes (punching a hole as appropriate) so
> that the file is still thin.  In fact, it matches the fact that we
> already have code that probes whether a qcow2 cluster that reports
> BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID then probes bs->file to see if
> there is a hole there, at which point it can add BDRV_BLOCK_ZERO to the=

> bdrv_get_block_status.
>=20
> I don't know which one of us will tackle patches along these lines, but=

> wanted to at least capture the gist of the IRC conversation in the
> archives for a bit more permanence.

Just short ideas:

(1) I do consider it a bug if v2 images are created. The BZ wasn't
closed for a very good reason, but because nobody answered this question:=


> is this really a problem?

And apparently it is.

(2) There is a way of creating zero clusters on v2 images, but we've
never done it (yet): You create a single data cluster containing zeroes
and then you just point to it whenever you need a zero cluster (until
its refcount overflows, at which point you allocate another cluster).
Maybe that helps.

I'd be really careful with optimizations for v2 images. You have already
proven to me that my fears of too much complexity are out of proportions
sometimes, but still. v2 upstream is old legacy and should be treated as
such, at least IMHO.

Max



--Hk5fH7M1QQx0J658MOvsTH25bMBMSB67w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZFd2WEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMgu
CAC+HFGn5JjM/2Jbaie3OOi5b+8GEZ232hDb/3XhLwBVqmWM32dboYskfVMnSYsD
pvtjqUGgTJrd18KncAJqqbih5qIDbAvwibCv1rGNR+kWoNOqonXSaa+7MAYNYwJu
VYyF7VOXZuxeHdIDhX1by/XzXcpctInHA6+bFHpVGgGr1mMquK63Dkk9PBJTP6AY
OW+VFeIEFaKSFGxNVcWrBg2gxTRr270XR9ht8vmWS4V6ujVqURjNti3qxTxRHVM1
4VoQ7U/auBAhNJY/jBPm06M5isV3+dtlYUPIhzulFQaAZRSBXo9ywzP5s4qi1M6l
/daJ3gJbmV9ajdAFKc5FYtMM
=zeRx
-----END PGP SIGNATURE-----

--Hk5fH7M1QQx0J658MOvsTH25bMBMSB67w--
