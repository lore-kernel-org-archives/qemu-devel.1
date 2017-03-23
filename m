Received: from eggs.gnu.org ([2001:4830:134:3::10]:46519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3Pu-0002Jl-VL
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3Pq-0004Jl-S5
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr3Pq-0004Jc-Hy
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:08:38 -0400
References: <20170323000645.10756-1-vfeenstr@redhat.com>
	<20170323000645.10756-2-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f914be20-d9d0-6681-e754-f84e60725865@redhat.com>
Date: Thu, 23 Mar 2017 09:08:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170323000645.10756-2-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9ESCVs7FOASohIFOVcGV3I8BOugXBL0FB"
Subject: Re: [Qemu-devel] [PATCH v3] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, sameeh@daynix.com, marcandre.lureau@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ESCVs7FOASohIFOVcGV3I8BOugXBL0FB
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, sameeh@daynix.com, marcandre.lureau@gmail.com
Message-ID: <f914be20-d9d0-6681-e754-f84e60725865@redhat.com>
Subject: Re: [PATCH v3] qga: Add `guest-get-timezone` command
References: <20170323000645.10756-1-vfeenstr@redhat.com>
 <20170323000645.10756-2-vfeenstr@redhat.com>
In-Reply-To: <20170323000645.10756-2-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 07:06 PM, Vinzenz 'evilissimo' Feenstra wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
>  qga/commands.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>=20
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..1debc91 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,45 @@ int ga_parse_whence(GuestFileWhence *whence, Error=
 **errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
> +
> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{
> +    GuestTimezone *info =3D g_new0(GuestTimezone, 1);
> +    if (info =3D=3D NULL) {

Dead code. g_new0() can't fail (or rather, if you are out of memory, it
exit()s so that you can't reach subsequent code)


> +
> +    gint32 interval =3D g_time_zone_find_interval(tz, G_TIME_TYPE_STAN=
DARD, 0);
> +    if (interval !=3D -1) {
> +        gchar const *name =3D g_time_zone_get_abbreviation(tz, interva=
l);
> +        if (name !=3D NULL) {
> +            info->offset =3D g_time_zone_get_offset(tz, interval);
> +            info->zone =3D g_strdup(name);

Should name be optional?  Offsets are the important part, while the name
is just informative.  So I hate to see us giving up just because someone
picked an offset that has no name.


> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,29 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +
> +##
> +# @GuestTimezone:
> +#
> +# @zone:    Timezone name
> +# @offset:  Offset to UTC in seconds. For western timezones the offset=
 has a
> +#           negative value and for eastern the offset is positive valu=
e
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestTimezone',
> +  'data':   { 'zone': 'str', 'offset': 'int' } }

To make the name optional, use '*zone', and be sure to set has_zone in
the C code.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9ESCVs7FOASohIFOVcGV3I8BOugXBL0FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09bjAAoJEKeha0olJ0NqOK0IAJr97d4OJe8uey7Qmn9CwiPT
Ex/AMhYIXgtIWA12thEhGBOGL7z9nGm41LwJCFeHQUnmo7qOLlilYqwNPd3wFIgm
vxAnyD0F+NsL5tzX6aL7Ai5u6hsVIeO/u1QFxLUDgD1DPGzM1UwbaKG0kDH/DT1U
srbJ5hUU14tT9SljUviTcxTUTjl4B3yM/aohNKKJt8VSYa2CmK2MefpJKGrwPZLy
T4ZlpznfTXR9arRgN7zkPEvfpSRzimrav2iLUiTOrZ7o2IT4TFmqricahz2ZwfFX
l4XtvAma9ZKPA+Z3Ec3m+HWY8QLYv632FN4pcnNo3YKJYhIi9twtJNAs/cHfbVw=
=Rpfp
-----END PGP SIGNATURE-----

--9ESCVs7FOASohIFOVcGV3I8BOugXBL0FB--
