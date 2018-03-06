Received: from eggs.gnu.org ([2001:4830:134:3::10]:41842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etFlZ-0007ay-L6
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etFlV-0000Zh-MB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:48:41 -0500
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
Date: Tue, 6 Mar 2018 17:48:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06.03.2018 05:01, David Gibson wrote:
> The following changes since commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a562:
> 
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-05 16:41:20 +0000)
> 
> are available in the Git repository at:
> 
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180306
> 
> for you to fetch changes up to 21b786f607b11d888f90bbb8c3414500515d11e7:
> 
>   PowerPC: Add TS bits into msr_mask (2018-03-06 13:16:29 +1100)
> 
> ----------------------------------------------------------------
> ppc patch queue 2018-03-06
> 
> This pull request supersedes ppc-for-2.12-20180302 which had compile
> problems with some gcc versions.  It also contains a few additional
> patches.
> 
> Highlights are:
>     * New Sam460ex machine type
>     * Yet more fixes related to vcpu id allocation for spapr
>     * Numerous macio cleanupsr
>     * Some enhancements to the Spectre/Meltdown fixes for pseries,
>       allowing use of a better mitigation for indirect branch based
>       exploits
>     * New pseries machine types with Spectre/Meltdown mitigations
>       enabled (stop gap until libvirt and management understands the
>       machine options)
>     * A handful of other fixes
> 
> ----------------------------------------------------------------
> BALATON Zoltan (5):
>       ppc440_uc: Fix unintialized variable warning with older gcc
>       ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
>       roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
>       pc-bios: Added u-boot-sam460 firmware binary
>       ppc: Add aCube Sam460ex board
> 
> David Engraf (1):
>       PPC: e500: Fix duplicate kernel load and device tree overlap
> 
> Greg Kurz (3):
>       spapr: fix missing CPU core nodes in DT when running with TCG
>       spapr: register dummy ICPs later
>       spapr: harden code that depends on VSMT
> 
> Mark Cave-Ayland (13):
>       macio: embed DBDMA device directly within macio
>       macio: move ESCC device within the macio device
>       heathrow: QOMify heathrow PIC
>       heathrow: convert to trace-events
>       heathrow: change heathrow_pic_init() to return the heathrow device
>       macio: move macio related structures and defines into separate macio.h file
>       mac_oldworld: use object link to pass heathrow PIC object to macio
>       openpic: move KVM-specific declarations into separate openpic_kvm.h file
>       openpic: move OpenPIC state and related definitions to openpic.h
>       mac_newworld: use object link to pass OpenPIC object to macio
>       macio: move setting of CUDA timebase frequency to macio_common_realize()
>       macio: remove macio_init() function
>       adb: add trace-events for monitoring keyboard/mouse during bus enumeration

Something in the recent commits introduced a new way to cause unexpected
aborts of QEMU:

$ ppc64-softmmu/qemu-system-ppc64 -monitor stdio
QEMU 2.11.50 monitor - type 'help' for more information
(qemu) device_add macio-newworld
Unexpected error in qemu_chr_fe_init() at
/home/thuth/devel/qemu/chardev/char-fe.c:222:
Device 'serial0' is in use
Aborted (core dumped)

Of course it does not make sense to add a macio-newworld device on the
pseries machine, but QEMU should not abort in this case - it should just
print an error message and continue afterwards. Any ideas how to fix this?

 Thomas
