Received: from eggs.gnu.org ([2001:4830:134:3::10]:36589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eqNLn-0005E0-Ow
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eqNLi-0005Ft-QY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:18:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1eqNLi-0005Fe-LG
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 13:18:06 -0500
From: Wei Huang <wei@redhat.com>
Date: Mon, 26 Feb 2018 12:17:54 -0600
Message-Id: <20180226181758.26922-1-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V6 0/4] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, drjones@redhat.com

This patchset adds a migration test for aarch64. It leverages
Dave Gilbert's recent patch "tests/migration: Add source to PC boot block"
to create a new test case for aarch64.

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
  rules: Move cross compilation auto detection functions to rules.mak
  tests/migration: Convert the boot block compilation script into
    Makefile
  tests/migration: Add migration-test header file
  tests: Add migration test for aarch64

 roms/Makefile                                      | 24 ++-----
 rules.mak                                          | 15 +++++
 tests/Makefile.include                             |  1 +
 tests/migration-test.c                             | 70 ++++++++++++++------
 tests/migration/Makefile                           | 44 +++++++++++++
 tests/migration/aarch64-a-b-kernel.S               | 75 ++++++++++++++++++++++
 tests/migration/aarch64-a-b-kernel.h               | 19 ++++++
 tests/migration/migration-test.h                   | 27 ++++++++
 tests/migration/rebuild-x86-bootblock.sh           | 33 ----------
 .../{x86-a-b-bootblock.s => x86-a-b-bootblock.S}   | 12 ++--
 tests/migration/x86-a-b-bootblock.h                |  4 +-
 11 files changed, 248 insertions(+), 76 deletions(-)
 create mode 100644 tests/migration/Makefile
 create mode 100644 tests/migration/aarch64-a-b-kernel.S
 create mode 100644 tests/migration/aarch64-a-b-kernel.h
 create mode 100644 tests/migration/migration-test.h
 delete mode 100755 tests/migration/rebuild-x86-bootblock.sh
 rename tests/migration/{x86-a-b-bootblock.s => x86-a-b-bootblock.S} (88%)

-- 
2.14.3
