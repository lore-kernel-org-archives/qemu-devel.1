Received: from eggs.gnu.org ([2001:4830:134:3::10]:35492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dHoin-0005Tb-5j
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dHoij-00020s-5R
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dHoii-0001zg-Si
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:54:45 -0400
Date: Mon, 5 Jun 2017 11:54:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170605115429.29c252f6@nial.brq.redhat.com>
In-Reply-To: <2ff62b03-d71b-93c4-79bf-10682b229758@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<2ff62b03-d71b-93c4-79bf-10682b229758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] allocation zone extensions for the firmware
 linker/loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: SeaBIOS devel list <SeaBIOS@seabios.org>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-ml01 <edk2-devel@ml01.01.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Ben Warren <ben@skyportsystems.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, "Leif Lindholm (Linaro
	address)" <leif.lindholm@linaro.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Kevin O'Connor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>

On Sat, 3 Jun 2017 09:36:23 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 06/02/17 17:45, Laszlo Ersek wrote:
> 
> > The patches can cause linker/loader breakage when old firmware is booted
> > on new QEMU. However, that's no problem (it's nothing new), the next
> > release of QEMU should bundle the new firmware binaries as always.  
> 
> Dave made a good point (which I should have realized myself, really!),
> namely if you launch old fw on old qemu, then migrate the guest to a new
> qemu and then reboot the guest on the target host, within the migrated
> VM, things will break.
[...]

> Regarding the NOACPI hint, I guess I'm dropping that. I only meant
> NOACPI for addressing Igor's long-standing dislike for the "ACPI SDT
> header probe suppression" in VMGENID (and future similar devices). But,
> there's no actual *technical* need to eliminate that 
I'd consider eliminating wasting space technical need,
but there are not a lot of tables that need it so far and
implementing NOACPI hint would lead to all out compat
logic impl. along with it (either negotiation or machine versioning).
The later seem to me too much so I wouldn't bother with it yet.

> (unlike the technical need for 64-bit blob allocations which should really be
> solved)
here I disagree, having 32bit pointer is sufficient enough hint.
Yep, firmware have to scan linker script to determine limits
before doing allocations but it's totally upto firmware to decide
where to allocate tables.
It also helps to avoid in qemu 2 points where we'd have to specify
that table is "64 bit-able" in add_pointer and allocate.

BTW:
how OVMF would deal with booting 32-bit OS if it would allocate
ACPI tables above 4Gb?
For BIOS on baremetal I'd expect some switch in settings, something
like "Disable 32-bit OS support".

> Self-nack for this set of sets.
> 
> Thanks for the feedback,
> Laszlo
> 
