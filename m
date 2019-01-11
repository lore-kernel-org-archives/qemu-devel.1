Received: from eggs.gnu.org ([209.51.188.92]:38557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ghtVP-0008TN-Cm
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ghtVN-0006fJ-PQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ghtVN-0006ek-IP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:33 -0500
Date: Fri, 11 Jan 2019 15:22:51 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20190107103426.2669-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1901111453590.12783@xnncv>
References: <20190107103426.2669-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] qga: check length of command-line &
 environment variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, niuguoxiang <niuguoxiang@huawei.com>

+-- On Mon, 7 Jan 2019, P J P wrote --+
| Qemu guest agent while executing user commands does not seem to
| check length of argument list and/or environment variables passed.
| It may lead to integer overflow or infinite loop issues. Add check
| to avoid it.
| 
| -    size_t str_size = 1;
| +    size_t str_size = 1, args_max;
|  
| +    args_max = sysconf(_SC_ARG_MAX);

Looks like sysconf()/_SC_ARG_MAX declarations aren't available. Is it okay to 
include header <unistd.h> ?

===
diff --git a/qga/commands.c b/qga/commands.c
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -18,6 +18,7 @@
 #include "qemu/atomic.h"
+#include <unistd.h>
===

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
