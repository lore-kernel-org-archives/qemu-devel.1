Received: from eggs.gnu.org ([2001:4830:134:3::10]:33081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqsr-00050R-Cs
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqsq-0001j4-0Y
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:20:09 -0500
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-24-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <711102c9-cd43-6c6f-cf2e-422251bbb211@redhat.com>
Date: Fri, 17 Feb 2017 16:19:58 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-24-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h7Tm1mJPoBfsIbhcUpk1rSF2Wrs6LuUNF"
Subject: Re: [Qemu-devel] [PATCH 23/24] util/cutils: Change qemu_strtosz*()
 from int64_t to uint64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7Tm1mJPoBfsIbhcUpk1rSF2Wrs6LuUNF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <711102c9-cd43-6c6f-cf2e-422251bbb211@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/24] util/cutils: Change qemu_strtosz*()
 from int64_t to uint64_t
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-24-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> This will permit its use in parse_option_size().

Progress!  (not that it matters - off_t is a signed value, so you are
STILL limited to 2^63, not 2^64, as the maximum theoretical size storage
that you can target - and it's not like we have that much storage even
accessible)

>=20
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
> Cc: qemu-block@nongnu.org (open list:Block layer core)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/hmp.c
> @@ -1338,7 +1338,7 @@ void hmp_migrate_set_parameter(Monitor *mon, cons=
t QDict *qdict)
>  {
>      const char *param =3D qdict_get_str(qdict, "parameter");
>      const char *valuestr =3D qdict_get_str(qdict, "value");
> -    int64_t valuebw =3D 0;
> +    uint64_t valuebw =3D 0;
>      long valueint =3D 0;
>      Error *err =3D NULL;
>      bool use_int_value =3D false;
> @@ -1379,7 +1379,8 @@ void hmp_migrate_set_parameter(Monitor *mon, cons=
t QDict *qdict)
>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>                  p.has_max_bandwidth =3D true;
>                  ret =3D qemu_strtosz_mebi(valuestr, NULL, &valuebw);
> -                if (ret < 0 || (size_t)valuebw !=3D valuebw) {
> +                if (ret < 0 || valuebw > INT64_MAX
> +                    || (size_t)valuebw !=3D valuebw) {

I don't know if this looks any better as:

if (ret < 0 || valuebw > MIN(INT64_MAX, SIZE_MAX))

so don't bother changing it if you think that's ugly.

> +++ b/qapi/opts-visitor.c
> @@ -481,7 +481,6 @@ opts_type_size(Visitor *v, const char *name, uint64=
_t *obj, Error **errp)
>  {
>      OptsVisitor *ov =3D to_ov(v);
>      const QemuOpt *opt;
> -    int64_t val;
>      int err;
> =20
>      opt =3D lookup_scalar(ov, name, errp);
> @@ -489,14 +488,13 @@ opts_type_size(Visitor *v, const char *name, uint=
64_t *obj, Error **errp)
>          return;
>      }
> =20
> -    err =3D qemu_strtosz(opt->str ? opt->str : "", NULL, &val);
> +    err =3D qemu_strtosz(opt->str ? opt->str : "", NULL, obj);
>      if (err < 0) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
> -                   "a size value representible as a non-negative int64=
");

Nice - you're killing the unusual variant spelling of representable.

> +++ b/util/cutils.c
> @@ -207,7 +207,7 @@ static int64_t suffix_mul(char suffix, int64_t unit=
)
>   */
>  static int do_strtosz(const char *nptr, char **end,
>                        const char default_suffix, int64_t unit,
> -                      int64_t *result)
> +                      uint64_t *result)
>  {
>      int retval;
>      char *endptr;
> @@ -237,7 +237,11 @@ static int do_strtosz(const char *nptr, char **end=
,
>          retval =3D -EINVAL;
>          goto out;
>      }
> -    if ((val * mul >=3D INT64_MAX) || val < 0) {
> +    /*
> +     * Values >=3D 0xfffffffffffffc00 overflow uint64_t after their tr=
ip
> +     * through double (53 bits of precision).
> +     */
> +    if ((val * mul >=3D 0xfffffffffffffc00) || val < 0) {

I guess there's not any simpler expression using INT64_MAX and
operations (including casts to double and int64_t) that would reliably
produce the same constant that you just open-coded here.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--h7Tm1mJPoBfsIbhcUpk1rSF2Wrs6LuUNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp3cOAAoJEKeha0olJ0Nq8GsH/RjOran3jbKpz3oypJks/kQ3
zdrmF4teRq2/uc5kpXc5VtqBxQ8+X9Ee6Zx5LWjm7z3D354qB9HYd70UTgbU9DXH
KL/MB6Wz8Kqfjzkc37ZwHX0vxuAR8r24nYcQh8WR2AJkbHmVs+/5imgxaY9Ih55w
deMRseC2ItKQqtfD+8ugMd0ZXqypsEDmLOCBIuXRrUlVpamLfPrAfBJN70sIC7/M
PCe9qF0j1x3PjtmiEdU9kOteNkFYvGfIzyhq/9niDpJUx5QWYUKVMmlEpcT6r4D+
Dv35LTjTEqrJg8inYr1WdjXckiSFfbOVBNCuv6+SVIAb4Sc5RWeZfw9x6CwMZjw=
=melk
-----END PGP SIGNATURE-----

--h7Tm1mJPoBfsIbhcUpk1rSF2Wrs6LuUNF--
