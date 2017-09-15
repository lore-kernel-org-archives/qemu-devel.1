Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsyO0-000478-1B
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsyNz-00054C-0P
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:42:56 -0400
References: <cover.1501827395.git.maozy.fnst@cn.fujitsu.com>
	<3702d1b07f96d8b6f51c14fc62a48f68a1646004.1501827395.git.maozy.fnst@cn.fujitsu.com>
	<3d9adc5b-0cc4-ed0a-521c-265d9e3e5cb4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <162e5e37-d90d-9f25-ed73-9a7e914324c0@redhat.com>
Date: Fri, 15 Sep 2017 16:42:43 -0500
MIME-Version: 1.0
In-Reply-To: <3d9adc5b-0cc4-ed0a-521c-265d9e3e5cb4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KQn1MlIaphDDjnIdWFVxnT0teroi9vjN0"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/ide: Convert DeviceClass init to
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQn1MlIaphDDjnIdWFVxnT0teroi9vjN0
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <162e5e37-d90d-9f25-ed73-9a7e914324c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/ide: Convert DeviceClass init to
 realize
References: <cover.1501827395.git.maozy.fnst@cn.fujitsu.com>
 <3702d1b07f96d8b6f51c14fc62a48f68a1646004.1501827395.git.maozy.fnst@cn.fujitsu.com>
 <3d9adc5b-0cc4-ed0a-521c-265d9e3e5cb4@redhat.com>
In-Reply-To: <3d9adc5b-0cc4-ed0a-521c-265d9e3e5cb4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 04:35 PM, John Snow wrote:
>=20
>=20
> On 08/04/2017 06:26 AM, Mao Zhongyi wrote:
>> Replace init with realize in IDEDeviceClass, which has errp
>> as a parameter. So all the implementations now use error_setg
>> instead of error_report for reporting error.
>>

>> @@ -2398,7 +2399,7 @@ int ide_init_drive(IDEState *s, BlockBackend *bl=
k, IDEDriveKind kind,
>>                     const char *version, const char *serial, const cha=
r *model,
>>                     uint64_t wwn,
>>                     uint32_t cylinders, uint32_t heads, uint32_t secs,=

>> -                   int chs_trans)
>> +                   int chs_trans, Error **errp)
>=20
> this function now requires an additional invariant, which is that we
> must return -1 AND set errp. Probably wisest to just get rid of the
> return code so that we don't accidentally goof this up in the future.
>=20
> I think Markus has had some guidance on this in the past, but admittedl=
y
> I can't remember his preference.

Returning void requires callers to use boilerplate:

bar(..., Error **errp)
{
    Error *err =3D NULL;
    foo(..., &err);
    if (err) {
        error_propagate(errp, err);
        handle error ...;
        return;
    }
}

whereas keeping the invariant that a -1 return is synonymous with err
being set is simpler:

bar(..., Error **errp)
{
    if (foo(..., errp) < 0) {
        handle error ...;
        return;
    }
}

So these days, the preference is to KEEP the redundancy rather than
eliminate it, due to ease-of-use concerns.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KQn1MlIaphDDjnIdWFVxnT0teroi9vjN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8SVQACgkQp6FrSiUn
Q2qNJwf+LufKX0H5LHUfdhOqv3br8uFFNX2d1PjGwGdqUvqnszDGYA1TsEW8pFyp
7pKDrH5dLmR9e2cF5SKoUxuQgLHdfjZTQhAL5WkGr9FWLxAUucuzupxB4Wzjvb9s
OAtaHIvvXwmGbH9kuETWjkjD8WJNE3yTvzAOlS1T9foXiJ9/Be7oNChwZDKju4Rm
TVdqnbRnu7jcYR1C8c6gCmWvsjqtVV9vB4PvvQl75U4JcZYT8p4JGDEEy64Vh/Tl
2nBG/m6QzP1NwzO2dAewzAnXsTmT1d6FfI51JT33UdcDXIT9QO4FpfHsuVCpkRIz
J0flV8lsD2jofnioJqLrsYYCCkVlBA==
=oiA9
-----END PGP SIGNATURE-----

--KQn1MlIaphDDjnIdWFVxnT0teroi9vjN0--
