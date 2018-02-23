Received: from eggs.gnu.org ([2001:4830:134:3::10]:45859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1ep2Fh-0001QF-9v
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 20:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1ep2Ei-0002zS-SI
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 20:34:21 -0500
Received: from phx2.ddci.com ([184.183.10.180]:63449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alarson@ddci.com>) id 1ep2Ei-0002bM-F1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 20:33:20 -0500
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
Date: Thu, 22 Feb 2018 18:39:19 -0600
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] -icount changes physical address assignments in QEMU
 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When porting our RTOS from QEMU 2.8 to 2.10/2.11, I ran into a problem
where 16-bit writes to the "bochs dispi interface" were being reported
differently depending on whether or not "-icount" was given to QEMU.

For example, info mtree:
  ...
  11000500-11000515 (prio 0, i/o): bochs dispi interface

A 16-bit write to 0x11000500 was delivered to pci_vga_bochs_write() as 
having
address 0, when -icount was not specified, but as address 2 when
-icount was specified.  Correspondingly writes to 0x11000502 were 2
and 0 respectively.  Essentially the words were swapped depending on
the presence of -icount.

I suspect a similar problem for the AARCH64 GIC (generic interrupt
controller), but other than observing the GIC changing from working to
non-working depending on the absence/presence of -icount I haven't
confirmed the underlying cause.

2.10 and 2.11 were built from source on Cygwin using mingw, 2.8 from a
"native" MinGW.  The results are consistent for 2.10 and 2.11.  2.8
does not have the -icount dependency.  The "broken" command line was:

qemu-system-aarch64 -m 1077 -name "arm" -M virt,virtualization=on 
  -cpu cortex-a53 -icount align=off,shift=0,sleep=on 
  -vga std -device secondary-vga 
  -device 
virtio-net,netdev=vlan0,addr=2,disable-modern=false,mac=52:54:00:12:67:56 
  -kernel ...deosBoot.bin -initrd "deosBoot.qemu" -netdev 
tap,id=vlan0,ifname="DDCI-tap0" 

The "working" command line omitted -icount and its argument.

FWIW, the error from the GIC with -icount was:

  qemu: fatal: IO on conditional branch instruction

Any pointers?
