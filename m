Received: from eggs.gnu.org ([209.51.188.92]:60679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grv9i-0000ZS-5w
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grv9Y-0004xc-P6
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:40:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:5004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1grv9U-0004tt-EU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:40:25 -0500
From: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Date: Fri,  8 Feb 2019 18:11:00 +0800
Message-Id: <f9346f1816b940a4231524a84d57a2cac8466ccc.1549555521.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
References: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel]  [PATCH V13 3/5] linux-headers: add linux/mman.h.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

Update it to 4.20-rc1

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 linux-headers/asm-arm/mman.h               |   4 ++
 linux-headers/asm-arm64/mman.h             |   1 +
 linux-headers/asm-generic/hugetlb_encode.h |  36 ++++++++++
 linux-headers/asm-generic/mman-common.h    |  77 ++++++++++++++++++++
 linux-headers/asm-generic/mman.h           |  24 +++++++
 linux-headers/asm-mips/mman.h              | 108 +++++++++++++++++++++++++++++
 linux-headers/asm-powerpc/mman.h           |  39 +++++++++++
 linux-headers/asm-s390/mman.h              |   1 +
 linux-headers/asm-x86/mman.h               |  31 +++++++++
 linux-headers/linux/mman.h                 |  38 ++++++++++
 10 files changed, 359 insertions(+)
 create mode 100644 linux-headers/asm-arm/mman.h
 create mode 100644 linux-headers/asm-arm64/mman.h
 create mode 100644 linux-headers/asm-generic/hugetlb_encode.h
 create mode 100644 linux-headers/asm-generic/mman-common.h
 create mode 100644 linux-headers/asm-generic/mman.h
 create mode 100644 linux-headers/asm-mips/mman.h
 create mode 100644 linux-headers/asm-powerpc/mman.h
 create mode 100644 linux-headers/asm-s390/mman.h
 create mode 100644 linux-headers/asm-x86/mman.h
 create mode 100644 linux-headers/linux/mman.h

diff --git a/linux-headers/asm-arm/mman.h b/linux-headers/asm-arm/mman.h
new file mode 100644
index 0000000..41f99c5
--- /dev/null
+++ b/linux-headers/asm-arm/mman.h
@@ -0,0 +1,4 @@
+#include <asm-generic/mman.h>
+
+#define arch_mmap_check(addr, len, flags) \
+	(((flags) & MAP_FIXED && (addr) < FIRST_USER_ADDRESS) ? -EINVAL : 0)
diff --git a/linux-headers/asm-arm64/mman.h b/linux-headers/asm-arm64/mman.h
new file mode 100644
index 0000000..8eebf89
--- /dev/null
+++ b/linux-headers/asm-arm64/mman.h
@@ -0,0 +1 @@
+#include <asm-generic/mman.h>
diff --git a/linux-headers/asm-generic/hugetlb_encode.h b/linux-headers/asm-generic/hugetlb_encode.h
new file mode 100644
index 0000000..b0f8e87
--- /dev/null
+++ b/linux-headers/asm-generic/hugetlb_encode.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_HUGETLB_ENCODE_H_
+#define _ASM_GENERIC_HUGETLB_ENCODE_H_
+
+/*
+ * Several system calls take a flag to request "hugetlb" huge pages.
+ * Without further specification, these system calls will use the
+ * system's default huge page size.  If a system supports multiple
+ * huge page sizes, the desired huge page size can be specified in
+ * bits [26:31] of the flag arguments.  The value in these 6 bits
+ * will encode the log2 of the huge page size.
+ *
+ * The following definitions are associated with this huge page size
+ * encoding in flag arguments.  System call specific header files
+ * that use this encoding should include this file.  They can then
+ * provide definitions based on these with their own specific prefix.
+ * for example:
+ * #define MAP_HUGE_SHIFT HUGETLB_FLAG_ENCODE_SHIFT
+ */
+
+#define HUGETLB_FLAG_ENCODE_SHIFT	26
+#define HUGETLB_FLAG_ENCODE_MASK	0x3f
+
+#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+
+#endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-generic/mman-common.h
new file mode 100644
index 0000000..e7ee328
--- /dev/null
+++ b/linux-headers/asm-generic/mman-common.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_GENERIC_MMAN_COMMON_H
+#define __ASM_GENERIC_MMAN_COMMON_H
+
+/*
+ Author: Michael S. Tsirkin <mst@mellanox.co.il>, Mellanox Technologies Ltd.
+ Based on: asm-xxx/mman.h
+*/
+
+#define PROT_READ	0x1		/* page can be read */
+#define PROT_WRITE	0x2		/* page can be written */
+#define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
+#define PROT_NONE	0x0		/* page can not be accessed */
+#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
+#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+#define MAP_TYPE	0x0f		/* Mask for type of mapping */
+#define MAP_FIXED	0x10		/* Interpret addr exactly */
+#define MAP_ANONYMOUS	0x20		/* don't use a file */
+#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
+# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be uninitialized */
+#else
+# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
+#endif
+
+/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
+#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
+/*
+ * Flags for mlock
+ */
+#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
+
+#define MS_ASYNC	1		/* sync memory asynchronously */
+#define MS_INVALIDATE	2		/* invalidate the caches */
+#define MS_SYNC		4		/* synchronous memory sync */
+
+#define MADV_NORMAL	0		/* no further special treatment */
+#define MADV_RANDOM	1		/* expect random page references */
+#define MADV_SEQUENTIAL	2		/* expect sequential page references */
+#define MADV_WILLNEED	3		/* will need these pages */
+#define MADV_DONTNEED	4		/* don't need these pages */
+
+/* common parameters: try to keep these consistent across architectures */
+#define MADV_FREE	8		/* free pages only if memory pressure */
+#define MADV_REMOVE	9		/* remove these pages & resources */
+#define MADV_DONTFORK	10		/* don't inherit across fork */
+#define MADV_DOFORK	11		/* do inherit across fork */
+#define MADV_HWPOISON	100		/* poison a page for testing */
+#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
+
+#define MADV_MERGEABLE   12		/* KSM may merge identical pages */
+#define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
+
+#define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
+#define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
+
+#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
+					   overrides the coredump filter bits */
+#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
+
+#define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
+#define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
+
+/* compatibility flags */
+#define MAP_FILE	0
+
+#define PKEY_DISABLE_ACCESS	0x1
+#define PKEY_DISABLE_WRITE	0x2
+#define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
+				 PKEY_DISABLE_WRITE)
+
+#endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/linux-headers/asm-generic/mman.h b/linux-headers/asm-generic/mman.h
new file mode 100644
index 0000000..653687d
--- /dev/null
+++ b/linux-headers/asm-generic/mman.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_GENERIC_MMAN_H
+#define __ASM_GENERIC_MMAN_H
+
+#include <asm-generic/mman-common.h>
+
+#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
+#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
+#define MAP_LOCKED	0x2000		/* pages are locked */
+#define MAP_NORESERVE	0x4000		/* don't check for reservations */
+#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
+#define MAP_SYNC	0x80000		/* perform synchronous page faults for the mapping */
+
+/* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
+
+#define MCL_CURRENT	1		/* lock all current mappings */
+#define MCL_FUTURE	2		/* lock all future mappings */
+#define MCL_ONFAULT	4		/* lock all pages that are faulted in */
+
+#endif /* __ASM_GENERIC_MMAN_H */
diff --git a/linux-headers/asm-mips/mman.h b/linux-headers/asm-mips/mman.h
new file mode 100644
index 0000000..3035ca4
--- /dev/null
+++ b/linux-headers/asm-mips/mman.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1999, 2002 by Ralf Baechle
+ */
+#ifndef _ASM_MMAN_H
+#define _ASM_MMAN_H
+
+/*
+ * Protections are chosen from these bits, OR'd together.  The
+ * implementation does not necessarily support PROT_EXEC or PROT_WRITE
+ * without PROT_READ.  The only guarantees are that no writing will be
+ * allowed without PROT_WRITE and no access will be allowed for PROT_NONE.
+ */
+#define PROT_NONE	0x00		/* page can not be accessed */
+#define PROT_READ	0x01		/* page can be read */
+#define PROT_WRITE	0x02		/* page can be written */
+#define PROT_EXEC	0x04		/* page can be executed */
+/*			0x08		   reserved for PROT_EXEC_NOFLUSH */
+#define PROT_SEM	0x10		/* page may be used for atomic ops */
+#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
+#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+
+/*
+ * Flags for mmap
+ */
+#define MAP_SHARED	0x001		/* Share changes */
+#define MAP_PRIVATE	0x002		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x003	/* share + validate extension flags */
+#define MAP_TYPE	0x00f		/* Mask for type of mapping */
+#define MAP_FIXED	0x010		/* Interpret addr exactly */
+
+/* not used by linux, but here to make sure we don't clash with ABI defines */
+#define MAP_RENAME	0x020		/* Assign page to file */
+#define MAP_AUTOGROW	0x040		/* File may grow by writing */
+#define MAP_LOCAL	0x080		/* Copy on fork/sproc */
+#define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
+
+/* These are linux-specific */
+#define MAP_NORESERVE	0x0400		/* don't check for reservations */
+#define MAP_ANONYMOUS	0x0800		/* don't use a file */
+#define MAP_GROWSDOWN	0x1000		/* stack-like segment */
+#define MAP_DENYWRITE	0x2000		/* ETXTBSY */
+#define MAP_EXECUTABLE	0x4000		/* mark it as an executable */
+#define MAP_LOCKED	0x8000		/* pages are locked */
+#define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB	0x80000		/* create a huge page mapping */
+#define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
+/*
+ * Flags for msync
+ */
+#define MS_ASYNC	0x0001		/* sync memory asynchronously */
+#define MS_INVALIDATE	0x0002		/* invalidate mappings & caches */
+#define MS_SYNC		0x0004		/* synchronous memory sync */
+
+/*
+ * Flags for mlockall
+ */
+#define MCL_CURRENT	1		/* lock all current mappings */
+#define MCL_FUTURE	2		/* lock all future mappings */
+#define MCL_ONFAULT	4		/* lock all pages that are faulted in */
+
+/*
+ * Flags for mlock
+ */
+#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
+
+#define MADV_NORMAL	0		/* no further special treatment */
+#define MADV_RANDOM	1		/* expect random page references */
+#define MADV_SEQUENTIAL 2		/* expect sequential page references */
+#define MADV_WILLNEED	3		/* will need these pages */
+#define MADV_DONTNEED	4		/* don't need these pages */
+
+/* common parameters: try to keep these consistent across architectures */
+#define MADV_FREE	8		/* free pages only if memory pressure */
+#define MADV_REMOVE	9		/* remove these pages & resources */
+#define MADV_DONTFORK	10		/* don't inherit across fork */
+#define MADV_DOFORK	11		/* do inherit across fork */
+
+#define MADV_MERGEABLE	 12		/* KSM may merge identical pages */
+#define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
+#define MADV_HWPOISON	 100		/* poison a page for testing */
+
+#define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
+#define MADV_NOHUGEPAGE 15		/* Not worth backing with hugepages */
+
+#define MADV_DONTDUMP	16		/* Explicity exclude from the core dump,
+					   overrides the coredump filter bits */
+#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
+
+#define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
+#define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
+
+/* compatibility flags */
+#define MAP_FILE	0
+
+#define PKEY_DISABLE_ACCESS	0x1
+#define PKEY_DISABLE_WRITE	0x2
+#define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
+				 PKEY_DISABLE_WRITE)
+
+#endif /* _ASM_MMAN_H */
diff --git a/linux-headers/asm-powerpc/mman.h b/linux-headers/asm-powerpc/mman.h
new file mode 100644
index 0000000..1c2b3fc
--- /dev/null
+++ b/linux-headers/asm-powerpc/mman.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_POWERPC_MMAN_H
+#define _ASM_POWERPC_MMAN_H
+
+#include <asm-generic/mman-common.h>
+
+
+#define PROT_SAO	0x10		/* Strong Access Ordering */
+
+#define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
+#define MAP_NORESERVE   0x40            /* don't reserve swap pages */
+#define MAP_LOCKED	0x80
+
+#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
+#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
+
+#define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
+#define MCL_FUTURE      0x4000          /* lock all additions to address space */
+#define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
+
+#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
+
+/* Override any generic PKEY permission defines */
+#define PKEY_DISABLE_EXECUTE   0x4
+#undef PKEY_ACCESS_MASK
+#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
+				PKEY_DISABLE_WRITE  |\
+				PKEY_DISABLE_EXECUTE)
+#endif /* _ASM_POWERPC_MMAN_H */
diff --git a/linux-headers/asm-s390/mman.h b/linux-headers/asm-s390/mman.h
new file mode 100644
index 0000000..8eebf89
--- /dev/null
+++ b/linux-headers/asm-s390/mman.h
@@ -0,0 +1 @@
+#include <asm-generic/mman.h>
diff --git a/linux-headers/asm-x86/mman.h b/linux-headers/asm-x86/mman.h
new file mode 100644
index 0000000..d4a8d04
--- /dev/null
+++ b/linux-headers/asm-x86/mman.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_X86_MMAN_H
+#define _ASM_X86_MMAN_H
+
+#define MAP_32BIT	0x40		/* only give out 32bit addresses */
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+/*
+ * Take the 4 protection key bits out of the vma->vm_flags
+ * value and turn them in to the bits that we can put in
+ * to a pte.
+ *
+ * Only override these if Protection Keys are available
+ * (which is only on 64-bit).
+ */
+#define arch_vm_get_page_prot(vm_flags)	__pgprot(	\
+		((vm_flags) & VM_PKEY_BIT0 ? _PAGE_PKEY_BIT0 : 0) |	\
+		((vm_flags) & VM_PKEY_BIT1 ? _PAGE_PKEY_BIT1 : 0) |	\
+		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
+		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
+
+#define arch_calc_vm_prot_bits(prot, key) (		\
+		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
+		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
+		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
+		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#endif
+
+#include <asm-generic/mman.h>
+
+#endif /* _ASM_X86_MMAN_H */
diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
new file mode 100644
index 0000000..3c44b6f
--- /dev/null
+++ b/linux-headers/linux/mman.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_MMAN_H
+#define _LINUX_MMAN_H
+
+#include <asm/mman.h>
+#include <asm-generic/hugetlb_encode.h>
+
+#define MREMAP_MAYMOVE	1
+#define MREMAP_FIXED	2
+
+#define OVERCOMMIT_GUESS		0
+#define OVERCOMMIT_ALWAYS		1
+#define OVERCOMMIT_NEVER		2
+
+/*
+ * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
+ * size other than the default is desired.  See hugetlb_encode.h.
+ * All known huge page size encodings are provided here.  It is the
+ * responsibility of the application to know which sizes are supported on
+ * the running system.  See mmap(2) man page for details.
+ */
+#define MAP_HUGE_SHIFT	HUGETLB_FLAG_ENCODE_SHIFT
+#define MAP_HUGE_MASK	HUGETLB_FLAG_ENCODE_MASK
+
+#define MAP_HUGE_64KB	HUGETLB_FLAG_ENCODE_64KB
+#define MAP_HUGE_512KB	HUGETLB_FLAG_ENCODE_512KB
+#define MAP_HUGE_1MB	HUGETLB_FLAG_ENCODE_1MB
+#define MAP_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
+#define MAP_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
+#define MAP_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
+#define MAP_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
+#define MAP_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
+#define MAP_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
+#define MAP_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
+#define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
+#define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
+
+#endif /* _LINUX_MMAN_H */
-- 
2.7.4
