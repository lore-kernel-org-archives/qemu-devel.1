Received: from eggs.gnu.org ([2001:4830:134:3::10]:44847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xH-0002mx-4q
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xE-00039n-14
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:24:59 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:27 +0200
Message-Id: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/23] generalize parsing of cpu_model (part
 3/PPC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

this series is continuation of effort to remove boards dependency on
cpu_model parsing and generalizing default cpu type handling.
For background story look at merged:=20

  [PATCH v2 0/5] generalize parsing of cpu_model (x86/arm)
  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03564.html

Part 3 is independent subset that takes care of all PPC boards.
Series borrows the 1st 3 patches from earlier posted part 2
  qom: update doc comment for type_register[_static]()                   =
       =20
  qom: introduce type_register_static_array()                            =
       =20
  qom: add helper macro DEFINE_TYPES()
to avoid interdependency, hopefully this 3 will be merged via machine-nex=
t,
but it's fine for them to go via any tree (whichever first)

Beside of switching to generic cpu_model parsing series contains a bunch
of cleanups/simplifications which reduces code a bit and normalizes
code that I've happend to touch to a typical QEMU patterns.

git tree for testing:
  https://github.com/imammedo/qemu/branches cpu_init_removal_ppc_part3_v1

CC: Alexander Graf <agraf@suse.de> (supporter:ppce500)
CC: David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
CC: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org> (maintainer:PReP)
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (odd fixer:virtex_ml50=
7)
CC: qemu-ppc@nongnu.org (open list:ppce500)

Igor Mammedov (23):
  qom: update doc comment for type_register[_static]()
  qom: introduce type_register_static_array()
  qom: add helper macro DEFINE_TYPES()
  ppc: mpc8544ds/e500plat: use generic cpu_model parsing
  ppc: mac_newworld: use generic cpu_model parsing
  ppc: mac_oldworld: use generic cpu_model parsing
  ppc: bamboo: use generic cpu_model parsing
  ppc: replace cpu_model with cpu_type on ref405ep,taihu boards
  ppc: virtex-ml507: replace cpu_model with cpu_type
  ppc: 40p/prep: replace cpu_model with cpu_type
  ppc: spapr: replace ppc_cpu_parse_features() with
    cpu_parse_cpu_model()
  ppc: move '-cpu foo,compat=3Dxxx' parsing into
    ppc_cpu_parse_featurestr()
  ppc: spapr: define core types statically
  ppc: spapr: use cpu type name directly
  ppc: spapr: register 'host' core type along with the rest of core
    types
  ppc: spapr: use cpu model names as tcg defaults instead of aliases
  ppc: spapr: use generic cpu_model parsing
  ppc: pnv: use generic cpu_model parsing
  ppc: pnv: normalize core/chip type names
  ppc: pnv: drop PnvCoreClass::cpu_oc field
  ppc: pnv: define core types statically
  ppc: pnv: drop PnvChipClass::cpu_model field
  ppc: pnv: consolidate type definitions and batch register them

 include/hw/ppc/pnv.h            |  12 +--
 include/hw/ppc/pnv_core.h       |   4 +-
 include/hw/ppc/ppc.h            |   2 -
 include/hw/ppc/spapr.h          |   2 -
 include/hw/ppc/spapr_cpu_core.h |   7 +-
 include/qom/object.h            |  50 ++++++++++-
 target/ppc/cpu-qom.h            |   1 +
 target/ppc/cpu.h                |   1 -
 hw/ppc/e500.c                   |   8 +-
 hw/ppc/e500plat.c               |   1 +
 hw/ppc/mac_newworld.c           |  15 ++--
 hw/ppc/mac_oldworld.c           |   6 +-
 hw/ppc/mpc8544ds.c              |   2 +
 hw/ppc/pnv.c                    | 131 ++++++++++++-----------------
 hw/ppc/pnv_core.c               |  67 +++++++--------
 hw/ppc/ppc.c                    |  25 ------
 hw/ppc/ppc405_uc.c              |   6 +-
 hw/ppc/ppc440_bamboo.c          |   7 +-
 hw/ppc/ppc4xx_devs.c            |   4 +-
 hw/ppc/prep.c                   |  12 +--
 hw/ppc/spapr.c                  |  22 ++---
 hw/ppc/spapr_cpu_core.c         | 182 ++++++++++------------------------=
------
 hw/ppc/virtex_ml507.c           |  11 +--
 qom/object.c                    |   9 ++
 target/ppc/kvm.c                |  20 ++---
 target/ppc/translate_init.c     |  72 ++++++++++++++--
 26 files changed, 304 insertions(+), 375 deletions(-)

--=20
2.7.4
