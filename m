Received: from eggs.gnu.org ([2001:4830:134:3::10]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeQXR-0002eP-SP
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeQXQ-0003Ij-Qs
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:16:49 -0500
References: <20180124061728.GA99621@localhost>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
Date: Wed, 24 Jan 2018 13:16:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180124061728.GA99621@localhost>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8JSZWCDxoEr6jLdhSY72H53E1dz8UPaAf"
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM
 has heavy BLK IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8JSZWCDxoEr6jLdhSY72H53E1dz8UPaAf
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM has
 heavy BLK IO
References: <20180124061728.GA99621@localhost>
In-Reply-To: <20180124061728.GA99621@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 12:17 AM, Liang Li wrote:
> We found that when doing drive mirror to a low speed shared storage,
> if there was heavy BLK IO write workload in VM after the 'ready' event,=

> drive mirror block job can't be canceled immediately, it would keep
> running until the heavy BLK IO workload stopped in the VM. This patch
> fixed this issue.

I think you are breaking semantics here.  Libvirt relies on
'block-job-cancel' after the 'ready' event to be a clean point-in-time
snapshot, but that is only possible if there is no out-of-order pending
I/O at the time the action takes place.  Breaking in the middle of the
loop, without using bdrv_drain(), risks leaving an inconsistent copy of
data in the mirror not corresponding to any point-in-time on the source.

There's ongoing work on adding async mirroring; this may be a better
solution to the issue you are seeing.

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05419.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8JSZWCDxoEr6jLdhSY72H53E1dz8UPaAf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpo25cACgkQp6FrSiUn
Q2qu2wf+Ml/vjeYEbLYSKwgJWJVeBWzjYIeefl3R1sjrkfEnbgqEGhV97TMwn4Gh
FadCXg3DYChErBki8rwwYtxHs1EbD+7uh9FNRhR61R0FS4V36FQTX778pf6IDGz5
uRQDQh59+9C4TE+bra1x4OtZBrEk/jmyVpnLs61w4VHdETv/3Scb8d2se7CVskCc
W2xFTb3t9x9iypXRIPEM74PHDt0kwcuyjNuvJgK0GlZgIciwI1akGSNwNA+C7LVI
roq2m5uLeY1St9Q/AsAi+HzrQSGdAinWR7thq3eneHh0UXqsjDdeOeHZtzbBqBBB
wejFwNfbf1HJEgRF/bTtxMkFJdudVQ==
=GFsQ
-----END PGP SIGNATURE-----

--8JSZWCDxoEr6jLdhSY72H53E1dz8UPaAf--
