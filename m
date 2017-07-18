Received: from eggs.gnu.org ([2001:4830:134:3::10]:44760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWOi-0007Pv-1r
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWOh-0008OM-37
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:35:00 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6bf7ff84-5286-fd21-c9a8-f25f2e37df50@redhat.com>
Date: Tue, 18 Jul 2017 12:34:49 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i9OBQpnmbMBvTgF7I71MKaUHwcsRqd457"
Subject: Re: [Qemu-devel] [PATCH for-2.10 06/10] hmp: Clean up and simplify
 hmp_migrate_set_parameter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i9OBQpnmbMBvTgF7I71MKaUHwcsRqd457
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <6bf7ff84-5286-fd21-c9a8-f25f2e37df50@redhat.com>
Subject: Re: [PATCH for-2.10 06/10] hmp: Clean up and simplify
 hmp_migrate_set_parameter()
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> The bulk of hmp_migrate_set_parameter()'s code sets one member of
> MigrationParameters according to the command's arguments.  It uses a
> string visitor for integer and boolean members, but not for string and
> size members.  It calls visit_type_bool() right away, but delays
> visit_type_int() some.  The delaying requires a flag variable and a
> bit of trickery: we set all integer members instead of just the one we
> want, and rely on the has_FOOs to mask the unwanted ones.
>=20
> Clean this up as follows.  Don't delay calling visit_type_int().  Use
> the string visitor for strings, too.  This involves extra allocations
> and cleanup, but doing them is simpler and cleaner than avoiding them.
>=20
> Sadly, using the string visitor for sizes isn't possible, because it
> defaults to Bytes rather than Mebibytes.  Add a comment explaining
> that.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c | 78 ++++++++++++++++++++++++++++-------------------------------=
--------
>  1 file changed, 32 insertions(+), 46 deletions(-)
>

Diffstat says it's cleaner.

>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
> -                p.has_max_bandwidth =3D true;
> +                p->has_max_bandwidth =3D true;
> +                /*
> +                 * Can't use visit_type_size() here, because it
> +                 * defaults to Bytes rather than Mebibytes.
> +                 */
>                  ret =3D qemu_strtosz_MiB(valuestr, NULL, &valuebw);

Can we munge valuestr (if it has a suffix, leave it alone; if it has
none, tack on "M"), and then call the size visitor as usual?

>                  if (ret < 0 || valuebw > INT64_MAX
>                      || (size_t)valuebw !=3D valuebw) {
>                      error_setg(&err, "Invalid size %s", valuestr);
> -                    goto cleanup;
> +                    break;
>                  }

But for now, the inline version works.

> -                /* Set all integers; only one has_FOO will be set, and=

> -                 * the code ignores the remaining values */
> -                p.compress_level =3D valueint;
> -                p.compress_threads =3D valueint;
> -                p.decompress_threads =3D valueint;
> -                p.cpu_throttle_initial =3D valueint;
> -                p.cpu_throttle_increment =3D valueint;
> -                p.downtime_limit =3D valueint;
> -                p.x_checkpoint_delay =3D valueint;
> +            if (err) {
> +                goto cleanup;
>              }
> =20
> -            qmp_migrate_set_parameters(&p, &err);

The old code is calling qmp_migrate_set_parameters() once per loop
iteration, because it could only parse one integer per loop.

> +            qmp_migrate_set_parameters(p, &err);

But couldn't you now sink this below the loop, and call it only once
after all members are parsed?  Can be a separate patch, though.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--i9OBQpnmbMBvTgF7I71MKaUHwcsRqd457
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluRrkACgkQp6FrSiUn
Q2rgNQf+LkfqKWzbZIlyMYH6PaTZjQ6up/C5wO5U1q7Ux/hvPqOoF1t15wNS48J/
mbq2L+DXH+cD/t0Bggb/jq2Br0wH96hyIwiC5PWQn5pVnQ1HVmOoAsEcPEURtkRy
8Cdt2MKLI6KYoCKFlJjaOBgRaWazVTPNWErdxBBgGaRkd7Em+suwbleAN8qfaUlF
34wY83TxN06OcN8BBoKk/uH5sFcZdgatePl5NggZyZU5QzkSdvxvPVIiKxHV7h1V
/eI3mQjhjr/d4hzOeJFXlMCQFohPZ6Xm3B1adUMsHoljaOGEPbto+oIWIuDSM+LR
0FRfHQH62mvQYj1wLGMN5wAxy0IO1g==
=LRC6
-----END PGP SIGNATURE-----

--i9OBQpnmbMBvTgF7I71MKaUHwcsRqd457--
