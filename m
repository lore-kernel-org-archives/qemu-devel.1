Received: from eggs.gnu.org ([2001:4830:134:3::10]:44063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dUv25-0002H7-Ml
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dUv20-0003X8-Kt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:16:53 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:47099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dUv20-0003VD-Dr
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:16:48 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8306C67774
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 15:16:40 +0200 (CEST)
Date: Tue, 11 Jul 2017 15:16:34 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170711151634.4f66bf5c@bahia.lan>
In-Reply-To: <20170711004303.3902-3-ehabkost@redhat.com>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/R8PT.uVsD4CWJF._vkxtc9j";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/3] test-qdev-global-props: Test global
 property ordering
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

--Sig_/R8PT.uVsD4CWJF._vkxtc9j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Jul 2017 21:43:02 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Test case to detect the bug fixed by commit
> "qdev: fix the order compat and global properties are applied".
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/test-qdev-global-props.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
> index 48e5b73..ef2951f 100644
> --- a/tests/test-qdev-global-props.c
> +++ b/tests/test-qdev-global-props.c
> @@ -33,6 +33,8 @@
>  #define STATIC_TYPE(obj) \
>      OBJECT_CHECK(MyType, (obj), TYPE_STATIC_PROPS)
> =20
> +#define TYPE_SUBCLASS "static_prop_subtype"
> +
>  #define PROP_DEFAULT 100
> =20
>  typedef struct MyType {
> @@ -63,6 +65,11 @@ static const TypeInfo static_prop_type =3D {
>      .class_init =3D static_prop_class_init,
>  };
> =20
> +static const TypeInfo subclass_type =3D {
> +    .name =3D TYPE_SUBCLASS,
> +    .parent =3D TYPE_STATIC_PROPS,
> +};
> +
>  /* Test simple static property setting to default value */
>  static void test_static_prop_subprocess(void)
>  {
> @@ -279,12 +286,35 @@ static void test_dynamic_globalprop_nouser(void)
>      g_test_trap_assert_stdout("");
>  }
> =20
> +/* Test if global props affecting subclasses are applied in the right or=
der */
> +static void test_subclass_global_props(void)
> +{
> +    MyType *mt;
> +    /* Global properties must be applied in the order they were register=
ed */
> +    static GlobalProperty props[] =3D {
> +        { TYPE_STATIC_PROPS, "prop1", "101" },
> +        { TYPE_SUBCLASS,     "prop1", "102" },
> +        { TYPE_SUBCLASS,     "prop2", "103" },
> +        { TYPE_STATIC_PROPS, "prop2", "104" },
> +        {}
> +    };
> +
> +    qdev_prop_register_global_list(props);
> +
> +    mt =3D STATIC_TYPE(object_new(TYPE_SUBCLASS));
> +    qdev_init_nofail(DEVICE(mt));
> +
> +    g_assert_cmpuint(mt->prop1, =3D=3D, 102);
> +    g_assert_cmpuint(mt->prop2, =3D=3D, 104);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> =20
>      module_call_init(MODULE_INIT_QOM);
>      type_register_static(&static_prop_type);
> +    type_register_static(&subclass_type);
>      type_register_static(&dynamic_prop_type);
>      type_register_static(&hotplug_type);
>      type_register_static(&nohotplug_type);
> @@ -310,6 +340,9 @@ int main(int argc, char **argv)
>      g_test_add_func("/qdev/properties/dynamic/global/nouser",
>                      test_dynamic_globalprop_nouser);
> =20
> +    g_test_add_func("/qdev/properties/global/subclass",
> +                    test_subclass_global_props);
> +
>      g_test_run();
> =20
>      return 0;


--Sig_/R8PT.uVsD4CWJF._vkxtc9j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllkz7IACgkQAvw66wEB28KtoACaAiJgzz4fbGujxYa4xVALBgPW
Ij8An2iZXXajpbuLBy6N3FQFtg9JQfJu
=rM08
-----END PGP SIGNATURE-----

--Sig_/R8PT.uVsD4CWJF._vkxtc9j--
