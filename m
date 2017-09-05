Received: from eggs.gnu.org ([2001:4830:134:3::10]:50565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpFss-0008Tw-1v
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpFsn-00076u-H5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:35:26 -0400
Date: Tue, 5 Sep 2017 23:35:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905153507.GA31389@lemon.lan>
References: <20170905131149.10669-1-famz@redhat.com>
	<20170905131149.10669-4-famz@redhat.com>
	<a628d888-f1e8-2d7f-034c-095c29818ae4@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a628d888-f1e8-2d7f-034c-095c29818ae4@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/6] gicv3: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On Tue, 09/05 10:44, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 09/05/2017 10:11 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   hw/intc/arm_gicv3_its_kvm.c | 19 +++++++------------
> >   1 file changed, 7 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.=
c
> > index 1f8991b8a6..39903d5eab 100644
> > --- a/hw/intc/arm_gicv3_its_kvm.c
> > +++ b/hw/intc/arm_gicv3_its_kvm.c
> > @@ -120,17 +120,6 @@ static void kvm_arm_its_realize(DeviceState *dev=
, Error **errp)
> >       qemu_add_vm_change_state_handler(vm_change_state_handler, s);
> >   }
> > -static void kvm_arm_its_init(Object *obj)
> > -{
> > -    GICv3ITSState *s =3D KVM_ARM_ITS(obj);
> > -
> > -    object_property_add_link(obj, "parent-gicv3",
> > -                             "kvm-arm-gicv3", (Object **)&s->gicv3,
> > -                             object_property_allow_set_link,
> > -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> > -                             &error_abort);
> > -}
> > -
> >   /**
> >    * kvm_arm_its_pre_save - handles the saving of ITS registers.
> >    * ITS tables are flushed into guest RAM separately and earlier,
> > @@ -205,12 +194,19 @@ static void kvm_arm_its_post_load(GICv3ITSState=
 *s)
> >                         GITS_CTLR, &s->ctlr, true, &error_abort);
> >   }
> > +static Property kvm_arm_its_props[] =3D {
> > +    DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "kvm-arm-=
gicv3",
>=20
> moving TYPE_KVM_ARM_GICV3 to kvm_arm.h and using it here:
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

This file is only compiled natively on arm, so I'm not comfortable to mak=
e a
more complex change than this patch which may break build due to the #ifd=
ef's in
the headers, or add your rev-by without a compile test.  :(

The open coded type name has already been used here so the change you req=
uested
can be done separately, I think.

Fam
