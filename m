Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ehDXK-0004rI-DZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ehDXB-0004wm-72
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:00:14 -0500
Received: from [45.249.212.32] (port=43922 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1ehDXA-0004qY-RT
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:00:05 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 1 Feb 2018 19:59:32 +0800
Message-ID: <1517486372-22868-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vl: fix possible int overflow for
 qemu_timedate_diff()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, shenghualong <shenghualong@huawei.com>, Gonglei <arei.gonglei@huawei.com>

From: shenghualong <shenghualong@huawei.com>

When the Windows guest users set the time to year 2099,
the return value of qemu_timedate_diff() will overflow
with variable clock mode as below format:

 <clock offset='variable' adjustment='-1201568405' basis='utc'>

Let's change the return value of qemu_timedate_diff() from
int to time_t to fix the possible overflow problem.

Signed-off-by: shenghualong <shenghualong@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 include/qemu-common.h | 2 +-
 vl.c                  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 05319b9..6fb80aa 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -33,7 +33,7 @@ int qemu_main(int argc, char **argv, char **envp);
 #endif
 
 void qemu_get_timedate(struct tm *tm, int offset);
-int qemu_timedate_diff(struct tm *tm);
+time_t qemu_timedate_diff(struct tm *tm);
 
 #define qemu_isalnum(c)		isalnum((unsigned char)(c))
 #define qemu_isalpha(c)		isalpha((unsigned char)(c))
diff --git a/vl.c b/vl.c
index e517a8d..9d225da 100644
--- a/vl.c
+++ b/vl.c
@@ -146,7 +146,7 @@ int nb_nics;
 NICInfo nd_table[MAX_NICS];
 int autostart;
 static int rtc_utc = 1;
-static int rtc_date_offset = -1; /* -1 means no change */
+static time_t rtc_date_offset = -1; /* -1 means no change */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static int full_screen = 0;
@@ -812,7 +812,7 @@ void qemu_get_timedate(struct tm *tm, int offset)
     }
 }
 
-int qemu_timedate_diff(struct tm *tm)
+time_t qemu_timedate_diff(struct tm *tm)
 {
     time_t seconds;
 
-- 
1.8.3.1
