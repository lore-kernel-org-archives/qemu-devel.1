Received: from eggs.gnu.org ([2001:4830:134:3::10]:45300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBcjR-0004Vs-Cd
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBcjQ-0007Zr-2x
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:58:25 -0400
Date: Thu, 26 Apr 2018 10:58:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180426085803.GA8883@localhost.localdomain>
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-4-mreitz@redhat.com>
	<5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
	<377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
	<ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.04.2018 um 04:12 hat Eric Blake geschrieben:
> On 04/25/2018 10:08 AM, Max Reitz wrote:
>=20
> >=20
> >> Also, that does raise the question of whether you have more work to
> >> support write-zero requests with WRITE_UNCHANGED (which indeed sounds
> >> like something plausible to support).
> >=20
> > I'm afraid I don't quite understand the question.
> > BDRV_REQ_WRITE_UNCHANGED support is usually rather simple because as
> > said above it is only needed by drivers that rely on their parent to
> > request the permissions, i.e. filter drivers.  Since filter drivers just
> > forward the requests, all they have to do is retain the
> > BDRV_REQ_WRITE_UNCHANGED flag, be it a zero write or a normal write.
>=20
> I'm trying to figure out if BDRV_REQ_WRITE_UNCHANGED makes sense for
> bdrv_co_pwrite_zeroes as well as bdrv_co_pwrite. I think the answer is
> yes (if we know the guest already reads zeroes, but need to write to the
> protocol layer anyways because of a commit operation, then mixing both
> BDRV_REQ_WRITE_UNCHANGED and BDRV_REQ_ZERO_WRITE to the block layer
> makes sense, and supported_zero_flags should indeed pass
> BDRV_REQ_WRITE_UNCHANGED on to a driver.

Yes, that makes sense to me. (Except that commit isn't WRITE_UNCHANGED,
but streaming is.)

> > It would be more complicated for format drivers, because they would have
> > to verify that the incoming unchanged write actually ends up as an
> > unchanged write in their file.  But we have already recognized that that
> > would be too much to ask and that format drivers may want to generally
> > just write anything to their child if it's writable (even regardless of
> > whether the grandparent issues writes to the format driver node), so
> > they always grab a WRITE permission on their file if possible.
> > Therefore, they do not have to support this request flag.
>=20
> So qcow2 doesn't have to support the flag, but file-posix.c might want
> to.  Or are you saying that only filter drivers need to advertise
> support for the flag?

Essentially a caller of bdrv_co_pwritev() must pass the flag if it wants
to write to a child for which it doesn't have BLK_PERM_WRITE.

This is potentially true for filter drivers if their parent does the
same (because we don't let filter drivers take BLK_PERM_WRITE
unconditionally, but only if one of their parents requests it on the
filter node).

In order to be able to rightfully set BDRV_REQ_WRITE_UNCHANGED for its
own requests, however, the child node must make sure that the parent
request it is processing already had the flag, i.e. it must support
BDRV_REQ_WRITE_UNCHANGED.

In contrast, qcow2 and other format drivers never need to send
BDRV_REQ_WRITE_UNCHANGED requests to their children (because they always
take BLK_PERM_WRITE for writable images anyway), so they don't have a
use for the flag and therefore don't need to advertise support for it.

This means that after putting a filter driver between a node and its
read-only (or write-unchanged-only, to be precise) parent, that node may
still be shared with users that don't tolerate a writer, but putting a
format driver above it will fail while that other user is still
attached. This is the expected behaviour.

(And if you think about it, there is no reason for format drivers to
ever send a write unchanged request: Something like image streaming is
about the backing chain and doesn't exist for the file child. So if the
content really doesn't change, the format driver just shouldn't send the
request at all.)

Kevin

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa4ZSbAAoJEH8JsnLIjy/W1hwQAMcGX/0c7Ov/R4QJv1L7fdIT
mTjnR/ACzdtqN1PduPVqh/Fyb5l5mTBlyPs3fUxuQBRdRgECtF8+B062ine9FAf1
Let+5qxS186ZmgiI33G+MKFrV7eqFTMpjEWR225fWVAKGKPrRMYWxPlaxScU8mhf
Dm9BQMlCiFdyOFCGPZYQOtwqWI+v8SYcmu9pIXJlxXyb4qWfN1qOceZ1WqRAJn5G
rtDvTOEKs2voWkvxDS6jbrd64Cg/X4LGXIHeoe84si2zoXTsD2vvGrb4gKRmCW+c
iG76el2cZHE/ptV1SOcBKVwvUkBTF8bYJO3Hci2oMfmMdUV4lOfVoRLdtB/vCCdm
yI825fTmgcJop5MGmNSvfQfi4yZnQU2OxMC37dXKEoAmJQKnSyZVpr+EkeityQB4
WhieZLCJ5EJBbYEhN9etyevOsQoQp/VnDJsEXSF+SYaF6g3fZsCv+OgINnn45SeC
strWuoIMOhf+Cv+/mSbM4BQRxM9ux8AjT90JLjuL87xmoBXMOrPdpROljL22QxGz
75rudrowrJgcV6/JrcuCbRAknUixyGTUGSeJdOJEx2fRw2VsECsc3POj+Aq04HzJ
0H3jqCeigkSOxllyHJBOTdxR3giZJQv9GBGewkLrEHgeF1qsTLl26fhDElPhFIJN
/eR3lepfjA43HIyoVcjy
=Ua35
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
