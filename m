Received: from eggs.gnu.org ([209.51.188.92]:35185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hB3ew-0006Li-Jb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hB3ev-0004ZK-6e
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:35:58 -0400
References: <20190329042750.14704-1-eblake@redhat.com>
	<20190330165349.32256-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <894946e6-eb9a-3466-de69-d99057ea394c@redhat.com>
Date: Mon, 1 Apr 2019 15:35:44 -0500
MIME-Version: 1.0
In-Reply-To: <20190330165349.32256-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AyEntWgLAO1D5246AZiFNX9A8T1shg0DC"
Subject: Re: [Qemu-devel] [PATCH v3 6.5/6] nbd/client: Trace server
 noncompliance on structured reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AyEntWgLAO1D5246AZiFNX9A8T1shg0DC
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>,
 jsnow@redhat.com
Message-ID: <894946e6-eb9a-3466-de69-d99057ea394c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6.5/6] nbd/client: Trace server
 noncompliance on structured reads
References: <20190329042750.14704-1-eblake@redhat.com>
 <20190330165349.32256-1-eblake@redhat.com>
In-Reply-To: <20190330165349.32256-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/30/19 11:53 AM, Eric Blake wrote:
> Just as we recently added a trace for a server sending block status
> that doesn't match the server's advertised minimum block alignment,
> let's do the same for read chunks.  But since qemu 3.1 is such a
> server (because it advertised 512-byte alignment, but when serving a
> file that ends in data but is not sector-aligned, NBD_CMD_READ would
> detect a mid-sector change between data and hole at EOF and the
> resulting read chunks are unaligned), we don't want to change our
> behavior of otherwise tolerating unaligned reads.
>=20
> Note that even though we fixed the server for 4.0 to advertise an
> actual block alignment (which gets rid of the unaligned reads at EOF
> for posix files), we can still trigger it via other means:
>=20
> $ qemu-nbd --image-opts driver=3Dblkdebug,align=3D512,image.driver=3Dfi=
le,image.filename=3D/path/to/non-aligned-file
>=20
> Arguably, that is a bug in the blkdebug block status function, for
> leaking a block status that is not aligned. It may also be possible to
> observe issues with a backing layer with smaller alignment than the
> active layer, although so far I have been unable to write a reliable
> iotest for that scenario.

More details on why I can't write an iotest (yet) - I wanted to use
blkdebug to let me expose an active image with a required alignment
greater than that of a backing image, but sadly, the current
implementation of blkdebug (and filters in general) reports block status
ONLY for the active layer (it does not properly follow the backing
chain, without Max's patches):

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00221.html

But I _finally_ found a way around the fact that blkdebug doesn't (yet)
do what I want - the qcow2 driver has a way to force alignment of 512,
by using encryption.  Thus, with this patch applied, I was able to set
up a scenario that proves our server is still non-compliant (and I hope
to have my patch for fixing it polished enough to send, soon, now that I
can actually test my patch without one-off hacks to manually force the
server into a fixed-size advertisement).

$ printf %01000d 0 > base
$ qemu-img create -f qcow2 -b base -F raw \
  --object=3Dsecret,id=3Ds0,data=3D12345 \
  -o encrypt.format=3Dluks,encrypt.key-secret=3Ds0,encrypt.iter-time=3D10=
 \
  top.qcow2 16k
$ qemu-nbd --object secret,id=3Ds0,data=3D12345 \
 --image-opts driver=3Dqcow2,file.filename=3Dtop.qcow2,encrypt.key-secret=
=3Ds0

$ # in second terminal
$ qemu-io --trace=3Dnbd_\* -f raw nbd://localhost:10809 -c 'r 0 2k'
=2E..
23211@1554150310.580828:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 2048, .handle =3D 93824995142096, .flags =3D 0x0,=
 .type =3D
0 (read) }
23211@1554150310.581049:nbd_receive_structured_reply_chunk Got
structured reply chunk: { flags =3D 0x0, type =3D 1 (data), handle =3D
93824995142096, length =3D 1008 }
23211@1554150310.581063:nbd_structured_read_compliance server sent
non-compliant unaligned read data chunk
23211@1554150310.581076:nbd_receive_structured_reply_chunk Got
structured reply chunk: { flags =3D 0x1, type =3D 2 (hole), handle =3D
93824995142096, length =3D 12 }
23211@1554150310.581085:nbd_structured_read_compliance server sent
non-compliant unaligned read hole chunk

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AyEntWgLAO1D5246AZiFNX9A8T1shg0DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyidiAACgkQp6FrSiUn
Q2q95wgAj8ASfo4vQor7Jr2KTbicK4uItF9mlqq0MOHYtNsPlnyW+yYjxkAwOl1q
5wjm4+AhjVerQhffWWAQ8yE3m/JzAnqt+Bj+BYPtTZ8zBq8yhNoS5msrkgGVfl6S
5oEuv0rJoXuUla/DAyJZ4cCSPOKDsGbtbWmcFDNlkx/RjtuNPiR6VCcN/xaRAc68
cxVdPq/8uZTDIGNU8F6kOl1s4TozIIA8tr9oFPox5BzybfJwCLgpKTO87cxZwts5
HFkzQPYTLKuCoLULz+tKGcrA4sdEGsbEYnUUfIBu4Rrf9JBbP9avEd7i5eU5c0QD
cDPmanwShuvuZXjMQkHrnY6HtpCM2w==
=QePF
-----END PGP SIGNATURE-----

--AyEntWgLAO1D5246AZiFNX9A8T1shg0DC--
