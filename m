Received: from eggs.gnu.org ([2001:4830:134:3::10]:34268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRGvO-0002jZ-2k
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRGvN-0006ME-8x
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:27:42 -0500
Date: Mon, 26 Nov 2018 11:27:31 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181126132731.GJ18284@habkost.net>
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
	<65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Luc Michel <luc.michel@greensocs.com>, Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On Sun, Nov 25, 2018 at 10:27:04PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>=20
> On 23/11/18 19:10, Eduardo Habkost wrote:
> > Hi,
> >=20
> > Sorry for not reviewing this series earlier.  I just stumbled
> > upon this part of the code:
> >=20
> > On Fri, Nov 23, 2018 at 10:17:14AM +0100, Luc Michel wrote:
> >> This commit adds the cpu-cluster type. It aims at gathering CPUs fro=
m
> >> the same cluster in a machine.
> >>
> >> For now it only has a `cluster-id` property.
> >>
> >> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > [...]
> >> +static void cpu_cluster_init(Object *obj)
> >> +{
> >> +    static uint32_t cluster_id_auto_increment;
> >> +    CPUClusterState *cluster =3D CPU_CLUSTER(obj);
> >> +
> >> +    cluster->cluster_id =3D cluster_id_auto_increment++;
> >=20
> > I see that you implemented this after a suggestion from Philippe,
> > but I'm worried about this kind of side-effect on object/device
> > code.  I'm afraid this will bite us back in the future.  We were
> > bitten by problems caused by automatic cpu_index assignment on
> > CPU instance_init, and we took a while to fix that.
>=20
> Oops, thanks for catching this. I'm not aware of the cpu_index past iss=
ue.
>=20
> >=20
> > If you really want to do this and assign cluster_id
> > automatically, please do it on realize, where it won't have
> > unexpected side-effects after a simple `qom-list-properties` QMP
> > command.
>=20
> This looks clean enough to me.
> Do you prefer we don't use static auto_increment at all?

I would prefer to avoid the static variable if possible, but I
won't reject it if the alternatives make the API too complex to
use.

In either case, I'd like to ensure the caveats of the cluster_id
field are clearly documented: no guarantees about ordering or
predictability, making it not appropriate for external
interfaces.


>=20
> >=20
> > I would also add a huge warning above the cluster_id field
> > declaration, mentioning that the field is not supposed to be used
> > for anything except debugging.  I think there's a large risk of
> > people trying to reuse the field incorrectly, just like cpu_index
> > was reused for multiple (conflicting) purposes in the past.
> >=20
> >=20
> >> +}
> >> +
> >> +static Property cpu_cluster_properties[] =3D {
> >> +    DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0=
),
> >> +    DEFINE_PROP_END_OF_LIST()
> >> +};
> > [...]
> >=20

--=20
Eduardo
