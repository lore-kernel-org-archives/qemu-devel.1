Received: from eggs.gnu.org ([2001:4830:134:3::10]:36241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fuWi2-0002Wy-Fn
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 01:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fuWhE-0007IW-NT
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 01:37:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fuWhE-0007Ff-Fk
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 01:37:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id j26-v6so325638wre.2
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 22:37:44 -0700 (PDT)
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
	<CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <5f5dc082-7053-d6b9-b01f-fffba1847ba5@gmail.com>
Date: Tue, 28 Aug 2018 08:37:39 +0300
MIME-Version: 1.0
In-Reply-To: <CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC v2 0/3] Support multiple pci
 domains in pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, seabios@seabios.org

Hi Gerd

On 08/28/2018 07:12 AM, Zihan Yang wrote:
> Gerd Hoffmann <kraxel@redhat.com> 于2018年8月27日周一 上午7:04写道：
>>    Hi,
>>
>>>>    However, QEMU only binds port 0xcf8 and 0xcfc to
>>>> bus pcie.0. To avoid bus confliction, we should use other port pairs for
>>>> busses under new domains.
>>> I would skip support for IO based configuration and use only MMCONFIG
>>> for extra root buses.
>>>
>>> The question remains: how do we assign MMCONFIG space for
>>> each PCI domain.

Thanks for your comments!

>> Allocation-wise it would be easiest to place them above 4G.  Right after
>> memory, or after etc/reserved-memory-end (if that fw_cfg file is
>> present), where the 64bit pci bars would have been placed.  Move the pci
>> bars up in address space to make room.
>>
>> Only problem is that seabios wouldn't be able to access mmconfig then.
>>
>> Placing them below 4G would work at least for a few pci domains.  q35
>> mmconfig bar is placed at 0xb0000000 -> 0xbfffffff, basically for
>> historical reasons.  Old qemu versions had 2.75G low memory on q35 (up
>> to 0xafffffff), and I think old machine types still have that for live
>> migration compatibility reasons.  Modern qemu uses 2G only, to make
>> gigabyte alignment work.
>>
>> 32bit pci bars are placed above 0xc0000000.  The address space from 2G
>> to 2.75G (0x8000000 -> 0xafffffff) is unused on new machine types.
>> Enough room for three additional mmconfig bars (full size), so four
>> pci domains total if you add the q35 one.
> Maybe we can support 4 domains first before we come up
> with a better solution. But I'm not sure if four domains are
> enough for those who want too many devices?

(Adding Michael)

Since we will not use all 256 buses of an extra PCI domain,
I think this space will allow us to support more PCI domains.

How will the flow look like ?

1. QEMU passes to SeaBIOS information of how many extra
    PCI domains needs, and how many buses per domain.
    How it will pass this info? A vendor specific capability,
    some PCI registers or modifying extra-pci-roots fw_cfg file?

2. SeaBIOS assigns the address for each PCI Domain and
     returns the information to QEMU.
     How it will do that? Some pxb-pcie registers? Or do we model
     the MMCFG like a PCI BAR?

3. Once QEMU gets the MMCFG addresses, it can answer to
     mmio configuration cycles.

4. SeaBIOS queries all PCI domains devices, computes
    and assigns IO/MEM resources (for PCI domains > 0 it will
    use MMCFG to configure the PCI devices)

5. QEMU uses the IO/MEM information to create the CRS for each
     extra PCI host bridge.

6. SeaBIOS gets the ACPI tables from QEMU and passes them to the
    guest OS.

Thanks,
Marcel





>> cheers,
>>    Gerd
>>
