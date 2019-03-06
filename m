Received: from eggs.gnu.org ([209.51.188.92]:52540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1Tcv-0004ya-NU
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1Tcu-0004YN-Ei
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:18:17 -0500
Date: Wed, 6 Mar 2019 10:18:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190306101811.GJ22159@stefanha-x1.localdomain>
References: <20190301160929.19892-1-stefanha@redhat.com>
	<bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OX7PPUk8qMPP4++R"
Content-Disposition: inline
In-Reply-To: <bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Neil Skrypuch <neil@tembosocial.com>, Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>


--OX7PPUk8qMPP4++R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 10:30:07AM -0600, Eric Blake wrote:
> On 3/1/19 10:09 AM, Stefan Hajnoczi wrote:
> > Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
> > implement bdrv_co_invalidate_cache() on Linux") introduced page cache
> > invalidation so that cache.direct=3Doff live migration is safe on Linux.
> >=20
> > The invalidation takes a significant amount of time when the file is
> > large and present in the page cache.  Normally this is not the case for
> > cross-host live migration but it can happen when migrating between QEMU
> > processes on the same host.
> >=20
> > On same-host migration we don't need to invalidate pages for correctness
> > anyway, so an option to skip page cache invalidation is useful.  I
> > investigated optimizing invalidation and detecting same-host migration,
> > but both are hard to achieve so a user-visible option will suffice.
> >=20
> > Suggested-by: Neil Skrypuch <neil@tembosocial.com>
> > Tested-by: Neil Skrypuch <neil@tembosocial.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v2:
> >  * Remove outdated comment about libvirt feature detection [danpb]
>=20
> Question - if we used qapi's 'if':COND to only declare the field on
> platforms where we know at compile time that we can support it, would
> that be enough for libvirt to introspect that if the field exists then
> migration is safe, without having to rely on an query-qemu-features comma=
nd?

Yes, although this raises another question:

The drop-cache implementation is not #ifdefed in file-posix.c.  If we
make the QMP schema conditional, should we also #ifdef the command-line
option in raw_runtime_opts[] to prevent QEMU from silently ignoring this
option?

Stefan

--OX7PPUk8qMPP4++R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf55jAAoJEJykq7OBq3PIZFQH/iyipEGFqHFFwHoHlhhy180y
kPrwlKJS/0KGNiC1b8sLzolT3T1gPhz4mdBmyvBy80BhHtkznGOU2c8vGjTM0BTm
MLnNbfrhuFCODbdqj1LyIXcytV9GfgJ6MQceizVLrwoDiG/j+gB+lzshb1Ha3Ylq
e1HUCzHt1iKYhAnVbFJaU1eCTfVA0UnMJ2LZ9DltmOeCmX66tF/eoOC+8v16wxfa
s3DG1zAjs/TeM7VGBbJ96SAiqoE8m5/wtvrcMZ+DuyQnrybMD4ixJdC8yZGyVRJV
EQCSLLfaCaaID0KHudp4ZcJTr7xCYpVqi3Y3/TGhrHRxU1UlXlqrGyvedSmSCrQ=
=08YS
-----END PGP SIGNATURE-----

--OX7PPUk8qMPP4++R--
