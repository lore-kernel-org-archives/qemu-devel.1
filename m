Received: from eggs.gnu.org ([2001:4830:134:3::10]:38840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLFIH-0002cL-M2
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLFIE-0008Qg-K8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:58:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fLFIE-0008QF-Ep
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:58:06 -0400
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<20180522151732.36122156@w520.home>
	<20180523001822-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8fdd9ce2-991f-301d-2a95-0f8e35bb2b9b@redhat.com>
Date: Tue, 22 May 2018 23:58:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180523001822-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Wei Huang <wei@redhat.com>, Drew Jones <drjones@redhat.com>, Eric Auger <eauger@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 05/22/18 23:22, Michael S. Tsirkin wrote:
> On Tue, May 22, 2018 at 03:17:32PM -0600, Alex Williamson wrote:
>> On Tue, 22 May 2018 21:51:47 +0200
>> Laszlo Ersek <lersek@redhat.com> wrote:

>>> But 64-bit is ill-partitioned and/or crowded too: first you have the
>>> cold-plugged >4GB DRAM (whose size the firmware can interrogate), then
>>> the hotplug DIMM area up to "etc/reserved-memory-end" (ditto), then the
>>> 64-bit PCI MMIO aperture (whose size the firmware decides itself,
>>> because QEMU cannot be asked about it presently). Placing the additional
>>> MMCFGs somewhere would need extending the total order between these
>>> things at the design level, more fw_cfg files, more sanity checks in
>>> platform code in the firmware, and, quite importantly, adding support to
>>> multiple discontiguous MMCFGs to core edk2 code.
>>
>> Hmm, we're doing something wrong if we can't figure out some standards
>> within QEMU for placing per domain 64-bit MMIO and MMCFG ranges.
> 
> I thought in this patch it is done by firmware.

Sure, the firmware programs the exbar registers already, but it needs to
rely on some information to figure out the values it should program.
(Also, the information should not arrive in the form of *just* an ACPI
table; that's too hard and/or too late to parse for the firmware.) Right
now the "information" is a hard-coded constant that's known not to
conflict with other parts.

Furthermore, I didn't highlight it earlier, but we can't go arbitrarily
high -- if EPT is enabled, then the physical address width of the host
CPU limits the guest-physical memory address space (incl. memory mapped
devices).

Thanks
Laszlo
