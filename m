Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fYTL7-0005R7-2R
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fYTL3-0000C8-UG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:35:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fYTL3-0000Be-Lq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:35:41 -0400
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
	<20180623085028.29553-2-mark.cave-ayland@ilande.co.uk>
	<7ac656b2-374a-8591-08a6-8303aae1eba1@redhat.com>
	<bde3e16f-e9e1-ace5-f324-83ef2042bc48@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <efc30091-81fc-2773-ea28-9cb4fea44659@redhat.com>
Date: Thu, 28 Jun 2018 11:35:36 +0200
MIME-Version: 1.0
In-Reply-To: <bde3e16f-e9e1-ace5-f324-83ef2042bc48@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] sysbus: always allow
 explicit_ofw_unit_address() to override address generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, marcel@redhat.com, armbru@redhat.com, mst@redhat.com

On 06/27/18 21:59, Mark Cave-Ayland wrote:
> On 25/06/18 08:32, Laszlo Ersek wrote:
>=20
> Hi Laszlo,
>=20
>>> As any class defining explicit_ofw_unit_address() has explicitly
>>> requested a
>>> specialised behaviour then it should be used in preference to the
>>> default
>>> implementation rather than being used as a fallback.
>>
>> I disagree about the last paragraph, when put like this. I don't
>> disagree with the *goal* of the patch, however the original
>> justification for explicit_ofw_unit_address() was different.
>>
>> It was meant as a fallback for distinguishing sysbus devices when thos=
e
>> sysbus devices had neither MMIO nor PIO resources. The issue wasn't th=
at
>> MMIO/PIO-based identification was not "right", the issue was that uniq=
ue
>> identification was impossible in the absence of such resources. Please
>> see commit 0b336b3b98d8 ("hw/core: explicit OFW unit address callback
>> for SysBusDeviceClass", 2015-06-23).
>>
>> I don't have anything against repurposing explicit_ofw_unit_address()
>> like this -- as long as you check that it doesn't change behavior for
>> existing devices -- it's just that we shouldn't justify the new purpos=
e
>> with the original intent. The original intent was different.
>>
>> I suggest stating, "we can have explicit_ofw_unit_address() take
>> priority in a backwards-compatible manner, because no sysbus device
>> currently has both explicit_ofw_unit_address() and MMIO/PIO resources"=
.
>=20
> Thanks for the feedback, I'm more than happy to update the commit
> message to better describe the original intent of the patch. How does
> the following sound to you?
>=20
>=20
> Some SysBusDevices either use sysbus_init_mmio() without
> sysbus_mmio_map() or the first MMIO memory region doesn't represent the
> bus address, causing a firmware device path with an invalid address to
> be generated.
>=20
> SysBusDeviceClass does provide a virtual explicit_ofw_unit_address()
> method that can be used to override this process, but it is only
> considered as a fallback option meaning that any existing MMIO memory
> regions still take priority whilst determining the firmware device addr=
ess.

s/is only considered as/was originally intended only as/

and then it looks great to me.

Thank you!
Laszlo

> There is currently only one user of explicit_ofw_unit_address() and tha=
t
> is the PCI expander bridge (PXB) device which has no MMIO/PIO resources
> defined. This enables us to allow explicit_ofw_unit_address() to take
> priority without affecting backwards compatibility, allowing the addres=
s
> to be customised as required.
>=20
>> (Obviously checking the validity of this statement is up to you; I'm
>> just suggesting what I'd see as one more precise explanation.)
> =C2=A0Yes, it seems correct to me - grep tells me the PXB device is the=
 only
> user of explicit_ofw_unit_address() in the whole code base, and there
> are no sysbus_init_*() functions anywhere within pci_expander_bridge.c.
>=20
>=20
> ATB,
>=20
> Mark.
