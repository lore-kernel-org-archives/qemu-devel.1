Received: from eggs.gnu.org ([2001:4830:134:3::10]:35069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dYhh8-0004Xq-V1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dYhh4-0000T4-CN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dYhh4-0000SY-0J
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:50:50 -0400
Date: Sat, 22 Jul 2017 02:50:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170722024929-mutt-send-email-mst@kernel.org>
References: <201707201057577907414@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201707201057577907414@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogIFtQQVRDSF0gdmhvc3Q6IGZp?=
 =?utf-8?q?x_a_migration_failed_because_ofvhost_region_merge?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: imammedo@redhat.com, dgilbert@redhat.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, wang.yechao255@zte.com.cn, qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 10:57:57AM +0800, peng.hao2@zte.com.cn wrote:
> =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A <mst@redhat.com>;
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A <imammedo@redhat.com>;
> =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A <dgilbert@redhat.com>; <marcandre.=
lureau@redhat.com>;
> <maxime.coquelin@redhat.com>;=E5=BD=AD=E6=B5=A910096742;=E7=8E=8B=E4=B8=
=9A=E8=B6=8510154425;
> <qemu-devel@nongnu.org>;
> =E6=97=A5=E6=9C=9F=EF=BC=9A2017=E5=B9=B407=E6=9C=8819=E6=97=A5 23:53
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [Qemu-devel] [PATCH] vhost: fix a migrat=
ion failed because ofvhost
> region merge
>=20
>=20
> On Wed, Jul 19, 2017 at 03:24:27PM +0200, Igor Mammedov wrote:
> > On Wed, 19 Jul 2017 12:46:13 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >=20
> > > * Igor Mammedov (imammedo@redhat.com) wrote:
> > > > On Wed, 19 Jul 2017 23:17:32 +0800
> > > > Peng Hao <peng.hao2@zte.com.cn> wrote:
> > > >  =20
> > > > > When a guest that has several hotplugged dimms is migrated, in
> > > > > destination host it will fail to resume. Because vhost regions =
of
> > > > > several dimms in source host are merged and in the restore stag=
e
> > > > > in destination host it computes whether more than vhost slot li=
mit
> > > > > before merging vhost regions of several dimms. =20
> > > > could you provide a bit more detailed description of the problem
> > > > including command line+used device_add commands on source and
> > > > command line on destination? =20
> > >=20
> > > (ccing in Marc Andre and Maxime)
> > >=20
> > > Hmm, I'd like to understade the situation where you get merging bet=
ween
> > > RAMBlocks; that complicates some stuff for postcopy.
> > and probably inconsistent merging breaks vhost as well
> >=20
> > merging might happen if regions are adjacent or overlap
> > but for that to happen merged regions must have equal
> > distance between their GPA:HVA pairs, so that following
> > translation would work:
> >=20
> > if gva in regionX[gva_start, len, hva_start]
> >    hva =3D hva_start + gva - gva_start
> >=20
> > while GVA of regions is under QEMU control and deterministic
> > HVA is not, so in migration case merging might happen on source
> > side but not on destination, resulting in different memory maps.
> >=20
> > Maybe Michael might know details why migration works in vhost usecase=
,
> > but I don't see vhost sending any vmstate data.
>=20
> We aren't merging ramblocks at all.
> When we are passing blocks A and B to vhost, if we see that
>=20
> hvaB=3DhvaA + lenA
> gpaB=3DgpaA + lenA
>=20
> then we can improve performance a bit by passing a single
> chunk to vhost: hvaA,gpaA,lena+lenB
>=20
>=20
> so it does not affect migration normally.
>=20
> ----- I think it is like this:
>=20
> in source;                                       in destination:(restor=
e)
>=20
> realize device 1                              realize device 1
>=20
> realize device 2                              realize dimm 0
>=20
>      ...                                               realize dimm1
>=20
>                                                        ....
>=20
> realize device n                              realize dimmx
>=20
>                                                        realize  device =
m
>=20
> realize dimm0                                  .....
>=20
> realize dimm1                                  .....
>=20
> ......                                                  .....
>=20
> realize dimmx                                realize device n
>=20
>=20
> In restore stage ,the sort of realizing device  is different from start=
ing vm
> because of adding dimms.
>=20
> So it may in some stage during restoring can't merge vhost regions.

If you run over the number of regions supported by vhost on destination
then you won't be able to start a VM there until you disable vhost.



>=20
>=20
>=20
>=20
>=20
> >=20
> > >=20
> > > > >=20
> > > > > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > > > > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > > > > ---
> > > > >  hw/mem/pc-dimm.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > > > > index ea67b46..bb0fa08 100644
> > > > > --- a/hw/mem/pc-dimm.c
> > > > > +++ b/hw/mem/pc-dimm.c
> > > > > @@ -101,7 +101,7 @@ void pc_dimm_memory_plug
> (DeviceState *dev, MemoryHotplugState *hpms,
> > > > >          goto out;
> > > > >      }
> > > > > =20
> > > > > -    if (!vhost_has_free_slot()) {
> > > > > +    if (!vhost_has_free_slot() && runstate_is_running()) {
> > > > >          error_setg(&local_err, "a used vhost backend has no fr=
ee"
> > > > >                                 " memory slots left");
> > > > >          goto out; =20
> > >=20
> > > Even this produces the wrong error message in this case,
> > > it also makes me think if the existing code should undo a lot of
> > > the object_property_set's that happen.
> > >=20
> > > Dave
> > > >=20
> > > >  =20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
>=20
