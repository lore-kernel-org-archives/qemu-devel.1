Received: from eggs.gnu.org ([209.51.188.92]:35534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJJr-0003hc-Lm
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJJp-0006ZD-RE
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:52:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1guJJp-0006VR-HV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:52:57 -0500
References: <20190214105733.25643-1-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a47911ce-1cc3-ca56-6c08-87e7f73611fb@redhat.com>
Date: Thu, 14 Feb 2019 09:52:54 -0600
MIME-Version: 1.0
In-Reply-To: <20190214105733.25643-1-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AFESz3IJ8hlvVHu0hMMKOaXUhmE87qUpH"
Subject: Re: [Qemu-devel] [PATCH v2] hostmem: fix crash when querying empty
 host-nodes property via QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, ehabkost@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AFESz3IJ8hlvVHu0hMMKOaXUhmE87qUpH
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, ehabkost@redhat.com
Message-ID: <a47911ce-1cc3-ca56-6c08-87e7f73611fb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hostmem: fix crash when querying empty
 host-nodes property via QMP
References: <20190214105733.25643-1-imammedo@redhat.com>
In-Reply-To: <20190214105733.25643-1-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/14/19 4:57 AM, Igor Mammedov wrote:
> QEMU will crashes with
>  qapi/qobject-output-visitor.c:210: qobject_output_complete: Assertion =
`qov->root && ((&qov->stack)->slh_first =3D=3D ((void *)0))' failed
> when trying to get value of not set hostmem's "host-nodes"
> property, HostMemoryBackend::host_nodes bitmap doesn't have
> any bits set in it, which leads to find_first_bit() returning
> MAX_NODES and consequently to an early return from
> host_memory_backend_get_host_nodes() without calling visitor.
>=20
> Fix it by calling visitor even if "host-nodes" property wasn't
> set before exiting from property getter to return valid empty
> list.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * fixup commit message to put emphasis on property instead
>     local variable host_nodes and make explanation more hopefully
>     more clear. (Markus Armbruster <armbru@redhat.com>)
> ---
>  backends/hostmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 87b19d2111..04baf479a1 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -88,7 +88,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visit=
or *v, const char *name,
> =20
>      value =3D find_first_bit(backend->host_nodes, MAX_NODES);
>      if (value =3D=3D MAX_NODES) {
> -        return;
> +        goto ret;
>      }
> =20
>      *node =3D g_malloc0(sizeof(**node));
> @@ -106,6 +106,7 @@ host_memory_backend_get_host_nodes(Object *obj, Vis=
itor *v, const char *name,
>          node =3D &(*node)->next;
>      } while (true);
> =20
> +ret:
>      visit_type_uint16List(v, name, &host_nodes, errp);
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AFESz3IJ8hlvVHu0hMMKOaXUhmE87qUpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxljtYACgkQp6FrSiUn
Q2poewf/RWw7LCVMkXuS4+70Z0ntDldLtWo661eqgdjT6MX+NRbtyBom0rOMk+D6
TV69PtoMEVjaE2nu/xB9axD2+KB+U895j45tDkBddRhu1qFH6q2RgLxQr7W88Vyx
6tqJ3ZONaxpghEUH87ES5a0a1YCknbWqeiVRrEtX/ieIg0xZY7YRfxX5EAEXRm0Q
vF/MoeBDONYrzye0RXSZUn+4zMR1zievWlXo4447XA/8Tt6ItreHLdcvWoXzukUQ
YSPyHsm0f6ttzaP3R6CdeuSxzzMzghpGBuIbNISSSlqH5g3Ygj/4UU0mbxWnRVQg
3jVSqVFrsgNy/jvk3SIQVKx5V+EE6Q==
=TJW2
-----END PGP SIGNATURE-----

--AFESz3IJ8hlvVHu0hMMKOaXUhmE87qUpH--
