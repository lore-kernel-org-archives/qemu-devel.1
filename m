Received: from eggs.gnu.org ([2001:4830:134:3::10]:55214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxDec-0006zX-OH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxDeZ-0005bS-I2
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxDeZ-0005b6-8V
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:49:35 -0400
Date: Wed, 27 Sep 2017 15:49:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170927144927.GC2108@work-vm>
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
	<e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
	<20170927125606.65dc514d.cohuck@redhat.com>
	<14df9ad6-f0e9-cd51-04dd-4fe994808433@de.ibm.com>
	<4681e677-9e5a-4c1c-8e22-dc5c51b7286d@redhat.com>
	<20170927142837.GB2108@work-vm>
	<20170927164644.42205e6f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927164644.42205e6f.cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: create a compat s390 phb for
 <=2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Wed, 27 Sep 2017 15:28:38 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>=20
> > * David Hildenbrand (david@redhat.com) wrote:
> > > On 27.09.2017 12:59, Christian Borntraeger wrote: =20
> > > >=20
> > > >=20
> > > > On 09/27/2017 12:56 PM, Cornelia Huck wrote: =20
> > > >> On Wed, 27 Sep 2017 18:25:00 +0800
> > > >> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> > > >> =20
> > > >>> =E5=9C=A8 2017/9/27 =E4=B8=8B=E5=8D=885:47, Cornelia Huck =E5=86=
=99=E9=81=93: =20
> > > >>>> On Tue, 26 Sep 2017 20:40:25 +0200
> > > >>>> David Hildenbrand <david@redhat.com> wrote: =20
> > > >> =20
> > > >>>>> I'd really really really (did I mention really?) favor someth=
ing like a
> > > >>>>> dummy device, because we could easily handle the !CONFIG_PCI =
case then.
> > > >>>>>
> > > >>>>> All these compat options and conditions will kill us someday.=
.. we're
> > > >>>>> already patching around that whole stuff way too much.
> > > >>>>>
> > > >>>>> If we ever unconditionally created a device, we should keep d=
oing so.   =20
> > > >>>> Yes, that whole thing is horrible, especially interaction with=
 compat
> > > >>>> machines.
> > > >>>>
> > > >>>> Do you have an idea on how to create such a dummy device (with=
out
> > > >>>> having to effectively copy a lot of configured-out code)?
> > > >>>>
> > > >>>>   =20
> > > >>> How about in s390_pcihost_hot_plug() we check s390_has_feat(zpc=
i)?
> > > >>> If no zpci feature, we avoid plugging any pci device.
> > > >>> Then we could always create phb.
> > > >>> I think pcibus's vmstate is only data to migrate. =20
> > > >>
> > > >> That's still problematic if CONFIG_PCI is off. I currently don't=
 have a
> > > >> better idea than either disallowing compat machines on builds wi=
thout
> > > >> pci, or using a dummy device... =20
> > > >=20
> > > > For this particular case your initial patch might be less problem=
atic than
> > > > a dummy device, because the code that does the migration is NOT c=
ontained
> > > > in s390 specific code but in common PCI code instead. We would ne=
ed to keep
> > > > the dummy device always in a way that it will work with the commo=
n PCI
> > > > code.
> > > >  =20
> > >=20
> > > Interesting, so how is migration then handled for e.g. x86 or other
> > > architectures that can work without CONFIG_PCI? I assume their migr=
ation
> > > should also break? =20
> >=20
> > It's tied to machine-type; the x86 i440fx and q35 machine types have
> > PCI; you can't disable PCI while still having those machine types.
> > (I don't know if you can disable PCI at all on x86)
>=20
> Ugh, that sounds like we need two machine types on s390x as well
> (s390x-ccw-virtio and s390x-ccw-virtio-nopci or so), built
> conditionally. That whole zpci detanglement is looking worse and
> worse :(

Well fundamentally the migration expects to migrate something into
the same shaped hole on the destination;  if you've got a lump of PCI
config on the source there's got to be somewhere for it to fit on the
destination.
Now, if PCI is actually pretty rare; then you might be able to make
the host-pci bridge a normal device and not include it in any
machine type; that way those who want PCI can just instantiate
the host-pci bridge, and those who don't want it just stick with
the base machine type.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
