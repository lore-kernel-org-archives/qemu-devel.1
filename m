Received: from eggs.gnu.org ([209.51.188.92]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9w9-00072o-SC
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9w7-00046v-Mt
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:50:33 -0500
References: <cover.1547739122.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23150df9-1a9d-d1ef-c624-64eb2425a8d5@redhat.com>
Date: Thu, 17 Jan 2019 09:50:20 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="evfcmNZstJBFp8fMgngdq7ClKddneZGPw"
Subject: Re: [Qemu-devel] [PATCH 00/13] Add a 'x-blockdev-reopen' QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--evfcmNZstJBFp8fMgngdq7ClKddneZGPw
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <23150df9-1a9d-d1ef-c624-64eb2425a8d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/13] Add a 'x-blockdev-reopen' QMP command
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 9:33 AM, Alberto Garcia wrote:

>=20
> Changing options
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The general idea is quite straightforward, but the devil is in the
> details. Since this command tries to mimic blockdev-add, the state of
> the block device after being reopened should generally be equivalent
> to that of a block device added with the same set of options.
>=20
> There are two important things with this:
>=20
>   a) Some options cannot be changed (most drivers don't allow that, in
>      fact).
>   b) If an option is missing, it should be reset to its default value
>      (rather than keeping its previous value).

Could we use QAPI alternate types where we could state that:

"option":"new" - set the option
"option":null - reset the option to its default
omit option - leave the option unchanged

basically, making each of the options an Alternate with JSON null, so
that a request to reset to the default becomes an explicit action?

>=20
> Example: the default value of l2-cache-size is 1MB. If we set a
> different value (2MB) on blockdev-add but then omit the option in
> x-blockdev-reopen, then it should be reset back to 1MB. The current
> bdrv_reopen() code keeps the previous value.
>=20
> Trying to change an option that doesn't allow it is already being
> handled by the code. The loop at the end of bdrv_reopen_prepare()
> checks all options that were not handled by the block driver and sees
> if any of them has been modified.
>=20
> However, as I explained earlier in (b), omitting an option is supposed
> to reset it to its default value, so it's also a way of changing
> it. If the option cannot be changed then we should detect it and
> return an error. What I'm doing in this series is making every driver
> publish its list of run-time options, and which ones of them can be
> modified.
>=20
> Backing files
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This command allows reconfigurations in the node graph. Currently it
> only allows changing an image's backing file, but it should be
> possible to implement similar functionalities in drivers that have
> other children, like blkverify or quorum.
>=20
> Let's add an image with its backing file (hd1 <- hd0) like this:
>=20
>     { "execute": "blockdev-add",
>       "arguments": {
>           "driver": "qcow2",
>           "node-name": "hd0",
>           "file": {
>               "driver": "file",
>               "filename": "hd0.qcow2",
>               "node-name": "hd0f"
>           },
>           "backing": {
>               "driver": "qcow2",
>               "node-name": "hd1",
>               "file": {
>                   "driver": "file",
>                   "filename": "hd1.qcow2",
>                   "node-name": "hd1f"
>               }
>           }
>        }
>     }
>=20
> Removing the backing file can be done by simply passing the option {
> ..., "backing": null } to x-blockdev-reopen.
>=20
> Replacing it is not so straightforward. If we pass something like {
> ..., "backing": { "driver": "foo" ... } } then x-blockdev-reopen will
> assume that we're trying to change the options of the existing backing
> file (and it will fail in most cases because it'll likely think that
> we're trying to change the node name, among other options).
>=20
> So I decided to use a reference instead: { ..., "backing": "hd2" },
> where "hd2" is of an existing node that has been added previously.
>=20
> Leaving out the "backing" option can be ambiguous on some cases (what
> should it do? keep the current backing file? open the default one
> specified in the image file?) so x-blockdev-reopen requires that this
> option is present. For convenience, if the BDS doesn't have a backing
> file then we allow leaving the option out.

Hmm - that makes my proposal of "option":null as an explicit request to
the default a bit trickier, if we are already using null for a different
meaning for backing files.

>=20
> As you can see in the patch series, I wrote a relatively large amount
> of tests for many different scenarios, including some tricky ones.
>=20
> Perhaps the part that I'm still not convinced about is the one about
> freezing backing links to prevent them from being removed, but the
> implementation was quite simple so I decided to give it a go. As
> you'll see in the patches I chose to use a bool instead of a counter
> because I couldn't think of a case where it would make sense to have
> two users freezing the same backing link.
>=20
> Thanks,
>=20
> Berto
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--evfcmNZstJBFp8fMgngdq7ClKddneZGPw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxApDwACgkQp6FrSiUn
Q2qZywf+P+ZItdGl/rhQgJvCr9uQyZt1NBXY3pL5fj72JSFeM7OJmslx+7CiEiw6
8qZKcfbn+xFP+7micVYyj2PyuOWovh0I6HXunC/7lFn11l0x1tdGVYgmP1G/ZEZF
3hW/xSlgZASIKswI2+id8a39+YmekBScPpnEWHLNoDqjjsVpc3PN4Y9ZOQb+5lJF
pJeXealR4LwMmTLHQduoejchxspFk0hu1c880ZcG5Wf3IcUa9mxk3nGhjk1s31tq
VhK9znRqtWCvRC5j8JUK9CZuXYkfCKkkP/3XkQShW9QAZfugozEPSYblBWUz925e
SuRWZYclUE5R/s+sfgJ9aa4xSRFYdg==
=R+Tc
-----END PGP SIGNATURE-----

--evfcmNZstJBFp8fMgngdq7ClKddneZGPw--
