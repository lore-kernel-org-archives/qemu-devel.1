Received: from eggs.gnu.org ([2001:4830:134:3::10]:45809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbrKh-0002qP-Vq
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbrKe-0003er-Un
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:49:20 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:44422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fbrKe-0003dS-LF
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:49:16 -0400
Received: by mail-pl0-x233.google.com with SMTP id m16-v6so4236538pls.11
	for <qemu-devel@nongnu.org>; Sat, 07 Jul 2018 10:49:16 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat,  7 Jul 2018 10:49:09 -0700
Message-Id: <20180707174909.23451-1-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-7-mdavidsaver@gmail.com>
References: <20180705182001.16537-7-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH v2 06/14] tests: ds-rtc test 12 hour mode
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
 tests/ds-rtc-common.h       |  9 ++++---
 tests/ds-rtc-current-test.c |  2 +-
 tests/ds-rtc-set-test.c     | 58 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/tests/ds-rtc-common.h b/tests/ds-rtc-common.h
index c8e6c2bc5b..5bc7ab32a6 100644
--- a/tests/ds-rtc-common.h
+++ b/tests/ds-rtc-common.h
@@ -20,12 +20,15 @@ static uint8_t addr;
 static bool use_century;
 
 /* input buffer must have at least 7 elements */
-static inline time_t rtc_parse(const uint8_t *buf)
+static inline time_t rtc_parse(const uint8_t *buf, int *mmode)
 {
     struct tm parts;
 
     parts.tm_sec = from_bcd(buf[0]);
     parts.tm_min = from_bcd(buf[1]);
+    if (mmode) {
+        *mmode = !!(buf[2] & 0x40);
+    }
     if (buf[2] & 0x40) {
         /* 12 hour */
         /* HOUR register is 1-12. */
@@ -51,7 +54,7 @@ static inline time_t rtc_parse(const uint8_t *buf)
     return mktimegm(&parts);
 }
 
-static time_t rtc_gettime(void)
+static time_t rtc_gettime(int *mmode)
 {
     uint8_t buf[7];
 
@@ -61,7 +64,7 @@ static time_t rtc_gettime(void)
     /* read back current time registers */
     i2c_recv(i2c, addr, buf, 7);
 
-    return rtc_parse(buf);
+    return rtc_parse(buf, mmode);
 }
 
 #endif /* DSRTCCOMMON_H */
diff --git a/tests/ds-rtc-current-test.c b/tests/ds-rtc-current-test.c
index 6acbbed9a6..3c15482a9d 100644
--- a/tests/ds-rtc-current-test.c
+++ b/tests/ds-rtc-current-test.c
@@ -28,7 +28,7 @@ void test_rtc_current(void)
 
     actual = time(NULL);
     /* new second may start here */
-    expected = rtc_gettime();
+    expected = rtc_gettime(NULL);
     g_assert_cmpuint(expected, <=, actual + max_delta);
     g_assert_cmpuint(expected, >=, actual);
 }
diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
index 35e1a36281..3a742e897f 100644
--- a/tests/ds-rtc-set-test.c
+++ b/tests/ds-rtc-set-test.c
@@ -29,6 +29,18 @@ static uint8_t test_time_24_12am[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_12am[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 00:30:53 +0000 */
+    0x53,
+    0x30,
+    0x52, /* 12 AM in 12 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 static uint8_t test_time_24_6am[8] = {
     0, /* address */
     /* Wed, 22 Nov 2017 06:30:53 +0000 */
@@ -41,6 +53,18 @@ static uint8_t test_time_24_6am[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_6am[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 06:30:53 +0000 */
+    0x53,
+    0x30,
+    0x46, /* 6 AM in 12 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 static uint8_t test_time_24_12pm[8] = {
     0, /* address */
     /* Wed, 22 Nov 2017 12:30:53 +0000 */
@@ -53,6 +77,18 @@ static uint8_t test_time_24_12pm[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_12pm[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 12:30:53 +0000 */
+    0x53,
+    0x30,
+    0x72, /* 12 PM in 24 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 static uint8_t test_time_24_6pm[8] = {
     0, /* address */
     /* Wed, 22 Nov 2017 18:30:53 +0000 */
@@ -65,6 +101,18 @@ static uint8_t test_time_24_6pm[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_6pm[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 18:30:53 +0000 */
+    0x53,
+    0x30,
+    0x66, /* 6 PM in 12 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 /* write in and read back known time */
 static
 void test_rtc_set(const void *raw)
@@ -76,16 +124,18 @@ void test_rtc_set(const void *raw)
 
     const uint8_t *testtime = raw;
     time_t expected, actual;
+    int mode_expect, mode_actual;
 
     /* skip address pointer and parse remainder */
-    expected = rtc_parse(&testtime[1]);
+    expected = rtc_parse(&testtime[1], &mode_expect);
 
     i2c_send(i2c, addr, testtime, 8);
     /* host may start new second here */
-    actual = rtc_gettime();
+    actual = rtc_gettime(&mode_actual);
 
     g_assert_cmpuint(expected, <=, actual);
     g_assert_cmpuint(expected + max_delta, >=, actual);
+    g_assert_cmpint(mode_expect, ==, mode_actual);
 }
 
 int main(int argc, char *argv[])
@@ -108,6 +158,10 @@ int main(int argc, char *argv[])
     qtest_add_data_func("/ds-rtc-i2c/set24_6am", test_time_24_6am, test_rtc_set);
     qtest_add_data_func("/ds-rtc-i2c/set24_12pm", test_time_24_12pm, test_rtc_set);
     qtest_add_data_func("/ds-rtc-i2c/set24_6pm", test_time_24_6pm, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_12am", test_time_12_12am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_6am", test_time_12_6am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_12pm", test_time_12_12pm, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_6pm", test_time_12_6pm, test_rtc_set);
 
     ret = g_test_run();
 
-- 
2.11.0
