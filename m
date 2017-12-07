Received: from eggs.gnu.org ([2001:4830:134:3::10]:38902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hP-0008KU-Gk
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hO-0006pC-E8
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:07 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Dec 2017 18:14:47 +0000
Message-Id: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] arm: support -cpu max (and gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>

This patchset adds support for '-cpu max' to Arm, along the lines
of the existing support we have for x86 targets:

 * under KVM, -cpu max is the same as -cpu host
 * under TCG, -cpu max means "emulate with as many features as
   possible"

-cpu max is supported for both usermode and system emulation,
again following the x86 line.

NB that cross-QEMU-version migration is not supported for -cpu max:
in future the definition of "maximum set of features" will change
as we add more emulation features.

The patchset also adds support to the virt board for the "max"
option to -machine gic-version, requesting "best available
interrupt controller", with the same semantics as -cpu max.

Together these should assist users like libguestfs that just want
to be able to run code without having to figure out what the
right command line arguments for this particular host system are.


Patch 1 is a bugfix, needed because now "-cpu host" without
-enable-kvm will only be detected when the CPU object fails
realize, rather than because we don't register the 'host'
CPU type at all.

(This is something that I meant to do much earlier: see
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg06183.html
but at the time we were about to freeze for 2.9, so it fell
off my immediate todo list and then I never got back to it...)

thanks
-- PMM

Peter Maydell (6):
  hw/arm/virt: Check that the CPU realize method succeeded
  target/arm: Query host CPU features on-demand at instance init
  target/arm: Move definition of 'host' cpu type into cpu.c
  target/arm: Add "-cpu max" support
  hw/arm/virt: Add "max" to the list of CPU types "virt" supports
  hw/arm/virt: Support -machine gic-version=max

 target/arm/cpu-qom.h |  2 ++
 target/arm/cpu.h     |  5 +++++
 target/arm/kvm_arm.h | 35 ++++++++++++++++++++----------
 hw/arm/virt.c        | 32 +++++++++++++++++----------
 target/arm/cpu.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c   | 21 ++++++++++++++++++
 target/arm/kvm.c     | 51 +++++++++++++++----------------------------
 target/arm/kvm32.c   |  8 +++----
 target/arm/kvm64.c   |  8 +++----
 9 files changed, 159 insertions(+), 64 deletions(-)

-- 
2.7.4
