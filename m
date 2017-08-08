Received: from eggs.gnu.org ([2001:4830:134:3::10]:43599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1df6n7-0008Qe-Lz
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1df6n5-0003Xj-9h
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1df6n4-0003Wq-Vj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:51:31 -0400
References: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
Date: Tue, 8 Aug 2017 17:51:23 +0200
MIME-Version: 1.0
In-Reply-To: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Drew Jones <drjones@redhat.com>, Christoffer Dall <cdall@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gema Gomez-Solano <gema.gomez-solano@linaro.org>, Marc Zygnier <marc.zyngier@arm.com>

On 08/08/17 12:39, Marcin Juszkiewicz wrote:
>
> Few days ago I had an issue with getting PCIe hotplug working on
> AArch64 machine. Enabled PCI hotplug in kernel and then got hit by
> some issues.
>
> Out setup is a bunch of aarch64 servers and we use OpenStack to
> provide access to arm64 systems. OpenStack uses libvirt to control VMs
> and allows to add network interfaces and disk volumes to running
> systems.
>
> By libvirt AArch64 is treated as PCIe machine without legacy PCI
> slots. So to hotplug anything you first need to have enough
> pcie-root-port entries as it is described in Qemu docs/pcie.txt and by
> patch to libvirt documentation [1][2].
>
> 1. https://bugs.linaro.org/attachment.cgi?id=782
> 2. https://www.redhat.com/archives/libvir-list/2017-July/msg01033.html
>
>
> But things get complicated once you are going to 32 PCIe devices limit
> (which in our setup will rather not happen). UEFI first takes ages to
> boot just to land in UEFI shell as it forgot all PCIe devices. With 31
> devices it boots (also after long time).

OK, let me quote my earlier off-list followup (so that the discussion
proceed publicly -- hopefully other thread participants will also repeat
their off-list messages, and/or clarify my conveying them):

On 08/07/17 19:32, Laszlo Ersek wrote:
>
> (1) Everything that's being worked out right now for PCI Express
> hotplug on Q35 (x86) applies equally to aarch64. Meaning, hotplug
> oriented aperture reservations for bus numbers, "IO ports", and
> various types of MMIO.
>
> This is to say that resource reservation is not a done deal (it's
> being designed) for x86 even, and it will take changes for both QEMU
> and OVMF. In OVMF, the relevant driver is "OvmfPkg/PciHotPlugInitDxe".
> Once we implement the necessary logic there (using a new
> "communication channel" with QEMU), then the driver should be possible
> to include in the ArmVirtQemu builds as well.
>
> Marcel, can you please provide pointers to the qemu-devel and seabios
> mailing list discussions?

(Marcel provided the following links, "IO/MEM/Bus reservation hints":

 SeaBIOS:
   - https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06289.html
   - https://www.mail-archive.com/qemu-devel@nongnu.org/msg468550.html
   - https://www.mail-archive.com/qemu-devel@nongnu.org/msg470584.html
 QEMU:
   - https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07110.html
   - https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg09157.html
)

>
> The OVMF (and AAVMF) RHBZs for adhering to QEMU's IO and MMIO aperture
> hints are:
>
> - https://bugzilla.redhat.com/show_bug.cgi?id=1434740
> - https://bugzilla.redhat.com/show_bug.cgi?id=1434747
>
> The prerequisite QEMU RHBZs are:
> - https://bugzilla.redhat.com/show_bug.cgi?id=1344299
> - https://bugzilla.redhat.com/show_bug.cgi?id=1437113
>
> In addition, there are some issues with edk2's generic PciBusDxe as
> well; for example ATM it ignores bus number reservations for the kinds
> of hotplug controllers that we care about:
>
> https://bugzilla.tianocore.org/show_bug.cgi?id=656
>
> I got a promise on edk2-devel from Ruiyu Ni (PciBusDxe maintainer from
> Intel) that he'd fix the issue at some point, but it's "not high
> priority".
>
>
> (2) As discussed earlier, the aarch64 "virt" machine type has a
> serious limitation relative to Q35: the former's MMCONFIG space is so
> small that it allows for only 16 buses. Each PCI Express root port and
> downstream port uses up a separate bus number. Please re-check
> "docs/pcie.txt" in the QEMU source tree with particular attention to
> section "4. Bus numbers issues" and "5. Hot-plug".
>
> When the edk2 PciBusDxe driver runs out of any kind of aperture (such
> as bus numbers, for example), it starts dropping devices. In general
> it prefers to drop devices with the largest resource consumptions (so
> that it has to drop the fewest devices for enabling the rest to work).
> In case many "uniform" devices are used, it is unspecified which ones
> get dropped. This can easily lead to boot failures (if the dropped
> devices inlcude the one(s) you wanted to boot off of).
>
> (3) The edk2 boot performance when using a large number of PCI
> (Express) devices is indeed really bad. I've looked into it earlier
> (on Q35), briefly, see for example:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1441550#c11

(Here Marcel referenced the following message, also reporting about slow
PCI enumeration:
<https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07182.html>.
In this case the issue hit the guest kernel; OVMF was not used (and
SeaBIOS was unaffected).)

> As you can see, platform-independent, NIC enumeration-related code in
> edk2 is *really heavy* on UEFI variables. If you had a physical
> machine with lots of pflash, and tens (or hundreds) of NICs, the perf
> would suffer mostly the same.
>
> Anyway, beyond the things written in that comment, there is one very
> interesting symptom that makes me think another (milder?) bottleneck
> could be in QEMU:
>
> When having a large number of PCI(e) devices (to the tune of 100+),
> even the printing of DEBUG messages slows down extremely, to the point
> where I can basically follow, with the naked eye, the printing of
> *individual* characters, on the QEMU debug port. (Obviously such
> printing is unrelated to PCI devices; the QEMU debug port is a simple
> platform device on Q35 and i440fx). This suggests to me that the high
> number of MemoryRegion objects in QEMU, used for the BARs of PCI(e)
> devices and bridges, could slow down the dispatching of the individual
> IO or MMIO accesses. I don't know what data structure QEMU uses for
> representing the "flat view" of the address sapce, but I think it
> *could* be a bottleneck. At least I tried to profile a few bits in the
> firmware, and found nothing related specifically to the slowdown of
> DEBUG prints.

(Paolo says the data structure is a radix tree, so the bottleneck being
there would be surprising. Also Paolo has given me tips for profiling,
so I'm looking into it.)

(Another remark from Paolo, paraphrased: programming the BARs relies on
an O(n^3) algorithm, fixing which is on the todo list.)

>
> In summary:
> - all of the hotplug stuff is still under design / in flux even for
>   x86
> - MMCONFIG of "virt" is too small (too few bus numbers available)
> - the boot perf issue might need even KVM tracing (this is not to say
>   that the UEFI variable massaging during edk2 NIC binding isn't
>   resource hungry! See again RHBZ#1441550 comment 11.)

(Drew added a few more points about mach-virt here; I'll let him repeat
himself.)

Thanks,
Laszlo
