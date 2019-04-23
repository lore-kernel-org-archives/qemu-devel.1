Received: from eggs.gnu.org ([209.51.188.92]:36328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hItdB-00012m-NG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hItdA-00051W-FD
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1hItdA-0004yl-5j
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27E8387623
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:30:30 +0000 (UTC)
Date: Tue, 23 Apr 2019 13:30:28 +0200
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20190423113028.GD30014@wheatley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
Subject: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Jones <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi,

I am using qemu-img with nbdkit to transfer a disk image and the update it with
extra data from newer snapshots.  The end image cannot be transferred because
the snapshots will be created later than the first transfer and we want to save
some time up front.  You might think of it as a continuous synchronisation.  It
looks something like this:

I first transfer the whole image:

  qemu-img convert -p $nbd disk.raw

Where `$nbd` is something along the lines of `nbd+unix:///?socket=nbdkit.sock`

Then, after the next snapshot is created, I can update it thanks to the `-n`
parameter (the $nbd now points to the newer snapshot with unchanged data looking
like holes in the file):

  qemu-img convert -p -n $nbd disk.raw

This is fast and efficient as it uses block status nbd extension, so it only
transfers new data.  This can be done over and over again to keep the local
`disk.raw` image up to date with the latest remote snapshot.

However, when the guest OS zeroes some of the data and it gets written into the
snapshot, qemu-img scans for those zeros and does not write them to the
destination image.  Checking the output of `qemu-img map --output=json $nbd`
shows that the zeroed data is properly marked as `data: true`.

Using `-S 0` would write zeros even where the holes are, effectively overwriting
the data from the last snapshot even though they should not be changed.

Having gone through some workarounds I would like there to be another way.  I
know this is far from the typical usage of qemu-img, but is this really the
expected behaviour or is this just something nobody really needed before?  If it
is the former, would it be possible to have a parameter that would control this
behaviour?  If the latter is the case, can that behaviour be changed so that it
properly replicates the data when `-n` parameter is used?

Basically the only thing we need is to either:

 1) write zeros where they actually are or

 2) turn off explicit sparsification without requesting dense image (basically
    sparsify only the par that is reported as hole on the source) or

 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did report data,
    but qemu-img found they are all zeros (or source reported HOLE+ZERO which, I
    believe, is effectively the same)

If you want to try this out, I found the easiest reproducible way is using
nbdkit's data plugin, which can simulate whatever source image you like.

The first iteration, which transfers the whole image can be simulated like this:

  nbdkit --run 'qemu-img convert -p $nbd output.raw' data data="1" size=2M

That command will expose an artificial disk with the size of 2MB which has first
byte '1' and the rest is zeros/holes and runs the specified qemu-img command on
that ($nbd is supplied by nbdkit, so the string needs to be enclosed in single
parentheses).

You can see how that data is exposed by running:

  nbdkit --run 'qemu-img map --output=json $nbd' data data="1" size=2M

For completeness I get this output:

  [{ "start": 0, "length": 32768, "depth": 0, "zero": false, "data": true},
   { "start": 32768, "length": 2064384, "depth": 0, "zero": true, "data": false}]

Consequent update from a snapshot (with the first block explicitly zeroed) could
be simulated by running:

  nbdkit --run 'qemu-img convert -n -p $nbd output.raw' data data="0" size=2M

Again, the mapping exposed by nbdkit can be seen by running:

  nbdkit --run 'qemu-img map --output=json $nbd' data data="0" size=2M

For completeness I get this output:

  [{ "start": 0, "length": 32768, "depth": 0, "zero": true, "data": true},
   { "start": 32768, "length": 2064384, "depth": 0, "zero": true, "data": false}]

The resulting image still has `1` as its first byte (following is the output of
`hexdump -C output.raw`):

  00000000  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  00200000

Have a nice day,
Martin

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAly+91QACgkQCB/CnyQX
ht1/rA/+PYHjRwk3FUBbuLp8CsygdL3Ub0//rAhHOr3xk7l8EjKxRYt7RQ5fpxne
zSTg5+euDsmG/glhuY/JHUEW9dZ59Hi+21Vb/yTHCZV9jri0uZayKlSfUdklzbuQ
h0zbeB+v2aMyCuLfX7/TAnKScvqmDUadLIqxn0b08uahB1ZoSH65w/n2Yu9J6GNb
zgUujS7FN0WdI8EvFeOsSff5LqAdd3n2hjIfcOVbMgqr1W7giACvqGcvZECf7qHL
xL1Wu6k4NS4jnz0670damAQ54S7Eey12mZJ9f5CBk9R1bmC6vtChkWKwppkge9UT
WwlaXCZj6RD3/Qd0rIFHWkawby1gu4YBdl2PPG9BCksjh4NUks3g1NvgrmFHw84/
L3DvbdsMuWMbEHw8L356kmAS9CVXhGq0ODnVRXssj3DF8+/06QkBpG8JyaMUQq00
CTE4Ea46g35QrUkp4VB19EpqgTkPm8gQeh7kfBpGlvacX2qUvxIZufz6GkJTmM3Y
ATd+wc/QzbSxs7F95iUUKe4bC7e5ITpfVYo0EnF9n7cmIORw8c6UKlkeI6EJMIlR
nK+kGuZsLptCSub0IRWuOW2YRf/T5N+AkRGSAtpxsP0JX+EBtuL5jEeUkYPEqWq6
7c0N/zgV8sif0jm0/Mn6pdv/w9AB0KCbOUiIKsnjCVujTvJ3Zv4=
=ImKk
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
