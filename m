Received: from eggs.gnu.org ([2001:4830:134:3::10]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHFf-0000QV-TN
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHFf-0005PL-0j
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:54:15 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
Date: Fri, 10 Nov 2017 15:54:03 -0600
MIME-Version: 1.0
In-Reply-To: <20171110203111.7666-6-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HNHMNafVH6nHG9a8Md6AoGo0KL4VrQPFs"
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get
 unaligned offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HNHMNafVH6nHG9a8Md6AoGo0KL4VrQPFs
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get unaligned
 offsets from cache
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-6-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 02:31 PM, Max Reitz wrote:
> Instead of using an assertion, it is better to emit a corruption event
> here.  Checking all offsets for correct alignment can be tedious and it=

> is easily possible to forget to do so.  qcow2_cache_do_get() is a
> function every L2 and refblock access has to go through, so this is a
> good central point to add such a check.
>=20
> And for good measure, let us also add an assertion that the offset is
> non-zero.  Making this a corruption event is not feasible, because a
> zero offset usually means something special (such as the cluster is
> unused), so all callers should be checking this anyway.  If they do not=
,
> it is their fault, hence the assertion here.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cache.c        | 21 +++++++++++++++++++++
>  tests/qemu-iotests/060     | 21 +++++++++++++++++++++
>  tests/qemu-iotests/060.out | 29 +++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+)
>=20

> +--- Repairing ---
> +Repairing refcount block 1 is outside image
> +ERROR refcount block 2 is not cluster aligned; refcount table entry co=
rrupted
> +qcow2: Marking image as corrupt: Refblock offset 0x200 unaligned (reft=
able index: 0x2); further corruption events will be suppressed
> +Can't get refcount for cluster 1048576: Input/output error

Trying to understand this: we have a double corruption, because we
encountered a refblock that points outside of the image, but fixing the
refblock in turn encounters a second refblock that points within the
image but to an unaligned area.

Of course, you should never encounter these bad refblocks in normal
usage, but when it comes to dealing with untrusted images, being robust
is always worth it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HNHMNafVH6nHG9a8Md6AoGo0KL4VrQPFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGH/sACgkQp6FrSiUn
Q2q0Mgf9GZ0kZGtH019unQoNiVM4gaw7r8TkEEs/C3Mz4qANiLGOwJpr3pxjjRpM
JqX1aazNTHtxUbzdX7IBBbTdC0ZH9XWK2NdJqpxam48S/WhyBlJV3cTF0PMLFHjU
+NkOnN+TnMwYCBx25JuCzPkbVMIETlstVUeZyCouuLrblwRrA6qFxARglUZsDsup
CSP3Gh7R7d2xyNAkYLwj+OxyJ1gSTgr7s4HcqBFbci4o2+5b0utTHznKD2LNG+61
F31EhpQwC330vJsInG9qI8roK81rb4mqGke2+2yVBFKwmv+kOqOHnekmblUngTq+
VaWqGcd2V0gzILh5SClCivUVl4KfHw==
=iLAU
-----END PGP SIGNATURE-----

--HNHMNafVH6nHG9a8Md6AoGo0KL4VrQPFs--
