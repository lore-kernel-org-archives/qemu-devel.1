Received: from eggs.gnu.org ([2001:4830:134:3::10]:56807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft859-00088l-3M
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft855-0005ut-V6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ft855-0005ub-QK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C20B87A74
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:08:35 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 24 Aug 2018 17:08:23 +0800
Message-Id: <20180824090826.21370-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/3] chardev: introduce chardev contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

This is a RFC series.  It majorly did these things:

(1) move the monitor iothread management from monitor code to chardev
    code somehow,

(2) decide which context/iothread to use for the chardev before
    chardev creates, by parsing monitor options earlier (not init, but
    only parsing) since monitor is the only exception now,

(2) disallow chardev context to change for the whole lifecycle.

Basically this work moves the only chardev iothread (the monitor
iothread) into chardev's management, then it's easy to setup the
iothread even before the chardev creates, hence no context switch for
chardev is needed any more.  In the future if we want to let any
chardev to run on some other threads, we just define a new
ChardevContext, then do qemu_opt_set_number(...) for the chardev.  For
now, there is only a monitor context.

It does not mean that this will let chardev depend on monitor code,
instead it'll totally remove the reverse dependency - before this
work, the chardev backend strangely depends on the frontend to setup
the context (which brought us many trouble).  Now this should be gone.

This series should solve the potential issue raised here:

  https://patchwork.kernel.org/patch/10122713/#22187395

And also should let Marc-Andr=C3=A9's vhost-user reconnect series work
without breaking context switch of chardev (since it never switches
now hence no way to break):

  http://patchwork.ozlabs.org/cover/961442/

Only smoke test carried out with out-of-band, and make check.

Please have a look on whether this is a workable solution,

TODO:
- should not allow user to specify the "context" parameter
- more ...

Thanks,

Peter Xu (3):
  chardev: introduce chardev contexts
  monitor: generate flag parse helper from init func
  monitor: switch to use chardev's iothread

 chardev/char-fe.c      |  6 ++++
 chardev/char.c         | 74 ++++++++++++++++++++++++++++++++++++++----
 gdbstub.c              |  2 +-
 hw/bt/hci-csr.c        |  2 +-
 include/chardev/char.h | 15 ++++++++-
 monitor.c              |  4 +--
 tests/test-char.c      |  4 +--
 vl.c                   | 45 +++++++++++++++++++++++--
 8 files changed, 136 insertions(+), 16 deletions(-)

--=20
2.17.1
