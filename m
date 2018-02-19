Received: from eggs.gnu.org ([2001:4830:134:3::10]:49537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgf-0007fD-Kz
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encge-0000mD-Nd
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:21 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:43958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1encge-0000lG-IT
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:20 -0500
Received: by mail-io0-x241.google.com with SMTP id l12so4181321ioc.10
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 20:04:20 -0800 (PST)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 18 Feb 2018 20:03:41 -0800
Message-Id: <20180219040342.12686-5-mdavidsaver@gmail.com>
In-Reply-To: <20180219040342.12686-1-mdavidsaver@gmail.com>
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 4/5] tests: ds-rtc-i2c-test test 12 hour mode
 and DoW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Brook <paul@codesourcery.com>, Peter Maydell <peter.maydell@linaro.org>, Antoine Mathys <barsamin@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Test time set+get in 12 hour mode.
Also test handling of day of week
offset.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/ds-rtc-i2c-test.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tests/ds-rtc-i2c-test.c b/tests/ds-rtc-i2c-test.c
index 464eb08558..226ac1399e 100644
--- a/tests/ds-rtc-i2c-test.c
+++ b/tests/ds-rtc-i2c-test.c
@@ -92,6 +92,18 @@ static uint8_t test_time_24_12am[8] = {
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
@@ -104,6 +116,18 @@ static uint8_t test_time_24_6am[8] = {
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
@@ -116,6 +140,18 @@ static uint8_t test_time_24_12pm[8] = {
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
@@ -128,6 +164,18 @@ static uint8_t test_time_24_6pm[8] = {
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
@@ -151,7 +199,7 @@ void test_rtc_set(const void *raw)
     g_assert_cmpuint(testtime[1], ==, buf[0]); /* SEC */
     g_assert_cmpuint(testtime[2], ==, buf[1]); /* MIN */
     g_assert_cmpuint(testtime[3], ==, buf[2]); /* HOUR */
-    /* skip comparing Day of Week.  Not handled correctly */
+    g_assert_cmpuint(testtime[4], ==, buf[3]); /* DoW */
     g_assert_cmpuint(testtime[5], ==, buf[4]); /* DoM */
     if (use_century) {
         g_assert_cmpuint(testtime[6], ==, buf[5]); /* MON+century */
@@ -183,6 +231,10 @@ int main(int argc, char *argv[])
     qtest_add_data_func("/ds-rtc-i2c/set24_6am", test_time_24_6am, test_rtc_set);
     qtest_add_data_func("/ds-rtc-i2c/set24_12pm", test_time_24_12pm, test_rtc_set);
     qtest_add_data_func("/ds-rtc-i2c/set24_6pm", test_time_24_6pm, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_12am", test_time_12_12am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_6am", test_time_12_6am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_12pm", test_time_12_12pm, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_6pm", test_time_12_6pm, test_rtc_set);
     qtest_add_func("/ds-rtc-i2c/current", test_rtc_current);
 
     ret = g_test_run();
-- 
2.11.0
