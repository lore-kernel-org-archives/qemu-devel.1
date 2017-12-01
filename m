Received: from eggs.gnu.org ([2001:4830:134:3::10]:41145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKqs5-0006DR-TZ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKqs4-00041d-Px
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:21:13 -0500
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
	<20171109154049.42386-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7f6f4e9a-16c1-9c57-55ac-ef30eb06f24b@redhat.com>
Date: Fri, 1 Dec 2017 20:21:02 +0100
MIME-Version: 1.0
In-Reply-To: <20171109154049.42386-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RXQCbf4G07jr63vWJuGibJ7T5vL4LXL7B"
Subject: Re: [Qemu-devel] [PATCH 2/2] qmp: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RXQCbf4G07jr63vWJuGibJ7T5vL4LXL7B
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, den@openvz.org
Message-ID: <7f6f4e9a-16c1-9c57-55ac-ef30eb06f24b@redhat.com>
Subject: Re: [PATCH 2/2] qmp: add nbd-server-remove
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
 <20171109154049.42386-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171109154049.42386-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 16:40, Vladimir Sementsov-Ogievskiy wrote:
> Add command for export removing. It is needed for cases when we
> don't want to keep export after the operation on it was completed.
> The other example is temporary node, created with blockdev-add.
> If we want to delete it we should firstly remove corresponding
> NBD export.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block.json | 20 ++++++++++++++++++++
>  blockdev-nbd.c  | 27 +++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)

Code looks good, just some documentation remarks:

> diff --git a/qapi/block.json b/qapi/block.json
> index f093fa3f27..1827940717 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -223,6 +223,26 @@
>  { 'command': 'nbd-server-add', 'data': {'device': 'str', '*writable': =
'bool'} }
> =20
>  ##
> +# @nbd-server-remove:
> +#
> +# Stop exporting block node through QEMU's embedded NBD server.

s/exporting block node/exporting a block node/

> +#
> +# @device: The device name or node name of the exported node. Should b=
e equal
> +#          to @device parameter for corresponding nbd-server-add comma=
nd call.

s/Should/Must/

This is indeed not the name of the node, but it is just the export name.
 Maybe the comment should more clearly say so (e.g. omit the first
sentence and change the second to "The export name, i.e. what has been
given to nbd-server-add as @device" or something).

> +#
> +# @force: Whether active connections to the export should be closed. I=
f this
> +#         parameter is false the export is only removed from named exp=
orts list,
> +#         so new connetions are impossible and it would be freed after=
 all

*connections

> +#         clients are disconnected (default false).
> +#
> +# Returns: error if the server is not running or the device is not mar=
ked for
> +#          export.

Maybe "[...] or there is no such NBD export."

(Because you can have a node attached to a device, specify the node name
for nbd-server-add and then you can't remove the export with the device
name even though technically that block device is exported)

Max

> +#
> +# Since: 2.12
> +##
> +{ 'command': 'nbd-server-remove', 'data': {'device': 'str', '*force': =
'bool'} }
> +
> +##
>  # @nbd-server-stop:
>  #
>  # Stop QEMU's embedded NBD server, and unregister all devices previous=
ly
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 28f551a7b0..5f66951c33 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -203,6 +203,33 @@ void qmp_nbd_server_add(const char *device, bool h=
as_writable, bool writable,
>      nbd_export_put(exp);
>  }
> =20
> +void qmp_nbd_server_remove(const char *device, bool has_force, bool fo=
rce,
> +                           Error **errp)
> +{
> +    NBDExport *exp;
> +
> +    if (!nbd_server) {
> +        error_setg(errp, "NBD server not running");
> +        return;
> +    }
> +
> +    exp =3D nbd_export_find(device);
> +    if (exp =3D=3D NULL) {
> +        error_setg(errp, "'%s' is not exported", device);
> +        return;
> +    }
> +
> +    if (!has_force) {
> +        force =3D false;
> +    }
> +
> +    if (force) {
> +        nbd_export_close(exp);
> +    } else {
> +        nbd_export_set_name(exp, NULL);
> +    }
> +}
> +
>  void qmp_nbd_server_stop(Error **errp)
>  {
>      nbd_export_close_all();
>=20



--RXQCbf4G07jr63vWJuGibJ7T5vL4LXL7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohq54SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AemQH/2IMnSKSQh1kkIUL7Zh5cg+CgM3nYMPS
dB7pvTq6Xb6uRfmJp9zEQBISvVlzGF65n9Kssjwl+evNYZWiZhfplLxNfvOuKnbU
oCI8RN/w2wIy3igCCz+hj8tAolAu4ZacgyRBRrrFRDCSAiu0mfVc8n6IgFaCMYDv
kOBlxmTsavoIq/6jyjSn5eFsfz4khGC/u5yZ3dg3xcCZVWAwya0Av0H6LvxXtAa8
NShu+QwunPFDkjFjpmEHFH0sLTCVGAcOxID0uhjDtGuEF7/oPPrqKc1P1YD4BTqa
rQaReO7iF3U+v1ilU2zuQY+/+mbIy9frTnqYSOH/e4tXZ8H+w9UFdZs=
=o6VF
-----END PGP SIGNATURE-----

--RXQCbf4G07jr63vWJuGibJ7T5vL4LXL7B--
