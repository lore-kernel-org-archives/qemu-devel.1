Received: from eggs.gnu.org ([2001:4830:134:3::10]:33014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gD2V4-0004XR-9f
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gD2V2-0000AA-MG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:13:42 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:38440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gD2V1-00005Z-6k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:13:40 -0400
Received: by mail-lf1-x141.google.com with SMTP id x24-v6so6009464lfe.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 00:13:39 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 18 Oct 2018 13:12:55 +0600
Message-Id: <1fc12c77e8b7115d3842919a8b586d9cbe4efca6.1539846575.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v3 4/4] vl,
 qapi: offset calculation in RTC_CHANGE event reverted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Return value of qemu_timedate_diff(), used for calculation offset in
QAPI 'RTC_CHANGE' event, restored to keep compatibility. Since it
wasn't documented that difference is relative to host clock
advancement, this change also adds important note to 'RTC_CHANGE'
event description to highlight established implementation specifics.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 qapi/misc.json |  3 ++-
 vl.c           | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index ada9af5..d0f5381 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3070,7 +3070,8 @@
 # Emitted when the guest changes the RTC time.
 #
 # @offset: offset between base RTC clock (as specified by -rtc base), and
-#          new RTC clock value
+#          new RTC clock value. Note that value will be different depending
+#          on clock chosen to drive RTC (specified by -rtc clock).
 #
 # Note: This event is rate-limited.
 #
diff --git a/vl.c b/vl.c
index 78a8a68..c350aba 100644
--- a/vl.c
+++ b/vl.c
@@ -788,10 +788,10 @@ void qemu_system_vmstop_request(RunState state)
 
 /***********************************************************/
 /* RTC reference time/date access */
-static time_t qemu_ref_timedate(void)
+static time_t qemu_ref_timedate(QEMUClockType clock)
 {
-    time_t value = qemu_clock_get_ms(rtc_clock) / 1000;
-    switch (rtc_clock) {
+    time_t value = qemu_clock_get_ms(clock) / 1000;
+    switch (clock) {
     case QEMU_CLOCK_REALTIME:
         value -= rtc_realtime_clock_offset;
         /* no break */
@@ -811,7 +811,7 @@ static time_t qemu_ref_timedate(void)
 
 void qemu_get_timedate(struct tm *tm, int offset)
 {
-    time_t ti = qemu_ref_timedate();
+    time_t ti = qemu_ref_timedate(rtc_clock);
 
     ti += offset;
 
@@ -849,7 +849,7 @@ int qemu_timedate_diff(struct tm *tm)
         break;
     }
 
-    return seconds - qemu_ref_timedate();
+    return seconds - qemu_ref_timedate(QEMU_CLOCK_HOST);
 }
 
 static void configure_rtc_base_datetime(const char *startdate)
-- 
2.7.4
