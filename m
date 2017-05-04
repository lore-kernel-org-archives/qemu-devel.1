Received: from eggs.gnu.org ([2001:4830:134:3::10]:56753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKP-0003Ek-Tf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKM-00065P-Q2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:37 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42230)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CKM-00063u-HP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:41:34 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 04 May 2017 11:41:36 +0300
Message-ID: <20170504084135.7488.24715.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v9 00/10] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This set of patches fixes some vmstate creation (and loading) issues
in record/replay modes:
 - VM start/stop fixes in replay mode
 - overlay creation for blkreplay filter
 - fixes for vmstate save/load in record/replay mode
 - fixes for host clock vmstate
 - fixes for icount timers vmstate

v9 changes:
 - Added vmstate for host clock parameters and icount timers
 - Fixed replay event queue issues
 - Fixed vm stopping while recording or replaying the execution
 - Fixed save/load vmstate issues in record/replay mode

v8 changes:
 - Refined replay exception processing (as suggested by Paolo Bonzini)
 - Saving/restoring static variable for APIC only once (as suggested by Paolo Bonzini)
 - Removed already queued patches
 - Minor fixes

v7 changes:
 - Fixed exception replaying when TB cache is full and
   when tb_find is called when there are no instructions about to execute
 - Added record/replay for audio devices

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

Pavel Dovgalyuk (10):
      block: implement bdrv_snapshot_goto for blkreplay
      blkreplay: create temporary overlay for underlaying devices
      replay: disable default snapshot for record/replay
      replay: fix processing async events
      replay: fixed replay_enable_events
      replay: fix save/load vm for non-empty queue
      replay: added replay log format description
      replay: make safe vmstop at record/replay
      replay: save prior value of the host clock
      icount: fixed saving/restoring of icount warp timers


 block/blkreplay.c        |   73 +++++++++++++++++++++++++++++++++++++
 cpus.c                   |   90 +++++++++++++++++++++++++++++++++++-----------
 docs/replay.txt          |   69 +++++++++++++++++++++++++++++++++++
 include/qemu/timer.h     |   14 +++++++
 include/sysemu/replay.h  |    3 ++
 migration/savevm.c       |   13 +++++++
 replay/replay-events.c   |   12 ++++--
 replay/replay-internal.h |    2 +
 replay/replay-snapshot.c |    9 +++++
 stubs/replay.c           |    1 +
 util/qemu-timer.c        |   12 ++++++
 vl.c                     |   10 ++++-
 12 files changed, 279 insertions(+), 29 deletions(-)

-- 
Pavel Dovgalyuk
