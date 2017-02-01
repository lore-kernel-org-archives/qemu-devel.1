Received: from eggs.gnu.org ([2001:4830:134:3::10]:44209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBN-0003xS-4t
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBK-0007Up-2q
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:57 -0500
Date: Wed, 1 Feb 2017 11:10:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201001028.GA30639@umbus.fritz.box>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1485868319-16151-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc/kvm: Handle the "family" CPU via
 alias instead of registering new types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 02:11:58PM +0100, Thomas Huth wrote:
> When running with KVM on POWER, we are registering a "family" CPU
> type for the host CPU that we are running on. For example, on all
> POWER8-compatible hosts, we register a "POWER8" CPU type, so that
> you can always start QEMU with "-cpu POWER8" there, without the
> need to know whether you are running on a POWER8, POWER8E or POWER8NVL
> host machine.
> However, we also have a "POWER8" CPU alias in the ppc_cpu_aliases list
> (that is mainly useful for TCG). This leads to two cosmetical drawbacks:
> If the user runs QEMU with "-cpu ?", we always claim that POWER8 is an
> "alias for POWER8_v2.0" - which is simply not true when running with
> KVM on POWER. And when using the 'query-cpu-definitions' QMP call,
> there are currently two entries for "POWER8", one for the alias, and
> one for the additional registered type.
> To solve the two problems, we should rather update the "family" alias
> instead of registering a new types. We then only have one "POWER8"
> CPU definition around, an alias, which also points to the right
> destination.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1396536
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Updating the otherwise static table of aliases is kind of ugly, but
then so is registering an extra full type as we do now.

Is this safe to apply without the follow up patch to vl.c.

> ---
>  target/ppc/kvm.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index ec92c64..f58c260 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -24,6 +24,7 @@
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
>  #include "cpu.h"
> +#include "cpu-models.h"
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
> @@ -2412,6 +2413,7 @@ static int kvm_ppc_register_host_cpu_type(void)
>      };
>      PowerPCCPUClass *pvr_pcc;
>      DeviceClass *dc;
> +    int i;
> =20
>      pvr_pcc =3D kvm_ppc_get_host_cpu_class();
>      if (pvr_pcc =3D=3D NULL) {
> @@ -2420,13 +2422,6 @@ static int kvm_ppc_register_host_cpu_type(void)
>      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
>      type_register(&type_info);
> =20
> -    /* Register generic family CPU class for a family */
> -    pvr_pcc =3D ppc_cpu_get_family_class(pvr_pcc);
> -    dc =3D DEVICE_CLASS(pvr_pcc);
> -    type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
> -    type_info.name =3D g_strdup_printf("%s-"TYPE_POWERPC_CPU, dc->desc);
> -    type_register(&type_info);
> -
>  #if defined(TARGET_PPC64)
>      type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
>      type_info.parent =3D TYPE_SPAPR_CPU_CORE,
> @@ -2436,14 +2431,29 @@ static int kvm_ppc_register_host_cpu_type(void)
>      type_info.class_data =3D (void *) "host";
>      type_register(&type_info);
>      g_free((void *)type_info.name);
> -
> -    /* Register generic spapr CPU family class for current host CPU type=
 */
> -    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, dc->des=
c);
> -    type_info.class_data =3D (void *) dc->desc;
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
>  #endif
> =20
> +    /*
> +     * Update generic CPU family class alias (e.g. on a POWER8NVL host,
> +     * we want "POWER8" to be a "family" alias that points to the current
> +     * host CPU type, too)
> +     */
> +    dc =3D DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
> +    for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
> +        if (strcmp(ppc_cpu_aliases[i].alias, dc->desc) =3D=3D 0) {
> +            ObjectClass *oc =3D OBJECT_CLASS(pvr_pcc);
> +            char *suffix;
> +
> +            ppc_cpu_aliases[i].model =3D g_strdup(object_class_get_name(=
oc));
> +            suffix =3D strstr(ppc_cpu_aliases[i].model, "-"TYPE_POWERPC_=
CPU);
> +            if (suffix) {
> +                *suffix =3D 0;
> +            }
> +            ppc_cpu_aliases[i].oc =3D oc;
> +            break;
> +        }
> +    }
> +
>      return 0;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkSd0AAoJEGw4ysog2bOSv6IP/RQuKmtLxEjcOg1B3MY/bRqC
aPhlUUMhj1jjtYQ6hK4u+hKGKP2UUlzD7Y8jQ4a/YoSGrR3VyvjU6Wrcdxqr3PJe
oufFjmnfV360GCHlYyBXc0mabHhnwqQAIgEEca5m/ERDoPpaLWm0PfrGyRNNJ2+f
xwKCSm68fGUujPX04qeCJjUfrPBBWFRblufcVbUR174kkM/uDTk5/n1C7Pg3cmXj
IyLW3bRgCBps7kLVa1ZOUduRiyEUdeXr7L2NnsswBpzJEXuKFVt0qRJhwnZ0u5MS
tOAyhM0Hw/HRPBr9xym6Gl7OYT0mTY0vdqfu2hMPIGJ7fIz0DSCzJ0CsmqKbUShJ
dwAg8yqtuGlS4jnaqfWcJ63Y2QYON6pQEvb/XQXd1zRH5hEqM34/OLq5Hte5aWsz
vsi2ytoDY52Cej+lWyqIMmeZn7cKdQ5RoqZZuuwjNBdXW0SntoU62ybhyxQsOhGK
4kAo7hx7EVIpfZpQeDThZKQSt+EHy0buLkhHWj/i7eh2rHKU39AkcEC9YZ7jU4vu
iuBUCj1SeOfgp10ckA8cQkBXUWRpLQRrlD+ZXwVT1Qw47WrwucxbdvMzEKzlNHZd
M2hUZ4Yfj7MQotHuhRneiIzDcPtsYzNJJj0nO+y9tVCCrH+4EzNH5v0375jsbycl
cCIsmp/cxyhwycQuJxjU
=q/TR
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
