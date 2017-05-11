Received: from eggs.gnu.org ([2001:4830:134:3::10]:43014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8g7Q-0006zM-3d
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8g7O-0006of-UF
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:54:28 -0400
Date: Thu, 11 May 2017 14:39:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170511043930.GH14408@umbus.fritz.box>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
	<1494415802-227633-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Content-Disposition: inline
In-Reply-To: <1494415802-227633-12-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/18] QMP: include
 CpuInstanceProperties into query_cpus output output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 01:29:55PM +0200, Igor Mammedov wrote:
> if board supports CpuInstanceProperties, report them for
> each CPU thread listed. Main motivation for this is to
> provide these properties introspection via QMP interface
> for using in test cases to verify numa node to cpu mapping,
> which includes not only boards that support cpu hotplug
> and have this info in query-hotpluggable-cpus (pc/spapr)
> but also for boards that don't not support hotpluggable-cpus
> but support numa mapping (virt-arm).
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>   * fix checkpatch error and remove extra space after =3D (Eric)
> ---
>  cpus.c           | 10 ++++++++++
>  qapi-schema.json |  6 +++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index 740b8dc..4f91d25 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -50,6 +50,7 @@
>  #include "qapi-event.h"
>  #include "hw/nmi.h"
>  #include "sysemu/replay.h"
> +#include "hw/boards.h"
> =20
>  #ifdef CONFIG_LINUX
> =20
> @@ -1859,6 +1860,8 @@ void list_cpus(FILE *f, fprintf_function cpu_fprint=
f, const char *optarg)
> =20
>  CpuInfoList *qmp_query_cpus(Error **errp)
>  {
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      CpuInfoList *head =3D NULL, *cur_item =3D NULL;
>      CPUState *cpu;
> =20
> @@ -1909,6 +1912,13 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>  #else
>          info->value->arch =3D CPU_INFO_ARCH_OTHER;
>  #endif
> +        info->value->has_props =3D !!mc->cpu_index_to_instance_props;
> +        if (info->value->has_props) {
> +            CpuInstanceProperties *props;
> +            props =3D g_malloc0(sizeof(*props));
> +            *props =3D mc->cpu_index_to_instance_props(ms, cpu->cpu_inde=
x);
> +            info->value->props =3D props;
> +        }
> =20
>          /* XXX: waiting for the qapi to support GSList */
>          if (!cur_item) {
> diff --git a/qapi-schema.json b/qapi-schema.json
> index bf48873..f1bcebe 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1325,6 +1325,9 @@
>  #
>  # @thread_id: ID of the underlying host thread
>  #
> +# @props: properties describing to which node/socket/core/thread
> +#         virtual CPU belongs to, provided if supported by board (since =
2.10)
> +#
>  # @arch: architecture of the cpu, which determines which additional fiel=
ds
>  #        will be listed (since 2.6)
>  #
> @@ -1335,7 +1338,8 @@
>  ##
>  { 'union': 'CpuInfo',
>    'base': {'CPU': 'int', 'current': 'bool', 'halted': 'bool',
> -           'qom_path': 'str', 'thread_id': 'int', 'arch': 'CpuInfoArch' =
},
> +           'qom_path': 'str', 'thread_id': 'int',
> +           '*props': 'CpuInstanceProperties', 'arch': 'CpuInfoArch' },
>    'discriminator': 'arch',
>    'data': { 'x86': 'CpuInfoX86',
>              'sparc': 'CpuInfoSPARC',

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE+sCAAoJEGw4ysog2bOSp60QAJ9NhVZZcYbkgm2HOu0LyXyl
995TwhAkv6VRO5b2sfqi5MxUhWGNh0fi6yYoD0bF1cREwc9uJ8aTGMLuil+pIFQy
YX3JkS9y1wXtB4vhB577VH9iPJcmsANlLBPW24g6VUWmmg5Soc9Gsqo7ECRDtt3V
P4Mn4ntyDctaljsrhjiiowZHJUlHb0qE5m3gASZaCAknt5qcMF2AWm/yZTc7CYDU
FTznJkIZju22J3ED6klUWbvyoVoBQZgYegKCDGBw0qH0nj9jkknE8VrV5zZ4yxaQ
VxOVKriIYccByrlIOGvFZsBUxBXFwEchysBOeBPn3kpKXcV1pFYJ6up4Mv3ssSc3
TgaMp6HFT+q9zYuF4IB/YTCc4yo3DO1id20LEeHSehrFbgzfDQ7J7zN6td+AwJmp
e/rBT+CqhYiFDd0oi8n7AVOulrVjOQuar3v4oE6LES99xRBQ4v4n0XCqDPtU9nGz
p0rnLDLPd5R3L91rinXPFECeq1+44e3BSXQuX6SbRqw61M7BuW2CgLZw0PcROfWv
pJVvgQbOBDpRJahbS8hjCxx9gWi7G9C7TPBtrorkZv9vOJmhClS13GjMZpCIUeaz
/3Y6Y+mzT5R5/0DajhHw+o5A239s0KIPn2OElY8oeU0a6XGobDKbqaLoDPIVq2jP
2svn3w80KozS9ewQA/PP
=dQP1
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
