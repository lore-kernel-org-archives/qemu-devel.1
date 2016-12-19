Received: from eggs.gnu.org ([2001:4830:134:3::10]:34141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxsO-00076d-CE
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxsL-0007Zv-6U
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:12 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46230)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxsK-0007Z6-VS
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:09 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Mon, 19 Dec 2016 16:21:04 +0300
Message-ID: <20161219132102.3016.46687.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 0/9] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com

This set of patches includes several fixes for replay and vmstate.

This patches add rrsnapshot option for icount. rrshapshot option creates
start snapshot at record and loads it at replay. It allows preserving
the state of disk images used by virtual machine. This vm state can also
use used to roll back the execution while replaying.

This set of patches includes fixes and additions for icount and
record/replay implementation:
 - VM start/stop in replay mode
 - overlay creation for blkreplay filter
 - rrsnapshot option for record/replay
 - vmstate fix for integratorcp ARM platform
 - vmstate fixes for apic and rtc

v6 changes:
 - Added overlay creation for blkreplay driver
 - Fixed vmstate loading for apic and rtc
 - Fixed instruction counting for apic instruction patching

v5 changes:
 - Recording is stopped when initial snapshot cannot be created
 - Minor changes

v4 changes:
 - Overlay option is removed from blkreplay driver (as suggested by Paolo Bonzini)
 - Minor changes

v3 changes:
 - Added rrsnapshot option for specifying the initial snapshot name (as suggested by Paolo Bonzini)
 - Minor changes

---

Pavel Dovgalyuk (9):
      icount: update instruction counter on apic patching
      replay: improve interrupt handling
      apic: save apic_delivered flag
      replay: don't use rtc clock on loadvm phase
      integratorcp: adding vmstate for save/restore
      savevm: add public save_vmstate function
      replay: save/load initial state
      block: implement bdrv_snapshot_goto for blkreplay
      blkreplay: create temporary overlay for underlaying devices


 block/blkreplay.c               |   84 +++++++++++++++++++++++++++++++++++++++
 cpu-exec.c                      |    2 -
 docs/replay.txt                 |   16 +++++++
 hw/arm/integratorcp.c           |   62 +++++++++++++++++++++++++++++
 hw/i386/kvmvapic.c              |    6 +++
 hw/intc/apic_common.c           |   32 +++++++++++++++
 hw/timer/mc146818rtc.c          |   14 +++++--
 include/hw/i386/apic_internal.h |    2 +
 include/sysemu/replay.h         |    9 ++++
 include/sysemu/sysemu.h         |    1 
 migration/savevm.c              |   33 ++++++++++-----
 qemu-options.hx                 |    8 +++-
 replay/replay-snapshot.c        |   17 ++++++++
 replay/replay.c                 |    5 ++
 stubs/replay.c                  |    1 
 target-i386/seg_helper.c        |    1 
 vl.c                            |    9 +++-
 17 files changed, 282 insertions(+), 20 deletions(-)

-- 
Pavel Dovgalyuk
