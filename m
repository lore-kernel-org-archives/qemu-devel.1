Received: from eggs.gnu.org ([2001:4830:134:3::10]:41591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLXX8-0003tl-4N
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLXVc-000575-Jw
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:26:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fLXVc-00051i-6n
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:25:08 -0400
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<dd40007d-b63b-d965-505f-11ff0748e54f@redhat.com>
	<20180523023944-mutt-send-email-mst@kernel.org>
	<e027866e-9740-0866-f1c4-45b8181a6f71@redhat.com>
	<6b3efcdf-c953-b2bc-e8f7-ac172f143d07@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <aa3e1859-bfd0-7fc6-bc9e-c35dd68588a8@redhat.com>
Date: Wed, 23 May 2018 19:25:04 +0200
MIME-Version: 1.0
In-Reply-To: <6b3efcdf-c953-b2bc-e8f7-ac172f143d07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eauger@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 05/23/18 19:11, Marcel Apfelbaum wrote:
> On 05/23/2018 10:32 AM, Laszlo Ersek wrote:
>> On 05/23/18 01:40, Michael S. Tsirkin wrote:
>>> On Wed, May 23, 2018 at 12:42:09AM +0200, Laszlo Ersek wrote:

>>>> If we figure out a placement strategy or an easy to consume
>>>> representation of these data for the firmware, it might be possible
>>>> for OVMF to hook them into the edk2 core (although not in the
>>>> earliest firmware phases, such as SEC and PEI).
>
> Can you please remind me how OVMF places the 64-bit PCI hotplug
> window?

If you mean the 64-bit PCI MMIO aperture, I described it here in detail:

  https://bugzilla.redhat.com/show_bug.cgi?id=1353591#c8

I'll also quote it inline, before returning to your email:

On 03/26/18 16:10, bugzilla@redhat.com wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1353591
>
> Laszlo Ersek <lersek@redhat.com> changed:
>
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>               Flags|needinfo?(lersek@redhat.com |
>                    |)                           |
>
>
>
> --- Comment #8 from Laszlo Ersek <lersek@redhat.com> ---
> Sure, I can attempt :) The function to look at is GetFirstNonAddress()
> in "OvmfPkg/PlatformPei/MemDetect.c". I'll try to write it up here in
> natural language (although I commented the function heavily as well).
>
> As an introduction, the "number of address bits" is a quantity that
> the firmware itself needs to know, so that in the DXE phase page
> tables exist that actually map that address space. The
> GetFirstNonAddress() function (in the PEI phase) calculates the
> highest *exclusive* address that the firmware might want or need to
> use (in the DXE phase).
>
> (1) First we get the highest exclusive cold-plugged RAM address.
> (There are two methods for this, the more robust one is to read QEMU's
> E820 map, the older / less robust one is to calculate it from the
> CMOS.) If the result would be <4GB, then we take exactly 4GB from this
> step, because the firmware always needs to be able to address up to
> 4GB. Note that this is already somewhat non-intuitive; for example, if
> you have 4GB of RAM (as in, *amount*), it will go up to 6GB in the
> guest-phys address space (because [0x8000_0000..0xFFFF_FFFF] is not
> RAM but MMIO on q35).
>
> (2) If the DXE phase is 32-bit, then we're done. (No addresses >=4GB
> can be accessed, either for RAM or MMIO.) For RHEL this is never the
> case.
>
> (3) Grab the size of the 64-bit PCI MMIO aperture. This defaults to
> 32GB, but a custom (OVMF specific) fw_cfg file (from the QEMU command
> line) can resize it or even disable it. This aperture is relevant
> because it's going to be the top of the address space that the
> firmware is interested in. If the aperture is disabled (on the QEMU
> cmdline), then we're done, and only the value from point (1) matters
> -- that determines the address width we need.
>
> (4) OK, so we have a 64-bit PCI MMIO aperture (for allocating BARs out
> of, later); we have to place it somewhere. The base cannot match the
> value from (1) directly, because that would not leave room for the
> DIMM hotplug area. So the end of that area is read from the fw_cfg
> file "etc/reserved-memory-end". DIMM hotplug is enabled iff
> "etc/reserved-memory-end" exists. If "etc/reserved-memory-end" exists,
> then it is guaranteed to be larger than the value from (1) -- i.e.,
> top of cold-plugged RAM.
>
> (5) We round up the size of the 64-bit PCI aperture to 1GB. We also
> round up the base of the same -- i.e., from (4) or (1), as appropriate
> -- to 1GB. This is inspired by SeaBIOS, because this lets the host map
> the aperture with 1GB hugepages.
>
> (6) The base address of the aperture is then rounded up so that it
> ends up aligned "naturally". "Natural" alignment means that we take
> the largest whole power of two (i.e., BAR size) that can fit *within*
> the aperture (whose size comes from (3) and (5)) and use that BAR size
> as alignment requirement. This is because the PciBusDxe driver sorts
> the BARs in decreasing size order (and equivalently, decreasing
> alignment order), for allocation in increasing address order, so if
> our aperture base is aligned sufficiently for the largest BAR that can
> theoretically fit into the aperture, then the base will be aligned
> correctly for *any* other BAR that fits.
>
> For example, if you have a 32GB aperture size, then the largest BAR
> that can fit is 32GB, so the alignment requirement in step (6) will be
> 32GB. Whereas, if the user configures a 48GB aperture size in (3),
> then your alignment will remain 32GB in step (6), because a 64GB BAR
> would not fit, and a 32GB BAR (which fits) dictates a 32GB alignment.
>
> Thus we have the following "ladder" of ranges:
>
> (a) cold-plugged RAM (low, <2GB)
> (b) 32-bit PCI MMIO aperture, ECAM/MMCONFIG, APIC, pflash, etc (<4GB)
> (c) cold-plugged RAM (high, >=4GB)
> (d) DIMM hot-plug area
> (e) padding up to 1GB alignment (for hugepages)
> (f) padding up to the natural alignment of the 64-bit PCI MMIO
>    aperture size (32GB by default)
> (g) 64-bit PCI MMIO aperture
>
> To my understanding, "maxmem" determines the end of (d). And, the
> address width is dictated by the end of (g).
>
> Two more examples.
>
> - If you have 36 phys address bits, that doesn't let you use
>   maxmem=32G. This is because maxmem=32G puts the end of the DIMM
>   hotplug area (d) strictly *above* 32GB (due to the "RAM gap" (b)),
>   and then the padding (f) places the 64-bit PCI MMIO aperture at
>   64GB. So 36 phys address bits don't suffice.
>
> - On the other hand, if you have 37 phys address bits, that *should*
>   let you use maxmem=64G. While the DIMM hot-plug area will end
>   strictly above 64GB, the 64-bit PCI MMIO aperture (of size 32GB) can
>   be placed at 96GB, so it will all fit into 128GB (i.e. 37 address
>   bits).
>
> Sorry if this is confusing, I got very little sleep last night.
>

Back to your email:

On 05/23/18 19:11, Marcel Apfelbaum wrote:
> I think we may be able to succeed with "standard" APCI declarations of
> the PCI segments + placing the extra MMCONFIG ranges before the 64-bit
> PCI hotplug area.

That idea could work, but firmware will need hints about it.

Thanks!
Laszlo
