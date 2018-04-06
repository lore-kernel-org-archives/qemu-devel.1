Received: from eggs.gnu.org ([2001:4830:134:3::10]:42933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4Voc-0006VP-Fe
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4VoZ-0000cf-At
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:10:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f4VoZ-0000cG-5j
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F4C8406EDAA
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 18:10:15 +0000 (UTC)
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180307151836.GK20201@redhat.com>
	<20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
	<20180308101728.GG4718@redhat.com>
	<f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85d1416c-c442-eaf2-c4a5-3308fd63de3a@redhat.com>
Date: Fri, 6 Apr 2018 13:10:00 -0500
MIME-Version: 1.0
In-Reply-To: <f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FtXNXkNiFtpLyhUe9SSSxSOZYrqXx3m00"
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FtXNXkNiFtpLyhUe9SSSxSOZYrqXx3m00
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 libvir-list@redhat.com
Message-ID: <85d1416c-c442-eaf2-c4a5-3308fd63de3a@redhat.com>
Subject: Re: [RFC] Defining firmware (OVMF, et al) metadata format & file
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
 <20180307151836.GK20201@redhat.com>
 <20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
 <20180308101728.GG4718@redhat.com>
 <f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
In-Reply-To: <f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2018 12:28 PM, Laszlo Ersek wrote:

> I've created an RFC-level "qapi/firmware.json" schema file, based on
> this discussion. It "builds", and the generated documentation looks
> acceptable, superficially speaking.
>=20
> Before I post "qapi/firmware.json" for getting comments, I'd like to
> write JSON text that (a) describes firmware that I use, and (b) conform=
s
> to the schema. IOW, I'd like to validate whether the schema is good
> enough for describing at least such firmware that I know.
>=20
> Is there a tool that generates example JSON objects from a given schema=
?

I know the QMP shell (scripts/qmp/qmp-shell) lets you enter commands
with a lot less typing than full JSON, and has a mode where it will then
echo the full JSON command it constructed from what you typed.  To be
able to quickly validate examples, it may be sufficient to temporarily
add a new QMP command 'check-firmware':

{ 'command': 'check-firmware', 'boxed': true, 'data': 'Firmware' }

assuming 'Firmware' is your top-level 'struct' in the QAPI file, then
implement a trivial:

qmp_check_firmware(Firmware *obj, Error **errp) {
    return 0;
}

so that you can then run QMP shell, and type:

check-firmware arg1=3Dfoo arg2=3Dbar ...

which will then generate the corresponding JSON, then either
successfully do nothing (what you typed validated, AND you have the JSON
output printed), or print an error (what you typed failed QAPI
validation, perhaps because it had an unrecognized key, was missing a
required key, used a wrong type, etc).

> I vaguely recall there used to be one. Otherwise, writing the examples
> manually looks arduous (and I wouldn't know how to verify them against
> the schema).

Similarly, if you generate a command the produces a 'Firmware' as the
return value, then you can populate the generated C struct (since you
did manage to run the QAPI generator over your new file, you should be
able to look at the C struct it generated), then output that over QMP to
show the counterpart JSON that matches the struct as populated.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FtXNXkNiFtpLyhUe9SSSxSOZYrqXx3m00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHt/gACgkQp6FrSiUn
Q2pl8Af/UDlsBtVhD+UCLBpFXj2upYXb6sw7+qe/Ik/XBjrVq6g0ayJKVnp16AGf
jd4hTG465/qzmJglozJeysTCQw0Mo8R4qeO8mNht6f6vAwmOtwST8aZTgIEQgfaf
ra34JrsffV5ljrgEPQYMD9NpYayd8wOGEh02g1JfyXBQ4S2wkunXj4iji4d7YpNL
YEPAzMguuK8+vvu8eXENDGpV4Qb/x2+s9gA/U2+IkftMVgQVp9+DTyby2Dtd5yef
bynJYFQZtjur+Bd7O1X5alXKi8JTx8rj0kKVNFKyjvthStlYK8fBVIWDP8mR5/Xf
QP/PFKAU45hXqX+gp8wCrTP400zjsA==
=+LPp
-----END PGP SIGNATURE-----

--FtXNXkNiFtpLyhUe9SSSxSOZYrqXx3m00--
