Received: from eggs.gnu.org ([2001:4830:134:3::10]:34567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gQGD5-0003kz-S2
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gQG7s-0008Kl-UQ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:24:26 -0500
Date: Fri, 23 Nov 2018 16:24:15 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181123182415.GP18284@habkost.net>
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
	<CAFEAcA_8jJz5dE7XP4R=LjEC5WzP3jzutg=YqiYjJVwZZz+jvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_8jJz5dE7XP4R=LjEC5WzP3jzutg=YqiYjJVwZZz+jvQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Luc Michel <luc.michel@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Fri, Nov 23, 2018 at 06:14:28PM +0000, Peter Maydell wrote:
> On Fri, 23 Nov 2018 at 18:11, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> > On Fri, Nov 23, 2018 at 10:17:14AM +0100, Luc Michel wrote:
> > > This commit adds the cpu-cluster type. It aims at gathering CPUs fr=
om
> > > the same cluster in a machine.
> > >
> > > For now it only has a `cluster-id` property.
> > >
> > > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > [...]
> > > +static void cpu_cluster_init(Object *obj)
> > > +{
> > > +    static uint32_t cluster_id_auto_increment;
> > > +    CPUClusterState *cluster =3D CPU_CLUSTER(obj);
> > > +
> > > +    cluster->cluster_id =3D cluster_id_auto_increment++;
> >
> > I see that you implemented this after a suggestion from Philippe,
> > but I'm worried about this kind of side-effect on object/device
> > code.  I'm afraid this will bite us back in the future.  We were
> > bitten by problems caused by automatic cpu_index assignment on
> > CPU instance_init, and we took a while to fix that.
> >
> > If you really want to do this and assign cluster_id
> > automatically, please do it on realize, where it won't have
> > unexpected side-effects after a simple `qom-list-properties` QMP
> > command.
> >
> > I would also add a huge warning above the cluster_id field
> > declaration, mentioning that the field is not supposed to be used
> > for anything except debugging.  I think there's a large risk of
> > people trying to reuse the field incorrectly, just like cpu_index
> > was reused for multiple (conflicting) purposes in the past.
>=20
> One thing I would like to do with this new "cpu cluster"
> concept is to use it to handle a problem we have at the
> moment with TCG, where we assume all CPUs have the same
> view of physical memory (and so if CPU A executes from physical
> address X it can share translated code with CPU B executing
> from physical address X). The idea is that we should include
> the CPU cluster number in the TCG hash key that we use to
> look up cached translation blocks, so that only CPUs in
> the same cluster (assumed to have the same view of memory
> and to be identical) share TBs.
>=20
> If we don't have a unique integer key for the cluster, what
> should we use instead ?

This sounds like a reasonable use of cluster_id as implemented in
this patch.  The ID would be only used internally and not exposed
to the outside, right?

I'm more worried about cases where we could end up exposing the
ID in an external interface (either to guests, or through QMP or
the command-line).  This happened to cpu_index and we took a long
time to fix the mess.

--=20
Eduardo
