Received: from eggs.gnu.org ([2001:4830:134:3::10]:35193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g89fy-0004qX-2i
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 15:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g89fx-000733-1Y
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 15:52:46 -0400
Date: Thu, 4 Oct 2018 16:52:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181004195225.GV5738@habkost.net>
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-16-luc.michel@greensocs.com>
	<35ffbd68-f783-b6f4-18a2-dd995819c046@redhat.com>
	<CAFEAcA9vHi=qrV-Aj5ptgBQntafLGwL6VezxnmOuuR=6=Pr8cA@mail.gmail.com>
	<33c3ea72-652a-53b2-4865-830f3d7f2c3a@greensocs.com>
	<3d459f14-b701-02b6-d231-fc48c509640f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3d459f14-b701-02b6-d231-fc48c509640f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/15] arm/xlnx-zynqmp: put APUs and
 RPUs in separate GDB groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Luc Michel <luc.michel@greensocs.com>, Peter Maydell <peter.maydell@linaro.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Oct 04, 2018 at 06:07:45PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 03/10/2018 13:44, Luc Michel wrote:
> > On 10/2/18 1:58 PM, Peter Maydell wrote:
> >> On 2 October 2018 at 12:33, Philippe Mathieu-Daud=E9 <philmd@redhat.=
com> wrote:
> >>> Cc'ing more QOM involved people.
> >>>
> >>> On 01/10/2018 13:57, Luc Michel wrote:
> >>>> Create two separate QOM containers for APUs and RPUs to indicate t=
o the
> >>>> GDB stub that those CPUs should be put in different processes.
> >>>>
> >>>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> >>>> ---
> >>>>  hw/arm/xlnx-zynqmp.c | 7 +++++--
> >>>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> >>>> index c195040350..5e92adbc71 100644
> >>>> --- a/hw/arm/xlnx-zynqmp.c
> >>>> +++ b/hw/arm/xlnx-zynqmp.c
> >>>> @@ -22,10 +22,11 @@
> >>>>  #include "hw/arm/xlnx-zynqmp.h"
> >>>>  #include "hw/intc/arm_gic_common.h"
> >>>>  #include "exec/address-spaces.h"
> >>>>  #include "sysemu/kvm.h"
> >>>>  #include "kvm_arm.h"
> >>>> +#include "exec/gdbstub.h"
> >>>>
> >>>>  #define GIC_NUM_SPI_INTR 160
> >>>>
> >>>>  #define ARM_PHYS_TIMER_PPI  30
> >>>>  #define ARM_VIRT_TIMER_PPI  27
> >>>> @@ -175,17 +176,18 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqM=
PState *s, const char *boot_cpu,
> >>>>                                     Error **errp)
> >>>>  {
> >>>>      Error *err =3D NULL;
> >>>>      int i;
> >>>>      int num_rpus =3D MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLN=
X_ZYNQMP_NUM_RPU_CPUS);
> >>>> +    Object *rpu_group =3D gdb_cpu_group_container_get(OBJECT(s));
> >>>
> >>> I'd rather keep this generic: not involve 'gdb' container name.
> >>
> >> Yes, I agree. We should structure how we construct our
> >> model to follow what the hardware has (two CPU clusters
> >> with 4 cores each), and then the gdb code should introspect
> >> the system later to decide how it exposes things to the gdb
> >> user. GDB specifics should (as far as possible) be kept out
> >> of the board code.

Agreed.

> >>
> >> The fact that there are two clusters here also
> >> affects other things, like whether they have the
> >> same view of memory, whether they can share translated
> >> code (they shouldn't but do at the moment), and so on --
> >> it's not just a GDB-relevant distinction. So we should
> >> be modelling it somehow, definitely. I don't have a clear
> >> view how just yet.
> >=20
> > So for now, maybe it's better to rely on an heuristic such as the one
> > suggested by Philippe in the gdb code to group the CPUs. Once QEMU ga=
ins
> > more supports for such heterogeneous architectures, we can remove the
> > heuristic and put the proper QOM introspection code instead.
>=20
> I'm not sure this is the best approach, just suggested because using
> object_resolve_path_type("", TYPE_CPU, NULL) seemed to me the
> quicker/easiest approach.
>=20
> Eduardo: Do you have other thoughts on how to resolve those generic
> containers, without involving any gdb-specific tag?

Changing the object hierarchy based on GDB groups doesn't seem
right, but I don't think it would be a big deal if we have the
board code explicitly telling the GDB code how to group the CPUs.

If you really want to do it implicitly, would it work if you
simply group the CPUs based on object_get_canonical_path()?

If a more explicit GDB grouping API is acceptable, what about
just adding a INTERFACE_GDB_GROUP interface name to (existing)
container objects that we expect to become GDB groups?

I'm not sure which way is better. I'm a bit worried that making
things too implicit could easily break (e.g. if somebody changes
the CPU QOM hierarchy in the future for unrelated reasons).


>=20
> >> This probably ties into the stuff I have somewhere on
> >> my todo list about supporting multiple heterogenous
> >> systems. The problem with this xilinx board is that it
> >> is trying to model that kind of system but we don't actually
> >> properly support that in QEMU yet.
> >>
> >> thanks
> >> -- PMM
> >>

--=20
Eduardo
