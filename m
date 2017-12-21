Received: from eggs.gnu.org ([2001:4830:134:3::10]:53202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS0sm-0006kL-Vm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS0si-0004b1-OD
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eS0si-0004a8-IL
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:27:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB6BC7EA8C
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 13:27:27 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 21 Dec 2017 13:27:15 +0000
Message-Id: <20171221132717.30284-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] Enable passing pre-opened chardev
 socket FDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This fixes a long standing problem that libvirt has with starting up QEMU.

We have to busy-wait retrying connect() on the QMP monitor socket until QEMU
finally creates & listens on it, but at same time must be careful to not wait
forever if QEMU exits.

This this patch series, libvirt can simply pass in a pre-opened UNIX domain
socket file descriptor, which it can immediately connect to with no busy-wait.

Daniel P. Berrange (2):
  io: move fd_is_socket() into common sockets code
  char: allow passing pre-opened socket file descriptor at startup

 chardev/char-socket.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++------
 chardev/char.c         |  6 +++++
 include/qemu/sockets.h |  1 +
 io/channel-util.c      | 13 ----------
 monitor.c              |  5 ++++
 qapi/common.json       | 11 +++++++++
 qapi/sockets.json      | 14 ++++++++---
 util/qemu-sockets.c    | 49 +++++++++++++++++++++++++++++++++++++
 8 files changed, 142 insertions(+), 23 deletions(-)

-- 
2.14.3
