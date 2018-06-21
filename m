Received: from eggs.gnu.org ([2001:4830:134:3::10]:60168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVzEk-0004Dw-Pn
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVzEf-0000qS-Qy
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:02:54 -0400
References: <20180621114015.9207-1-f4bug@amsat.org>
	<20180621114015.9207-3-f4bug@amsat.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <988a6d50-a911-6ac0-2955-0f99292d8a15@redhat.com>
Date: Thu, 21 Jun 2018 15:02:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180621114015.9207-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] hw/arm/sysbus-fdt: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Philippe,
On 06/21/2018 01:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Use error_report() + exit() instead of error_setg(&error_fatal),
> as suggested by the "qapi/error.h" documentation:
>=20
>    Please don't error_setg(&error_fatal, ...), use error_report() and
>    exit(), because that's more obvious.
>=20
> This fixes CID 1352173:
>     "Passing null pointer dt_name to qemu_fdt_node_path, which derefere=
nces it."
>=20
> And this also fixes:
>=20
>     hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable 'no=
de_path') results in a null pointer dereference
>         if (node_path[1]) {
>             ^~~~~~~~~~~~
>=20
> Fixes: Coverity CID 1352173 (Dereference after null check)
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/sysbus-fdt.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index 277ed872e7..63b74a353e 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -92,7 +92,7 @@ static void copy_properties_from_host(HostProperty *p=
rops, int nb_props,
>          r =3D qemu_fdt_getprop(host_fdt, node_path,
>                               props[i].name,
>                               &prop_len,
> -                             props[i].optional ? &err : &error_fatal);
> +                             &err);
>          if (r) {
>              qemu_fdt_setprop(guest_fdt, nodename,
>                               props[i].name, r, prop_len);
> @@ -103,6 +103,10 @@ static void copy_properties_from_host(HostProperty=
 *props, int nb_props,
>              } else {
>                  error_free(err);
>              }
> +            if (!props[i].optional) {
> +                /* mandatory property not found: bail out */
> +                exit(1);
reading that code again, I am not sure this does the same thing as
before. In case case the property is tagged not optional and is not
found in the host dt, qemu_fdt_getprop will fill err with error_setg.
However prop_len =3D=3D -FDT_ERR_NOTFOUND so we are going to call error_f=
ree
and no trace will be output to the user. Before the
error_setg(&error_fatal) printed the cause of error error and exited. Do
I miss something?

Thanks

Eric
> +            }
>          }
>      }
>  }
> @@ -138,9 +142,9 @@ static void fdt_build_clock_node(void *host_fdt, vo=
id *guest_fdt,
> =20
>      node_offset =3D fdt_node_offset_by_phandle(host_fdt, host_phandle)=
;
>      if (node_offset <=3D 0) {
> -        error_setg(&error_fatal,
> -                   "not able to locate clock handle %d in host device =
tree",
> -                   host_phandle);
> +        error_report("not able to locate clock handle %d in host devic=
e tree",
> +                     host_phandle);
> +        exit(1);
>      }
>      node_path =3D g_malloc(path_len);
>      while ((ret =3D fdt_get_path(host_fdt, node_offset, node_path, pat=
h_len))
> @@ -149,16 +153,16 @@ static void fdt_build_clock_node(void *host_fdt, =
void *guest_fdt,
>          node_path =3D g_realloc(node_path, path_len);
>      }
>      if (ret < 0) {
> -        error_setg(&error_fatal,
> -                   "not able to retrieve node path for clock handle %d=
",
> -                   host_phandle);
> +        error_report("not able to retrieve node path for clock handle =
%d",
> +                     host_phandle);
> +        exit(1);
>      }
> =20
>      r =3D qemu_fdt_getprop(host_fdt, node_path, "compatible", &prop_le=
n,
>                           &error_fatal);
>      if (strcmp(r, "fixed-clock")) {
> -        error_setg(&error_fatal,
> -                   "clock handle %d is not a fixed clock", host_phandl=
e);
> +        error_report("clock handle %d is not a fixed clock", host_phan=
dle);
> +        exit(1);
>      }
> =20
>      nodename =3D strrchr(node_path, '/');
> @@ -301,34 +305,37 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sb=
dev, void *opaque)
> =20
>      dt_name =3D sysfs_to_dt_name(vbasedev->name);
>      if (!dt_name) {
> -        error_setg(&error_fatal, "%s incorrect sysfs device name %s",
> -                    __func__, vbasedev->name);
> +        error_report("%s incorrect sysfs device name %s",
> +                     __func__, vbasedev->name);
> +        exit(1);
>      }
>      node_path =3D qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
>                                     &error_fatal);
>      if (!node_path || !node_path[0]) {
> -        error_setg(&error_fatal, "%s unable to retrieve node path for =
%s/%s",
> -                   __func__, dt_name, vdev->compat);
> +        error_report("%s unable to retrieve node path for %s/%s",
> +                     __func__, dt_name, vdev->compat);
> +        exit(1);
>      }
> =20
>      if (node_path[1]) {
> -        error_setg(&error_fatal, "%s more than one node matching %s/%s=
!",
> -                   __func__, dt_name, vdev->compat);
> +        error_report("%s more than one node matching %s/%s!",
> +                     __func__, dt_name, vdev->compat);
> +        exit(1);
>      }
> =20
>      g_free(dt_name);
> =20
>      if (vbasedev->num_regions !=3D 5) {
> -        error_setg(&error_fatal, "%s Does the host dt node combine XGB=
E/PHY?",
> -                   __func__);
> +        error_report("%s Does the host dt node combine XGBE/PHY?", __f=
unc__);
> +        exit(1);
>      }
> =20
>      /* generate nodes for DMA_CLK and PTP_CLK */
>      r =3D qemu_fdt_getprop(host_fdt, node_path[0], "clocks",
>                           &prop_len, &error_fatal);
>      if (prop_len !=3D 8) {
> -        error_setg(&error_fatal, "%s clocks property should contain 2 =
handles",
> -                   __func__);
> +        error_report("%s clocks property should contain 2 handles", __=
func__);
> +        exit(1);
>      }
>      host_clock_phandles =3D (uint32_t *)r;
>      guest_clock_phandles[0] =3D qemu_fdt_alloc_phandle(guest_fdt);
>=20
