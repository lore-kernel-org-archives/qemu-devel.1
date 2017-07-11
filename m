Received: from eggs.gnu.org ([2001:4830:134:3::10]:44119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dUv2H-0002NQ-D8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dUv2C-0003d8-CJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:17:05 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:47601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dUv2C-0003cs-6j
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:17:00 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B569B68056
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 15:16:58 +0200 (CEST)
Date: Tue, 11 Jul 2017 15:16:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170711151653.62d52954@bahia.lan>
In-Reply-To: <20170711004303.3902-4-ehabkost@redhat.com>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/.Vaq/hevITL27bqFlj/w2B4";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/3] Revert "machine: Convert abstract
 typename on compat_props to subclass names"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

--Sig_/.Vaq/hevITL27bqFlj/w2B4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Jul 2017 21:43:03 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> This reverts commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2.
>=20
> The bug addressed by that commit is now fixed in a better way by the
> commit "qdev: fix the order compat and global properties are applied".
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/core/machine.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ecb5552..1d10b01 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -770,18 +770,11 @@ static void machine_class_finalize(ObjectClass *kla=
ss, void *data)
>      g_free(mc->name);
>  }
> =20
> -static void machine_register_compat_for_subclass(ObjectClass *oc, void *=
opaque)
> -{
> -    GlobalProperty *p =3D opaque;
> -    register_compat_prop(object_class_get_name(oc), p->property, p->valu=
e);
> -}
> -
>  void machine_register_compat_props(MachineState *machine)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      int i;
>      GlobalProperty *p;
> -    ObjectClass *oc;
> =20
>      if (!mc->compat_props) {
>          return;
> @@ -789,22 +782,9 @@ void machine_register_compat_props(MachineState *mac=
hine)
> =20
>      for (i =3D 0; i < mc->compat_props->len; i++) {
>          p =3D g_array_index(mc->compat_props, GlobalProperty *, i);
> -        oc =3D object_class_by_name(p->driver);
> -        if (oc && object_class_is_abstract(oc)) {
> -            /* temporary hack to make sure we do not override
> -             * globals set explicitly on -global: if an abstract class
> -             * is on compat_props, register globals for all its
> -             * non-abstract subtypes instead.
> -             *
> -             * This doesn't solve the problem for cases where
> -             * a non-abstract typename mentioned on compat_props
> -             * has subclasses, like spapr-pci-host-bridge.
> -             */
> -            object_class_foreach(machine_register_compat_for_subclass,
> -                                 p->driver, false, p);
> -        } else {
> -            register_compat_prop(p->driver, p->property, p->value);
> -        }
> +        /* Machine compat_props must never cause errors: */
> +        p->errp =3D &error_abort;
> +        qdev_prop_register_global(p);
>      }
>  }
> =20


--Sig_/.Vaq/hevITL27bqFlj/w2B4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllkz8UACgkQAvw66wEB28LYrwCfZygq6A3MF6Qcm+B5IOYMlsF5
D1MAn05GDHZJeFJILz9Q9r8fs+gdPw6F
=9q7P
-----END PGP SIGNATURE-----

--Sig_/.Vaq/hevITL27bqFlj/w2B4--
