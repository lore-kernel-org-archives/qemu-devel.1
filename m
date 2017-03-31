Received: from eggs.gnu.org ([2001:4830:134:3::10]:38783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctuhr-0002Ht-4d
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctuhm-0006tB-7t
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:03 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:43109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctuhm-0006ry-1C
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:26:58 -0400
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6EAB7341D3
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 13:26:55 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 31 Mar 2017 13:26:31 +0200
Message-ID: <149095959109.26233.3201018420228514740.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.9 PATCH 0/3] 9pfs: fix 9p session reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Greg Kurz <groug@kaod.org>

When resetting a 9p session we leak the migration blocker: this makes the
device unmigratable until the guest remounts/unmounts the 9p share again.
We also leak in-flight I/O whose completion will occur in the context of
the new session. This violates the 9p specification [*] and is likely to
confuse clients.

This series fixes both issues.

---

Greg Kurz (3):
      9pfs: clear migration blocker at session reset
      9pfs: cancel active PDUs in virtfs_reset()
      9pfs: drop useless loop in v9fs_reset()


 hw/9pfs/9p.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

--
Greg
