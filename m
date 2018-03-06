Received: from eggs.gnu.org ([2001:4830:134:3::10]:41407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etC89-0008T9-QW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etC88-0004wb-Vn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:55:45 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Mar 2018 12:55:20 +0000
Message-Id: <20180306125526.27838-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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

The patches make 'any' a synonym for 'max', using the approach
of putting a compat hack into arm_cpu_class_by_name() that
Igor suggested. For the moment, we don't enable any of the
CPU feature bits in 'max' that aren't in the a15/a57 if we're
doing system emulation mode. This is a combination of:
 * some of those bits are currently only implemented sufficiently
   for user-only mode, not for system emulation
 * we would also need to update ID register bits to advertise the
   extra features
We should certainly do that, but I'd like to get basic -cpu max
support into 2.12, and the softfreeze deadline is rapidly approaching,
so I've opted to postpone that to post 2.12. If people have the time
to review this series this week I'd really appreciate it.

Changes since v1:
 * the "check CPU realize succeeded in virt board" patch is in master
 * the "target/arm: Make 'any' CPU just an alias for 'max'" is new,
   and unifies 'any' with 'max' as suggested in review of v1
 * the other patches are essentially unchanged

thanks
-- PMM


Peter Maydell (6):
  target/arm: Query host CPU features on-demand at instance init
  target/arm: Move definition of 'host' cpu type into cpu.c
  target/arm: Add "-cpu max" support
  target/arm: Make 'any' CPU just an alias for 'max'
  hw/arm/virt: Add "max" to the list of CPU types "virt" supports
  hw/arm/virt: Support -machine gic-version=max

 target/arm/cpu-qom.h |  2 ++
 target/arm/cpu.h     |  5 +++
 target/arm/kvm_arm.h | 35 +++++++++++++------
 hw/arm/virt.c        | 30 +++++++++++------
 target/arm/cpu.c     | 95 +++++++++++++++++++++++++++++++++++++++++++---------
 target/arm/cpu64.c   | 66 +++++++++++++++++++++++-------------
 target/arm/kvm.c     | 53 ++++++++++-------------------
 target/arm/kvm32.c   |  8 ++---
 target/arm/kvm64.c   |  8 ++---
 9 files changed, 198 insertions(+), 104 deletions(-)

-- 
2.16.2
