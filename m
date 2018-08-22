Received: from eggs.gnu.org ([2001:4830:134:3::10]:53095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsU9B-0004u0-8N
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsU97-0000qR-HW
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:30:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsU97-0000oD-8C
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:30:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31BD1807689C
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 14:30:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Aug 2018 16:29:53 +0200
Message-Id: <20180822142956.6859-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/3] seccomp fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series fixes 2 issues with -sandbox:

- The seccomp action SCMP_ACT_KILL results in immediate termination of
  the thread that made the bad system call. However, qemu being
  multi-threaded, it keeps running. There is no easy way for parent
  process / management layer (libvirt) to know about that situation.

  Instead, the default SIGSYS handler when invoked with SCMP_ACT_TRAP
  will terminate the program and core dump.

  This may not be the most secure solution, but probably better than
  just killing the offending thread. SCMP_ACT_KILL_PROCESS has been
  added in Linux 4.14 to improve the situation, which I propose to use
  by default if available.

  Related to:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456

- The seccomp filter isn't applied to all threads. We can solve the
  issue by using SECCOMP_FILTER_FLAG_TSYNC since libseccomp 2.2.0 and
  kernel >=3D 3.17. The issue remains on older kernels or older
  libseccomp. I chose to report an error by default, but we may want
  it to fail instead.

v3:
- modify qemu_seccomp() to set errno=3DENOSYS
- add patch "seccomp: set the seccomp filter to all threads"

v2:
- fix clang unused inline warning
- add acked-by/r-b tags

Marc-Andr=C3=A9 Lureau (3):
  seccomp: use SIGSYS signal instead of killing the thread
  seccomp: prefer SCMP_ACT_KILL_PROCESS if available
  seccomp: set the seccomp filter to all threads

 qemu-seccomp.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx |  2 ++
 2 files changed, 95 insertions(+), 3 deletions(-)

--=20
2.18.0.547.g1d89318c48
