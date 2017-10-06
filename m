Received: from eggs.gnu.org ([2001:4830:134:3::10]:36739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCk-0002MD-VT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCg-0005Dn-Tp
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:38 -0400
Date: Fri, 6 Oct 2017 14:06:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006030601.GG3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k9EanI4qvbxMqdC7"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/23] qom: add helper macro DEFINE_TYPES()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--k9EanI4qvbxMqdC7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:30PM +0200, Igor Mammedov wrote:
> DEFINE_TYPES() will help to simplify following routine patterns:
>=20
>  static void foo_register_types(void)
>  {
>     type_register_static(&foo1_type_info);
>     type_register_static(&foo2_type_info);
>     ...
>  }
>=20
>  type_init(foo_register_types)
>=20
> or
>=20
>  static void foo_register_types(void)
>  {
>     int i;
>=20
>     for (i =3D 0; i < ARRAY_SIZE(type_infos); i++) {
>         type_register_static(&type_infos[i]);
>     }
>  }
>=20
>  type_init(foo_register_types)
>=20
> with a single line
>=20
>  DEFINE_TYPES(type_infos)
>=20
> where types have static definition which could be consolidated in
> a single array of TypeInfo structures.
> It saves us ~6-10LOC per use case and would help to replace
> imperative foo_register_types() there with declarative style of
> type registration.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/object.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 9a2369c..dc73d59 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -79,6 +79,28 @@ typedef struct InterfaceInfo InterfaceInfo;
>   * #TypeInfo describes information about the type including what it inhe=
rits
>   * from, the instance and class size, and constructor/destructor hooks.
>   *
> + * Alternatively several static types could be registered using helper m=
acro
> + * DEFINE_TYPES()
> + *
> + * <example>
> + *   <programlisting>
> + * static const TypeInfo device_types_info[] =3D {
> + *     {
> + *         .name =3D TYPE_MY_DEVICE_A,
> + *         .parent =3D TYPE_DEVICE,
> + *         .instance_size =3D sizeof(MyDeviceA),
> + *     },
> + *     {
> + *         .name =3D TYPE_MY_DEVICE_B,
> + *         .parent =3D TYPE_DEVICE,
> + *         .instance_size =3D sizeof(MyDeviceB),
> + *     },
> + * };
> + *
> + * DEFINE_TYPES(device_types_info)
> + *   </programlisting>
> + * </example>
> + *
>   * Every type has an #ObjectClass associated with it.  #ObjectClass deri=
vatives
>   * are instantiated dynamically but there is only ever one instance for =
any
>   * given type.  The #ObjectClass typically holds a table of function poi=
nters
> @@ -799,6 +821,20 @@ Type type_register(const TypeInfo *info);
>  void type_register_static_array(const TypeInfo *infos, int nr_infos);
> =20
>  /**
> + * DEFINE_TYPES:
> + * @type_array: The array containing #TypeInfo structures to register
> + *
> + * @type_array should be static constant that exists for the life time
> + * that the type is registered.
> + */
> +#define DEFINE_TYPES(type_array)                                        =
    \
> +static void do_qemu_init_ ## type_array(void)                           =
    \
> +{                                                                       =
    \
> +    type_register_static_array(type_array, ARRAY_SIZE(type_array));     =
    \
> +}                                                                       =
    \
> +type_init(do_qemu_init_ ## type_array)
> +
> +/**
>   * object_class_dynamic_cast_assert:
>   * @klass: The #ObjectClass to attempt to cast.
>   * @typename: The QOM typename of the class to cast to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k9EanI4qvbxMqdC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW8xkACgkQbDjKyiDZ
s5KcmQ//cbdgp+Ujiw5TAxRNLIY2xNYtIshFB6z5etb4ZyFnPDhYSISsExf81PDY
QoaIoSO+DKyMa9XxbH1gDfLaYZMqX9Qp75Nd4bmPLoYOO4xitRGyaYz1+uHr1WA8
jGbwHP4hlQFyz9u2mtHu8t5ekixvkpVx0B3fUgElGpBpiZBf1J/fvHgdny/LW+2s
PDm5iFSCk0DpQRft0vY33RgeSswIETN5z4O9kypJWCrbOE0yn6x1fG+SreHLDam3
bTSNWcKbFPZ/zyYktFbv0hFgPXV2JN7gfnl2z5VrVbXveyd5YBEHQCJu2on8Xqzm
6+snn9O7xWGaXV/o4z6UuXF7Etq04whMTxlxjYNRpyigTUIHcTNrGNHOANjKCSqM
ff0SRdfyObzKnIWg7Z77ZWXToGkOz4v8YSS1zODp+g+vdm4wk9li+ovvkpa94Fv3
BpWNKyH2yQEDGlK4lJ9a0SxeFqbJHg0cbitCCsnJ2dwzaKDAalYpfbSJYdDJPS/Z
+dkaV4+vWvhYxnnRVkhzSC/Ye9GOJ6V8SSxtpd62Wglt5/g4zE+NREfpnog222rm
cr2Y4zbErOKrZ/l/xz8TCHubJHxhbxFqrhjC5Y6vEQ46Q3GVyjLQl2ZmLV64TnE5
BQmuXCq19rNYqqA5nCTQQPVuL0+61G8ssdLUTfhAc+mY7SOzaHE=
=53oJ
-----END PGP SIGNATURE-----

--k9EanI4qvbxMqdC7--
