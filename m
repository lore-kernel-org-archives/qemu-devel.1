Received: from eggs.gnu.org ([2001:4830:134:3::10]:41052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPfNY-0006aB-N5
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPfNV-0002eF-Jy
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPfNV-0002e3-B8
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:33:17 -0400
References: <20170623164557.11636-1-f4bug@amsat.org>
	<20170623164557.11636-4-f4bug@amsat.org>
	<20170623192500.GC3038@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05b3e29e-6b5a-9834-c638-6beb2f13cf83@redhat.com>
Date: Mon, 26 Jun 2017 20:33:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170623192500.GC3038@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FAsig8eNeltsxD1uCcaWbC73tIiqPBIba"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/core: report an error if invalid
 gpio is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FAsig8eNeltsxD1uCcaWbC73tIiqPBIba
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Message-ID: <05b3e29e-6b5a-9834-c638-6beb2f13cf83@redhat.com>
Subject: Re: [PATCH 3/3] hw/core: report an error if invalid gpio is used
References: <20170623164557.11636-1-f4bug@amsat.org>
 <20170623164557.11636-4-f4bug@amsat.org>
 <20170623192500.GC3038@localhost.localdomain>
In-Reply-To: <20170623192500.GC3038@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2017 02:25 PM, Eduardo Habkost wrote:
> On Fri, Jun 23, 2017 at 01:45:57PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> then abort calling error_setg()
>=20
> I don't understand the reasons for this.  This commit message says
> "what" and "how", but not "why".
>=20

>> -    assert(n >=3D 0 && n < gpio_list->num_in);
>> +    assert(n >=3D 0);
>> +    if (n >=3D gpio_list->num_in) {
>> +        error_setg(&error_abort, "Invalid gpio #%d (of %d) for %s",
>> +                   n, gpio_list->num_in, name ? name : "device");
>=20
> Why exactly assert() is ok for (n < 0), but not for
> (n >=3D gpio_list->num_io)?
>=20
> If you have reasons to believe (n >=3D gpio_list->num_in) can be trigge=
red
> by user input, then abort() isn't an appropriate way to handle it.

What's more, error_setg(&error_abort) should not be used.  Yes, a quick
grep for 'error_setg.*error_abort' shows that we have a couple of bad
examples in the tree that should be patched, but it also finds that
include/qapi/error.h states:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
 * Likewise, don't error_setg(&error_abort, ...), use assert().

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FAsig8eNeltsxD1uCcaWbC73tIiqPBIba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUbXVAAoJEKeha0olJ0NqTsMH/jaBko8Q5YkMfBuc8bXrxXnW
gpc+izYDSAh9z6GLKDCYUKe2FPh2rW0nI4qcIo6NM8BMjRMPMg20wzz+KRDT4X9f
AeDpzryafojKj5VB9PO43UK1yRqYMTqONLNekW4vUrFCnF3BTW5BoiES/JPyX+Dx
ibC6huXbBXWqPiFPcuoH3/6+svqtl0kvHN+L2iN15DpIQ5k1ZjdkhZZyiukHMtxC
GxaISypLqNDg0Wa4n4GhkdSmfgRpEzqKvC4Jy+RgisGAv6C3Kpntf4KIGgTt6zIV
yJsiOxTRyJvxubv+RshbNz2c1tbWV0FnsfOU1q9DiHzxhzlDeW7UBjMpjAjPLpQ=
=mp8m
-----END PGP SIGNATURE-----

--FAsig8eNeltsxD1uCcaWbC73tIiqPBIba--
