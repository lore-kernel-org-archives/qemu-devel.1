Received: from eggs.gnu.org ([2001:4830:134:3::10]:59230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcCz5-0007SO-1z
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcCz2-00038y-BM
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:51:55 -0400
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcCz2-00037S-3q
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:51:52 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 8345766723
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 17:51:49 +0200 (CEST)
Date: Mon, 31 Jul 2017 17:51:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170731175139.5d569df6@bahia.lan>
In-Reply-To: <1501119055-4060-3-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1501119055-4060-3-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//IEilcbSdHapvCKH07Aecec";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/3] Revert "qdev: Free QemuOpts
 when the QOM path goes away"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, armbru@redhat.com

--Sig_//IEilcbSdHapvCKH07Aecec
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 20:30:54 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> This reverts commit abed886ec60cf239a03515cf0b30fb11fa964c44.
>=20
> This patch originally addressed an issue where a DEVICE_DELETED
> event could be emitted (in device_unparent()) before a Device's
> QemuOpts were cleaned up (in device_finalize()), leading to a
> "duplicate ID" error if management attempted to immediately add
> a device with the same ID in response to the DEVICE_DELETED event.
>=20
> An alternative will be implemented in a subsequent patch where we
> defer the DEVICE_DELETED event until device_finalize(), which would
> also prevent the race, so we revert the original fix in preparation.
>=20

Do you really need to revert abed886ec60cf239a03515cf0b30fb11fa964c44 ?

IIUC, the purpose of this series is to fix/workaround the VFIO cleanup issu=
e.
Even if it also relates to when we emit DEVICE_DELETED, it isn't exactly the
same problem here, is it ?

> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/core/qdev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index a64b35c..08c4061 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1067,6 +1067,7 @@ static void device_finalize(Object *obj)
>      NamedGPIOList *ngl, *next;
> =20
>      DeviceState *dev =3D DEVICE(obj);
> +    qemu_opts_del(dev->opts);
> =20
>      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
>          QLIST_REMOVE(ngl, node);
> @@ -1116,9 +1117,6 @@ static void device_unparent(Object *obj)
>          g_free(dev->canonical_path);
>          dev->canonical_path =3D NULL;
>      }
> -
> -    qemu_opts_del(dev->opts);
> -    dev->opts =3D NULL;
>  }
> =20
>  static void device_class_init(ObjectClass *class, void *data)


--Sig_//IEilcbSdHapvCKH07Aecec
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEUEARECAAYFAll/UgsACgkQAvw66wEB28LnXwCfQp04bhSdnPpKH3SSPHiygQrY
m4wAmJDmx+6QyXDAe9E/BuN1JrKSymk=
=3nYH
-----END PGP SIGNATURE-----

--Sig_//IEilcbSdHapvCKH07Aecec--
