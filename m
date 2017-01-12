Received: from eggs.gnu.org ([2001:4830:134:3::10]:57587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cRkf4-0000nr-2A
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cRkf3-00016T-6q
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:03:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cRkf3-00013b-0E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:03:45 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 19:03:32 +0000
Message-Id: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] "unimplemented" device for debug logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset implements an "unimplemented" sysbus device,
which is a dummy device which accepts and logs all accesses.
It's useful for stubbing out regions of an SoC or board
map which correspond to devices that have not yet been
implemented. This is often sufficient to placate initial
guest device driver probing such that the system will come up.

Since QEMU's default behaviour for accesses to bits of the
memory map with nothing there is to RAZ/WI them, instantiating
this device somewhere doesn't actually change behaviour,
and so the benefits here are really:
 * provide helpful debug logging of which things the guest
   is actually trying to talk to, so we know which things
   are most useful to implement next
 * allow stubbing out of devices on architectures which
   implement the CPU unassigned_access hook to actually
   throw a guest exception like real hardware does
 * allow somebody reading board model code to easily see
   that some things have not yet been implemented

Patch 2 is the actual "unimp" device; patches 1 and 3
are to the stellaris board as an example of usage, but the
short usage example is that you can just do:

   create_unimplemented_device("PWM", 0x40028000, 0x1000);

in your board model. If you're writing an SoC container
object that maps things into another memory region rather
than doing direct mapping into the system memory address
space, you can create, configure, instantiate and map the
thing by hand (as with all the other devices you're creating).

Resulting debug trace looks like this if you turn on -d unimp:

PWM: unimplemented device read (size 4, offset 0x40)
PWM: unimplemented device write (size 4, value 0x316a, offset 0x50)

thanks
-- PMM

Peter Maydell (3):
  stellaris: Document memory map and which SoC devices are unimplemented
  hw/misc: New "unimplemented" sysbus device
  stellaris: Use the 'unimplemented' device for parts we don't implement

 hw/misc/Makefile.objs   |   2 +
 include/hw/misc/unimp.h |  39 ++++++++++++++++++
 hw/arm/stellaris.c      |  45 ++++++++++++++++++++
 hw/misc/unimp.c         | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 include/hw/misc/unimp.h
 create mode 100644 hw/misc/unimp.c

-- 
2.7.4
