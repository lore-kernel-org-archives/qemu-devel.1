Received: from eggs.gnu.org ([2001:4830:134:3::10]:35623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRft-0005up-Tq
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRfq-0003xf-P2
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:23:29 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:43433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRfq-0003xC-JU
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:23:26 -0400
Received: by mail-qt0-x236.google.com with SMTP id f13-v6so9169932qtp.10
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:23:26 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:02 -0400
Message-Id: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 00/13] 9p: Add support for Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org

From: Keno Fischer <keno@alumni.harvard.edu>

Hi Greg,

this series adds support for building the 9p code on Mac OS X.
It seems to work decently well (tested by booting up a linux
guest and building a copy of qemu on a 9p mount in the guest),
but there are probably corner cases I got wrong (particular
in the xattr support). Is there a stress test you recommend
running for those corner cases?

I've split the commits rather finely to hopefully ease review,
of each individual concern I ran into while porting. Happy to
merge commits back together if you would prefer.

Lastly, I should remark that I'm not super familiar with the qemu
code base, so please let me know if there's a better place for
some of the code (particularly some of the compatibility code).

Keno Fischer (13):
  9p: linux: Fix a couple Linux assumptions
  9p: Avoid warning if FS_IOC_GETVERSION is not defined
  9p: Move a couple xattr functions to 9p-util
  9p: darwin: Handle struct stat(fs) differences
  9p: darwin: Handle struct dirent differences
  9p: darwin: Address minor differences
  9p: darwin: Properly translate AT_REMOVEDIR flag
  9p: darwin: Ignore O_{NOATIME, DIRECT}
  9p: darwin: Provide a compatibility definition for XATTR_SIZE_MAX
  9p: darwin: *xattr_nofollow implementations
  9p: darwin: Mark mknod as unsupported
  9p: darwin: Provide a fallback implementation for utimensat
  9p: darwin: configure: Allow VirtFS on Darwin

 Makefile.objs        |   1 +
 configure            |  23 ++++++----
 fsdev/file-op-9p.h   |   6 +++
 hw/9pfs/9p-local.c   |  84 +++++++++++++++++++++++-------------
 hw/9pfs/9p-proxy.c   |  17 ++++++--
 hw/9pfs/9p-synth.c   |   6 +++
 hw/9pfs/9p-util.c    | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/9pfs/9p-util.h    |  13 ++++++
 hw/9pfs/9p-xattr.c   |  33 --------------
 hw/9pfs/9p.c         |  79 +++++++++++++++++++++++++--------
 include/qemu/xattr.h |   4 +-
 11 files changed, 293 insertions(+), 93 deletions(-)

-- 
2.8.1
