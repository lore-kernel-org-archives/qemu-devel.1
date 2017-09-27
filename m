Received: from eggs.gnu.org ([2001:4830:134:3::10]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxKAX-00031O-54
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxKAV-0008Pd-Uz
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:47:01 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-2-eblake@redhat.com>
	<8ded19fb-d0dc-d816-b045-07184bf77db3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fce419bf-ab25-bffc-6324-b67df444abaf@redhat.com>
Date: Wed, 27 Sep 2017 16:46:14 -0500
MIME-Version: 1.0
In-Reply-To: <8ded19fb-d0dc-d816-b045-07184bf77db3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SxATl5241CbuK4vBn211jBuTEiNLgtUNe"
Subject: Re: [Qemu-devel] [PATCH v4 01/23] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SxATl5241CbuK4vBn211jBuTEiNLgtUNe
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <fce419bf-ab25-bffc-6324-b67df444abaf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/23] block: Allow NULL file for
 bdrv_get_block_status()
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-2-eblake@redhat.com>
 <8ded19fb-d0dc-d816-b045-07184bf77db3@redhat.com>
In-Reply-To: <8ded19fb-d0dc-d816-b045-07184bf77db3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 05:43 PM, John Snow wrote:
>=20
>=20
> On 09/13/2017 12:03 PM, Eric Blake wrote:
>> Not all callers care about which BDS owns the mapping for a given
>> range of the file.  This patch merely simplifies the callers by
>> consolidating the logic in the common call point, while guaranteeing
>> a non-NULL file to all the driver callbacks, for no semantic change.
>> The only caller that does not care about pnum is bdrv_is_allocated,
>> as invoked by vvfat; we can likewise add assertions that the rest
>> of the stack does not have to worry about a NULL pnum.
>>
>> Furthermore, this will also set the stage for a future cleanup: when
>> a caller does not care about which BDS owns an offset, it would be
>> nice to allow the driver to optimize things to not have to return
>> BDRV_BLOCK_OFFSET_VALID in the first place.  In the case of fragmented=

>> allocation (for example, it's fairly easy to create a qcow2 image
>> where consecutive guest addresses are not at consecutive host
>> addresses), the current contract requires bdrv_get_block_status()
>> to clamp *pnum to the limit where host addresses are no longer
>> consecutive, but allowing a NULL file means that *pnum could be
>> set to the full length of known-allocated data.
>>
>=20
> Function reads slightly worse for the wear now with all of the return
> logic handled at various places within, but unifying it might be even
> stranger, perhaps..
>=20
> Let's see if I hate this more:
>=20
> out:
> bdrv_dec_in_flight(bs);
>     bdrv_dec_in_flight(bs);
>     if (ret >=3D 0 && sector_num + *pnum =3D=3D total_sectors) {
>         ret |=3D BDRV_BLOCK_EOF;
>     }
> early_out:
>     if (file) {
>         *file =3D local_file;
>     }
>     return ret;
>=20
>=20
> and then earlier in the function, we can just:
>=20
> if (total_sectors < 0) {
>   ret =3D total_sectors;
>   goto early_out;
> }

Seems reasonable enough, I'll work that in to v5, since there are other
reasons to respin the series anyway.

>=20
> It's only shed paint, though:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> I'm looking at the rest of the series now, so please stand by.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SxATl5241CbuK4vBn211jBuTEiNLgtUNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnMHCYACgkQp6FrSiUn
Q2rxmAf/ZY9Wd+yqJmzFTdA2edlktagg3jPQrjzF9jwiTxHMwUmUolHNv7Lg4gOK
PwOYwSb+ctb+FARaI1RmmsgGS1fH1+JXbRnPjmrWHgqn4yN0UPFS7xjWUjJ0pVvw
kA5rGSzRPEBhdudmhQXJKfDHTt8B3wxPAedy6Mq4KNDwGH6pMIt+K4xtXF4Mr47p
Bh4Fcv0v1Q4ETTnKt8fYIXK9ZvDqcoOVjifnNeTt0Ok0TfyaLi+XKcp8qIvs892x
XmNoCl2CYhluy0ns58lFkvRij2xayV+pPI9MFGZvVQ1bi8uEIc7CmgcUf4+QZNIy
e/rYQ/hZgIrYvGTA3NFoCsi6noq4OQ==
=+c60
-----END PGP SIGNATURE-----

--SxATl5241CbuK4vBn211jBuTEiNLgtUNe--
