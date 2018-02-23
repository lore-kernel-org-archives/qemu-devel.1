Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epGRX-0008AZ-5y
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epGRW-0003mP-AM
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:43:31 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-22-kwolf@redhat.com>
	<3482089d-ae14-ff82-6792-498de033c600@redhat.com>
	<20180223161951.GE3470@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bc9f6454-45eb-156f-5cef-cdc73c80249e@redhat.com>
Date: Fri, 23 Feb 2018 17:43:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180223161951.GE3470@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0MZONLhmX4cgv8XUDGsXtfDUSKiUeetVf"
Subject: Re: [Qemu-devel] [PATCH v2 21/36] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0MZONLhmX4cgv8XUDGsXtfDUSKiUeetVf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com,
 jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, qemu-devel@nongnu.org
Message-ID: <bc9f6454-45eb-156f-5cef-cdc73c80249e@redhat.com>
Subject: Re: [PATCH v2 21/36] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-22-kwolf@redhat.com>
 <3482089d-ae14-ff82-6792-498de033c600@redhat.com>
 <20180223161951.GE3470@localhost.localdomain>
In-Reply-To: <20180223161951.GE3470@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 17:19, Kevin Wolf wrote:
> Am 23.02.2018 um 00:25 hat Max Reitz geschrieben:
>> On 2018-02-21 14:53, Kevin Wolf wrote:
>>> With the conversion to a QAPI options object, the function is now
>>> prepared to be used in a .bdrv_co_create implementation.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
>>> -    *s_snap =3D g_strdup(snap);
>>> -    *s_image_name =3D g_strdup(image_name);
>>> +    *s_snap =3D g_strdup(opts->snapshot);
>>> +    *s_image_name =3D g_strdup(opts->image);
>>> =20
>>>      /* try default location when conf=3DNULL, but ignore failure */
>>> -    r =3D rados_conf_read_file(*cluster, conf);
>>> -    if (conf && r < 0) {
>>> -        error_setg_errno(errp, -r, "error reading conf file %s", con=
f);
>>> +    r =3D rados_conf_read_file(*cluster, opts->conf);
>>> +    if (opts->has_conf && r < 0) {
>>
>> Reading opts->conf without knowing whether opts->has_conf is true is a=

>> bit weird.  Would you mind "s->has_conf ? opts->conf : NULL" for the
>> rados_conf_read() call?
>>
>> On that thought, opts->snapshot and opts->user are optional, too.  Are=

>> they guaranteed to be NULL if they haven't been specified?  Should we
>> guard those accesses with opts->has_* queries, too?
>=20
> These days, both the QMP marshalling code (for the outermost struct whe=
n
> called from x-blockdev-create) and the input visitor (for nested struct=
s
> and non-QMP callers) initialise the objects with {0} and g_malloc0().
>=20
> I think Markus once told me that I shouldn't do pointless has_* checks
> any more in QMP commands, so I intentionally did the same here.

I'm a bit cautious because of non-zero defaults (like sslverify in the
ssh driver), but as long as you're aware...

Max


--0MZONLhmX4cgv8XUDGsXtfDUSKiUeetVf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqQRKESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbyUH/RhFrF/8g01p8Lk/nH3TZf01mTEd8Dzk
STxHo005q9cgInnbNUQSxE0WP4rR/2XPi1gbTtQbqtlhT1hYQmvZ/QyrJgxeZRBC
YbJQYERErL+zLzuEH40Z3CKtMV8IHeazsp3gMgRFkVOGfWI3erSO7G/qYl55lHmi
3IWEWFqJdmxUpnvncWCpbMatcSgtzZo9eKggBeW9QeSwPfTFZHP1/XXoF8tcBEHQ
okeZUzmHDEepnnMQCY7CmOhsuijV1/Cjq69oXe04df39Pxv7qQnmzFe/H/IYZjS6
SEZfq8AW3rW84gtT/dkiXC5Qk0/UKOzhmgEsRO5ofuGNkCCTZuGKX3k=
=IB9B
-----END PGP SIGNATURE-----

--0MZONLhmX4cgv8XUDGsXtfDUSKiUeetVf--
