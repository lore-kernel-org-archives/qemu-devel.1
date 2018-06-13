Received: from eggs.gnu.org ([2001:4830:134:3::10]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT6Ve-0004OY-S8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT6Vd-0003IX-TL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:12:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT6Vd-0003HZ-My
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:12:25 -0400
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
	<20180613094727.11326-2-mark.cave-ayland@ilande.co.uk>
	<51d6368f-8a13-0daf-dcc2-78303af152ad@redhat.com>
	<2b146796-ade4-ec2c-34a9-6d6532d94175@ilande.co.uk>
	<4a2d3eca-95d0-c1ca-4769-7a06115cc2e5@redhat.com>
	<6515c082-3904-e077-144d-d1f3f9fd7ee1@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee19138b-fc56-abef-a556-c725fcd4841b@redhat.com>
Date: Wed, 13 Jun 2018 16:12:04 +0200
MIME-Version: 1.0
In-Reply-To: <6515c082-3904-e077-144d-d1f3f9fd7ee1@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/mips/jazz: create ESP device
 directly via qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, hpoussin@reactos.org, famz@redhat.com

On 13/06/2018 15:06, Mark Cave-Ayland wrote:
>>
>> Heh, those are disgusting indeed. :)=C2=A0 So I guess it would have to=
 stay,
>> only MIPS can use the pure MemoryRegion-based approach.
>=20
> The only option I can think of is inserting an AddressSpace between the
> esp/ledma device and the IOMMU AddressSpace which intercepts the DMA
> request (addr, len, direction).
>=20
> I can then grab a reference to the device from the MemoryRegion opaque,
> perform the magic, and then manually invoke address_space_rw() on iommu=
_as.
>=20
> Is there a hook somewhere in the memory API that could allow me to do t=
his?

No, I don't think so.  Only MMIO regions intercept reads/writes, and
they only do it at 1/2/4/8 byte granularity.

>> Regarding pcnet, is CSR_BSWP really a no-op on PCI cards?=C2=A0 If not=
, an
>> option could be to move that handling to pcnet.c - making the ledma sw=
ap
>> unconditional and removing the do_bswap argument.=C2=A0 The disadvanta=
ge is
>> that SPARC would swap twice, and you'd have to keep the callback becau=
se
>> of s->dmaregs[3], but maybe it's still worthwhile.
>=20
> Hmmm good question. If we can intercept the request above, that would b=
e
> my preferred option as something tells it me it might be useful for
> other similar situations.

Yeah, it wouldn't be a great improvement, but there would be the benefit
of more accurate emulation.

Paolo
