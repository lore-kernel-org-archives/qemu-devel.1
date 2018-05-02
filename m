Received: from eggs.gnu.org ([2001:4830:134:3::10]:44457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fDpzK-0008Bb-FH
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fDpzJ-00028l-GY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:31:58 -0400
References: <f41972e8-0ae2-7c1d-a66a-499a841080e3@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <13d95529-d61e-fc30-ffd4-f1ef93edad40@redhat.com>
Date: Wed, 2 May 2018 13:31:47 +0200
MIME-Version: 1.0
In-Reply-To: <f41972e8-0ae2-7c1d-a66a-499a841080e3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Expand ECAM region in machvirt 2_13?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu list <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 05/01/18 17:59, Auger Eric wrote:
> Hi,
> 
> I would like to resume the discussion on extending the number of PCI
> buses to 256 (as in Q35) as a follow-up of past discussions:
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03631.html.
> 
> With the current 16MB ECAM region we are limited to 16 PCIe busses.
> 
> Could we envision to have a 256MB ECAM region and move it to another
> location beyond 256GB, in virt2_13 machine type?
> 
> Current ECAM range within [0x3f000000, 0x40000000]
> would be kept unchanged for legacy and when vms->highmem is set to false.
> Migration from <2_13 to >=2_13 would be allowed whereas migration from
>> =2.13 to <2.13 wouldn't.

If I understand correctly, the idea is to *move* the current one range,
if the virt machine type is >= 2.13 and highmem is set to true (which is
the default IIUC, from 2.12 onward).

For 64-bit (AARCH64) ArmVirtQemu, that should work fine. The firmware
takes the ECAM base and size from the "pci-host-ecam-generic" DT node,
property "reg", uint64_t elements #0 and #1. (Sorry if this isn't exact
DT lingo, I'm paraphrasing the firmware source code.) If the QEMU patch
just changes the values, that should work transparently.

For 32-bit (ARM) ArmVirtQemu, this change (the new ECAM default) could
be a problem. PCI stuff in the firmware wouldn't work unless people
specified highmem=off on the QEMU command line.

Now, I notice highmen defaults to "on" starting with 2.12 even for
"qemu-system-arm -M virt", not just "qemu-system-aarch64 -M virt", so
why doesn't that already cause a problem with PCI in the 32-bit guest fw?

Because, currently "highmen" only controls the presence of the 64-bit
PCI MMIO aperture for BAR allocation; it has no effect on config space.
And if the 64-bit PCI MMIO aperture is exposed to the 32-bit guest
firmware, the latter simply ignores the former, and works with the
32-bit aperture solely (which is always there).

So, for "qemu-system-arm -M virt" compatibility, I think we might need a
separate machine type property, which should default to "on" only on
qemu-system-aarch64 (if such distinctions are allowed).

Of course, I can't tell if the 32-bit ArmVirtQemu firmware is possible
to run on "qemu-system-aarch64 -M virt". (I think it is; I recall
something something about ARMv8 having ARMv7 compat, but I don't
remember ever trying.) If that's the case, then even the above
suggestion won't work, because it would break 32-bit guest fw that the
user has run (for whatever reason) on "qemu-system-aarch64 -M virt". In
this case, I believe we can't just change the contents of the current
"pci-host-ecam-generic" node, but we should implement some structural
DTB addition that old firmware will simply not notice, while new
(64-bit) firmware will specifically look for (and prefer over the old DT
stuff).

Ard, what's your take? (Sorry if you've already followed up, my email
processing lags.)

Thanks
Laszlo
