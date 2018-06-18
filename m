Received: from eggs.gnu.org ([2001:4830:134:3::10]:49813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUySq-0008O1-AM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUySm-0005h1-VG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:01:16 -0400
Date: Mon, 18 Jun 2018 23:32:56 +0530
From: Amol Surati <suratiamol@gmail.com>
Message-ID: <20180618180254.GA2441@arch>
References: <20180617183515.3982-1-suratiamol@gmail.com>
	<20180617183515.3982-2-suratiamol@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617183515.3982-2-suratiamol@gmail.com>
Subject: Re: [Qemu-devel] [RFC 1/1] ide: bug #1777315: io_buffer_size and
 sg.size can represent partial sector sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amol Surati <suratiamol@gmail.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

On Mon, Jun 18, 2018 at 12:05:15AM +0530, Amol Surati wrote:
> This patch fixes the assumption that io_buffer_size is always a perfect
> multiple of the sector size. The assumption is the cause of the firing
> of 'assert(n * 512 == s->sg.size);'.
> 
> Signed-off-by: Amol Surati <suratiamol@gmail.com>
> ---

The repository https://github.com/asurati/1777315 contains a module for
QEMU's 8086:7010 ATA controller, which exercises the code path
described in [RFC 0/1] of this series.

Loading the module reproduces the bug. Tested on the latest master
branch.

Steps:
- Install a Linux distribution as a guest, ensuring that the boot disk
  resides on non-IDE controllers (such as virtio)
- Attach another disk as a master device on the primary
  IDE controller (i.e. attach at -hda.)
- Blacklist ata_piix, pata_acpi and ata_generic modules, and reboot.
- Copy the source files into the guest and build the module.
- Load the module. QEMU process should die with the message:
  qemu-system-x86_64: hw/ide/core.c:871: ide_dma_cb:
  Assertion `n * 512 == s->sg.size' failed.


-Amol
