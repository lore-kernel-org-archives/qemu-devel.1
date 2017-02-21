Received: from eggs.gnu.org ([2001:4830:134:3::10]:55020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-0007Pj-GK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGp9-0008Sq-84
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGp9-0008Sc-2Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:11 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44FEA4E02A
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:44 +0100
Message-Id: <1487708048-2131-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/24] QemuOpts util/cutils: Fix and clean
 up number conversions
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

v2:
* PATCH 01+04: Use g_assert_cmphex() instead of g_assert_cmpuint() in
  a few places
* PATCH 01+09: Cover invalid input and leading whitespace in tests
  [Marc-Andr=C3=A9]
* PATCH 04: Prettier literal numbers
* PATCH 07+08: Rename to @libc_errno instead of @eno [Paolo]
* PATCH 15+18: Rename to qemu_strtosz_MiB() instead of _mebi() [Paolo]
* Commit messages massaged a bit
* R-bys retained

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
 tests/test-qemu-opts.c | 306 ++++++++++++++++++++++-
 util/cutils.c          | 239 +++++++++---------
 util/log.c             |   4 +-
 util/qemu-option.c     |  87 +++----
 15 files changed, 976 insertions(+), 492 deletions(-)

--=20
2.7.4
