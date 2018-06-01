Received: from eggs.gnu.org ([2001:4830:134:3::10]:59044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOkLy-00075z-R0
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOkLt-0002aZ-RN
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:44:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fOkLt-0002aD-LA
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:44:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E868A814F0B6
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 13:44:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
Message-ID: <e84c3fc3-9ebd-e1e9-2960-1c0fc2af4599@redhat.com>
Date: Fri, 1 Jun 2018 15:44:17 +0200
MIME-Version: 1.0
In-Reply-To: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3HQKOJ5yFm9ZtIyJvfCrQaIG4Hhe4eHae"
Subject: Re: [Qemu-devel] Preconfig state reachable without --preconfig given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3HQKOJ5yFm9ZtIyJvfCrQaIG4Hhe4eHae
From: Max Reitz <mreitz@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <e84c3fc3-9ebd-e1e9-2960-1c0fc2af4599@redhat.com>
Subject: Re: Preconfig state reachable without --preconfig given
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
In-Reply-To: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-01 15:28, Max Reitz wrote:
> Hi,
>=20
> The @preconfig RunState documentation states:
>=20
>> The state is reachable only if the --preconfig CLI option is used.
>=20
> However, this is not true:
>=20
> $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu)
> HMP not available in preconfig state, use QMP instead

Another issue that has been introduced by commit
047f7038f586d2150f16c6d9ba9cfd0479f0f6ac is this:

$ echo quit | x86_64-softmmu/qemu-system-x86_64 \
    -drive file=3D/dev/null,if=3Dide,readonly=3Don -monitor stdio
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) qqemu-system-x86_64: Initialization of device ide-hd failed:
Block node is read-only

Or:

$ echo foo | x86_64-softmmu/qemu-system-x86_64 \
    -drive file=3D/dev/null,if=3Dide,readonly=3Don -monitor stdio
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) fqemu-system-x86_64: Initialization of device ide-hd failed:
Block node is read-only

So the first character of the next command is printed before the error
message.  First, this is a change in behavior, and secondly, it seems
weird that the monitor accepts a single character before the command
line is fully interpreted.

(I suspect this is also the reason why the "HMP not available..."
message does not appear when you actually execute any command, because
processing anything more than a single character is held off until after
the runstate transition.)

Max


--3HQKOJ5yFm9ZtIyJvfCrQaIG4Hhe4eHae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRTbEACgkQ9AfbAGHV
z0AV/AgAnGyENzGN4PF47d7ODXKtH6jtmMgQ4NCPQT0POg5ZXnVVir2vAGcvks1H
EBueOnTlkz1/08XvSOuF7F67cfdipCx5RmaMoGqm/QdmxjT3Rbcj2tEZSjRj/nJ3
20yuXW2pl+boNe1CcjP8iQZYD9Hcyng9xZuzk0U/8EkV0akJ/WpillBySu2pr332
ajFSJFhB+QsLfNFpRR07GDxDJbXYhQavX1+D7wJqte3Lh7jQCshRid3tTXAu66j1
pi9lonXGbLKZO4pke9053j9BRM6YwgRRvSOjhrrngzn4+KfhHz4UbCFeF03KqvgL
gBP5ePzAh+luTfVXZTU0Fa0oY+lAzg==
=qfau
-----END PGP SIGNATURE-----

--3HQKOJ5yFm9ZtIyJvfCrQaIG4Hhe4eHae--
