Received: from eggs.gnu.org ([2001:4830:134:3::10]:43944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJInx-0002fs-L9
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJInw-0002gY-GN
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:14:17 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-4-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
Date: Fri, 9 Jun 2017 07:14:07 -0500
MIME-Version: 1.0
In-Reply-To: <1497009003-25794-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VQioIdALBdfmMleTDKxGfns9La1S6qLr1"
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VQioIdALBdfmMleTDKxGfns9La1S6qLr1
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497009003-25794-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 06:50 AM, Kevin Wolf wrote:
> When qemu is exited, all running jobs should be cancelled successfully.=

> This adds a test for this for all types of block jobs that currently
> exist in qemu.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/185     | 189 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/185.out |  59 ++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 249 insertions(+)
>  create mode 100755 tests/qemu-iotests/185
>  create mode 100644 tests/qemu-iotests/185.out
>=20

> +
> +_send_qemu_cmd $h \
> +    "{ 'execute': 'human-monitor-command',
> +       'arguments': { 'command-line':
> +                      'qemu-io disk \"write 0 4M\"' } }" \
> +    "return"

My first reaction? "Why are we still dropping back to HMP?"  My second -
"Oh yeah - qemu-io is a debugging interface, and we really don't
need/want it in QMP".  This part is fine.

> +_send_qemu_cmd $h \
> +    "{ 'execute': 'drive-backup',
> +       'arguments': { 'device': 'disk',
> +                      'target': '$TEST_IMG.copy',
> +                      'format': '$IMGFMT',
> +                      'sync': 'full',
> +                      'speed': 65536 } }" \

Fun with slow speeds :)

64k is slow enough compared to your 4M chunk that you should be fairly
immune to a heavy load allowing the job to converge.  However,

> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, =
"offset": 524288, "speed": 65536, "type": "commit"}}

I'm worried that if you don't sanitize at least offset, you will still
be prone to some race conditions changing the output.  You may want to
add in some additional filtering on the output to be safer.

Other than that, the patch looks good to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VQioIdALBdfmMleTDKxGfns9La1S6qLr1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOpEPAAoJEKeha0olJ0NqROgH/idDXc+t4wspjcCvsaMNxBl5
8LFiMqhe/PTh28g6OqBO37Hx+vwOpxHfQppZuQ6nuTEIgwWOnxZmwEeFUBh+gm5G
/sp3wYpYSXFOD7WqRcZJ294+Y3oiYl7OI6F+b8tdlDVU3fq6cmHpPI7wuxtK2sN/
3X0e34d0/hs+7/ZpsI+w4V398I9eJgY48v+b9LYk+UUnpnxcTL2uWumVNBoS0KIl
mBjFLdAtZ2EV4N7Uuco6yFZnEoQiOqkyn0Hd9Bf0dpbHYCkGTHqpoFZNOdLY1QiQ
QEQivpR8Or/Zx41lmqiYz7PRML3l9W/OBUw7fysp/g98L9L56SMnasBs9e3UcVs=
=8rca
-----END PGP SIGNATURE-----

--VQioIdALBdfmMleTDKxGfns9La1S6qLr1--
