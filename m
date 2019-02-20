Received: from eggs.gnu.org ([209.51.188.92]:41266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUOL-0002Jp-37
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwUOJ-0005Fu-QM
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:06:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwUOJ-0005DQ-BX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:06:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8467C139833
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:06:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 17:06:24 +0100
Message-Id: <20190220160628.6555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] RFC: make chardev context switching safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,

The chardev context switching code is a bit fragile, as it works as if
the current context is properly synchronized with the new context.  It
isn't so obvious to me that concurrent usage of chardev can't happen,
as there might be various main loop sources being dispatched during
the switch.

Worried about the situation, I wrote those patches a while ago, I
think they are still worth to consider. I used to have some basic
test, but it now conflicts a lot with recent changes. I would like to
get some feedback about the series before I rewrite it.

The importat patch is "chardev: make qemu_chr_fe_set_handlers()
context switching safer". It works by "freezing" the given contexts
while the chardev will "move" (recreate to the new context) the
various sources it owns. This looks quite ugly to me overall, but still
safer than today.

This should allow to simplify the scary code from "monitor: set the
chardev context from the main context/thread".

Finally, "char-socket: restart the reconnect timer to switch context"
shows that we have chardev backends that do not switch fully yet.

(there should be a meme "using chardev from multiple threads is
considered harmful")

Marc-Andr=C3=A9 Lureau (4):
  iothread: wait until the glib context is acquired
  chardev: make qemu_chr_fe_set_handlers() context switching safer
  monitor: set the chardev context from the main context/thread
  char-socket: restart the reconnect timer to switch context

 include/chardev/char-fe.h |  23 +++++++++
 chardev/char-fe.c         | 103 +++++++++++++++++++++++++++++++++-----
 chardev/char-mux.c        |  14 +++---
 chardev/char-socket.c     |   5 ++
 iothread.c                |   7 +++
 monitor.c                 |  39 +++------------
 6 files changed, 139 insertions(+), 52 deletions(-)

--=20
2.21.0.rc1
