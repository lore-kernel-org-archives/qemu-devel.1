Received: from eggs.gnu.org ([2001:4830:134:3::10]:43300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evk7O-0003R7-58
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evk7N-0004m4-6i
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:37:30 -0400
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-12-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_9cmK9gebqE9997fzhTzKT6Ky9q4jn=fxwziopDyK9Ew@mail.gmail.com>
	<cc6029a1-c177-ee8c-d09b-0ed2af81c897@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75aee987-a08b-570f-ec10-8b4853d853c6@redhat.com>
Date: Tue, 13 Mar 2018 14:37:13 +0100
MIME-Version: 1.0
In-Reply-To: <cc6029a1-c177-ee8c-d09b-0ed2af81c897@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 11/14] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 12/03/2018 16:16, Auger Eric wrote:
>> It is still unclear to me if we need to register an IOMMUNotifier
>> to handle any change in the MSI doorbell which would occur behind
>> the scene and would not lead to any call to kvm_arch_fixup_msi_route()=
.
>=20
> Paolo, do you know the answer to this question ?

Yes, x86 is wrong in this respect (it wouldn't use an IOMMUNotifier, but
it still should process Interrupt Entry Cache invalidations).

>> It seems a bit odd that:
>>  * the code for arm for "PCI devices behind IOMMU need to have
>>    the MSI doorbell writes go through the IOMMU" looks rather
>>    different from the code for x86 for the same thing
>
> ARM SMMU translates MSIs whereas Intel/AMD IOMMU do not translate them.
> Hence this implementation

More precisely, Intel IOMMU implements interrupt remapping through an
MMIO region instead of an IOMMU region, because on x86 interrupt
remapping can also change the MSI value and not just the address.

>>  * the code here needs to know specifically that this is an SMMU
>>    and not some other kind of IOMMU
> Yes when introducing virtio-iommu we will need to get this fixed. We
> need a way to retrieve the iommu mr from the as. I will work on this
> concurrently.

Probably something like address_space_translate can be used?

Paolo
