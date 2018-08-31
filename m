Received: from eggs.gnu.org ([2001:4830:134:3::10]:45907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgp8-0002b9-Hd
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgp5-0001af-BU
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:42 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:48001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvgp5-0001aA-58
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:39 -0400
Received: from player168.ha.ovh.net (unknown [10.109.146.5])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id EDC74127225
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 12:38:37 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 12:38:08 +0200
Message-Id: <20180831103816.13479-2-clg@kaod.org>
In-Reply-To: <20180831103816.13479-1-clg@kaod.org>
References: <20180831103816.13479-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/11] aspeed/timer: fix compile breakage with
 clang 3.4.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

In file included from /home/thuth/devel/qemu/hw/timer/aspeed_timer.c:16:
/home/thuth/devel/qemu/include/hw/misc/aspeed_scu.h:37:3: error:
redefinition of typedef 'AspeedSCUState' is a C11 feature
      [-Werror,-Wtypedef-redefinition]
} AspeedSCUState;
  ^
/home/thuth/devel/qemu/include/hw/timer/aspeed_timer.h:27:31: note:
previous definition is here
typedef struct AspeedSCUState AspeedSCUState;

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/timer/aspeed_timer.h | 3 +--
 hw/timer/aspeed_timer.c         | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
index 040a08873432..1fb949e16710 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -23,8 +23,7 @@
 #define ASPEED_TIMER_H
=20
 #include "qemu/timer.h"
-
-typedef struct AspeedSCUState AspeedSCUState;
+#include "hw/misc/aspeed_scu.h"
=20
 #define ASPEED_TIMER(obj) \
     OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER);
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 5e3f51b66b43..54b400b94aa9 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -13,7 +13,6 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/timer/aspeed_timer.h"
-#include "hw/misc/aspeed_scu.h"
 #include "qemu-common.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
--=20
2.17.1
