Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00EEC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFBB217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFBB217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHMoI-0006IG-77
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 02:15:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmZ-00055X-HV
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmY-0004k3-Hu
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMmY-0004jc-A8
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5880B3003737;
	Fri, 19 Apr 2019 06:13:52 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D58BA60BE0;
	Fri, 19 Apr 2019 06:13:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 03:13:32 -0300
Message-Id: <20190419061349.17094-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 19 Apr 2019 06:13:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/17] Delete 16 *_cpu_class_by_name() functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419061332.O7rqhLzxwIGHs7qu-wd5vkU6hOvdJIjY7gb0yysRHp4@z>

This series adds a new CPUClass::class_name_format field, which
allows us to delete 16 of the 21 *_cpu_class_by_name() functions
that exist today.

Cornelia Huck (1):
  hw: add compat machines for 4.1

Eduardo Habkost (9):
  cpu: Rename parse_cpu_model() to parse_cpu_option()
  cpu: Fix crash with empty -cpu option
  cpu: Change return type of cpu_class_by_name() to CPUClass
  riscv: Don't split CPU model string
  arm: Don't split CPU model string
  arm: Remove special case for "any" CPU model
  cpu: Let architectures set CPU class name format
  cpu: Set class name format for some architectures
  cpu: Set fixed class name on some architectures

Markus Armbruster (2):
  vl: Clean up after previous commit
  vl: Simplify machine_parse()

Wei Yang (2):
  vl.c: make find_default_machine() local
  vl.c: allocate TYPE_MACHINE list once during bootup

Zhang Yi (3):
  util/mmap-alloc: Add a 'is_pmem' parameter to qemu_ram_mmap
  scripts/update-linux-headers: add linux/mman.h
  linux-headers: add linux/mman.h.

 include/hw/boards.h                        |   4 +-
 include/hw/i386/pc.h                       |   3 +
 include/qemu/mmap-alloc.h                  |  21 +++-
 include/qom/cpu.h                          |  20 +++-
 linux-headers/asm-arm/mman.h               |   4 +
 linux-headers/asm-arm64/mman.h             |   1 +
 linux-headers/asm-generic/hugetlb_encode.h |  36 +++++++
 linux-headers/asm-generic/mman-common.h    |  77 +++++++++++++++
 linux-headers/asm-generic/mman.h           |  24 +++++
 linux-headers/asm-mips/mman.h              | 108 +++++++++++++++++++++
 linux-headers/asm-powerpc/mman.h           |  39 ++++++++
 linux-headers/asm-s390/mman.h              |   1 +
 linux-headers/asm-x86/mman.h               |  31 ++++++
 linux-headers/linux/mman.h                 |  38 ++++++++
 target/s390x/internal.h                    |   1 -
 bsd-user/main.c                            |   2 +-
 exec.c                                     |  18 ++--
 hw/arm/virt.c                              |   9 +-
 hw/core/machine.c                          |   3 +
 hw/i386/pc.c                               |   3 +
 hw/i386/pc_piix.c                          |  14 ++-
 hw/i386/pc_q35.c                           |  13 ++-
 hw/ppc/spapr.c                             |  15 ++-
 hw/s390x/s390-virtio-ccw.c                 |  14 ++-
 linux-user/main.c                          |   2 +-
 qom/cpu.c                                  |  20 +++-
 target/arm/cpu.c                           |  30 +-----
 target/hppa/cpu.c                          |   8 +-
 target/i386/cpu.c                          |  11 +--
 target/lm32/cpu.c                          |  17 +---
 target/m68k/cpu.c                          |  17 +---
 target/microblaze/cpu.c                    |   8 +-
 target/mips/cpu.c                          |  13 +--
 target/moxie/cpu.c                         |  17 +---
 target/nios2/cpu.c                         |   8 +-
 target/openrisc/cpu.c                      |  17 +---
 target/riscv/cpu.c                         |  20 +---
 target/s390x/cpu.c                         |   2 +-
 target/s390x/cpu_models.c                  |  20 +---
 target/tilegx/cpu.c                        |   8 +-
 target/tricore/cpu.c                       |  17 +---
 target/unicore32/cpu.c                     |  17 +---
 target/xtensa/cpu.c                        |  17 +---
 util/mmap-alloc.c                          |   6 +-
 util/oslib-posix.c                         |   2 +-
 vl.c                                       |  87 +++++++----------
 scripts/update-linux-headers.sh            |   6 +-
 47 files changed, 566 insertions(+), 303 deletions(-)
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

-- 
2.18.0.rc1.1.g3f1ff2140


