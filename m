Received: from eggs.gnu.org ([2001:4830:134:3::10]:53964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehhEI-0001tI-35
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehhED-0002p5-1o
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:42:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehhEC-0002om-MY
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:42:28 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3195606a-d39c-63db-f5bd-bc258f8d6fd4@redhat.com>
Date: Fri, 2 Feb 2018 13:42:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-9-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mi0Aw9POTobv3ZRY9TSvBtepOIqASuOLM"
Subject: Re: [Qemu-devel] [PATCH RFC 08/21] qapi: Touch generated files only
 when they change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mi0Aw9POTobv3ZRY9TSvBtepOIqASuOLM
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <3195606a-d39c-63db-f5bd-bc258f8d6fd4@redhat.com>
Subject: Re: [PATCH RFC 08/21] qapi: Touch generated files only when they
 change
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-9-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> A massive number of objects depends on QAPI-generated headers.  In my
> "build everything" tree, it's roughly 4500 out of 4800.  This is
> particularly annoying when only some of the generated files change,
> say for a doc fix.
>=20
> Improve qapi-gen.py to touch its output files only if they actually
> change.  Rebuild time for a QAPI doc fix drops from many minutes to a
> few seconds.  Rebuilds get faster for certain code changes, too.  For
> instance, adding a simple QMP event now recompiles less than 200
> instead of 4500 objects.  But adding a QAPI type is as bad as ever; we
> clearly got more work to do.

The last phrase sounds quite colloquial.  It may have been intentional;
but if not, s/we/we've/

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index cfa2671ca3..be0fcc548a 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1944,9 +1944,16 @@ class QAPIGen(object):
>              except os.error as e:
>                  if e.errno !=3D errno.EEXIST:
>                      raise
> -        f =3D open(os.path.join(output_dir, fname), 'w')
> -        f.write(self.top(fname) + self._preamble + self._body
> +        fd =3D os.open(os.path.join(output_dir, fname),
> +                     os.O_RDWR | os.O_CREAT, 0666)
> +        f =3D os.fdopen(fd, 'r+')
> +        text =3D (self.top(fname) + self._preamble + self._body
>                  + self.bottom(fname))
> +        oldtext =3D f.read(len(text) + 1)
> +        if text !=3D oldtext:
> +            f.seek(0)
> +            f.truncate(0)
> +            f.write(text)

In-memory rewrite rather than playing games with a secondary file
combined with the rename(2) syscall.  It means you're not atomic (an
external reader has a window of time where they can see an incomplete
version of the file).  But I think make dependency rules mean we don't
care - even in a parallel rule, as long as all clients depend on the
timestamp file, and the timestamp file isn't updated until all our
rewrites (if any) have settled, then we don't create any of those
external readers that can find the window of incomplete contents.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mi0Aw9POTobv3ZRY9TSvBtepOIqASuOLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0vyAACgkQp6FrSiUn
Q2rKIAf+NBOfFHs+yCjonhtb98iBuuyckvvCIh7LFQeWtma8ZeRDr1CUB87ehZCZ
6O/4Gm60o4vAQN8y188c4pJQncEjL9V6imBezi7/0eo5lWNT/AiX1JAck39jOUzY
vxzUfbptEItvxOPcAxy470ES/NLvnbjB58bLmHhI3kMcWDNDccaZC78XeF155xnE
7CYVhK/GXkd9gzA2scAZlYvj4CpBZi7EaX+qvTaIsEcEd+9/QpNgxzu25s8zTj/N
Nobf0B7N/SQkkvrN7kv0s3mRe+WR64n9BsncO0BM12NQFuwgiU01b6g/UpO4P8Zw
7hVLnAAJElW9jbQHZPf4QBHds8R3tA==
=oDjV
-----END PGP SIGNATURE-----

--mi0Aw9POTobv3ZRY9TSvBtepOIqASuOLM--
