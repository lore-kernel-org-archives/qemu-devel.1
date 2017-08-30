Received: from eggs.gnu.org ([2001:4830:134:3::10]:50912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2z5-0001od-7B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2z1-0003UE-G5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:43 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 30 Aug 2017 15:24:27 +0200
Message-Id: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/8] ppc: cpu_model handling cleanups
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


Changelog since v1:
  - normalize all cpu model names to lower-case
  - check that all cpu model string is consumed
    before going to PVR lookup path
  - add a new optional patch to remove unused junk
     '[PATCH v2 8/8] ppc: remove non implemented cpu models'
  - pull in dependency patch from
      https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03364.html
      'ppc: replace cpu_ppc_init() with cpu_generic_init()'
    so this series won't depend unnecessarily on another series

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


repo for testing:
  https://github.com/imammedo/qemu.git ppc_cpu_model_cleanups_V2

CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alexander Graf <agraf@suse.de>
CC: qemu-ppc@nongnu.org

Igor Mammedov (8):
  ppc: replace cpu_ppc_init() with cpu_generic_init()
  ppc: use macros to make cpu type name from string literal
  ppc: make cpu_model translation to type consistent
  ppc: make cpu alias point only to real cpu models
  ppc: replace inter-function cyclic dependency/recurssion with 2 simple
    lookups
  ppc: simplify cpu model lookup by PVR
  ppc: drop caching ObjectClass from PowerPCCPUAlias
  ppc: remove non implemented cpu models

 target/ppc/cpu-models.h     |    3 +-
 target/ppc/cpu.h            |    6 +-
 target/ppc/kvm_ppc.h        |    2 +-
 hw/ppc/e500.c               |    3 +-
 hw/ppc/mac_newworld.c       |    3 +-
 hw/ppc/mac_oldworld.c       |    3 +-
 hw/ppc/ppc440_bamboo.c      |    2 +-
 hw/ppc/ppc4xx_devs.c        |    2 +-
 hw/ppc/prep.c               |    5 +-
 hw/ppc/spapr_cpu_core.c     |   24 +-
 hw/ppc/virtex_ml507.c       |    2 +-
 target/ppc/cpu-models.c     | 1023 ++++++++++++-------------------------=
------
 target/ppc/kvm.c            |    5 +-
 target/ppc/translate_init.c |  105 ++---
 14 files changed, 344 insertions(+), 844 deletions(-)

--=20
2.7.4
