Received: from eggs.gnu.org ([2001:4830:134:3::10]:39731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSs-0001xj-D6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSo-0000m9-8S
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgzSn-0000lI-VY
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:06 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 597807E9D5
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:54:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1NJs4ZK009476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:54:05 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 20:53:38 +0100
Message-Id: <1487879642-16139-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/24] option cutils: Fix and clean up number
 conversions
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

The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b42=
06:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into =
staging (2017-02-23 09:59:40 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-util-2017-02-23

for you to fetch changes up to 75cdcd1553e74b5edc58aed23e3b2da8dabb1876:

  option: Fix checking of sizes for overflow and trailing crap (2017-02-2=
3 20:35:36 +0100)

----------------------------------------------------------------
option cutils: Fix and clean up number conversions

----------------------------------------------------------------
Markus Armbruster (24):
      test-qemu-opts: Cover qemu_opts_parse()
      option: Assert value string isn't null
      test-cutils: Add missing qemu_strtol()... endptr checks
      test-cutils: Clean up qemu_strtoul() result checks
      util/cutils: Rewrite documentation of qemu_strtol() & friends
      util/cutils: Rename qemu_strtoll(), qemu_strtoull()
      util/cutils: Clean up variable names around qemu_strtol()
      util/cutils: Clean up control flow around qemu_strtol() a bit
      option: Fix to reject invalid and overflowing numbers
      test-cutils: Add missing qemu_strtosz()... endptr checks
      test-cutils: Cover qemu_strtosz() invalid input
      test-cutils: Cover qemu_strtosz() with trailing crap
      test-cutils: Cover qemu_strtosz() around range limits
      util/cutils: New qemu_strtosz_metric()
      util/cutils: Rename qemu_strtosz() to qemu_strtosz_MiB()
      util/cutils: New qemu_strtosz()
      util/cutils: Drop QEMU_STRTOSZ_DEFSUFFIX_* macros
      test-cutils: Use qemu_strtosz() more often
      test-cutils: Drop suffix from test_qemu_strtosz_simple()
      qemu-img: Wrap cvtnum() around qemu_strtosz()
      util/cutils: Let qemu_strtosz*() optionally reject trailing crap
      util/cutils: Return qemu_strtosz*() error and value separately
      util/cutils: Change qemu_strtosz*() from int64_t to uint64_t
      option: Fix checking of sizes for overflow and trailing crap

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
 tests/test-cutils.c    | 642 ++++++++++++++++++++++++++++++++-----------=
------
 tests/test-qemu-opts.c | 324 ++++++++++++++++++++++++-
 util/cutils.c          | 239 +++++++++---------
 util/log.c             |   4 +-
 util/qemu-option.c     |  87 +++----
 15 files changed, 994 insertions(+), 492 deletions(-)

--=20
2.7.4
