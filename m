Received: from eggs.gnu.org ([2001:4830:134:3::10]:49277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctvH5-00069r-Bz
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctvH2-0004nu-9n
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:03:27 -0400
References: <20170330124707.28142-1-aik@ozlabs.ru>
	<20170330124707.28142-3-aik@ozlabs.ru>
	<82c140ad-da36-5c2a-3f10-567d3108b15a@redhat.com>
	<a08e4150-6a3b-b6d3-efc6-16def8517b59@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <306e1353-2a82-79e3-7001-5933efbf01f3@redhat.com>
Date: Fri, 31 Mar 2017 14:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <a08e4150-6a3b-b6d3-efc6-16def8517b59@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH qemu 2/5] spapr-iommu: Subclass
 TYPE_IOMMU_MEMORY_REGION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>



On 31/03/2017 13:47, Alexey Kardashevskiy wrote:
>>> =20
>>> +static void spapr_iommu_memory_region_class_init(ObjectClass *k, voi=
d *data)
>>> +{
>>> +    sPAPRIOMMUMemoryRegionClass *smrc =3D SPAPR_IOMMU_MEMORY_REGION_=
CLASS(k);
>>> +
>>> +    smrc->get_fd =3D spapr_tce_get_fd;
>>> +}
>>> +
>> You don't even need the virtual function.  Rather, make spapr_tce_get_=
fd
>> public and give it a sPAPRTCETable argument.  Then vfio_spapr_notify_k=
vm
>> can use SPAPR_IOMMU_MEMORY_REGION(iommumr).
> Well, if I make spapr_tce_get_fd() public, vfio_spapr_notify_kvm() coul=
d
> just take MemoryRegion and cast it to sPAPRTCETable without all these
> dances with MemoryRegion, IOMMUMemoryRegion, what do I miss here? I hav=
e
> made a big patch with IOMMUMemoryRegion though, post it?

*I* was missing that the call was inside an "if (container->iommu_type =3D=
=3D TCE)".

So the hierarchy is good to have, but the virtual function can be removed=
.

Paolo
