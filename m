Received: from eggs.gnu.org ([2001:4830:134:3::10]:47434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2g-0005sg-Tv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2g-0000pd-3r
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1emR2f-0000p5-Uw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 849418182D27
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 21:25:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Feb 2018 22:25:46 +0100
Message-Id: <20180215212552.26997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] vhost-user-test and leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The following patches fix a regression introduced in commit
218bb57dd79d that prevent ASAN from being detected & used.  There is
also a works around for a GCC ASAN optimization bug. A few test leaks
are fixed, and a few patches reenable vhost-user memfd test fixing the
recent race bug that was identified in the previous version.

Marc-Andr=C3=A9 Lureau (6):
  build-sys: fix -fsanitize=3Daddress check
  lockable: workaround GCC link issue with ASAN
  vhost-user-test: add back memfd check
  vhost-user-test: do not hang if chardev creation failed
  ahci-test: fix opts leak of skip tests
  sdhci-test: fix leaks

 include/qemu/lockable.h |  2 +-
 tests/ahci-test.c       |  1 +
 tests/sdhci-test.c      |  2 ++
 tests/vhost-user-test.c | 94 +++++++++++++++++++++++++++++++++++--------=
------
 configure               | 22 ++++++------
 5 files changed, 83 insertions(+), 38 deletions(-)

--=20
2.16.1.73.g5832b7e9f2
