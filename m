Received: from eggs.gnu.org ([2001:4830:134:3::10]:49791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwhrB-0002mA-TD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwhr8-00009P-SO
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwhr8-00008j-Mg
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:52:26 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 26 Sep 2017 12:52:08 +0800
Message-Id: <1506401532-25274-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] iothread: allow to create internal
 iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, peterx@redhat.com, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

v3:
- pick up r-bs (one missing for Fam's on last patch)
- fix patch 1 to create isolated internal container

v2:
- add one patch to provide object_get_internal_root() [Daniel]
- patch 2: use the new object_get_internal_root()
- patch 3: fix commit message, "reentrant" is wrongly used by me. it
  should be "called multiple times"; move iothread->ctx check into
  iothread_stop() [Fam]
- patch 4: add one paragraph in commit message, mention about the glib
  issue. [Fam]

When trying to support monitor OOB (out-of-band) commands, I found
that the monitor IO thread I did looks just like iothread.  It would
be best if I can use iothread directly.  However it seems that it was
mostly used by "-object iothread" before but not friendly to internal
usages.  This series tries to export essential functions to do it.

Also, I think patch 2 also fixes a bug in iothread_stop().

Please review. Thanks.

Peter Xu (4):
  qom: provide root container for internal objs
  iothread: provide helpers for internal use
  iothread: export iothread_stop()
  iothread: delay the context release to finalize

 include/qom/object.h      | 10 ++++++++++
 include/sysemu/iothread.h |  9 +++++++++
 iothread.c                | 46 ++++++++++++++++++++++++++++++++++++-----=
-----
 qom/object.c              | 11 +++++++++++
 4 files changed, 66 insertions(+), 10 deletions(-)

--=20
2.7.4
