Received: from eggs.gnu.org ([2001:4830:134:3::10]:55922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1cgPQd-0000kP-EH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1cgPQZ-0008JI-CS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:25:27 -0500
Received: from ozlabs.org ([103.22.144.67]:45441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <paulus@ozlabs.org>) id 1cgPQZ-0008Gc-0o
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 00:25:23 -0500
Date: Wed, 22 Feb 2017 16:25:11 +1100
From: Paul Mackerras <paulus@ozlabs.org>
Message-ID: <20170222052511.GA4313@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Background to Yong Ji's patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I thought it might help to explain some more of the background to Yong
Ji's recent patch "memory: make ram device read/write endian
sensitive".  I don't know whether that patch touches the right code or
not, but with a bit more background, maybe somebody can tell us what
code does need to be fixed.

This patch fixes an issue with passing through a Chelsio 10Gb network
adapter to a guest on POWER8.  The host is running a recent upstream
kernel plus a patch from Yong Ji to align PCI BARs to the system page
size.  The guest is running Ubuntu 16.04.  Both host and guest are
little-endian.

A critical factor here is QEMU commit 95251725, also from Yong Ji.  If
the guest is run using a qemu from the parent of that commit, it works
properly.  With a qemu built from 95251725, or a qemu built from v2.8,
it doesn't work.

The problem in the failing case boils down to MMIO reads from BAR 0 of
the device coming back byte-swapped.

In each case, BAR 0 starts out page-aligned in the host, but the guest
reassigns it to a non-page-aligned address.  That means that the guest
doesn't access the device registers in BAR 0 directly; instead the
MMIO accesses are emulated by QEMU.

Before 95251725, it seems that QEMU never attempts to make the BAR
directly accessible (I think because the BAR is smaller than a page).
With 95251725, I believe QEMU initially makes the BAR directly
accessible, and then when the guest changes the BAR address to a
non-page-aligned value, QEMU switches it back to emulation.  The
emulation in this case must be using a different code path from the
emulation that was being done prior to 95251725, since we get
byte-swapped values in this case but not the prior case.

Then, with 95251725 plus the recent patch from Yong Ji, the values
read from BAR 0 are no longer byte-swapped, and the driver works
correctly.

Please keep me cc'd on any replies, since I'm not subscribed to this
list.

Paul.
