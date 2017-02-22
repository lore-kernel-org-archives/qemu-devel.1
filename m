Received: from eggs.gnu.org ([2001:4830:134:3::10]:40159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgW5a-0005SB-Hk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgW5Z-00084M-G7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:32:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgW5Z-00083w-8O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:32:09 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
	<9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
	<f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
Date: Wed, 22 Feb 2017 06:32:05 -0600
MIME-Version: 1.0
In-Reply-To: <f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4laa5giTwg5ar2CXFlLII8G6iIcKX5iqD"
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Christian Theune <ct@flyingcircus.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4laa5giTwg5ar2CXFlLII8G6iIcKX5iqD
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Christian Theune <ct@flyingcircus.io>
Message-ID: <c207e00d-25a6-45bb-a849-235d0cd2be0d@redhat.com>
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
 <9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
 <f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
In-Reply-To: <f0eb7ff1-47d7-42d0-c7b5-946d2224e986@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 02:45 AM, Peter Lieven wrote:
>> A bit outdated now, but:
>> http://wiki.qemu-project.org/Features/IncrementalBackup
>>
>> and also a summary I wrote not too far back (PDF):
>> https://drive.google.com/file/d/0B3CFr1TuHydWalVJaEdPaE5PbFE
>>
>> and I'm sure the Virtuozzo developers could chime in on this subject,
>> but basically we do have something similar in the works, as eblake say=
s.
>=20
> Hi John, Hi Erik,

It's Eric, but you're not the first to make that typo :)

>=20
> thanks for your feedback. Are you both the ones working primary on this=
 topic?
> If there is anything to review or help needed, please let me know.
>=20
> My 2 cents:
> I thing I had in mind if there is no image fleecing available, but fetc=
hing the dirty bitmap
> from external would be a feauture to put a write lock on a block device=
=2E

The whole idea is to use a dirty bitmap coupled with image fleecing,
where the point-in-time of the image fleecing is done at a window where
the guest I/O is quiescent in order to get a stable fleecing point.  We
already support write locks (guest quiesence) using qga to do fsfreeze.
You want the time that guest I/O is frozen to be as small as possible
(in particular, the Windows implementation of quiescence will fail if
you hold things frozen for more than a couple of seconds).

Right now, the qcow2 image format does not track write generations, and
I don't think we plan on adding that directly into qcow2.  However, you
can externally simulate write generations by keeping track of how many
image fleecing points you have created (each fleecing point is another
write generation).


> In this case something like this via QMP (and external software) should=
 work:
> ---8<---
>  gen =3D  write generation of last backup (or 0 for full backup)
>  do {
>      nextgen =3D fetch current write generation (via QMP)
>      dirtymap =3D send all block whose write generation is greater than=
 'gen' (via QMP)

No, we are NOT going to send dirty information via QMP.  Rather, we are
going to send it via NBD's extension NBD_CMD_BLOCK_STATUS.  The idea is
that a client connects and asks which qemu blocks are dirty, then uses
that information to read only the dirty blocks.

>      dirtycnt =3D 0
>      foreach block in dirtymap {
>                copy to backup via external software
>                dirtycnt++
>      }
>      gen =3D nextgen
>  } while (dirtycnt < X)         <--- to achieve this a thorttling or si=
milar might be needed
>=20
> fsfreeze (optional)
> write lock (via QMP)
> backupgen =3D fetch current write generation (via QMP)
> dirtymap =3D send all block whose write generation is greater than 'gen=
' (via QMP)
> foreach block in dirtymap {
>                copy to backup via external software
> }
> unlock (via QMP)
> fsthaw (optional)
> --->8---

That is too long for the guest to be frozen.  Rather, the flow is more li=
ke:

set up bitmap0 to track all writes since last point in time
fsfreeze (optional)
transaction to pivot to new bitmap1 (effectively freezing bitmap0 as the
point in time we are interested in)
fsthaw
connect via NBD with a request to view the data at the bitmap0 point in
time - read the bitmap, then read the sectors that the bitmap says are di=
rty
clean up bitmap0 (qemu can finally delete any point-in-time sectors that
were copied off due to any writes after the thaw)

> As far as I understand CBT in VMware is not just only a dirty bitmap, b=
ut also a write generation tracking for blocks (size 64kb or whatever)

Write generation is a matter of tracking which bitmaps and points in
time you fleeced from.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4laa5giTwg5ar2CXFlLII8G6iIcKX5iqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrYTFAAoJEKeha0olJ0Nq5cUIAIzCSx1Eh6yEfOgyzMRo4ZEM
2ZFZPCIRRTXJMHW+W9IKA3DqXPrLnv0kXgG6WOqx2N4hzjJPhxCgh5E/dx7i4x2k
MmC4ya7QW5OW1cb0UnQhaoFdZ07lbJFTI+nNTobgnAaujERpUs9qvliBjK1dKsn1
5g4uCwaNrVmAuM8P/41smrs3ThJNnldVmTxWKKcMM+3wN7KQyIiK0LqI83O+Ht4X
FE8Zq4Q9orEXpDOMShTc1hQoYlykeKXgP4LbmTSdUXXliecwljjgC2euaSvJnSGM
HcLObXbX7EpZpiMgvn7aAB/EoGYCvKY7RyqRAJFai9FlLzVNyBULPU7LPOoVmr4=
=nN/E
-----END PGP SIGNATURE-----

--4laa5giTwg5ar2CXFlLII8G6iIcKX5iqD--
