Received: from eggs.gnu.org ([2001:4830:134:3::10]:60359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxs-0004mU-DW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxm-0001nD-1F
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2Dxl-0001l7-R9
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C4CB82107
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:10:04 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 11 Oct 2017 11:09:52 +0100
Message-Id: <20171011100959.29326-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Limit websockets memory usage & other
 bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The core motivation for this patch series is to fix a security
issue publically reported, where websockets code can consume
arbitrary amounts of RAM with slow clients:

   https://bugs.launchpad.net/qemu/+bug/1718964

I've asked for a CVE but its not assigned yet. Since the bug
is public we might as well get on with code review while waiting
for the CVE number.

The first patch is the minimum required to fix the actual CVE
in git master, taking advantage of how we know the VNC server
will call us. The 5th patch lets us tighten up buffer limiting
of writes further, so we're not making assumptions about VNC
server code.

The websockets code is broken right back to the day it was
merged in QEMU 1.2.1

The fix in patch 1 can apply to stable branches from 2.6 -> 2.10
inclusive, provided another fix from master is cherry-picked
first

  commit eefa3d8ef649f9055611361e2201cca49f8c3433
  Author: Brandon Carpenter <brandon.carpenter@cypherpath.com>
  Date:   Tue Sep 12 08:21:48 2017 -0700

    io: Small updates in preparation for websocket changes

since that refactors code duplication in the GSource impl.
Once we merge for master, I'll send a patch to qemu-stable.

Versions prior to 2.6 would require a fix to be done in
the ui/vnc.c file vnc_update_client method instead. It
would need to check vs->ws_output buffer size. I'm not
intending to write any such patch - this is just info in
case anyone is stuck on such ancient versions and needs
to figure out a fix.

Changed in v2:

  - Correctly index the struct iovec array when encoding (Eric)
  - Change ping_remain to pong_remain (Eric)
  - Misc typos (Eric)

Daniel P. Berrange (7):
  io: monitor encoutput buffer size from websocket GSource
  io: simplify websocket ping reply handling
  io: get rid of qio_channel_websock_encode helper method
  io: pass a struct iovec into qio_channel_websock_encode
  io: get rid of bounce buffering in websock write path
  io: cope with websock 'Connection' header having multiple values
  io: add trace points for websocket HTTP protocol headers

 include/io/channel-websock.h |   3 +-
 io/channel-websock.c         | 163 ++++++++++++++++++++++++-------------------
 io/trace-events              |   2 +
 3 files changed, 93 insertions(+), 75 deletions(-)

-- 
2.13.5
