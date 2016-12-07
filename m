Received: from eggs.gnu.org ([2001:4830:134:3::10]:45289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEeUu-0006ll-71
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEeUo-0002P2-Hf
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:51:08 -0500
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161206092523.GA4990@noname.str.redhat.com>
	<871488c7-b870-da8f-1a71-c2462214e650@redhat.com>
	<20161207104425.GC4773@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12602b60-df5f-b365-c34a-80c37610a1fc@redhat.com>
Date: Wed, 7 Dec 2016 09:50:51 -0600
MIME-Version: 1.0
In-Reply-To: <20161207104425.GC4773@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mxCbKlptsXfaMFH2k6bMbDbuONPpjQj9g"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mxCbKlptsXfaMFH2k6bMbDbuONPpjQj9g
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com,
 subo7@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <12602b60-df5f-b365-c34a-80c37610a1fc@redhat.com>
Subject: Re: [Qemu-block] [PATCH] doc: Propose NBD_FLAG_INIT_ZEROES extension
References: <20161205234235.5728-1-eblake@redhat.com>
 <20161206092523.GA4990@noname.str.redhat.com>
 <871488c7-b870-da8f-1a71-c2462214e650@redhat.com>
 <20161207104425.GC4773@noname.str.redhat.com>
In-Reply-To: <20161207104425.GC4773@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 04:44 AM, Kevin Wolf wrote:
>> Just because the NBD spec describes the bit does NOT require that
>> servers HAVE to set the bit on all images that are all zeroes.  It is
>> perfectly compliant if the server never advertises the bit.
>=20
> True, but if no server exists that would actually make use of the
> feature, it's kind of useless to include it in the spec.

No server, or no client?  I think qemu can be a client fairly easily: if
the server advertises the bit, then the client can set
=2Ebdrv_has_zero_init() and avoid rewriting any sector of a file that is
already known to be zero.

>=20
> I think we should have concrete use cases in mind when extending the
> spec, and explain them in the commit message. Just "maybe this could be=

> useful for someone sometime" isn't a good enough justification if you
> ask me.

But I think we DO have a concrete case already in mind, both of a client
being able to take advantage of the information if the bit is set, and
of servers that are able to set the bit because they can either
efficiently determine that the file is all-zeroes, or can give the user
a flag to advertise the bit.

>=20
> qemu doesn't really know whether an image has been written to since it
> has been created.

It's not so much whether the image has been written to, as much as
easily proving that the image reads as all zeroes.

> The interesting case is probably where the image is
> created externally with qemu-img before it's exported either with
> qemu-nbd or the builtin server, and then we use it as a mirror target.
>=20
> Even in the rare cases where both image creation and the NBD server are=

> in the same process, bdrv_create() doesn't work on a BlockDriverState,
> but just on a filename. So even then you would have to do hacks like
> remembering file names between create and the first open or something
> like that.

Or add in a driver-specific callback that checks if a file is provably
all-zeroes; for the raw file driver, check if lseek(SEEK_DATA) finds
nothing, for the qcow2 driver, check for no backing files, and no L1
table entries.

>> Another option on the NBD server side is to create a server option -
>> when firing up a server to serve a particular file as an export, the
>> user can explicitly tell the server to advertise the bit because the
>> user has side knowledge that the file was just created (and then the
>> burden of misbehavior is on the user if they mistakenly request the
>> advertisement when it is not true).
>=20
> Maybe that's the only practical approach.

But it's still a viable approach, and therefore this bit definition in
the NBD protocol is worthwhile.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--mxCbKlptsXfaMFH2k6bMbDbuONPpjQj9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSC/bAAoJEKeha0olJ0Nqo8MH/2RqxqQYgecEhKAGCu8bp8SX
fxuOx1a/D6tfJNPFVT4h1sCi78nFUnPsihZuXTFIUsXuFLr595xELnbR3W+Im/of
PRwphmYn9knpbQZBSSIsERIwhktJTK8WzbW2IY3wnr8gH+TJcVps6CQzjtTksWb3
EZF3zP9USGU6FsetrrGDfJ7LlfDOLwHq95OQsgL8+ffj788+NaUaZNu/tnRmu/sk
KZ5PmUzYky+EaZy0B93Wx+CCR5fN6rMHMv+gQQ51+ZfR4FlRPoSfUa/SFWKIw0Xu
jK25Gga88FZKqWUK6sf8aQjsx91Xv73+kh/tdYjY6xS+ItKhmMhafeeSWy0miuc=
=V+f2
-----END PGP SIGNATURE-----

--mxCbKlptsXfaMFH2k6bMbDbuONPpjQj9g--
