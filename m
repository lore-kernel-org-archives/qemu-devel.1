Received: from eggs.gnu.org ([2001:4830:134:3::10]:39440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqeE-000128-Rn
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqeB-00045a-G0
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:31:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsqeB-00041j-AP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:31:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12AE04023827
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:31:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Aug 2018 16:31:20 +0200
Message-Id: <20180823143125.16767-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] Fix socket chardev regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

In commit 25679e5d58e "chardev: tcp: postpone async connection setup"
(and its follow up 99f2f54174a59), Peter moved chardev socket
connection to machine_done event. However, chardev created later will
no longer attempt to connect, and chardev created in tests do not have
machine_done event (breaking some of vhost-user-test).

The goal was to move the "connect" source to the chardev frontend
context (the monitor thread context in his case). chr->gcontext is set
with qemu_chr_fe_set_handlers(). But there is no guarantee that the
function will be called in general, so we can't delay connection until
then: the chardev should still attempt to connect during open(), using
the main context.

An alternative would be to specify the iothread during chardev
creation. Setting up monitor OOB would be quite different too, it
would take the same iothread as argument.

99f2f54174a595e is also a bit problematic, since it will behave
differently before and after machine_done (the first case gives a
chance to use a different context reliably, the second looks racy)

In the end, I am not sure this is all necessary, as chardev callbacks
are called after qemu_chr_fe_set_handlers(), at which point the
context of sources are updated. In "char-socket: update all ioc
handlers when changing context", I moved also the hup handler to the
updated context. So unless the main thread is already stuck, we can
setup a different context for the chardev at that time. Or not?

v2:
- fix a random socket chardev test failure

Marc-Andr=C3=A9 Lureau (5):
  Revert "chardev: tcp: postpone TLS work until machine done"
  Revert "chardev: tcp: postpone async connection setup"
  char-socket: update all ioc handlers when changing context
  test-char: fix random socket test failure
  test-char: add socket reconnect test

 chardev/char-socket.c | 86 ++++++++++++++++++-------------------------
 tests/test-char.c     | 25 +++++++++++--
 2 files changed, 57 insertions(+), 54 deletions(-)

--=20
2.18.0.547.g1d89318c48
