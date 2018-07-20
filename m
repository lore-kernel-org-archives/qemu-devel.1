Received: from eggs.gnu.org ([2001:4830:134:3::10]:58543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgXa2-0002D6-Bf
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgXZz-0001g2-9W
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:44:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgXZz-0001fr-4h
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:44:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72B1E5BCD7
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:44:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 20 Jul 2018 17:44:23 +0200
Message-Id: <20180720154425.31285-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] RFC: seccomp action,
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

Marc-Andr=C3=A9 Lureau (2):
  seccomp: use SIGSYS signal instead of killing the thread
  RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS if available

 qemu-seccomp.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

--=20
2.18.0.232.gb7bd9486b0
