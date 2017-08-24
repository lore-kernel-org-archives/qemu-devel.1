Received: from eggs.gnu.org ([2001:4830:134:3::10]:60318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dknOo-0008EJ-Di
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dknOl-0006gd-AJ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:21:58 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 10:21:45 +0200
Message-Id: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 0/6] ppc: cpu_model handling cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

While removing cpu_init() tree-wide, I've stumbled uppon
PPC way of parsing cpu_model which looked way too complex
compared to other targets.

So here goes cleanups that instead of current inconsistent
way of dealing with cpu models
 - mix of case-(in)sensetive lookups and cpu model names
 - aliases pointing to another aliases
normalize cpu model names to upper-case and make aliases
point to cpu moldel names. These changes allow to simplify
cpu model handling quite a bit and make it look/behave
a bit more in line with other targets.
=20
Patches are not must have for cpu_init() removal but make
it a little bit easier without need to deal with way of
conversion of cpu model to cpu type, so pls consider
merging it early once 2.11 merge window is open if
patches make any sense.

loosly (to avoid conflicts) depends on:
  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03364.html

repo for testing:
  https://github.com/imammedo/qemu.git ppc_cpu_model_cleanups_V1

CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alexander Graf <agraf@suse.de>
CC: qemu-ppc@nongnu.org


Igor Mammedov (6):
  ppc: use macros to make cpu type name from string literal
  ppc: make cpu_model translation to type consistent
  ppc: make cpu alias point only to real cpu models
  ppc: replace inter-function cyclic dependency/recurssion with 2 simple
    lookups
  ppc: simplify cpu model lookup by PVR
  ppc: drop caching ObjectClass from PowerPCCPUAlias

 target/ppc/cpu-models.h     |   3 +-
 target/ppc/cpu.h            |   3 +
 target/ppc/kvm_ppc.h        |   2 +-
 hw/ppc/spapr_cpu_core.c     |  30 +-
 target/ppc/cpu-models.c     | 876 ++++++++++++++++++++++----------------=
------
 target/ppc/kvm.c            |   5 +-
 target/ppc/translate_init.c | 100 ++---
 7 files changed, 490 insertions(+), 529 deletions(-)

--=20
2.7.4
