Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwN1Y-0004R6-MG
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 02:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwN1V-0004vm-I8
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 02:37:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwN1V-0004uW-Bz
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 02:37:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97A62285B5
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:37:43 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 25 Sep 2017 14:37:25 +0800
Message-Id: <1506321449-24013-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] iothread: allow to create internal
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

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
 qom/object.c              |  5 +++++
 4 files changed, 60 insertions(+), 10 deletions(-)

--=20
2.7.4
