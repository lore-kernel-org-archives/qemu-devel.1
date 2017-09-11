Received: from eggs.gnu.org ([2001:4830:134:3::10]:52174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drQfj-0003h8-G5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drQfe-00069J-Jb
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:30:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drQfe-00067E-Bm
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:30:46 -0400
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-4-aik@ozlabs.ru>
	<984ae4a4-3045-e880-b39e-da846b1e2821@redhat.com>
	<b0ddd613-701c-4814-8241-d15d6917643f@ozlabs.ru>
	<32ae1779-0d00-0d1b-194f-130477531fdc@redhat.com>
	<38a55868-aea6-b0ef-3785-6d3621c2ab78@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15727777-9a90-3da9-dfa0-17a717dcab15@redhat.com>
Date: Mon, 11 Sep 2017 17:30:40 +0200
MIME-Version: 1.0
In-Reply-To: <38a55868-aea6-b0ef-3785-6d3621c2ab78@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/4] memory: Share flat views and
 dispatch trees between address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 11/09/2017 14:08, Alexey Kardashevskiy wrote:
>> Ok, this makes sense.  Maybe it should be a flatview rather than an
>> AddressSpaceDispatch (a FlatView is essentially a list of
>> MemoryRegionSections; attaching the ASD to the FlatView is more or les=
s
>> an implementation detail).
> The helpers I converted from AddressSpace to AddressSpaceDispatch do us=
e
> dispatch structure only and do not use FlatView so it seemed logical.

Understood, but from a design POV FlatView makes more sense.

> btw this address_space in MemoryRegionSection - it does not seem to mak=
e
> much sense in the PhysPageMap::sections array, it only makes sense when
> MemoryRegionSection uses as a temporary object when calling listeners. =
Will
> it make sense if we enforce MemoryRegionSection::address_space to be NU=
LL
> in the array and not NULL when used temporary?

memory_region_section_get_iotlb needs to access the AddressSpaceDispatch
for sections stored in the PhysPageMap array, because
memory_region_section_get_iotlb uses the ASD to compute the section index=
.

Paolo
