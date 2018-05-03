Received: from eggs.gnu.org ([2001:4830:134:3::10]:45457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fEDG6-0005tm-MT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fEDG5-0004Mv-MQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:22:50 -0400
Date: Thu, 3 May 2018 14:22:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180503122241.GA6140@localhost.localdomain>
References: <w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
	<w51wowvqu65.fsf@maestria.local.igalia.com>
	<b3ec832d-202b-db93-a163-3d63a4d36326@redhat.com>
	<w51h8nqcijb.fsf@maestria.local.igalia.com>
	<aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <aab201a7-ef3f-8152-cc37-85ae7e106a5e@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 02.05.2018 um 16:12 hat Max Reitz geschrieben:
> On 2018-05-02 15:07, Alberto Garcia wrote:
> > Were the (more or less) exact requirements of QMP blockdev-reopen
> > discussed? How is it different from qemu-io's "reopen" command? What are
> > the options that you can and can not change?
>=20
> I can't quite remember, I'm afraid.  I think it was supposed to be
> pretty much qemu-io's reopen (so just bdrv_reopen()).  I suppose you
> cannot change the driver (obviously) or probably the node name, because
> either would result in the node being replaced by a completely new one.
>=20
> Other than that, it probably depends on what the block driver supports,
> but ideally you should be able to change everything.

Honestly the design of bdrv_reopen() is quite broken because of the way
it tries to maintain old options if they aren't specified, and guesses
what you might mean when you add flags to the mix. The exact semantics
are quite complicated and I'd rather avoid them in a stable API.

A clean QMP command would probably apply the same defaults as
blockdev-add, so you just get to specify the full options again.

> reopen: You call it like blockdev-add, that is:
>     { "node-name": "overlay",
>       "backing": "new-backing" }
> In theory every option you do not specify is unchanged, so I suppose you
> can leave out e.g. the "driver" option here.

That already doesn't work because "driver" is the discriminator for the
QAPI union, so it must be mandatory. I'd go further and reuse
BlockdevOptions, which makes everything mandatory that is mandatory when
creating the image.

blockdev-reopen would basically mean "replace the whole set of options
of this node".

> Sure, with reopen you can also respecify the whole tree if you so desire
> (so you can get away without blockdev-add'ing new-backing before), but
> you don't have to.

It might be reasonable to forbid inline declarations for BlockdevRef in
blockdev-reopen, so that always have to specify node names instead. On
the other hand, maybe support for inline declarations falls out almost
automatically.

Kevin

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa6v8RAAoJEH8JsnLIjy/Wf8oQAJlY5txTKCX2AGO9iJQdVcJj
JVVUQMYO+kdlF8TtjsK/5PH2aknpVrC9kBW2IQa2Klbr/tIz2gqvuYH1G199kJQQ
BzaXOU+uqGIH+zwANsDz8yyCzhel5iqmvWcPREGZdEY0q6atI59nJlfqjif89vbk
L69eM5BpXdKwTyJ+bJE+b6IIyGRd3ugbxVq/QRGSjHl2DQLmKBxI53N4wCjCGMY+
6G3N5G4kOMqbE71LlvD/aGC33VQbLFI3wuOODBeT27rTC84fVzLacCFpPd/swK/I
oCj8wcwLcbfw1oQw9JTlpQQkahiLvh21O4cx5VHXU7JhPwFFw4YUseUICzouV9Lm
nK5ZTjIKmHZpXq/5JhwxuE8HM2Y/ZImNwN0v2ZwlWMtQdfkhoMrXe8SCJ0OAKsEA
rB/B5Rk1fTJCYMLnujC7x90srGe8jn0ew9P1253M1zGrvZB1sgcfAgiUpU/iohO6
WfQZfLL/GU22ITXqNvDNvOBTUswd1fKEuX8/D6pTjaqp+hq8nQ4rtCQjqbNMTPsu
L5UolakXKQVSrywRqUm77/YyOPh1gA974sq4zERKrQQ3jltiA2+DB66EZsX0NhGP
GRBgZCkz8H9eM9sygm8rbGqqL2TuNGjOOMn/K68BgcVs4Wpw6cgVGUmJ0Uf1LSbw
My3D3PwbsRXKaApVLIdO
=/5FB
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
