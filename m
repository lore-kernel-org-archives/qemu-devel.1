Received: from eggs.gnu.org ([2001:4830:134:3::10]:47494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYBSz-00070p-3E
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYBSu-0005Bd-0c
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:30:41 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-15-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dd88cb0f-1b0e-ce65-7418-78a25d3b8855@redhat.com>
Date: Wed, 27 Jun 2018 16:30:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-15-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GtrRxfucIet5MqOlKY9Q6zCkHDmowuzwg"
Subject: Re: [Qemu-devel] [PATCH 14/19] block: Defer .bdrv_drain_begin
 callback to polling phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GtrRxfucIet5MqOlKY9Q6zCkHDmowuzwg
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <dd88cb0f-1b0e-ce65-7418-78a25d3b8855@redhat.com>
Subject: Re: [PATCH 14/19] block: Defer .bdrv_drain_begin callback to polling
 phase
References: <20180411163940.2523-1-kwolf@redhat.com>
 <20180411163940.2523-15-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-11 18:39, Kevin Wolf wrote:
> We cannot allow aio_poll() in bdrv_drain_invoke(begin=3Dtrue) until we'=
re
> done with propagating the drain through the graph and are doing the
> single final BDRV_POLL_WHILE().
>=20
> Just schedule the coroutine with the callback and increase bs->in_fligh=
t
> to make sure that the polling phase will wait for it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)

According to bisect, this breaks blockdev-snapshot with QED:

$ ./qemu-img create -f qed foo.qed 64M
Formatting 'foo.qed', fmt=3Dqed size=3D67108864 cluster_size=3D65536
$ echo "{'execute':'qmp_capabilities'}
        {'execute':'blockdev-snapshot',
         'arguments':{'node':'backing','overlay':'overlay'}}
        {'execute':'quit'}" | \
    x86_64-softmmu/qemu-system-x86_64 -qmp stdio -nodefaults \
        -blockdev "{'node-name':'backing','driver':'null-co'}" \
        -blockdev "{'node-name':'overlay','driver':'qed',
                    'file':{'driver':'file','filename':'foo.qed'}}"
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
"package": "v2.12.0-1422-g0109e7e6f8"}, "capabilities": []}}
{"return": {}}
qemu-system-x86_64: block.c:3434: bdrv_replace_node: Assertion
`!atomic_read(&to->in_flight)' failed.
[1]    5252 done                 echo  |
       5253 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
stdio -nodefaults -blockdev  -blockdev

Max


--GtrRxfucIet5MqOlKY9Q6zCkHDmowuzwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlszn3kACgkQ9AfbAGHV
z0BV+ggAo5hL5634W3rv5qbRTSDFrGM7pf2rMQ+ctjd/vSIddcs+EzlzWljbeLX8
R7DyHIXsRq6LQ8Q/lQvw9dmsTDhFFy5CAf03Ja6zDd+oITtuXuzOEMvuPtAunmQl
ypO4NyURsEJhKg8VLhNTp6nj+9LZkF18hZgw3os2WIIWsCaTBz1daQy+t+hJ+6cw
D8CsKmY07psUQIU+x0d6kn7uVP2n0Q7pNtHBrQNwhAufWZ6YXswXWyMKZ3z58LQ8
sMvEPbGlaxOXjgM2vqRAuRICSMLR17E1IE+71rAJ0b02CoznZKZ4jiY6/Snc1ArG
+XGApjqQRhsWLJ/Zg95coFjJoRpICQ==
=sPLz
-----END PGP SIGNATURE-----

--GtrRxfucIet5MqOlKY9Q6zCkHDmowuzwg--
