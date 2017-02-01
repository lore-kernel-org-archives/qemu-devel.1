Received: from eggs.gnu.org ([2001:4830:134:3::10]:58010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYw8H-0004S7-6x
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYw8E-00020A-JI
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:43:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYw8E-0001zy-Ad
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:43:34 -0500
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
	<20170201102013.GC3232@redhat.com>
	<CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
	<20170201110320.GD3232@redhat.com>
	<CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15e45a8d-852e-97da-65c5-3f69258dd59b@redhat.com>
Date: Wed, 1 Feb 2017 08:43:28 -0600
MIME-Version: 1.0
In-Reply-To: <CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xQqFh1T0Di0TqS2HM5DnsxkiF9tcx4MJG"
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xQqFh1T0Di0TqS2HM5DnsxkiF9tcx4MJG
From: Eric Blake <eblake@redhat.com>
To: Ladi Prosek <lprosek@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com
Message-ID: <15e45a8d-852e-97da-65c5-3f69258dd59b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
 <20170201102013.GC3232@redhat.com>
 <CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
 <20170201110320.GD3232@redhat.com>
 <CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
In-Reply-To: <CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2017 07:41 AM, Ladi Prosek wrote:

>=20
> Ok, so there are two different aspects that should probably be
> separated. The actual semantics of IOCTL calls is equivalent to the
> semantics of files in general. For files it's stream in, stream out
> (and seeking and such). For IOCTL it's a buffer in, buffer out (and a
> return code). The content is file specific, IOCTL code specific,
> whatever. Definitely not guest agent's business to interpret it. Here
> I think my analogy holds.

I don't.  ioctl() is a leaky abstraction - it exists as the blanket
catch-all do-anything-else-that-doesn't-have-a-dedicated-API.  It is, by
its very nature, non-portable and VERY hard to abstract - because there
is no one abstraction for every possible ioctl code.  I strongly agree
with Dan here that you are going to get nowhere by adding a qga-ioctl
command, because there is no SANE way that you can specify it in QAPI.
Rather, add specific commands for the specific actions you want to
expose, and if the implementation of those specific commands uses a
particular ioctl() under the hood, fine.  But don't directly expose
ioctl() over the wire.


>> It would be possible to design a ioctl API that is more usable if you
>> didn't try to do generic passthrough of arbitrary ioctl commands. Inst=
ead
>> provide a QAPI schema that uses a union to provide strongly typed argu=
ments
>> for the ioctl commands you care about using. Or completely separate QA=
PI
>> commands instead of multiplexing everything into an ioctl command.
>=20
> I can add a QAPI command for my specific use case if it's acceptable,

Certainly more palatable, and more likely to gain my acceptance.

> that's not a problem. Although at that point I would probably just go
> back to my plan b and use regular file I/O and guest-file-read. I just
> wanted to be as generic as possible to benefit other use cases as well
> and I ended up with what's basically my stab at RPC ioctl.

The problem is that RPC ioctl is not sanely possible.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xQqFh1T0Di0TqS2HM5DnsxkiF9tcx4MJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkfQQAAoJEKeha0olJ0Nqsr0H/2/uaMTfux789n4amk3iool0
3p9YCJAgAnsltbDj9+/Ay5TPSWviBXOswbiCChIK7gBlii+oyz4FH93FwDwiFHKa
eYTgaoK2BeeAnOahenbN19K+yMV0DtD8YVbzkDXZpEHcmucrmh2Y3w80FgjYsxKy
CR9R7dMI2yYxo3HlZF6egozvluHDn6eR9IgT8T4ZshLfPSnQM4SPIaJmJ3nWOdcd
uPT2C965u3nLtqD+tdAfD9tRfSSzTqmb5ympNJQLvms/T7WpKrplKf1PE02gDCnl
lD0X1Ov5bVmU2lmZGEzCG8YoutMIWhg6j8/LmXpaGiwoEntr0ctcCWfGGzBWBxs=
=NVnG
-----END PGP SIGNATURE-----

--xQqFh1T0Di0TqS2HM5DnsxkiF9tcx4MJG--
