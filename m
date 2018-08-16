Received: from eggs.gnu.org ([2001:4830:134:3::10]:49214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqHwt-0005sP-EA
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqHws-0002i9-Jh
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:04:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqHws-0002i1-FE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C44140201C7
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 13:04:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Aug 2018 15:04:13 +0200
Message-Id: <20180816130415.26057-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] seccomp action,
 prefer KILL_PROCESS or TRAP
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

The seccomp action SCMP_ACT_KILL results in immediate termination of
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

v2:
- fix clang unused inline warning
- add acked-by/r-b tags

Marc-Andr=C3=A9 Lureau (2):
  seccomp: use SIGSYS signal instead of killing the thread
  seccomp: prefer SCMP_ACT_KILL_PROCESS if available

 qemu-seccomp.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

--=20
2.18.0.547.g1d89318c48
