Received: from eggs.gnu.org ([2001:4830:134:3::10]:46019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbrM8-0003eY-CK
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbrM5-0004wD-9f
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:50:48 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:36317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fbrM5-0004vv-3C
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:50:45 -0400
Received: by mail-pf0-x230.google.com with SMTP id u16-v6so10813036pfh.3
	for <qemu-devel@nongnu.org>; Sat, 07 Jul 2018 10:50:44 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat,  7 Jul 2018 10:50:39 -0700
Message-Id: <20180707175039.23522-1-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-8-mdavidsaver@gmail.com>
References: <20180705182001.16537-8-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH v2 07/14] tests: ds-rtc test wday offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/ds-rtc-common.h       | 10 +++++++---
 tests/ds-rtc-current-test.c |  9 ++++++++-
 tests/ds-rtc-set-test.c     |  6 ++++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/ds-rtc-common.h b/tests/ds-rtc-common.h
index 5bc7ab32a6..782ea60453 100644
--- a/tests/ds-rtc-common.h
+++ b/tests/ds-rtc-common.h
@@ -20,7 +20,7 @@ static uint8_t addr;
 static bool use_century;
 
 /* input buffer must have at least 7 elements */
-static inline time_t rtc_parse(const uint8_t *buf, int *mmode)
+static inline time_t rtc_parse(const uint8_t *buf, unsigned *wday, int *mmode)
 {
     struct tm parts;
 
@@ -51,10 +51,14 @@ static inline time_t rtc_parse(const uint8_t *buf, int *mmode)
         parts.tm_year += 100u;
     }
 
+    if (wday) {
+        *wday = parts.tm_wday;
+    }
+
     return mktimegm(&parts);
 }
 
-static time_t rtc_gettime(int *mmode)
+static time_t rtc_gettime(unsigned *wday, int *mmode)
 {
     uint8_t buf[7];
 
@@ -64,7 +68,7 @@ static time_t rtc_gettime(int *mmode)
     /* read back current time registers */
     i2c_recv(i2c, addr, buf, 7);
 
-    return rtc_parse(buf, mmode);
+    return rtc_parse(buf, wday, mmode);
 }
 
 #endif /* DSRTCCOMMON_H */
diff --git a/tests/ds-rtc-current-test.c b/tests/ds-rtc-current-test.c
index 3c15482a9d..08d8411671 100644
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
-    expected = rtc_gettime(NULL);
+    expected = rtc_gettime(&wday_expect, NULL);
+
+    gmtime_r(&actual, &tm_actual);
+
     g_assert_cmpuint(expected, <=, actual + max_delta);
     g_assert_cmpuint(expected, >=, actual);
+    g_assert_cmpuint(wday_expect, ==, tm_actual.tm_wday);
 }
 
 int main(int argc, char *argv[])
diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
index 3a742e897f..1004470931 100644
--- a/tests/ds-rtc-set-test.c
+++ b/tests/ds-rtc-set-test.c
@@ -124,17 +124,19 @@ void test_rtc_set(const void *raw)
 
     const uint8_t *testtime = raw;
     time_t expected, actual;
+    unsigned wday_expect, wday_actual;
     int mode_expect, mode_actual;
 
     /* skip address pointer and parse remainder */
-    expected = rtc_parse(&testtime[1], &mode_expect);
+    expected = rtc_parse(&testtime[1], &wday_expect, &mode_expect);
 
     i2c_send(i2c, addr, testtime, 8);
     /* host may start new second here */
-    actual = rtc_gettime(&mode_actual);
+    actual = rtc_gettime(&wday_actual, &mode_actual);
 
     g_assert_cmpuint(expected, <=, actual);
     g_assert_cmpuint(expected + max_delta, >=, actual);
+    g_assert_cmpuint(wday_expect, ==, wday_actual);
     g_assert_cmpint(mode_expect, ==, mode_actual);
 }
 
-- 
2.11.0
