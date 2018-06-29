Received: from eggs.gnu.org ([2001:4830:134:3::10]:38964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWr-0007ZK-PW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWp-0000wy-PG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrWp-0000vV-Ix
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:27 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 29 Jun 2018 12:25:18 +0100
Message-Id: <20180629112520.31358-2-berrange@redhat.com>
In-Reply-To: <20180629112520.31358-1-berrange@redhat.com>
References: <20180629112520.31358-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] util: remove redundant include of glib.h
 and add osdep.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

Code must only ever include glib.h indirectly via the glib-compat.h
header file, because we will need some macros set before glib.h is
pulled in. Adding extra includes of glib.h will (soon) cause compile
failures such as:

In file included from /home/berrange/src/virt/qemu/include/qemu/osdep.h:1=
07,
                 from /home/berrange/src/virt/qemu/include/qemu/iova-tree=
.h:26,
                 from util/iova-tree.c:13:
/home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_VERSI=
ON_MIN_REQUIRED" redefined [-Werror]
 #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40

In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
                 from /usr/include/glib-2.0/glib/galloca.h:32,
                 from /usr/include/glib-2.0/glib.h:30,
                 from util/iova-tree.c:12:
/usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the locati=
on of the previous definition
 # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)

Furthermore, the osdep.h include should always be done directly from the
.c file rather than indirectly via any .h file.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/qemu/iova-tree.h | 1 -
 util/iova-tree.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index b061932097..b66cf93c4b 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -23,7 +23,6 @@
  * for the thread safety issue.
  */
=20
-#include "qemu/osdep.h"
 #include "exec/memory.h"
 #include "exec/hwaddr.h"
=20
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 2d9cebfc89..7990692cbd 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -9,7 +9,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  */
=20
-#include <glib.h>
+#include "qemu/osdep.h"
 #include "qemu/iova-tree.h"
=20
 struct IOVATree {
--=20
2.17.1
