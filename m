Received: from eggs.gnu.org ([2001:4830:134:3::10]:52195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZi-0006q0-15
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZc-0001wo-VE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:50 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dsRZc-0001tf-4g
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:44 -0400
Received: by mail-wm0-x242.google.com with SMTP id f4so2872766wmh.4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 03:40:42 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 14 Sep 2017 06:40:04 -0400
Message-Id: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v11 0/6] fsdev: qmp interface for io throttling
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
fsdev to a required value. Some of the patches also remove the
duplicate code that was present in block and fsdev files. 

Pradeep Jagadeesh (6):
  throttle: factor out duplicate code
  qmp: Use ThrottleLimits structure
  qmp: factor out throttle code to reuse code
  hmp: create a throttle initialization function for code reuse
  fsdev: QMP interface for throttling
  fsdev: hmp interface for throttling

 Makefile                        |   3 +-
 blockdev.c                      |  97 ++--------------------------
 fsdev/qemu-fsdev-dummy.c        |  11 ++++
 fsdev/qemu-fsdev-throttle.c     | 140 ++++++++++++++++++++++++++--------------
 fsdev/qemu-fsdev-throttle.h     |   9 ++-
 fsdev/qemu-fsdev.c              |  30 +++++++++
 hmp-commands-info.hx            |  18 ++++++
 hmp-commands.hx                 |  19 ++++++
 hmp.c                           |  79 +++++++++++++++++++++--
 hmp.h                           |   4 ++
 include/qemu/throttle-options.h |   3 +
 include/qemu/throttle.h         |   4 +-
 include/qemu/typedefs.h         |   1 +
 monitor.c                       |   5 ++
 qapi-schema.json                |   4 ++
 qapi/block-core.json            |  78 ++--------------------
 qapi/fsdev.json                 |  81 +++++++++++++++++++++++
 qmp.c                           |  14 ++++
 util/throttle.c                 |  52 +++++++++++++++
 19 files changed, 426 insertions(+), 226 deletions(-)
 create mode 100644 qapi/fsdev.json

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

v7 -> v8:
  Addressed comments from Markus Armbruster and Eric Blake
  Removed unwanted headers from qmp-fsdev-throttle.h

v8 -> v9:
  Addressed comments from Markus Armbruster and Eric Blake
  Removed the iothrottle.json and pushed the iothrottle struct to
  block-core.json

v9 -> v10:
  Addressed comments from Albert Garcia
  Fixed issue related to dynamically passing throttle configuration
  Removed some unused code

v10 -> v11:
  Addressed the comments from Markus Armbruster and Eric Blake
  Rebased the patches over 2.10
-- 
1.8.3.1
