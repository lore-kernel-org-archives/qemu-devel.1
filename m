Received: from eggs.gnu.org ([2001:4830:134:3::10]:49473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ewLco-0005Dt-D1
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ewLcl-0006V5-9U
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1ewLck-0006ST-UU
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:40:23 -0400
Date: Thu, 15 Mar 2018 01:40:18 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <696526015.11205269.1521092418816.JavaMail.zimbra@redhat.com>
In-Reply-To: <71BA0BC4-C5FD-4286-B3A7-EFF579588F63@redhat.com>
References: <797197129.10905208.1521004004370.JavaMail.zimbra@redhat.com>
	<71BA0BC4-C5FD-4286-B3A7-EFF579588F63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Suggestion on 'virtio-pmem' implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <dhildenb@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@surriel.com>


Hi David,

>=20
> Hi Pankaj,
>=20
> I have a prototype (new one for virtio-mem I was working on over the last
> weeks) for exactly what you need. I basically factored out the notion of =
a
> memory device. So also virtio devices can be memory devices and get
> recognized e.g. in formerly known pc_dimm_get_free_address(), so it works
> out nicely with ordinary memory hotplug and such.

Nice. This is very useful re-factoring.

>=20
> Guess your main problem right now is that you don=E2=80=98t create a memo=
ry slot
> properly. But I also have code for that that you can built onto.

sure.

>=20
> I=E2=80=98m right now in Sri Lanka on vacation, I=E2=80=98ll be back on 2=
3. September and
> will send you the link to a branch with the prototype asap.

Cool. Enjoy your vacation and thanks for the reply.

Best regards,
Pankaj

>=20
> Thanks,
>=20
> David / dhildenb / david@redhat.com
>=20
> Von meinem iPhone gesendet
>=20
> > Am 14.03.2018 um 10:36 schrieb Pankaj Gupta <pagupta@redhat.com>:
> >=20
> >=20
> >=20
> > Hi,
> >=20
> >=20
> > I am implementing 'virtio-pmem' as a mechanism to
> > flush guest writes with 'fake DAX' flushing interface.
> >=20
> > Below is the high level details of components:
> >=20
> > 1] 'virtio-pmem' device expose guest physical address
> >  details(start, len).
> >=20
> > 2] 'virtio-pmem' driver in guest discovers this
> >    information and configures 'libnvdimm'. Guest 'pmem'
> >    driver works on this memory range.
> >=20
> > 3] Guest 'pmem' driver uses 'virtio-pmem' PV driver to
> >   send flush commands.
> >=20
> >=20
> > I need suggestion implementing part 1]
> >=20
> > * When tried with 'hotplug_memory.base' address as guest physical
> >  address, I am facing 'EPT_MISCONFIG' errors when pmem does mkfs.
> >  After digging more it looks like address range I am using as guest
> >  physical address is either already mapped as MMIO or reserved.
> >  Though Guest hot-plugs this physical address into its virtual
> >  memory range when guest tries to read/write the memory KVM cannot
> >  translate the address and throw 'EPT_MISCONFIG' error.
> >=20
> > * While I am trying to get the appropriate guest physical address
> >  which is free, I could see memory 'pc_dimm_memory_plug' code
> >  has a function 'pc_dimm_get_free_addr' which works with 'PC DIMM'
> >  class. As I am using 'VIRTIO', there is no way AFAIK this function
> >  can be used by VIRTIO or my PV device code.
> >=20
> >=20
> > I need ideas to get the free guest physical address from my PV
> > device code so that we can use this range in guest address space.
> >=20
> > Find below pointer to previous discussion:
> >=20
> > https://marc.info/?l=3Dkvm&m=3D151629709903946&w=3D2
> >=20
> > Thanks,
> > Pankaj
> >=20
>=20
