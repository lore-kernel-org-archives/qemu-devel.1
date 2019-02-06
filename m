Received: from eggs.gnu.org ([209.51.188.92]:45649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grQHm-0002Aq-Fr
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grQHj-0005HH-0M
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:42:52 -0500
References: <20190206152919.5532-1-mreitz@redhat.com>
	<20190206163704.GV12500@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0d644429-0b16-bc7c-c583-d4684e47adb1@redhat.com>
Date: Wed, 6 Feb 2019 17:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190206163704.GV12500@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ta4OAZcrlYG4tscItozK3VgODdh5S7qOj"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ta4OAZcrlYG4tscItozK3VgODdh5S7qOj
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <0d644429-0b16-bc7c-c583-d4684e47adb1@redhat.com>
Subject: Re: [PATCH v2 0/2] block/ssh: Implement .bdrv_refresh_filename()
References: <20190206152919.5532-1-mreitz@redhat.com>
 <20190206163704.GV12500@redhat.com>
In-Reply-To: <20190206163704.GV12500@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.02.19 17:37, Richard W.M. Jones wrote:
> On Wed, Feb 06, 2019 at 04:29:17PM +0100, Max Reitz wrote:
>> This series implements .bdrv_refresh_filename() for the ssh block
>> driver, along with an appropriate .bdrv_dirname() so we don't chop off=

>> query strings for backing files with relative filenames.
>>
>> This series depends on my "block: Fix some filename generation issues"=

>> series.
>>
>> Based-on: 20190201192935.18394-1-mreitz@redhat.com
>=20
> I have verified that this doesn't appear to break the existing driver:
> ssh connections to block devices still work as well as they did before
> (which is to say, not very well, I wish we would replace this driver
> with Pino Toscano's reimplementation that uses libssh1).
>=20
> However I wasn't sure how I could trigger the bdrv_refresh_filename
> code path, so I don't think I tested that.

One test case goes like this:

Before this series:

$ ./qemu-img create -f qcow2 /tmp/base.qcow2 64M
$ ./qemu-img create -f qcow2 -b base.qcow2 /tmp/top.qcow2
$ ./qemu-img info ssh://localhost/tmp/top.qcow2
image: json:{"driver": "qcow2", "file": {"server.host": "localhost",
"server.port": "22", "driver": "ssh", "path": "/tmp/top.qcow2"}}
[...]
backing file: base.qcow2 (cannot determine actual path)
[...]
$ ./qemu-io ssh://localhost/tmp/top.qcow2
can't open device ssh://localhost/tmp/top.qcow2: Cannot generate a base
directory for ssh nodes


So the filename is weird and you cannot open overlays with relative
backing files.

After this series:

$ ./qemu-img info ssh://localhost/tmp/top.qcow2
image: ssh://maxx@localhost:22/tmp/top.qcow2
[...]
backing file: base.qcow2 (actual path:
ssh://maxx@localhost:22/tmp/base.qcow2)
$ ./qemu-io ssh://localhost/tmp/top.qcow2
qemu-io> quit

The filename looks better and the image is usable.

Max


--ta4OAZcrlYG4tscItozK3VgODdh5S7qOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxbDmcACgkQ9AfbAGHV
z0AmqQf+P7/2bZvbhu8Vutm0nbHyWDYn0Y04QpXuCoTQ4loqZAHgoxK7ZH3hx78D
A1BqhLlkTIDE0+aOkIrv1qCD1x95BfNMlH1zeYr3TM8xk/AkxsjyEVy3YDwk0L+Z
yAneZ2su4TqzEjTq/6Drie10opiR2WgDVvSFJMQ6YZcR7XF6yYcbxiEP7O8SOcgJ
AEGdH2Ja/eylqrZ9raSc5stqIE6M2Abp6LVJtF9UuUwb+fYBL2WEE3TWVnZz2pAN
bTcofqG8uB3rztklSd9APg1v0rHXb3isLj2oVtoTApCtMR9Tv3Fhgo2mgmmuCALx
pqwXJzspK+sFT1rXOmypFRqDfTsvUg==
=IHKw
-----END PGP SIGNATURE-----

--ta4OAZcrlYG4tscItozK3VgODdh5S7qOj--
