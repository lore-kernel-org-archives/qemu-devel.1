Received: from eggs.gnu.org ([2001:4830:134:3::10]:56362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgfdR-0003eC-QO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgfdO-00035u-IV
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:43:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgfdO-00033g-9E
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:43:42 -0500
References: <20170222192647.19690-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2e5c730-c47c-8a06-d5b0-820e6db61d5e@redhat.com>
Date: Wed, 22 Feb 2017 16:43:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170222192647.19690-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6upa1rsK6OtR6vc94gJWCH5dllwmdwpqH"
Subject: Re: [Qemu-devel] [libvirt] [PATCH RESEND] qdev: Make "hotplugged"
 property read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6upa1rsK6OtR6vc94gJWCH5dllwmdwpqH
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?=
 <afaerber@suse.de>
Message-ID: <f2e5c730-c47c-8a06-d5b0-820e6db61d5e@redhat.com>
Subject: Re: [libvirt] [PATCH RESEND] qdev: Make "hotplugged" property
 read-only
References: <20170222192647.19690-1-ehabkost@redhat.com>
In-Reply-To: <20170222192647.19690-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 01:26 PM, Eduardo Habkost wrote:
> The "hotplugged" property is user visible, but it was never meant
> to be set by the user. There are probably multiple ways to break
> or crash device code by overriding the property. For example, we
> recently fixed a crash in rtc_set_memory() related to the
> property (commit 26ef65beab852caf2b1ef4976e3473f2d525164d).
>=20
> There has been some discussion about making management software
> use "hotplugged=3Don" on migration, to indicate devices that were
> hotplugged in the migration source. There were other suggestions
> to address this, like including the "hotplugged" field in the
> migration stream instead of requiring it to be set propertly.

s/propertly/properly/

>=20
> Whatever solution we choose in the future, this patch disables
> setting "hotplugged" explicitly in the command-line by now,
> because the ability to set the property is unused, untested, and
> undocumented.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/qdev.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 06ba02e2a3..800c9ca23f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1016,13 +1016,6 @@ static bool device_get_hotplugged(Object *obj, E=
rror **err)
>      return dev->hotplugged;
>  }
> =20
> -static void device_set_hotplugged(Object *obj, bool value, Error **err=
)
> -{
> -    DeviceState *dev =3D DEVICE(obj);
> -
> -    dev->hotplugged =3D value;
> -}
> -
>  static void device_initfn(Object *obj)
>  {
>      DeviceState *dev =3D DEVICE(obj);
> @@ -1042,7 +1035,7 @@ static void device_initfn(Object *obj)
>      object_property_add_bool(obj, "hotpluggable",
>                               device_get_hotpluggable, NULL, NULL);
>      object_property_add_bool(obj, "hotplugged",
> -                             device_get_hotplugged, device_set_hotplug=
ged,
> +                             device_get_hotplugged, NULL,
>                               &error_abort);
> =20
>      class =3D object_get_class(OBJECT(dev));
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6upa1rsK6OtR6vc94gJWCH5dllwmdwpqH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrhQZAAoJEKeha0olJ0NqYkYH/iD5vHGqLx51Cm2xqqozgWgW
NR/e6N6MnklYiRrYQtRysLboFkjg2yPWe/pxGM+nMpY1RTaiPS+YbWzJxPwUF+9q
U39OAhE89OTJCTUm32f32Cs+rIH/5Ax+o+fPWmGlxfwR8DkHLFkC7BzhyilfJWRT
jM5kPH5Jfu7Chk8ZA6J3CJGYrLE5bufR5pGoPPlnbqO/GNBCWWd0NANVSxaOjRw7
eQkBv3gxCdjWG5bbCmm+/OO1+KDiV+scdYe1F80IEG2ceMAB8S1XVIR6mFOGTAwl
SglwQUkWvi6QZzphwB99gfom8sayt+kFWsFqlXvPwwTUhRI3+2f+jaQ2G7BwNug=
=AqFF
-----END PGP SIGNATURE-----

--6upa1rsK6OtR6vc94gJWCH5dllwmdwpqH--
