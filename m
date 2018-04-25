Received: from eggs.gnu.org ([2001:4830:134:3::10]:40381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fBKPz-00049V-MX
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fBKPy-0000pm-Ay
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:25:07 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 25 Apr 2018 13:24:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83869381A@FRAEML521-MBX.china.huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-4-git-send-email-zhuyijun@huawei.com>
	<20171114145002.jbrw7k4n2m2rfwes@kamzik.brq.redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83868CA39@FRAEML521-MBX.china.huawei.com>
	<20180424152932.tszber3blx32luro@kamzik.brq.redhat.com>
In-Reply-To: <20180424152932.tszber3blx32luro@kamzik.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 3/5] hw/arm: add scattered RAM memory region
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>

Hi Drew,

> -----Original Message-----
> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Tuesday, April 24, 2018 4:30 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: peter.maydell@linaro.org; qemu-devel@nongnu.org; Linuxarm
> <linuxarm@huawei.com>; eric.auger@redhat.com; qemu-arm@nongnu.org;
> xuwei (O) <xuwei5@huawei.com>; Zhaoshenglong
> <zhaoshenglong@huawei.com>; Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [Qemu-devel] [RFC 3/5] hw/arm: add scattered RAM memory
> region support
>=20
> On Thu, Apr 19, 2018 at 09:06:30AM +0000, Shameerali Kolothum Thodi wrote=
:
> > > From: Andrew Jones [mailto:drjones@redhat.com] Instead of using
> > > memory region aliases, it would be best if each RAM region was
> > > modeled with pc-dimms, as that would move us towards supporting
> > > memory hotplug and allow the regions to be explicitly identified
> > > (start/size) on the command line - supporting migration. Actually,
> > > how does this series address migration? What if the host we migrate
> > > to doesn't have the same reserved regions in sysfs?
> >
> > Thanks for going through this series and comments.
> >
> > I am looking into reviving this series based on the new proposed vfio
> > iova interface[1]. The vfio interface will now provide  a list of valid=
 iova
> ranges.
> > That means, instead of working on reserved regions to find out the
> > valid  memory regions, the code here will have the valid regions list d=
irectly.
> >
> > The above comment of yours mentions about modelling the memory regions
> > with pc-dimms. If I understand that proposal correctly, in case the
> > iova list has  multiple entries in it(means there are holes in the
> > memory) the extra regions has to be added as a pc-dimm slot memory.
>=20
> Hi Shameer,
>=20
> iiuc, the concern is that the valid region list may look something like t=
his made
> up example:
>=20
>  0x000e0000000 0x000000011fffffff
>  0x00180000000 0x00000002ffffffff
>  0x02000000000 0x0000011fffffffff
>  0x22000000000 0xffffffffffffffff
>=20
> You then want to avoid overlapping the holes with memory, because the hol=
es
> represent regions that may have platform devices assigned, which need to =
keep
> 1:1 gpa -> hpa mappings.

Yes, the holes are basically reserved regions not translated by iommu.

> If that's the case, then I think the biggest problem with the made up exa=
mple is
> the initial hole [0x0 0xdfffffff], as that would overlap the currently ha=
rd coded
> base of RAM (0x40000000). Indeed we were thinking that the base of RAM
> would be modeled as a non-pluggable dimm of size 1G at the 1G boundary. A=
s
> for the rest of memory (for memory > 1G), in the made up example we could
> just allocate a single pc-dimm from a memory region representing the
> [0x22000000000 0xffffffffffffffff] range without any hassle.

Right. I was more worried about a highly fragmented case where we have to
model multiple pc-dimms to accommodate all the required memory. But that
may be a highly unlikely scenario.
=20
> > Having gone through
> > the Qemu source, I am not sure what is the best way to accomplish that.
> > (of course I am not that familiar with the Qemu source). Is it ok to
> > invoke
> > qdev_device_add() from here? Any pointers on this is very appreciated.
>=20
> I'm not an expert on that (nor any of this stuff, really - hopefully what=
 I've
> written above isn't completely bonkers). I've CC'ed Igor for help.
> I've also CC'ed Eric, because of the magic word 'vfio'.

Thanks. I am moving in this direction at the moment.  Please let me know
if there is a better way of doing this, than invoking user_creatable_add_op=
ts()
for mem backend object creation and qdev_device_add() for pc-dimm dev.

> > One more point is, considering the fact that ARM64 linux kernel still
> > doesn't support hotplug memory at the moment, not sure how much we
> > gain from the pc-dimm model.
>=20
> It will eventually. Moving towards the pc-dimm model now, in order to han=
dle
> the non-contiguous memory needs, will go a long ways to enabling hotplug
> later.

Ok. I will try to come up with something and will post as an RFC.=20

Appreciate your feedback,
Shameer

>=20
> Thanks,
> drew
>=20
> >
> > Please let me know your thoughts on this.
> >
> > Thanks,
> > Shameer
> >
> > [1]. https://lkml.org/lkml/2018/4/18/293
