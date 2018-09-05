Received: from eggs.gnu.org ([2001:4830:134:3::10]:50174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fxdHE-0006Ug-Mj
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1fxdHA-00084Q-Kn
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1fxdHA-000807-6n
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:15:40 -0400
From: Wei Huang <wei@redhat.com>
Date: Wed,  5 Sep 2018 15:15:30 -0400
Message-Id: <1536174934-26022-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V9 0/4] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, lvivier@redhat.com, drjones@redhat.com, dgilbert@redhat.com, quintela@redhat.com, wei@redhat.com

This patchset adds a migration test for aarch64. It leverages
Dave Gilbert's migration boot block patches to create a new test case
for aarch64.

V8->V9:
 * Remove accel= setting for AArch64. It uses the default "kvm:tcg" now
 * Revise the header file comment (suggested by drjones)
 * Name x86 directory to i386 instead of x86_64; change Makefile accordingly
 * Remove $(ARCH) from the assembly and header file names

V7->V8:
 * Support cross compilation by searching for CROSS_CC_GUEST option,
   instead of using the find-cross-prefix defined in roms/Makefile
 * Use the "max" options for ARM guest VM's CPU and GIC types
 * $(TARGET)/Makefile rules are rewritten based on Laurent Vivier's comment
 * NOTE: because Patch 1/2 is re-written, I remove the "Reviewed-by" for
   reviewers to take a look again. Thanks.

V6->V7:
 * Define test memory start/end addresses for all architectures
 * Check aarch64 kernel binary size, limit under 512KB

V5->V6:
 * Add Reviewed-by to patch 1-3
 * Add more design notes in patch 4 (aarch64 assembly compilation, bin space)

V4->V5:
 * Extract cross compilation detection code into rules.mak for sharing
 * Minor comment and code revision in migration-test.c & aarch64-a-b-kernel.S
 
V3->V4:
 * Rename .s to .S, allowing assembly to include C-style header file
 * Move test defines into a new migration-test.h file
 * Use different cpu & gic settings for kvm and tcg modes on aarch64
 * Clean up aarch64-a-b-kernel.S based on Andrew Jones' comments
 
V2->V3:
 * Convert build script to Makefile
 * Add cross-compilation support
 * Fix CPU type for "tcg" machine type
 * Revise asm code and the compilation process from asm to header file

V1->V2:
 * Similar to Dave Gilbert's recent changes to migration-test, we
   provide the test source and a build script in V2.
 * aarch64 kernel blob is defined as "unsigned char" because the source
   is now provided in V2.
 * Add "-machine none" to test_deprecated() because aarch64 doesn't have
   a default machine type.

RFC->V1:
 * aarch64 kernel blob is defined as an uint32_t array
 * The test code is re-written to address a data caching issue under KVM.
   Tests passed under both x86 and aarch64.
 * Re-use init_bootfile_x86() for both x86 and aarch64
 * Other minor fixes

Thanks,
-Wei

Wei Huang (4):
  tests/migration: Convert x86 boot block compilation script into
    Makefile
  tests/migration: Support cross compilation in generating boot header
    file
  tests/migration: Add migration-test header file
  tests: Add migration test for aarch64

 tests/Makefile.include                             |  1 +
 tests/migration-test.c                             | 57 +++++++++++-----
 tests/migration/Makefile                           | 35 ++++++++++
 tests/migration/aarch64/Makefile                   | 20 ++++++
 tests/migration/aarch64/a-b-kernel.S               | 75 ++++++++++++++++++++++
 tests/migration/aarch64/a-b-kernel.h               | 19 ++++++
 tests/migration/i386/Makefile                      | 22 +++++++
 .../{x86-a-b-bootblock.s => i386/a-b-bootblock.S}  |  4 --
 .../{x86-a-b-bootblock.h => i386/a-b-bootblock.h}  |  8 +--
 tests/migration/migration-test.h                   | 30 +++++++++
 tests/migration/rebuild-x86-bootblock.sh           | 33 ----------
 11 files changed, 248 insertions(+), 56 deletions(-)
 create mode 100644 tests/migration/Makefile
 create mode 100644 tests/migration/aarch64/Makefile
 create mode 100644 tests/migration/aarch64/a-b-kernel.S
 create mode 100644 tests/migration/aarch64/a-b-kernel.h
 create mode 100644 tests/migration/i386/Makefile
 rename tests/migration/{x86-a-b-bootblock.s => i386/a-b-bootblock.S} (93%)
 rename tests/migration/{x86-a-b-bootblock.h => i386/a-b-bootblock.h} (92%)
 create mode 100644 tests/migration/migration-test.h
 delete mode 100755 tests/migration/rebuild-x86-bootblock.sh

-- 
1.8.3.1
