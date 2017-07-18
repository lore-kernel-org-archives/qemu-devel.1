Received: from eggs.gnu.org ([2001:4830:134:3::10]:52831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXUKq-0005pV-9u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXUKn-0000Bk-4r
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:22:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXUKm-0000At-Ri
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:22:49 -0400
Date: Tue, 18 Jul 2017 17:22:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170718172244.75fa5d73@gondolin>
In-Reply-To: <CAAdtpL4TGurYS3tO1RbbJ78HrMRg+AyUmFf_+WhfkTdXLp0cOA@mail.gmail.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-9-cohuck@redhat.com>
	<CAAdtpL4TGurYS3tO1RbbJ78HrMRg+AyUmFf_+WhfkTdXLp0cOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 8/9] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, zyimin@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, 18 Jul 2017 11:58:08 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Cornelia,
>=20
> On Tue, Jul 18, 2017 at 11:24 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> > If we don't provide pci, we cannot have a pci device for which we
> > have to translate to adapter routes: just return -ENODEV.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 33 +++++++++++++++++++--------------
> >  1 file changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 60688888c3..df0e5af151 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -2424,22 +2424,27 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_rou=
ting_entry *route,
> >      uint32_t idx =3D data >> ZPCI_MSI_VEC_BITS;
> >      uint32_t vec =3D data & ZPCI_MSI_VEC_MASK;
> >
> > -    pbdev =3D s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> > -    if (!pbdev) {
> > -        DPRINTF("add_msi_route no dev\n");
> > -        return -ENODEV;
> > -    }
> > +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> > +        pbdev =3D s390_pci_find_dev_by_idx(s390_get_phb(), idx);
> > +        if (!pbdev) {
> > +            DPRINTF("add_msi_route no dev\n");
> > +            return -ENODEV;
> > +        }
> >
> > -    pbdev->routes.adapter.ind_offset =3D vec;
> > +        pbdev->routes.adapter.ind_offset =3D vec;
> >
> > -    route->type =3D KVM_IRQ_ROUTING_S390_ADAPTER;
> > -    route->flags =3D 0;
> > -    route->u.adapter.summary_addr =3D pbdev->routes.adapter.summary_ad=
dr;
> > -    route->u.adapter.ind_addr =3D pbdev->routes.adapter.ind_addr;
> > -    route->u.adapter.summary_offset =3D pbdev->routes.adapter.summary_=
offset;
> > -    route->u.adapter.ind_offset =3D pbdev->routes.adapter.ind_offset;
> > -    route->u.adapter.adapter_id =3D pbdev->routes.adapter.adapter_id;
> > -    return 0;
> > +        route->type =3D KVM_IRQ_ROUTING_S390_ADAPTER;
> > +        route->flags =3D 0;
> > +        route->u.adapter.summary_addr =3D pbdev->routes.adapter.summar=
y_addr;
> > +        route->u.adapter.ind_addr =3D pbdev->routes.adapter.ind_addr;
> > +        route->u.adapter.summary_offset =3D pbdev->routes.adapter.summ=
ary_offset;
> > +        route->u.adapter.ind_offset =3D pbdev->routes.adapter.ind_offs=
et;
> > +        route->u.adapter.adapter_id =3D pbdev->routes.adapter.adapter_=
id;
> > +        return 0;
> > +    } else {
> > +        DPRINTF("fixup_msi_route on non-pci machine?!\n");
> > +        return -ENODEV;
> > +    }
> >  }
> >
> >  int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
> > --
> > 2.13.3 =20
>=20
> What about inverting the check?
>=20
> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
> +        DPRINTF("fixup_msi_route on non-pci machine?!\n");
> +        return -ENODEV;
> +    }

I usually prefer the more common branch on top, but (1) this causes
more changes in this case and (2) I'm not so sure if zpci on really is
the common case...
