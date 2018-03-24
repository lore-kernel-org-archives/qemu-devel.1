Received: from eggs.gnu.org ([208.118.235.92]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezoo4-0007o3-QU
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezon0-0005o8-Qk
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:26:24 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezon0-0005n9-Ky
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:18 -0400
Received: by mail-pl0-x242.google.com with SMTP id p9-v6so9440708pls.2
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:18 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:49 -0700
Message-Id: <20180324192455.12254-9-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 08/14] tests: ds-rtc test wday offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/ds-rtc-common.h       | 10 +++++++---
 tests/ds-rtc-current-test.c |  9 ++++++++-
 tests/ds-rtc-set-test.c     |  6 ++++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/ds-rtc-common.h b/tests/ds-rtc-common.h
index c8e6c2bc5b..633131c55f 100644
--- a/tests/ds-rtc-common.h
+++ b/tests/ds-rtc-common.h
@@ -20,7 +20,7 @@ static uint8_t addr;
 static bool use_century;
 
 /* input buffer must have at least 7 elements */
-static inline time_t rtc_parse(const uint8_t *buf)
+static inline time_t rtc_parse(const uint8_t *buf, unsigned *wday)
 {
     struct tm parts;
 
@@ -48,10 +48,14 @@ static inline time_t rtc_parse(const uint8_t *buf)
         parts.tm_year += 100u;
     }
 
+    if (wday) {
+        *wday = parts.tm_wday;
+    }
+
     return mktimegm(&parts);
 }
 
-static time_t rtc_gettime(void)
+static time_t rtc_gettime(unsigned *wday)
 {
     uint8_t buf[7];
 
@@ -61,7 +65,7 @@ static time_t rtc_gettime(void)
     /* read back current time registers */
     i2c_recv(i2c, addr, buf, 7);
 
-    return rtc_parse(buf);
+    return rtc_parse(buf, wday);
 }
 
 #endif /* DSRTCCOMMON_H */
diff --git a/tests/ds-rtc-current-test.c b/tests/ds-rtc-current-test.c
index 6acbbed9a6..7dc3202261 100644
--- a/tests/ds-rtc-current-test.c
+++ b/tests/ds-rtc-current-test.c
@@ -20,17 +20,24 @@
 static
 void test_rtc_current(void)
 {
+    struct tm tm_actual;
     time_t expected, actual;
     /* relax test to limit false positives when host may be overloaded.
      * Allow larger delta when running "-m quick"
      */
     time_t max_delta = g_test_slow() ? 1 : 30;
 
+    unsigned wday_expect;
+
     actual = time(NULL);
     /* new second may start here */
-    expected = rtc_gettime();
+    expected = rtc_gettime(&wday_expect);
+
+    gmtime_r(&actual, &tm_actual);
+
     g_assert_cmpuint(expected, <=, actual + max_delta);
     g_assert_cmpuint(expected, >=, actual);
+    g_assert_cmpuint(wday_expect, ==, tm_actual.tm_wday);
 }
 
 int main(int argc, char *argv[])
diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
index c48406ee2c..12aeb2580a 100644
--- a/tests/ds-rtc-set-test.c
+++ b/tests/ds-rtc-set-test.c
@@ -124,16 +124,18 @@ void test_rtc_set(const void *raw)
 
     const uint8_t *testtime = raw;
     time_t expected, actual;
+    unsigned wday_expect, wday_actual;
 
     /* skip address pointer and parse remainder */
-    expected = rtc_parse(&testtime[1]);
+    expected = rtc_parse(&testtime[1], &wday_expect);
 
     i2c_send(i2c, addr, testtime, 8);
     /* host may start new second here */
-    actual = rtc_gettime();
+    actual = rtc_gettime(&wday_actual);
 
     g_assert_cmpuint(expected, <=, actual);
     g_assert_cmpuint(expected + max_delta, >=, actual);
+    g_assert_cmpuint(wday_expect, ==, wday_actual);
 }
 
 int main(int argc, char *argv[])
-- 
2.11.0
