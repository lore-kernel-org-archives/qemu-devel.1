Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWX-0001vA-Jm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWT-0003rw-9Q
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:13 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:50133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWT-0003qO-2o
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:09 -0400
Received: by mail-wm0-x235.google.com with SMTP id b189so12949284wmd.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:30 +0200
Message-Id: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFH PATCH 00/10] i386: hvf: miscellaneous cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex@alex.org.uk, agraf@suse.de, sergio.g.delreal@gmail.com

This is an initial set of (untested!) cleanups for the HVF code.
If anyone could pick them up, I think they represent the bare minimum
that has to be done before we can commit HVF support to master.
It's by no means the end, but the existing MMU code in target/i386 could
definitely stand a rewrite, and HVF could then use it as well.

They are available at git://github.com/bonzini/qemu.git, branch hvf.

Alex (both of them), Sergio, anyone else who can help?

Paolo

Paolo Bonzini (10):
  i386: hvf: move all hvf files in the same directory
  i386: hvf: header cleanup
  i386: hvf: unify register enums between HVF and the rest
  i386: hvf: remove more dead emulator code
  i386: hvf: remove ZERO_INIT macro
  i386: hvf: abort on decoding error
  i386: hvf: simplify flag handling
  i386: hvf: remove addr_t
  i386: hvf: simplify and fix in/out handling
  i386: hvf: cleanup x86_gen.h

 target/i386/Makefile.objs                    |   2 +-
 target/i386/cpu.h                            |  62 ++++---
 target/i386/hvf-utils/panic.h                |  45 +++++
 target/i386/hvf-utils/x86_flags.h            | 243 ---------------------------
 target/i386/{hvf-utils => hvf}/Makefile.objs |   1 +
 target/i386/{hvf-utils => hvf}/README.md     |   0
 target/i386/{ => hvf}/hvf-i386.h             |   2 +-
 target/i386/{hvf-all.c => hvf/hvf.c}         |  36 ++--
 target/i386/{hvf-utils => hvf}/vmcs.h        |   0
 target/i386/{hvf-utils => hvf}/vmx.h         |  10 +-
 target/i386/{hvf-utils => hvf}/x86.c         |  23 +--
 target/i386/{hvf-utils => hvf}/x86.h         | 167 ++++++------------
 target/i386/{hvf-utils => hvf}/x86_cpuid.c   |   0
 target/i386/{hvf-utils => hvf}/x86_cpuid.h   |   0
 target/i386/{hvf-utils => hvf}/x86_decode.c  | 144 ++++++++--------
 target/i386/{hvf-utils => hvf}/x86_decode.h  |  23 ++-
 target/i386/{hvf-utils => hvf}/x86_descr.c   |  26 +--
 target/i386/{hvf-utils => hvf}/x86_descr.h   |  21 ++-
 target/i386/{hvf-utils => hvf}/x86_emu.c     | 238 ++++++++++----------------
 target/i386/{hvf-utils => hvf}/x86_emu.h     |  14 +-
 target/i386/{hvf-utils => hvf}/x86_flags.c   | 237 ++++++++++++--------------
 target/i386/hvf/x86_flags.h                  |  77 +++++++++
 target/i386/{hvf-utils => hvf}/x86_gen.h     |   4 -
 target/i386/{hvf-utils => hvf}/x86_mmu.c     |  36 ++--
 target/i386/{hvf-utils => hvf}/x86_mmu.h     |   8 +-
 target/i386/{hvf-utils => hvf}/x86_task.c    |  65 +++----
 target/i386/{hvf-utils => hvf}/x86_task.h    |   0
 target/i386/{hvf-utils => hvf}/x86hvf.c      |  32 ++--
 target/i386/{hvf-utils => hvf}/x86hvf.h      |   0
 29 files changed, 624 insertions(+), 892 deletions(-)
 create mode 100644 target/i386/hvf-utils/panic.h
 delete mode 100644 target/i386/hvf-utils/x86_flags.h
 rename target/i386/{hvf-utils => hvf}/Makefile.objs (87%)
 rename target/i386/{hvf-utils => hvf}/README.md (100%)
 rename target/i386/{ => hvf}/hvf-i386.h (97%)
 rename target/i386/{hvf-all.c => hvf/hvf.c} (97%)
 rename target/i386/{hvf-utils => hvf}/vmcs.h (100%)
 rename target/i386/{hvf-utils => hvf}/vmx.h (97%)
 rename target/i386/{hvf-utils => hvf}/x86.c (88%)
 rename target/i386/{hvf-utils => hvf}/x86.h (71%)
 rename target/i386/{hvf-utils => hvf}/x86_cpuid.c (100%)
 rename target/i386/{hvf-utils => hvf}/x86_cpuid.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86_decode.c (96%)
 rename target/i386/{hvf-utils => hvf}/x86_decode.h (94%)
 rename target/i386/{hvf-utils => hvf}/x86_descr.c (82%)
 rename target/i386/{hvf-utils => hvf}/x86_descr.h (75%)
 rename target/i386/{hvf-utils => hvf}/x86_emu.c (84%)
 rename target/i386/{hvf-utils => hvf}/x86_emu.h (75%)
 rename target/i386/{hvf-utils => hvf}/x86_flags.c (57%)
 create mode 100644 target/i386/hvf/x86_flags.h
 rename target/i386/{hvf-utils => hvf}/x86_gen.h (93%)
 rename target/i386/{hvf-utils => hvf}/x86_mmu.c (85%)
 rename target/i386/{hvf-utils => hvf}/x86_mmu.h (84%)
 rename target/i386/{hvf-utils => hvf}/x86_task.c (81%)
 rename target/i386/{hvf-utils => hvf}/x86_task.h (100%)
 rename target/i386/{hvf-utils => hvf}/x86hvf.c (93%)
 rename target/i386/{hvf-utils => hvf}/x86hvf.h (100%)

-- 
2.13.6
