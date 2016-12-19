Received: from eggs.gnu.org ([2001:4830:134:3::10]:46318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJ0BB-0003d1-QU
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJ0B8-0007zr-O9
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:48:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJ0B8-0007zk-F2
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:48:42 -0500
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
	<20161219010743.GA2719@lemon>
	<20161219135529.GE17374@stefanha-x1.localdomain>
	<aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
Date: Mon, 19 Dec 2016 09:48:37 -0600
MIME-Version: 1.0
In-Reply-To: <aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MQiHIUSvuMHD7cBUmblJrIl6NCEJKUS0i"
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Pereira <kripper@imatronix.cl>, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MQiHIUSvuMHD7cBUmblJrIl6NCEJKUS0i
From: Eric Blake <eblake@redhat.com>
To: Christopher Pereira <kripper@imatronix.cl>,
 Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <4fb58e00-63bf-ce50-677d-cec2ed5684a9@redhat.com>
Subject: Re: [Qemu-devel] Can qemu reopen image files?
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
 <20161219010743.GA2719@lemon>
 <20161219135529.GE17374@stefanha-x1.localdomain>
 <aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
In-Reply-To: <aee6f019-7d2f-5b4a-3679-35a909af6d6d@imatronix.cl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2016 09:03 AM, Christopher Pereira wrote:
> Hi Fam, Stefan,
>=20
> Thanks for answering.
>=20
> We use "qemu-img convert" to convert a image in the middle of the chain=
,
> not the active one.
> Those images (and the previous ones in the chain) are read-only and
> there should be no risk in converting them:
>=20
> E.g.: for the following chain:
>=20
>    base --> snap1 ---> snap2 ---> snap3 (active)

We typically write that as:

base <- snap1 <- snap2 <- snap3

where the <- operator can be pronounced "backs", and where the direction
of the arrow shows that it is snap1 that depends on base (and not base
that depends on snap1).

>=20
> we do "qemu-img convert" on snap2 (readonly), generating a snap2' with
> the same content as snap2.

That part is fine, but why not use QMP to let qemu generate a single
file with the same contents, instead of delegating to qemu-img?

>=20
> Then we do the rebase while the VM is suspended to make sure the image
> files are reopened.
>=20
> Please confirm if I'm missing something here.

That part is where you are liable to break things.  Qemu does NOT have a
graceful way to reopen the backing chain, so rebasing snap3 to point to
snap2' behind qemu's back is asking for problems.  Since qemu may be
caching things it has already learned about snap2, you have invalidated
that cached data by making snap3 point to snap2', but have no way to
force qemu to reread the backing chain to start reading from snap2'.

But if you would use qemu block-commit to merge "base <- snap1 <- snap2"
into "base'", then the block-commit command will gracefully take care of
rewriting the backing image of snap3 to now point to base.  You achieve
the same result, but without the need for an external qemu-img call,
without the need to pause the guest, and the only thing you have to be
careful of is dealing with the difference in file names.

Or, if you don't want to merge into "base'", you can use block-stream to
merge the other direction, so that "base <- snap1 <- snap2" is converted
into "snap2'" - but that depends on patches that were only barely added
in qemu 2.8 (intermediate block-commit has existed a lot longer than
intermediate block-stream).  But the point remains that you are still
using qemu to do the work, and therefore with no external qemu-img
process interfering with the chain, you don't need any guest downtime or
any risk of breaking qemu operation by invalidating data it may have cach=
ed.

>=20
> We are not using block-commit since we want to have more control (keep
> the base snapshot unmodified, use compression, etc).

If block-commit and block-stream don't have enough power to do what you
want, then we should patch them to expose that power, rather than
worrying about how to use qemu-img to modify the backing chain behind
qemu's back.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MQiHIUSvuMHD7cBUmblJrIl6NCEJKUS0i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWAFVAAoJEKeha0olJ0NqfgkH/Av95tBSM9H72fcUuoJyAyA5
mDBUtM5VqmLStLwyV7i7KGzjb4UPu+cTKQl9G3co6t2cNUOWMe1oMdEWa2yxpGtp
D7CHeValYJ0KRdWynWfpsIN2fsRZ1lQzpPaA7bhZWKjlhNJjIRMgzxqNR3rAndVe
77yvIKebXPvmgYpbioq4ZRTrrEKixj63a3elI2dYvptaq53FNLjzTbE3xifDC+eg
7uUfRW+/ZQoyQXT2EQ6XqWS5n0DMa23JHYxOUni/Zx2tqPpb5EUp0zZmpY6dNxJd
OUdasbpROowRpea4stO6NcnVpiosk8rgoKLZAjRPW53Wl3yKj38XlRm+Wvhc+uo=
=pf46
-----END PGP SIGNATURE-----

--MQiHIUSvuMHD7cBUmblJrIl6NCEJKUS0i--
