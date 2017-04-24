Received: from eggs.gnu.org ([2001:4830:134:3::10]:53990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d2lUM-00007y-G1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d2lUJ-00055o-1B
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:25:42 -0400
Received: from mail.kernel.org ([198.145.29.136]:36220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d2lUI-00055P-Ou
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 17:25:38 -0400
Date: Mon, 24 Apr 2017 14:25:31 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA-F4mKWyknfRWhJfymJxbsYPvWH20CSecTmY8-kq-dipA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1704241423030.16723@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<CAFEAcA-F4mKWyknfRWhJfymJxbsYPvWH20CSecTmY8-kq-dipA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PULL 0/21] Please pull xen-20170421-tag for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com

On Mon, 24 Apr 2017, Peter Maydell wrote:
> On 21 April 2017 at 21:14, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:
> >
> >   Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)
> >
> > are available in the git repository at:
> >
> >   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170421-tag
> >
> > for you to fetch changes up to b0d48550a2d10f0fa8c30a7cc3ff5a1cbda8d4c4:
> >
> >   move xen-mapcache.c to hw/i386/xen/ (2017-04-21 12:41:29 -0700)
> >
> > ----------------------------------------------------------------
> > Xen 2017/04/21
> >
> > ----------------------------------------------------------------
> 
> Hi; I'm afraid this doesn't build with clang:
> 
> 
>   CC      hw/9pfs/xen-9p-backend.o
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/xen-9p-backend.c:21:1:
> error: unused fun
> ction 'xen_9pfs_get_ring_ptr' [-Werror,-Wunused-function]
> DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
> ^
> /home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:469:79:
> note: expanded
> from macro 'DEFINE_XEN_FLEX_RING_AND_INTF'
> };                                                                            \
>                                                                               ^
> /home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:387:30:
> note: expanded from macro '\
> DEFINE_XEN_FLEX_RING'
> static inline unsigned char *name##_get_ring_ptr(unsigned char *buf,          \
>                              ^
> <scratch space>:151:1: note: expanded from here
> xen_9pfs_get_ring_ptr
> ^
> /home/petmay01/linaro/qemu-for-merges/hw/9pfs/xen-9p-backend.c:21:1:
> error: unused function 'xen_9pfs_write_packet'
> [-Werror,-Wunused-function]
> /home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:469:79:
> note: expanded from macro 'DEFINE_XEN_FLEX_RING_AND_INTF'
> };                                                                            \
>                                                                               ^
> /home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:412:20:
> note: expanded from macro '\
> DEFINE_XEN_FLEX_RING'
> static inline void name##_write_packet(unsigned char *buf,                    \
>                    ^
> <scratch space>:155:1: note: expanded from here
> xen_9pfs_write_packet
> ^
> 2 errors generated.
> /home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
> 'hw/9pfs/xen-9p-backend.o' failed
> 
> 
> Clang requires that functions, even inline functions, defined in .c files
> must be used.

Thank you for finding this issue. Given that ring.h is synced from Xen,
I think it makes sense to leave as is. I'll fix it as follow:

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 7e962aa..9c7f41a 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -13,12 +13,9 @@
 #include "hw/hw.h"
 #include "hw/9pfs/9p.h"
 #include "hw/xen/xen_backend.h"
-#include "hw/xen/io/ring.h"
+#include "hw/9pfs/xen-9pfs.h"
 #include "qemu/config-file.h"
 #include "fsdev/qemu-fsdev.h"
-#include <xen/io/protocols.h>
-
-DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
 
 #define VERSIONS "1"
 #define MAX_RINGS 8
diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
new file mode 100644
index 0000000..18f0ec0
--- /dev/null
+++ b/hw/9pfs/xen-9pfs.h
@@ -0,0 +1,14 @@
+/*
+ * Xen 9p backend
+ *
+ * Copyright Aporeto 2017
+ *
+ * Authors:
+ *  Stefano Stabellini <stefano@aporeto.com>
+ *
+ */
+
+#include <xen/io/protocols.h>
+#include "hw/xen/io/ring.h"
+
+DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
