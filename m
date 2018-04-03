Received: from eggs.gnu.org ([2001:4830:134:3::10]:48044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3Ljm-0002lZ-Lg
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3Ljf-0001Ha-1E
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1f3Lje-0001HB-SP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DA7F402314E
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 13:12:26 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue,  3 Apr 2018 15:12:13 +0200
Message-Id: <cover.1522760575.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Couple of qemu-pr-helper fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

The first one is trivial.

The second is slightly trickier. Libvirt has this virCommand subsystem
(found under src/util/vircommand.c) which it uses to spawn commands. The
subsystem allows libvirt to both daemonize a process and learn its PID.
The latter of course does not work if command daemonizes itself (hence
libvirt will not use qemu-pr-helper --daemon). BUT, we still need
qemu-pr-helper to lock the pidfile (so that when libvirt tries to lock
it it is denied). NB, libvirt uses fnctl(cmd = F_SETLK) to lock
pidfiles. So leaking locked FD into qemu-pr-helper is not an option
because that doesn't survive fork().

Another, trivial reason might be that if I run:

  qemu-pr-helper --pidfile /tmp/pr.pid

(without --daemon), I'd still expect qemu-pr-helper to write pidfile
because I told it to.

Michal Privoznik (2):
  qemu-pr-helper: Daemonize before dropping privileges
  qemu-pr-helper: Write pidfile more often

 scsi/qemu-pr-helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.16.1
