Received: from eggs.gnu.org ([2001:4830:134:3::10]:56936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRcw0-0005mL-Eq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRcvz-0004z3-Jl
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:57:48 -0500
Date: Tue, 27 Nov 2018 10:56:44 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127125644.GB18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181127092801.21777-17-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 16/28] hw: apply machine compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:Virt" <qemu-arm@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=E9 Lureau wrote:
> Similarly to accel properties, move compat properties out of globals
> registration, and apply the machine compat properties during
> device_post_init().
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
[...]
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 7066d28271..3b31b2c025 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -971,17 +971,26 @@ static void device_initfn(Object *obj)
>  }
> =20
>  static const GPtrArray *ac_compat_props;
> +static const GPtrArray *mc_compat_props;
> =20
>  void accel_register_compat_props(const GPtrArray *props)
>  {
>      ac_compat_props =3D props;
>  }
> =20
> +void machine_register_compat_props(const GPtrArray *props)
> +{
> +    mc_compat_props =3D props;
> +}
> +
>  static void device_post_init(Object *obj)
>  {
>      if (ac_compat_props) {
>          object_apply_global_props(obj, ac_compat_props, &error_abort);
>      }

Why not just use MACHINE(qdev_get_machine())->accel->compat_props
directly?

> +    if (mc_compat_props) {
> +        object_apply_global_props(obj, mc_compat_props, &error_abort);
> +    }

Why not just use MACHINE(qdev_get_machine())->compat_props
directly?

> =20
>      qdev_prop_set_globals(DEVICE(obj));
>  }
[...]

--=20
Eduardo
