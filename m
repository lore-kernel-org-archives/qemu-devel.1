Received: from eggs.gnu.org ([2001:4830:134:3::10]:40184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYZBy-0005kV-Ix
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYZBt-0002Fq-Nr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dYZBt-0002FR-GS
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:46:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 21 Jul 2017 16:45:54 +0200
Message-Id: <1500648359-25931-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] target/s390x: Fix broken build with
 --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Our configure script was recently equipped with a new --disable-tcg
parameter, but this does unfortunately not work on s390x hosts yet. Fix
the build by moving some code around and by adding some few #ifdefs
in the right places.

v2:
- Reworked the changes to program_interrupt() according to the
  suggestions by Richard

Thomas Huth (5):
  target/s390x: Move s390_cpu_dump_state() to helper.c
  target/s390x: Move diag helpers to a separate file
  target/s390x: Rework program_interrupt() and related functions
  target/s390x: Move exception-related functions to a new excp_helper.c
    file
  target/s390x: Add remaining switches to compile with --disable-tcg

 target/s390x/Makefile.objs |   8 +-
 target/s390x/cpu.c         |   4 +
 target/s390x/cpu.h         |  17 +-
 target/s390x/diag.c        | 179 +++++++++++++++
 target/s390x/excp_helper.c | 515 +++++++++++++++++++++++++++++++++++++++++++
 target/s390x/helper.c      | 528 +++++----------------------------------------
 target/s390x/interrupt.c   |  37 ++++
 target/s390x/kvm.c         |  16 +-
 target/s390x/misc_helper.c | 193 -----------------
 target/s390x/translate.c   |  60 ------
 10 files changed, 817 insertions(+), 740 deletions(-)
 create mode 100644 target/s390x/diag.c
 create mode 100644 target/s390x/excp_helper.c

-- 
1.8.3.1
