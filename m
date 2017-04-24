Received: from eggs.gnu.org ([2001:4830:134:3::10]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d2nfB-0003NK-Ns
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d2nf7-0003tr-RC
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:45:01 -0400
Received: from mail.kernel.org ([198.145.29.136]:52822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d2nf7-0003tJ-MZ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:44:57 -0400
Date: Mon, 24 Apr 2017 16:44:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA8CWYCxVauuWSsmuQw4YG1O0DO+rYASm2aVhirp3Z3mZA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1704241640160.16723@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<CAFEAcA-F4mKWyknfRWhJfymJxbsYPvWH20CSecTmY8-kq-dipA@mail.gmail.com>
	<alpine.DEB.2.10.1704241423030.16723@sstabellini-ThinkPad-X260>
	<CAFEAcA8CWYCxVauuWSsmuQw4YG1O0DO+rYASm2aVhirp3Z3mZA@mail.gmail.com>
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Mon, 24 Apr 2017, Peter Maydell wrote:
> On 24 April 2017 at 22:25, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
> > new file mode 100644
> > index 0000000..18f0ec0
> > --- /dev/null
> > +++ b/hw/9pfs/xen-9pfs.h
> > @@ -0,0 +1,14 @@
> > +/*
> > + * Xen 9p backend
> > + *
> > + * Copyright Aporeto 2017
> > + *
> > + * Authors:
> > + *  Stefano Stabellini <stefano@aporeto.com>
> > + *
> > + */
> 
> Trivial file, but I prefer it if we have a brief license
> statement in every file, just to be clear (it might
> accumulate more code later).

Sure

> > +
> > +#include <xen/io/protocols.h>
> > +#include "hw/xen/io/ring.h"
> > +
> > +DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
> 
> Is it worth a comment to dissuade people from thinking they can
> inline the file back into xen-9p-backend.c ?

Thanks for the quick review! Here you go:


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
index 0000000..6e33d77
--- /dev/null
+++ b/hw/9pfs/xen-9pfs.h
@@ -0,0 +1,21 @@
+/*
+ * Xen 9p backend
+ *
+ * Copyright Aporeto 2017
+ *
+ * Authors:
+ *  Stefano Stabellini <stefano@aporeto.com>
+ *
+ * This work is licensed under the terms of the GNU GPL version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <xen/io/protocols.h>
+#include "hw/xen/io/ring.h"
+
+/*
+ * Do not merge into xen-9p-backend.c: clang doesn't allow unused static
+ * inline functions in c files.
+ */
+DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
