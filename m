Received: from eggs.gnu.org ([2001:4830:134:3::10]:38730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJO-0005qf-GH
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJL-0003Kg-8i
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJL-0003KI-37
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:15 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DC797FB60
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQDFS003164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:47 +0100
Message-Id: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/24] QemuOpts util/cutils: Fix and clean up
 number conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QemuOpts has its own code to convert strings to numbers, and being
QemuOpts, it gets it wrong.  util/cutils is less wrong.  Fix it up
some, and reuse it for QemuOpts.

Markus Armbruster (24):
  tests/test-qemu-opts: Cover qemu_opts_parse()
  QemuOpts: Assert value string isn't null
  tests/test-cutils: Add missing qemu_strtol()... endptr checks
  tests/test-cutils: Clean up qemu_strtoul() result checks
  util/cutils: Rewrite documentation of qemu_strtol() & friends
  util/cutils: Rename qemu_strtoll(), qemu_strtoull()
  util/cutils: Clean up variable names around qemu_strtol()
  util/cutils: Clean up control flow around qemu_strtol() a bit
  QemuOpts: Fix to reject numbers that overflow uint64_t
  tests/test-cutils: Add missing qemu_strtosz()... endptr checks
  tests/test-cutils: Cover qemu_strtosz() invalid input
  tests/test-cutils: Cover qemu_strtosz() with trailing crap
  tests/test-cutils: Cover qemu_strtosz() around range limits
  util/cutils: New qemu_strtosz_metric()
  util/cutils: Rename qemu_strtosz() to qemu_strtosz_mebi()
  util/cutils: New qemu_strtosz()
  util/cutils: Drop QEMU_STRTOSZ_DEFSUFFIX_* macros
  tests/test-cutils: Use qemu_strtosz() more often
  tests/test-cutils: Drop suffix from test_qemu_strtosz_simple()
  qemu-img: Wrap cvtnum() around qemu_strtosz()
  util/cutils: Let qemu_strtosz*() optionally reject trailing crap
  util/cutils: Return qemu_strtosz*() error and value separately
  util/cutils: Change qemu_strtosz*() from int64_t to uint64_t
  QemuOpts: Fix checking of sizes for overflow and trailing crap

 hmp.c                  |  11 +-
 hw/misc/ivshmem.c      |   9 +-
 include/qemu/cutils.h  |  29 +--
 monitor.c              |   7 +-
 qapi/opts-visitor.c    |  11 +-
 qemu-img.c             |  62 ++---
 qemu-io-cmds.c         |  16 +-
 qobject/qdict.c        |   2 +-
 qtest.c                |  34 +--
 target/i386/cpu.c      |   9 +-
 tests/test-cutils.c    | 642 ++++++++++++++++++++++++++++++++-----------------
 tests/test-qemu-opts.c | 289 +++++++++++++++++++++-
 util/cutils.c          | 239 +++++++++---------
 util/log.c             |   4 +-
 util/qemu-option.c     |  87 +++----
 15 files changed, 959 insertions(+), 492 deletions(-)

-- 
2.7.4
