Received: from eggs.gnu.org ([2001:4830:134:3::10]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dSPnh-0006c4-Ew
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dSPnd-0000bT-Af
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:31:41 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dSPnd-0000aN-40
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:31:37 -0400
Received: by mail-wr0-x241.google.com with SMTP id 77so47624221wrb.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 08:31:35 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Tue,  4 Jul 2017 11:30:57 -0400
Message-Id: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v7 0/6] fsdev: qmp interface for io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

These patches provide the qmp interface, to query the io throttle 
status of the all fsdev devices that are present in a vm.
also, it provides an interface to set the io throttle parameters of a
fsdev to a required value. some of the patches also remove the duplicate
code that was present in block and fsdev files. 

Pradeep Jagadeesh (6):
  throttle: factor out duplicate code
  qmp: Create IOThrottle structure
  throttle: move out function to reuse the code
  hmp: create a throttle initialization function for code reusability
  fsdev: hmp interface for throttling
  fsdev: QMP interface for throttling

 Makefile                        |   4 ++
 blockdev.c                      |  97 ++-------------------------------
 fsdev/qemu-fsdev-dummy.c        |  10 ++++
 fsdev/qemu-fsdev-throttle.c     | 118 ++++++++++++++++++++++++++--------------
 fsdev/qemu-fsdev-throttle.h     |  13 +++++
 fsdev/qemu-fsdev.c              |  37 +++++++++++++
 hmp-commands-info.hx            |  18 ++++++
 hmp-commands.hx                 |  19 +++++++
 hmp.c                           |  81 +++++++++++++++++++++++++--
 hmp.h                           |   4 ++
 include/qemu/throttle-options.h |   7 +++
 include/qemu/throttle.h         |   4 +-
 include/qemu/typedefs.h         |   1 +
 monitor.c                       |   5 ++
 qapi-schema.json                |   3 +
 qapi/block-core.json            |  76 +-------------------------
 qapi/fsdev.json                 |  84 ++++++++++++++++++++++++++++
 qapi/iothrottle.json            |  88 ++++++++++++++++++++++++++++++
 qmp.c                           |  14 +++++
 util/throttle.c                 | 110 +++++++++++++++++++++++++++++++++++++
 20 files changed, 577 insertions(+), 216 deletions(-)
 create mode 100644 qapi/fsdev.json
 create mode 100644 qapi/iothrottle.json

v0 -> v1:
 Addressed comments from Eric Blake, Greg Kurz and Daniel P.Berrange
 Mainly renaming the functions and removing the redundant code.

v1 -> v2:
 Addressed comments from Eric Blake and Greg Kurz.
 As per the suggestion I split the patches into smaller patches.
 Removed some more duplicate code.

v2 -> v3:
 Addresssed comments from Alberto Garcia.
 Changed the comment from block to iothrottle in the iothrottle.json 
 Added the dummy functions in qemu-fsdev-dummy.c to address the compilation
 issues that were observed.

v3 -> v4:
 Addressed comments from Eric Blake and Greg Kurz
 Re-ordered the patches
 Added the dummy functions in qmp.c to address the cross compilation issues

v4 -> v5:
  Addressed comments from Eric Blake and Greg Kurz
  Split the fsdev qmp patch into hmp and qmp related patches
  Moved the common functionalities to throttle.c instead of creating
  a new file

v5 -> v6:
  Addressed comments from Greg Kurz and Markus Armbruster
  Split the commits to specific to hmp and throttle as suggested by Greg
  Moved ThrottleConfig typedef to qemu/typedefs.h
  Addressed compilation issue on FreeBSD by adding flags in qmp.c

v6 -> v7:
  Addressed comments from Albert Garcia and Dr. David Alan Gilbert
  Fixed the hmp-commands-info.hx and hmp-commands.hx as per Dr. David's
  comments.
  Fixed the bug with the hmp fsdev_set_io_throttle and info fsdev_iothrottle  
-- 
1.8.3.1
