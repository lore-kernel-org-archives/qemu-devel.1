Received: from eggs.gnu.org ([2001:4830:134:3::10]:49318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMZd-0003XG-Hz
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMZc-00032R-LY
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:00:57 -0400
References: <20170412164445.23039-1-berrange@redhat.com>
	<20170412164445.23039-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a4c226c-4c91-10d0-50f7-0cd83dbe377b@redhat.com>
Date: Wed, 12 Apr 2017 13:00:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170412164445.23039-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D1PuU4MRwU8XxukahDjBI4n9eR0ojB7t1"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D1PuU4MRwU8XxukahDjBI4n9eR0ojB7t1
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <6a4c226c-4c91-10d0-50f7-0cd83dbe377b@redhat.com>
Subject: Re: [PATCH v4 4/4] qemu-img: copy *key-secret opts when opening newly
 created files
References: <20170412164445.23039-1-berrange@redhat.com>
 <20170412164445.23039-5-berrange@redhat.com>
In-Reply-To: <20170412164445.23039-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 11:44 AM, Daniel P. Berrange wrote:
> The qemu-img dd/convert commands will create a image file and
> then try to open it. Historically it has been possible to open
> new files without passing any options. With encrypted files
> though, the *key-secret options are mandatory, so we need to
> provide those options when opening the newly created file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


> @@ -332,6 +334,33 @@ static BlockBackend *img_open_file(const char *fil=
ename,
>  }
> =20
> =20
> +static int img_add_key_secrets(void *opaque,
> +                               const char *name, const char *value,
> +                               Error **errp)
> +{
> +    QDict *options =3D opaque;
> +
> +    if (g_str_has_suffix(name, "key-secret")) {
> +        qdict_put(options, name, qstring_from_str(value));

If my patch to add qdict_put_str() lands (probably through Markus'
qapi-next tree) before yours, you can simplify this line. If yours lands
first, we just rerun my Coccinelle script to simplify it as part of my
patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D1PuU4MRwU8XxukahDjBI4n9eR0ojB7t1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7ms+AAoJEKeha0olJ0NqozgH/0tOPq3qxajqwc6vKnHqchgr
F8U2NivAXyBQ9KrMpd1equrw3LSyCtB494fqbmzRtXo9Iq22MpPUV0ZtifYAvGM0
NwjeSKCsz6hTnLvvAJ7zjnmC3gOEjUqKNxi0F0fd5GNfGCRrpJUWZjTZmtEuABUz
Nc6JDmCkBdiRvwiU8mzdaxXQOz8rPXflClNZu7R8N5JBb0cQCEtbWB5mCxsK/PAN
pAnr/shKOaUQcoHSHhS9upUjWtRIj7eCmaZ3Zl7qW+42U/dyMOiwELw8nZLnSuEO
MKfTkQIR2kyXYhls2I6CcIuWeN/bumKaCc88xOgzpazl5tt/A27B+8ris9jUv2Q=
=mI0F
-----END PGP SIGNATURE-----

--D1PuU4MRwU8XxukahDjBI4n9eR0ojB7t1--
