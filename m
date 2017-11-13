Received: from eggs.gnu.org ([2001:4830:134:3::10]:38128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEIxA-0007bN-G8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEIx6-0005VY-BH
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:55:24 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0d53b78-d9aa-7aa9-9fa5-8b29d53c1a9b@redhat.com>
Date: Mon, 13 Nov 2017 11:55:13 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3DJ41QM1XfE1W5KXw2LjMOEHMks85ctuI"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3DJ41QM1XfE1W5KXw2LjMOEHMks85ctuI
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <a0d53b78-d9aa-7aa9-9fa5-8b29d53c1a9b@redhat.com>
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
In-Reply-To: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 11:14 AM, Peter Maydell wrote:> I have a qcow v1 file
which I created by mistake (forgetting that
> you need to tell qemu-img create 'qcow2' and not just 'qcow'),
> which I want to convert to a v2 file so I can put snapshots into
> it. But when I try to do this with qemu-img convert it creates a
> v3 file instead:
>
> $ file hda-old.qcow
> hda-old.qcow: QEMU QCOW Image (v1), 5368709120 bytes
> $ build/x86/qemu-img convert -O qcow2 hda-old.qcow hda.qcow2
> $ file hda.qcow2
> hda.qcow2: QEMU QCOW Image (v3), 5368709120 bytes
>
> and if you then try to use that in QEMU it complains:
>
> qemu-system-aarch64: -drive if=3Dnone,file=3Dhda.qcow2,format=3Dqcow,id=
=3Dhd:
> Unsupported qcow version 3
>
> What am I missing here?
qcow2 has two versions; v2 (aka compat=3D0.10), and v3 (aka compat=3D1.1)=
=2E
We changed qemu-img to create v3 by default several years ago, but there
are older qemu binaries (hello, CentOS 6) that still don't understand
v3.  Your qemu-system-aarch64 appears to be one of these older binaries.

Try:
qemu-img convert -O qcow2 -o compat=3D0.10 hda-old.qcow hda.qcow2

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3DJ41QM1XfE1W5KXw2LjMOEHMks85ctuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ3IEACgkQp6FrSiUn
Q2rQrwf/VTeHK+feKJzrUuVsNggEM0H0ptpp3uO5tencCpFCHN5ibi7xupqz16dM
HA7gVZsClIGyl7MP0h0bcj96kZ0CbGRabzfbYj70e6v7NxHvlFDr8rMA1FX5lvqR
j/NGAjRnk+hrBhx1ujt39rRZaGrHc2ttPR5TI74xc75kNkvHJc8a/iRsahPYg9lw
vd4/WLKZgPuvoesn5JwTcD+d+r3z865CMVPPJUlxaISdlSZRGVKkkSbaWZTmXqhP
fSIsYqTdi0nRjDqsDrfroPcd5kysU8wnLCQS76/9MZw3qVEI0zRHSb2bfXh7wgcK
+JgHpr2UTkvxG2qcwwQ8pN/PHKJDyw==
=aK5l
-----END PGP SIGNATURE-----

--3DJ41QM1XfE1W5KXw2LjMOEHMks85ctuI--
