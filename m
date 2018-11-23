Received: from eggs.gnu.org ([2001:4830:134:3::10]:58477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gQFv4-00067e-H9
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gQFv3-0000Ls-Ml
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:11:10 -0500
Date: Fri, 23 Nov 2018 16:10:59 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181123181059.GN18284@habkost.net>
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181123091729.29921-2-luc.michel@greensocs.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Hi,

Sorry for not reviewing this series earlier.  I just stumbled
upon this part of the code:

On Fri, Nov 23, 2018 at 10:17:14AM +0100, Luc Michel wrote:
> This commit adds the cpu-cluster type. It aims at gathering CPUs from
> the same cluster in a machine.
>=20
> For now it only has a `cluster-id` property.
>=20
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
[...]
> +static void cpu_cluster_init(Object *obj)
> +{
> +    static uint32_t cluster_id_auto_increment;
> +    CPUClusterState *cluster =3D CPU_CLUSTER(obj);
> +
> +    cluster->cluster_id =3D cluster_id_auto_increment++;

I see that you implemented this after a suggestion from Philippe,
but I'm worried about this kind of side-effect on object/device
code.  I'm afraid this will bite us back in the future.  We were
bitten by problems caused by automatic cpu_index assignment on
CPU instance_init, and we took a while to fix that.

If you really want to do this and assign cluster_id
automatically, please do it on realize, where it won't have
unexpected side-effects after a simple `qom-list-properties` QMP
command.

I would also add a huge warning above the cluster_id field
declaration, mentioning that the field is not supposed to be used
for anything except debugging.  I think there's a large risk of
people trying to reuse the field incorrectly, just like cpu_index
was reused for multiple (conflicting) purposes in the past.


> +}
> +
> +static Property cpu_cluster_properties[] =3D {
> +    DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
> +    DEFINE_PROP_END_OF_LIST()
> +};
[...]

--=20
Eduardo
