Received: from eggs.gnu.org ([2001:4830:134:3::10]:46203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d8NCZ-0005Ze-Rn
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d8NCW-0007DB-Pq
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:42:31 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1d8NCW-0007Cw-Jq
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:42:28 -0400
Received: by mail-wr0-x244.google.com with SMTP id w50so6343067wrc.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 01:42:28 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Wed, 10 May 2017 04:41:19 -0400
Message-Id: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v4 0/4] fsdev: qmp interface for io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

These patches provide the qmp interface, to query the io throttle 
status of the all fsdev devices that are present in a vm.
also, it provides an interface to set the io throttle parameters of a
fsdev to a required value. some of the patches also remove the duplicate
code that was present in block and fsdev files. 

Pradeep Jagadeesh (4):
  throttle: factor out duplicate code
  qmp: Create IOThrottle structure
  qmp: refactor duplicate code
  fsdev: QMP interface for throttling

 Makefile                        |   3 +
 blockdev.c                      |  97 ++-------------------------------
 fsdev/qemu-fsdev-dummy.c        |  10 ++++
 fsdev/qemu-fsdev-throttle.c     | 118 ++++++++++++++++++++++++++--------------
 fsdev/qemu-fsdev-throttle.h     |  13 +++++
 fsdev/qemu-fsdev.c              |  37 +++++++++++++
 hmp-commands-info.hx            |  19 +++++++
 hmp-commands.hx                 |  19 +++++++
 hmp.c                           |  88 ++++++++++++++++++++++++++++--
 hmp.h                           |   4 ++
 include/qemu/throttle-options.h |   7 +++
 qapi-schema.json                |   3 +
 qapi/block-core.json            |  76 +-------------------------
 qapi/fsdev.json                 |  84 ++++++++++++++++++++++++++++
 qapi/iothrottle.json            |  88 ++++++++++++++++++++++++++++++
 qmp.c                           |  15 +++++
 util/Makefile.objs              |   1 +
 util/throttle-options.c         | 105 +++++++++++++++++++++++++++++++++++
 18 files changed, 573 insertions(+), 214 deletions(-)
 create mode 100644 qapi/fsdev.json
 create mode 100644 qapi/iothrottle.json
 create mode 100644 util/throttle-options.c

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

-- 
1.8.3.1
