Received: from eggs.gnu.org ([2001:4830:134:3::10]:49691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxDKc-000351-Mk
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxDKW-00032f-Oi
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:28:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxDKW-000325-FW
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:28:52 -0400
Date: Wed, 27 Sep 2017 15:28:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170927142837.GB2108@work-vm>
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
	<e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
	<20170927125606.65dc514d.cohuck@redhat.com>
	<14df9ad6-f0e9-cd51-04dd-4fe994808433@de.ibm.com>
	<4681e677-9e5a-4c1c-8e22-dc5c51b7286d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4681e677-9e5a-4c1c-8e22-dc5c51b7286d@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com

* David Hildenbrand (david@redhat.com) wrote:
> On 27.09.2017 12:59, Christian Borntraeger wrote:
> >=20
> >=20
> > On 09/27/2017 12:56 PM, Cornelia Huck wrote:
> >> On Wed, 27 Sep 2017 18:25:00 +0800
> >> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> >>
> >>> =E5=9C=A8 2017/9/27 =E4=B8=8B=E5=8D=885:47, Cornelia Huck =E5=86=99=
=E9=81=93:
> >>>> On Tue, 26 Sep 2017 20:40:25 +0200
> >>>> David Hildenbrand <david@redhat.com> wrote:
> >>
> >>>>> I'd really really really (did I mention really?) favor something =
like a
> >>>>> dummy device, because we could easily handle the !CONFIG_PCI case=
 then.
> >>>>>
> >>>>> All these compat options and conditions will kill us someday... w=
e're
> >>>>> already patching around that whole stuff way too much.
> >>>>>
> >>>>> If we ever unconditionally created a device, we should keep doing=
 so. =20
> >>>> Yes, that whole thing is horrible, especially interaction with com=
pat
> >>>> machines.
> >>>>
> >>>> Do you have an idea on how to create such a dummy device (without
> >>>> having to effectively copy a lot of configured-out code)?
> >>>>
> >>>> =20
> >>> How about in s390_pcihost_hot_plug() we check s390_has_feat(zpci)?
> >>> If no zpci feature, we avoid plugging any pci device.
> >>> Then we could always create phb.
> >>> I think pcibus's vmstate is only data to migrate.
> >>
> >> That's still problematic if CONFIG_PCI is off. I currently don't hav=
e a
> >> better idea than either disallowing compat machines on builds withou=
t
> >> pci, or using a dummy device...
> >=20
> > For this particular case your initial patch might be less problematic=
 than
> > a dummy device, because the code that does the migration is NOT conta=
ined
> > in s390 specific code but in common PCI code instead. We would need t=
o keep
> > the dummy device always in a way that it will work with the common PC=
I
> > code.
> >=20
>=20
> Interesting, so how is migration then handled for e.g. x86 or other
> architectures that can work without CONFIG_PCI? I assume their migratio=
n
> should also break?

It's tied to machine-type; the x86 i440fx and q35 machine types have
PCI; you can't disable PCI while still having those machine types.
(I don't know if you can disable PCI at all on x86)

Dave

> --=20
>=20
> Thanks,
>=20
> David
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
