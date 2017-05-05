Received: from eggs.gnu.org ([2001:4830:134:3::10]:60699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6eyB-0006MB-3X
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6ey7-0006ys-Ss
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:16:35 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:40427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6ey7-0006xk-MO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:16:31 -0400
Received: from player786.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1B050EBC77
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 17:16:29 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 May 2017 16:36:46 +0200
Message-ID: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] 9pfs: local: fix metadata of mapped-file
 security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?L=C3=A9o?= Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

This series fixes two issues in the local backend when using the mapped-f=
ile
security mode:
- allow chmod and chown to succeed on the virtfs root (patch 4)
- completely hide the metadata files from the client (patch 5)

Patch 2 resolves '.' and '..' in paths, and patch 3 reworks the way we op=
en
files accordingly. They could be squashed together in a single patch (thi=
s
was the case in earlier versions actually), but I decided to separate the=
m
for easier review.

L=C3=A9o,

I'd appreciate if you could test this series (especially patch 4) on your
setup.

Cheers.

--
Greg

---

Greg Kurz (5):
      9pfs: check return value of v9fs_co_name_to_path()
      9pfs: local: resolve special directories in paths
      9pfs: local: simplify file opening
      9pfs: local: metadata file for the VirtFS root
      9pfs: local: forbid client access to metadata


 hw/9pfs/9p-local.c |  164 ++++++++++++++++++++++++++++++++++++++++------=
------
 hw/9pfs/9p-util.c  |   26 +++-----
 hw/9pfs/9p.c       |   36 ++++++++---
 3 files changed, 160 insertions(+), 66 deletions(-)
