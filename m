Received: from eggs.gnu.org ([2001:4830:134:3::10]:51779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dfA4p-0004dy-Kj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dfA4o-0000bm-B6
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:22:03 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:33127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dfA4o-0000bU-5E
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:22:02 -0400
Received: by mail-pf0-x22e.google.com with SMTP id h68so18301643pfk.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 12:22:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87e569e6-e1ec-4238-e073-38c0e136af0d@redhat.com>
References: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
	<1501964858-5159-6-git-send-email-zuban32s@gmail.com>
	<87e569e6-e1ec-4238-e073-38c0e136af0d@redhat.com>
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Tue, 8 Aug 2017 22:21:59 +0300
Message-ID: <CAKSfGUD3cy7hMxT6PQULk21PO16e=s3A5jq_fZfR_J6rk325eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net

2017-08-08 18:11 GMT+03:00 Laszlo Ersek <lersek@redhat.com>:
> one comment below
>
> On 08/05/17 22:27, Aleksandr Bezzubikov wrote:
>
>> +Capability layout (defined in include/hw/pci/pci_bridge.h):
>> +
>> +    uint8_t id;     Standard PCI capability header field
>> +    uint8_t next;   Standard PCI capability header field
>> +    uint8_t len;    Standard PCI vendor-specific capability header field
>> +
>> +    uint8_t type;   Red Hat vendor-specific capability type
>> +                    List of currently existing types:
>> +                        QEMU_RESERVE = 1
>> +
>> +
>> +    uint32_t bus_res;   Minimum number of buses to reserve
>> +
>> +    uint64_t io;        IO space to reserve
>> +    uint64_t mem        Non-prefetchable memory to reserve
>> +    uint64_t mem_pref;  Prefetchable memory to reserve
>
> (I apologize if I missed any concrete points from the past messages
> regarding this structure.)
>
> How is the firmware supposed to know whether the prefetchable MMIO
> reservation should be made in 32-bit or 64-bit address space? If we
> reserve prefetchable MMIO outside of the 32-bit address space, then
> hot-plugging a device without 64-bit MMIO support could fail.
>
> My earlier request, to distinguish "prefetchable_32" from
> "prefetchable_64" (mutually exclusively), was so that firmware would
> know whether to restrict the MMIO reservation to 32-bit address space.

IIUC now (in SeaBIOS at least) we just assign this PREF registers
unconditionally,
so the decision about the mode can be made basing on !=0
UPPER_PREF_LIMIT register.
My idea was the same - we can just check if the value doesn't fit into
16-bit (PREF_LIMIT reg size, 32-bit MMIO). Do we really need separate
fields for that?

>
> This is based on an earlier email from Alex to me:
>
> On 10/03/16 18:01, Alex Williamson wrote:
>> I don't think there's such a thing as a 64-bit non-prefetchable
>> aperture.  In fact, there are not separate 32 and 64 bit prefetchable
>> apertures.  The apertures are:
>>
>> I/O base/limit - (default 16bit, may be 32bit)
>> Memory base/limit - (32bit only, non-prefetchable)
>> Prefetchable Memory base/limit - (default 32bit, may be 64bit)
>>
>> This is according to Table 3-2 in the PCI-to-PCI bridge spec rev 1.2.
>
> I don't care much about the 16-bit vs. 32-bit IO difference (that's
> entirely academic and the Platform Spec init doesn't even provide a way
> for OVMF to express such a difference). However, the optional
> restriction to 32-bit matters for the prefetchable MMIO aperture.
>
> Other than this, the patch looks good to me, and I'm ready to R-b.
>
> Thanks!
> Laszlo



-- 
Aleksandr Bezzubikov
