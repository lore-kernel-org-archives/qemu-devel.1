Received: from eggs.gnu.org ([2001:4830:134:3::10]:49375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXRtZ-0004lL-Tl
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXRtV-00066t-Da
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:51:05 -0400
References: <20180621032539.134944-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7570accb-ecb1-1481-4737-5a5004a2106a@redhat.com>
Date: Mon, 25 Jun 2018 15:50:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180621032539.134944-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OyoOuS284Zo17dZ4DdNdvi0XwlbQykObu"
Subject: Re: [Qemu-devel] [PATCH] nbd/client: add x-block-status hack for
 testing server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OyoOuS284Zo17dZ4DdNdvi0XwlbQykObu
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org,
 vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <7570accb-ecb1-1481-4737-5a5004a2106a@redhat.com>
Subject: Re: [PATCH] nbd/client: add x-block-status hack for testing server
References: <20180621032539.134944-1-eblake@redhat.com>
In-Reply-To: <20180621032539.134944-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-21 05:25, Eric Blake wrote:
> In order to test that the NBD server is properly advertising
> dirty bitmaps, we need a bare minimum client that can request
> and read the context.  This patch is a hack (hence the use of
> the x- prefix) that serves two purposes: first, it lets the
> client pass a request of more than one context at a time to
> the server, to test the reaction of the server to various
> contexts (via the list command).  Second, whatever the first
> context in the user's list becomes the context wired up to the
> results visible in bdrv_block_status(); this has the result
> that if you pass in 'qemu:dirty-bitmap:b' instead of the usual
> 'base:allocation', and the server is currently serving a named
> bitmap 'b', then commands like 'qemu-img map' now output status
> corresponding to the dirty bitmap (dirty sections look like
> holes, while clean sections look like data, based on how the
> status bits are mapped over the NBD protocol).
>=20
> Since the hack corrupts the meaning of bdrv_block_status(), I
> would NOT try to run 'qemu-img convert' or any other program
> that might misbehave based on thinking clusters have a different
> status than what the normal 'base:allocation' would provide.
>=20
> The hack uses a semicolon-separated list embedded in a single
> string, as that was easier to wire into the nbd block driver than
> figuring out the right incantation of flattened QDict to represent
> an array via the command line.  Oh well, just one more reason that
> this hack deserves the 'x-' prefix.

Without having looked at the patch, would an "x-debug-" prefix work
better?  We have that for x-debug-block-dirty-bitmap-sha256.  The reason
is that just "x-" means "experimental", which at least to me implies
"once we have done all of our experiments, it will no longer be
experimental and the prefix is dropped".  "x-debug-" means that it is
actually not experimental, but just a debugging interface that will
never be stable.

(Yes, I know we haven't documented the meaning of x-debug- anywhere...)

Max

> As a demo, I was able to prove things work with the following sequence:=

>=20
> $ qemu-img info file
> image: file
> file format: qcow2
> virtual size: 2.0M (2097152 bytes)
> disk size: 2.0M
> cluster_size: 65536
> Format specific information:
>     compat: 1.1
>     lazy refcounts: false
>     refcount bits: 16
>     corrupt: false
>=20
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio=

> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "p=
ackage": "v2.12.0-1531-g3ab98aa673d"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'blockdev-add','arguments':{'driver':'qcow2','node-name':'n'=
,'file':{'driver':'file','filename':'file'}}}
> {"return": {}}
> {'execute':'block-dirty-bitmap-add','arguments':{'node':'n','name':'b',=
'persistent':true}}
> {"return": {}}
> {'execute':'quit'}
> {"return": {}}
> {"timestamp": {"seconds": 1529548814, "microseconds": 472828}, "event":=
 "SHUTDOWN", "data": {"guest": false}}
>=20
> $ ./qemu-io -f qcow2 file
> qemu-io> r -v 0 1
> 00000000:  01  .
> read 1/1 bytes at offset 0
> 1 bytes, 1 ops; 0.0001 sec (4.957 KiB/sec and 5076.1421 ops/sec)
> qemu-io> w -P 1 0 1
> wrote 1/1 bytes at offset 0
> 1 bytes, 1 ops; 0.0078 sec (127.502231 bytes/sec and 127.5022 ops/sec)
> qemu-io> q
>=20
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio=

> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "p=
ackage": "v2.12.0-1531-g3ab98aa673d"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data'=
:{'host':'localhost','port':'10809'}}}}
> {"return": {}}
> {'execute':'blockdev-add','arguments':{'driver':'qcow2','node-name':'n'=
,'file':{'driver':'file','filename':'file'}}}
> {"return": {}}
> {'execute':'nbd-server-add','arguments':{'device':'n'}}
> {"return": {}}
> {'execute':'x-nbd-server-add-bitmap','arguments':{'name':'n','bitmap':'=
b'}}
> {"error": {"class": "GenericError", "desc": "Bitmap 'b' is enabled"}}
> {'execute':'x-block-dirty-bitmap-disable','arguments':{'node':'n','name=
':'b'}}
> {"return": {}}
> {'execute':'x-nbd-server-add-bitmap','arguments':{'name':'n','bitmap':'=
b'}}
> {"return": {}}
> ... leave running
>=20
> $ ./qemu-img map --output=3Djson --image-opts driver=3Dnbd,export=3Dn,s=
erver.type=3Dinet,server.host=3Dlocalhost,server.port=3D10809
> [{ "start": 0, "length": 1114112, "depth": 0, "zero": false, "data": tr=
ue},
> { "start": 1114112, "length": 458752, "depth": 0, "zero": true, "data":=
 false},
> { "start": 1572864, "length": 524288, "depth": 0, "zero": false, "data"=
: true}]
>=20
> $ ./qemu-img map --output=3Djson --image-opts driver=3Dnbd,export=3Dn,s=
erver.type=3Dinet,server.host=3Dlocalhost,server.port=3D10809,x-block-sta=
tus=3Dqemu:dirty-bitmap:b
> [{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": fals=
e},
> { "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data":=
 true}]
>=20
> The difference between the two runs shows that base:allocation status
> is thus different from the contents of dirty bitmap 'b'; and that the
> dirty bitmap 'b' indeed tracked the first 64k of the file as being
> dirty due to the qemu-io write at offset 0 performed between the creati=
on
> of bitmap b in the first qemu, and the disabling it prior to exporting =
it
> in the second qemu.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---


--OyoOuS284Zo17dZ4DdNdvi0XwlbQykObu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsw8zsACgkQ9AfbAGHV
z0BKAggAvKQIaEIsLqp4jVxwr6BolbidIH5NRvolxGKf30ToZnwf5TImf9gojiv5
ioftxDZmLr4T56Co1cg1X8eJUT6KD85vvI+1GgvWeGDqu8n0ZRvWsICgP29s8nNt
hDN7WqmFnGMN/V+KZCVaQSAhFWyg2uBxnhhJLkBHW8tsn7VPm7tBhT0QY/oVzJa9
2D6Lv9QkTUbYKS9pO4yV6N/PiOa8rkxoh2f0J65tVxuPHmoe/tj7epzHI3HvzDKJ
mfVB6Jl74fEMEyaM2sc9DhEFCat2amMW2c0QiRI49ZDm97bOijH0+yfdVb15HP+i
FxdPyKHcXBKiVSdQKdAsnwon70toAg==
=3+YB
-----END PGP SIGNATURE-----

--OyoOuS284Zo17dZ4DdNdvi0XwlbQykObu--
