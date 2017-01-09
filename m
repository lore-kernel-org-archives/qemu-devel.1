Received: from eggs.gnu.org ([2001:4830:134:3::10]:41153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQeHX-0007Iv-VD
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQeHU-0003Xy-2Z
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:02:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQeHT-0003XQ-RJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 13:02:52 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4C9EC057FA7
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 18:02:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-21-marcandre.lureau@redhat.com>
Message-ID: <7b1f56d5-adfd-f57b-312d-ec7e2383bbf5@redhat.com>
Date: Mon, 9 Jan 2017 12:02:49 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-21-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jIqC8AbcmSuQFcFAewemCowWShrnJqijF"
Subject: Re: [Qemu-devel] [PATCH 20/20] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jIqC8AbcmSuQFcFAewemCowWShrnJqijF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <7b1f56d5-adfd-f57b-312d-ec7e2383bbf5@redhat.com>
Subject: Re: [PATCH 20/20] chardev: qom-ify
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Turn Chardev into Object.
>=20
> qemu_chr_alloc() is replaced by the qemu_chardev_new() constructor. It
> will call qemu_char_open() to open/intialize the chardev with the
> ChardevCommon *backend settings.
>=20
> The CharDriver::create() callback is turned into a ChardevClass::open()=

> which is called from the newly introduced qemu_chardev_open().
>=20
> "chardev-gdb" and "chardev-hci" are internal chardev and aren't
> creatable directly with -chardev. Use a new internal flag to disable
> them. We may want to use TYPE_USER_CREATABLE interface instead, or
> perhaps allow -chardev usage.
>=20
> Although in general we keep typename and macros private, unless the typ=
e
> is being used by some other file, in this patch, all types and common
> helper macros for qemu-char.c are in char.h. This is to help transition=

> now (some types must be declared early, while some aren't shared) and
> when splitting in several units. This is to be improved later.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/qemu-char.c

> @@ -466,7 +433,8 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fd=
s, int len)
>          return -1;
>      }
> =20
> -    return s->driver->get_msgfds ? s->driver->get_msgfds(s, fds, len) =
: -1;
> +    return CHARDEV_GET_CLASS(s)->get_msgfds ?
> +        CHARDEV_GET_CLASS(s)->get_msgfds(s, fds, len) : -1;

I'm not familiar enough with the Object hierarchy to know if there is
any significant runtime cost to CHARDEV_GET_CLASS() that would warrant
capturing the output in a temporary variable, or if it is simple enough
that a compiler can already figure out that it is a reusable value
rather than computing it twice.  Probably not worrying about, though,
unless it actually shows up in a hot spot on a trace.


> @@ -4957,47 +4994,96 @@ void qemu_chr_set_feature(Chardev *chr,
>      return set_bit(feature, chr->features);
>  }
> =20
> -ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend=
,
> -                               Error **errp)
> +static const ChardevClass *char_get_class(const char *driver, Error **=
errp)
> +{
> +    ObjectClass *oc;
> +    const ChardevClass *cc;
> +    char *typename =3D g_strdup_printf("chardev-%s", driver);
> +
> +    oc =3D object_class_by_name(typename);
> +    g_free(typename);

char_get_class("tty", NULL) will fail, because that's merely an alias
name rather than the canonical "serial" name. Will that matter to any of
the code? I didn't spot anything, so I'm not letting it stop my review.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org



--jIqC8AbcmSuQFcFAewemCowWShrnJqijF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYc9BJAAoJEKeha0olJ0Nq+mYIAJSVnbGsNDnJXUTGi+ZmGRqH
HkTt/QDB5Tx4QZaof8DuyOWz5LkUNmMjUchpwga2Z+c+G+uQjcGy5NU13Fs84qZw
lBOj2sTkywy5Fk/BHHtxdR4G3iJzGCt7OB8WJYl2EawW9GT451x2Vaz33u9yaRIm
szhi7NOElYN55oJItPOEsAJOrYnytMoK8etfpzx8gaoQJC/LKnnIDfxjOrBNoPyh
kkygjTLWHCQXwIe5l5IeZcI0S0WB8dyXkmDdbM6C7/Q5uMG9qWx8nwBxsCtc6zQF
EC/CtGyv51Sqwg5TbPcuMfH4JJpMCmtwD5qCeReFe7DZm0yt/mCb3jXHCqoaa3M=
=gqGj
-----END PGP SIGNATURE-----

--jIqC8AbcmSuQFcFAewemCowWShrnJqijF--
