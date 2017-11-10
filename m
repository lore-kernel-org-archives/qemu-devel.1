Received: from eggs.gnu.org ([2001:4830:134:3::10]:43237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDH7z-0006mV-TO
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDH7z-0002vh-1I
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:46:19 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5fd7f83-b0f6-6029-6dcc-86ac132f59c4@redhat.com>
Date: Fri, 10 Nov 2017 15:46:08 -0600
MIME-Version: 1.0
In-Reply-To: <20171110203111.7666-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ov75DW1x92P0GQl8wvAPuxW5JnFBhiDkE"
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/5] block: Guard against NULL
 bs->drv
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
--ov75DW1x92P0GQl8wvAPuxW5JnFBhiDkE
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <e5fd7f83-b0f6-6029-6dcc-86ac132f59c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/5] block: Guard against NULL
 bs->drv
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-4-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 02:31 PM, Max Reitz wrote:
> We currently do not guard everywhere against a NULL bs->drv where we
> should be doing so.  Most of the places fixed here just do not care
> about that case at all.
>=20
> Some care implicitly, e.g. through a prior function call to
> bdrv_getlength() which would always fail for an ejected BDS.  Add an
> assert there to make it more obvious.
>=20
> Other places seem to care, but do so insufficiently: Freeing clusters i=
n
> a qcow2 image is an error-free operation, but it may leave the image in=

> an unusable state anyway.  Giving qcow2_free_clusters() an error code i=
s
> not really viable, it is much easier to note that bs->drv may be NULL
> even after a successful driver call.  This concerns bdrv_co_flush(), an=
d
> the way the check is added to bdrv_co_pdiscard() (in every iteration
> instead of only once).
>=20
> Finally, some places employ at least an assert(bs->drv); somewhere, tha=
t
> may be reasonable (such as in the reopen code), but in
> bdrv_has_zero_init(), it is definitely not.  Returning 0 there in case
> of an ejected BDS saves us much headache instead.
>=20
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1728660
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/block/replication.c

> =20
> +    if (!s->hidden_disk->bs->drv) {
> +        error_setg(errp, "Hidden disk %s is ejected",
> +                   s->hidden_disk->bs->node_name);
> +        return;
> +    }

How would the hidden disk ever be ejected?  Could this be an assert inste=
ad?

But what you have is equally safe, so
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ov75DW1x92P0GQl8wvAPuxW5JnFBhiDkE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGHiAACgkQp6FrSiUn
Q2pToQf/aUZ5iPCFTA9LGnHjLDB3X4WDKUGRCd4lTp4Lc8rdPBAlgGRtEqwrnh9c
S7Ln0T7p8VNqOaKPzVs9rFdxgivDBJOaJHl8d90dJZzTy0i7wSdV97WBQWB1EkNI
8YLg2yp38y/uKczQ33NK9EkuQ+fN6wBXVI3Nsjfbn3nrCpf21iBcPDwpz3i5TRM9
0msZLaaf0UQwqeIM+q98mnXZEN7+kihNazCMrQ5qlBN5+kZPnujeaXgpky33cjt/
2VhUaZ/fY4NilksxPkF7gqbopk5J7WyKWeCTBxnTHBmX8X5KoStVorrVxRsAp6f6
/uBkWpHDLBi5pkC3p70ILuSZx4muoQ==
=TtRR
-----END PGP SIGNATURE-----

--ov75DW1x92P0GQl8wvAPuxW5JnFBhiDkE--
