Received: from eggs.gnu.org ([2001:4830:134:3::10]:55898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyG6K-0005AA-1w
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyG6I-0003bB-AW
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:43:03 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-5-mreitz@redhat.com>
	<w5136uot46b.fsf@maestria.local.igalia.com>
	<3ed9672d-12ba-1a89-e960-617e779bcba9@redhat.com>
	<w51o9d9ij92.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fa35bb97-0354-58d9-d752-5d8ca3f56b93@redhat.com>
Date: Fri, 7 Sep 2018 14:42:53 +0200
MIME-Version: 1.0
In-Reply-To: <w51o9d9ij92.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yIBKkE97YYNtT9Fi35JLlfkmWYf0G3aKL"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 04/31] block: Add
 BDS.auto_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yIBKkE97YYNtT9Fi35JLlfkmWYf0G3aKL
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <fa35bb97-0354-58d9-d752-5d8ca3f56b93@redhat.com>
Subject: Re: [PATCH for-3.1 v10 04/31] block: Add BDS.auto_backing_file
References: <20180809213528.14738-1-mreitz@redhat.com>
 <20180809213528.14738-5-mreitz@redhat.com>
 <w5136uot46b.fsf@maestria.local.igalia.com>
 <3ed9672d-12ba-1a89-e960-617e779bcba9@redhat.com>
 <w51o9d9ij92.fsf@maestria.local.igalia.com>
In-Reply-To: <w51o9d9ij92.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-07 14:28, Alberto Garcia wrote:
> On Fri 07 Sep 2018 01:32:58 PM CEST, Max Reitz wrote:
>> On 2018-09-05 16:22, Alberto Garcia wrote:
>>> On Thu 09 Aug 2018 11:35:01 PM CEST, Max Reitz wrote:
>>>> If the backing file is overridden, this most probably does change th=
e
>>>> guest-visible data of a BDS.  Therefore, we will need to consider th=
is
>>>> in bdrv_refresh_filename().
>>>>
>>>> To see whether it has been overridden, we might want to compare
>>>> bs->backing_file and bs->backing->bs->filename.  However,
>>>> bs->backing_file is changed by bdrv_set_backing_hd() (which is just =
used
>>>> to change the backing child at runtime, without modifying the image
>>>> header), so bs->backing_file most of the time simply contains a copy=
 of
>>>> bs->backing->bs->filename anyway, so it is useless for such a
>>>> comparison.
>>>
>>> What's the point of bs->backing_file then? In what cases is it differ=
ent
>>> from backing->bs->filename?
>>
>> Good question!  Yes, why?
>>
>> One thing is when you have detached the backing file, bs->backing_file=

>> will stay the same, even though backing is now NULL.  But that is
>> pretty much useless, I couldn't find any part in the block layer which=

>> relies on this.
>   [...]
>> But when the backing BDS is attached, bdrv_set_backing_hd() (through
>> bdrv_backing_attach()) will update backing_file to "foo/base.qcow2"
>> (or probably the absolute equivalent, I can't remember).
>=20
> But then why do you need bs->backing_file at all? What are the cases
> where you need bs->backing_file but you can't use directly the value in=

> bs->backing->bs->filename because it's wrong or missing?

The main case is when bs->backing has not been opened yet.  Then
bdrv_open_backing_file() needs some place that tells it what image file
to open.

>> So consequentially, there is a "block: Leave BDS.backing_file
>> constant" patch in my "block: Deal with filters" series.  It makes
>> backing_file always report what the image header says.
>=20
> Ok, so after tha patch bs->backing_file is guaranteed to be exactly as
> it's written on the image header.

Yes.

> And bs->auto_backing_file is the backing filename after having called
> bdrv_refresh_filename(). And that's supposed to be exactly the same as
> bs->backing->bs->filename.

No.

It's supposed to be exactly the same, *if* bs->backing->bs has been
opened only based on bs->backing_file.

The user can override the backing file (either as a whole through the
@backing node reference, or at least some of its options as a dict under
@backing), and then bs->auto_backing_filename is not supposed to be the
same as bs->backing->bs->filename.

> So I have the same question again, why do you
> need bs->auto_backing_filename and in what cases is it different from
> bs->auto_backing_file different from bs->backing->bs->filename?

The whole purpose of bs->auto_backing_file is so you can compare it with
bs->backing->bs->filename, see when it differs, and then you know that
the user has changed the backing file from what it would be based on the
image header alone (that is, if the user hadn't specified any @backing
option at all).

This is exactly what the commit message says.


It's just that for this comparison to really make sense, we would need
the refreshed filename of the BDS that is opened when you just take the
image header's backing filename.
If we know that the user has not specified any options that override it,
we copy bs->backing->bs->filename to bs->auto_backing_filename, because
we know it to be exactly that value that we want.
Otherwise, we just have to hope that refreshing the filename does not
change it from what the image header said.

(Now you could ask yourself, if we know the user hasn't specified any
options to override the backing file -- why don't we just store a flag?
I tried that, Kevin wasn't really happy about it because it's hard to
catch all corner cases.  There are many ways to change a backing file,
and if you want to find out when a backing file has been changed to
exactly what the image header says (this is the ideal outcome of the
commit block job, for instance), you basically get back to the same
problem of comparing filenames.)


Let me try to summarize what bs->auto_backing_filename is again.

We want to compare it against bs->backing->bs->filename, which is
basically bdrv_filename(bdrv_open(X)).  Question is, is X the same as
bs->backing_file?  (assuming bs->backing_file is what the image header sa=
ys)

So ideally, bs->auto_backing_filename needs to be the result of
bdrv_filename(bdrv_open(bs->backing_file)).  But that is rather stupid
to do, so we don't do that.

The next best thing is just using bs->backing_file and hoping that
bdrv_refresh_filename() didn't change anything.  Sometimes, that hope is
futile, however.

So I try to get bdrv_refresh_filename() squeezed in there sometimes.
When at any point we know that bs->backing->bs is exactly
bdrv_open(bs->backing_file), we know that bs->backing->bs->filename is
bdrv_filename(bdrv_open(bs->backing_file)).  So then we can copy it into
bs->auto_backing_file -- *but only if we know that bs->backing->bs =3D=3D=

bdrv_open(bs->backing_file)!*

Max


--yIBKkE97YYNtT9Fi35JLlfkmWYf0G3aKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluSck0ACgkQ9AfbAGHV
z0BOywf+LLTxe8xZT26UGFWiYCNzaO53wa47kb75heahggk1QZQ7b1vYWSmKneTm
xKIWfymPYiul4C1LuDTaYD0lWugxRPoPXL5bQnDd4vvlQptCDF60jpUP156+FIOG
550gQ2yyXiv0VXGz4LQGV6CQ/o2Chkq0NC0ZvGqe26iUP4gz1+V/ef4DWBate8VU
FXokwaH0I8rbJwBqJ14si2Jq0ge7eA5rMo5076oKsuLAfPau9mwCOfzCbTaZd1F6
TwQwVA2UcH9l/YXZXWDq+unEvoqFLMMJZAcvY2HQDDYnvwZN+CdqAl3355nOQk6r
JGIDAsMOVc/gs/d3HDROo7Zd8f/68Q==
=trFM
-----END PGP SIGNATURE-----

--yIBKkE97YYNtT9Fi35JLlfkmWYf0G3aKL--
