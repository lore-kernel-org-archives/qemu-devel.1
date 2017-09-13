Received: from eggs.gnu.org ([2001:4830:134:3::10]:51029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45p-00011i-OU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45m-0007TK-J9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds45m-0007St-Dx
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 811047F755
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:36:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 13 Sep 2017 17:36:02 +0800
Message-Id: <1505295366-25295-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] qtest: fix "device_del" out-of-order events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, peterx@redhat.com

It starts from a "make check" failure on one of my private tree. The
problem is that when we do "device_del" we normally looking for two
things: one response (which is mostly empty), and a REMOVE event.  The
tricky point is the event can either be there before/after the empty
response.  So I added qmp_device_del() to make sure the order does not
matter, then use it where proper.

Since I'm at it, I also added the sister helper qmp_device_add(), it
helps to remove LOCs.

I still don't 100% sure why my private tree can trigger this error,
while the master cannot. Anyway, I think this is something we should
have, no matter what.

Please review.  Thanks.

Peter Xu (4):
  libqtest: add qmp_device_del()
  tests: use qmp_device_del() where proper
  libqtest: add qmp_device_add()
  tests: use qmp_device_add() where proper

 tests/libqos/pci.c        | 15 +++--------
 tests/libqos/usb.c        | 28 +++++----------------
 tests/libqtest.c          | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.h          | 17 +++++++++++++
 tests/usb-hcd-uhci-test.c | 28 +++------------------
 tests/usb-hcd-xhci-test.c | 52 ++++----------------------------------
 6 files changed, 97 insertions(+), 106 deletions(-)

-- 
2.7.4
