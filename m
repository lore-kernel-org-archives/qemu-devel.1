Received: from eggs.gnu.org ([209.51.188.92]:41604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj2PW-0007aM-NM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj2PR-0003yz-GD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:36:12 -0500
Date: Mon, 14 Jan 2019 13:35:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190114133553.GE7038@stefanha-x1.localdomain>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <w51pnt3qo27.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 03:14:08PM +0100, Alberto Garcia wrote:
> On Fri 11 Jan 2019 02:24:16 PM CET, Kevin Wolf wrote:
> >> >> The following QMP command leads to a crash when iothreads are used:
> >> >>
> >> >>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }
> >> >
> >> > How did you reproduce this? Do you have a test case?
> >>=20
> >> Ok, I finally reproduced it, the patch looks good to me.
> >
> > Can it be turned into a qemu-iotests case or is it too complicated for
> > that?
>=20
> I can reproduce the problem reliably with this:
>=20
> { "execute": "qmp_capabilities" }
> { "execute": "blockdev-add",
>   "arguments": {"driver": "null-co", "node-name": "hd0"}}
> { "execute": "object-add",
>   "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> { "execute": "device_add",
>   "arguments": {"id": "scsi0", "driver": "virtio-scsi-pci",
>                 "iothread": "iothread0"}}
> { "execute": "device_add",
>   "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> { "execute": "block_set_io_throttle",
>   "arguments": {"id": "scsi-hd0", "bps": 0, "bps_rd": 0, "bps_wr": 0,
>                 "iops": 1000, "iops_rd": 0, "iops_wr": 0}}
> { "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
>=20
> But this doesn't crash if I put it in an iotest.

I've been able to reproduce this in an iotest, please see v2 of this
series.

Stefan

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPJA5AAoJEJykq7OBq3PI3IwH/37a1WpYLn9uZvZPukE4DEMN
/KfCB+Wn6ZYaiAQPTs8UYQKMvK7koudrTyfT+R5mgzo+E+Q7F9hZD4uNvny0KbFs
mRD44cmEngFoXlTveJS7WYJ1rKPYt6xw+X3zgJibBOhi80YN0E1DfUceIiOmnF7y
VkLSiwj1lkUVZVFe5DthkJHC0qp3prkKHhBOREhYqC/fjtQy1xnT3Y/ePN6Gj0qv
y/6tegJx0LLgJa6eIg3ySNssJ2OrL64p5dnUma1nkpU3YqxaQLKZNbyJ2+QEzsMm
OIcrfBPdtja2TYnveO79NfalUWd1xDwWQHgFnVnlMLfJ4EcgshTkIdAnu2olQII=
=4ajh
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
