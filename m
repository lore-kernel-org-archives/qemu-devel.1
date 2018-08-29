Received: from eggs.gnu.org ([208.118.235.92]:42924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuzp5-00069q-Jv
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuznk-00030b-As
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:28 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com
	([40.107.4.138]:19424
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fuznj-0002zG-D3
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:24 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Wed, 29 Aug 2018 15:41:23 +0300
Message-Id: <1535546488-30208-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/5] contrib: add elf2dmp tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com, dgilbert@redhat.com, rkagan@virtuozzo.com, viktor.prutyanov@phystech.edu, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

elf2dmp is a converter from ELF dump (produced by 'dump-guest-memory') to
Windows MEMORY.DMP format (also know as 'Complete Memory Dump') which can be
opened in WinDbg.

This tool can help if VMCoreInfo device/driver is absent in Windows VM and
'dump-guest-memory -w' is not available but dump can be created in ELF format.

elf2dmp differs from other universal converters in method of determining of
virtual memory layout. The tool uses register values from QEMU ELF dump file
to do it. In particular, it uses KERNEL_GS_BASE value added to dump format in
QEMU 3.0.

Even if KERNEL_GS_BASEs are absent in ELF dump file, at least 1 vCPU with
kernel task can be found quite often and virtual memory layout can be
determined.

Viktor Prutyanov (5):
  dump: move Windows dump structures definitions
  contrib: add elf2dmp tool
  contrib/elf2dmp: improve paging root selection
  contrib/elf2dmp: add DMP file name as 2nd argument
  contrib/elf2dmp: add 1GB and 2MB pages support

 Makefile                      |   5 +
 Makefile.objs                 |   1 +
 configure                     |   3 +
 contrib/elf2dmp/Makefile.objs |   1 +
 contrib/elf2dmp/addrspace.c   | 236 +++++++++++++++++
 contrib/elf2dmp/addrspace.h   |  44 ++++
 contrib/elf2dmp/download.c    |  50 ++++
 contrib/elf2dmp/download.h    |  13 +
 contrib/elf2dmp/err.h         |  13 +
 contrib/elf2dmp/kdbg.h        | 194 ++++++++++++++
 contrib/elf2dmp/main.c        | 594 ++++++++++++++++++++++++++++++++++++++++++
 contrib/elf2dmp/pdb.c         | 331 +++++++++++++++++++++++
 contrib/elf2dmp/pdb.h         | 241 +++++++++++++++++
 contrib/elf2dmp/pe.h          | 121 +++++++++
 contrib/elf2dmp/qemu_elf.c    | 172 ++++++++++++
 contrib/elf2dmp/qemu_elf.h    |  51 ++++
 include/qemu/win_dump_defs.h  | 179 +++++++++++++
 win_dump.h                    | 166 +-----------
 18 files changed, 2253 insertions(+), 162 deletions(-)
 create mode 100644 contrib/elf2dmp/Makefile.objs
 create mode 100644 contrib/elf2dmp/addrspace.c
 create mode 100644 contrib/elf2dmp/addrspace.h
 create mode 100644 contrib/elf2dmp/download.c
 create mode 100644 contrib/elf2dmp/download.h
 create mode 100644 contrib/elf2dmp/err.h
 create mode 100644 contrib/elf2dmp/kdbg.h
 create mode 100644 contrib/elf2dmp/main.c
 create mode 100644 contrib/elf2dmp/pdb.c
 create mode 100644 contrib/elf2dmp/pdb.h
 create mode 100644 contrib/elf2dmp/pe.h
 create mode 100644 contrib/elf2dmp/qemu_elf.c
 create mode 100644 contrib/elf2dmp/qemu_elf.h
 create mode 100644 include/qemu/win_dump_defs.h

-- 
2.7.4
