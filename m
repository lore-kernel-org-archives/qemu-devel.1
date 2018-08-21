Received: from eggs.gnu.org ([2001:4830:134:3::10]:45482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fs9US-00026f-RG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fs9UP-0003AK-QQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:26:44 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Aug 2018 12:26:18 -0400
Message-Id: <cover.1534868459.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] block: for jobs,
 do not clear user_paused until after the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, eblake@redhat.com

v3 changes:
    Rebased to master
    Patch 2: Wait for pause after mirror instead of error, to gobble the
             right message (Thanks John)
    Patch 2: Replace a hard-coded 'qcow2' with '$IMGFMT', oops.

v2 changes:

    Patch 1: Added r-b from John, Eric (Thanks)
    Patch 2: Attached an iotest as patch 2

    * cc'ed qemu-stable

For the test in patch 2, failure here is the failure output w/o patch 1:

 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "write", "action": "stop"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 2097152, "offset": 1048576, "speed": 0, "type": "mirror"}}
-*** done
+QEMU_PROG: blockjob.c:460: block_job_iostatus_reset: Assertion `job->job.user_paused && job->job.pause_count > 0' failed.
+Wrong response matching Assertion on handle 0
Failures: 229
Failed 1 of 1 tests

git-backport-diff, v2->v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/2:[----] [--] 'block: for jobs, do not clear user_paused until after the resume'
002/2:[0006] [FC] 'block: iotest to catch abort on forced blockjob cancel'


Jeff Cody (2):
  block: for jobs, do not clear user_paused until after the resume
  block: iotest to catch abort on forced blockjob cancel

 job.c                      |  2 +-
 tests/qemu-iotests/229     | 95 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/229.out | 23 +++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/229
 create mode 100644 tests/qemu-iotests/229.out

-- 
2.17.1
