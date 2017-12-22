Received: from eggs.gnu.org ([2001:4830:134:3::10]:47283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNe2-0006CY-6B
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNdz-0002lX-Sm
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSNdz-0002l8-K9
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2D10C045741
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 13:45:46 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 22 Dec 2017 13:45:20 +0000
Message-Id: <20171222134527.14467-2-berrange@redhat.com>
In-Reply-To: <20171222134527.14467-1-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/8] cutils: add qemu_strtoi & qemu_strtoui
 parsers for int/unsigned int types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

There are qemu_strtoNN functions for various sized integers. This adds two
more for plain int & unsigned int types, with suitable range checking.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/qemu/cutils.h |   4 +
 tests/test-cutils.c   | 653 ++++++++++++++++++++++++++++++++++++++++++++++++++
 util/cutils.c         | 104 ++++++++
 3 files changed, 761 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index f0878eaafa..a663340b23 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -126,6 +126,10 @@ time_t mktimegm(struct tm *tm);
 int qemu_fdatasync(int fd);
 int fcntl_setfl(int fd, int flag);
 int qemu_parse_fd(const char *param);
+int qemu_strtoi(const char *nptr, const char **endptr, int base,
+                int *result);
+int qemu_strtoui(const char *nptr, const char **endptr, int base,
+                 unsigned int *result);
 int qemu_strtol(const char *nptr, const char **endptr, int base,
                 long *result);
 int qemu_strtoul(const char *nptr, const char **endptr, int base,
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index f64a49b7fb..0b2b5d417b 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -223,6 +223,579 @@ static void test_parse_uint_full_correct(void)
     g_assert_cmpint(i, ==, 123);
 }
 
+static void test_qemu_strtoi_correct(void)
+{
+    const char *str = "12345 foo";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 12345);
+    g_assert(endptr == str + 5);
+}
+
+static void test_qemu_strtoi_null(void)
+{
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(NULL, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == NULL);
+}
+
+static void test_qemu_strtoi_empty(void)
+{
+    const char *str = "";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtoi_whitespace(void)
+{
+    const char *str = "  \t  ";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtoi_invalid(void)
+{
+    const char *str = "   xxxx  \t abc";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtoi_trailing(void)
+{
+    const char *str = "123xxx";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 123);
+    g_assert(endptr == str + 3);
+}
+
+static void test_qemu_strtoi_octal(void)
+{
+    const char *str = "0123";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 8, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0123);
+    g_assert(endptr == str + strlen(str));
+
+    res = 999;
+    endptr = &f;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0123);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_decimal(void)
+{
+    const char *str = "0123";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 10, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 123);
+    g_assert(endptr == str + strlen(str));
+
+    str = "123";
+    res = 999;
+    endptr = &f;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 123);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_hex(void)
+{
+    const char *str = "0123";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 16, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x123);
+    g_assert(endptr == str + strlen(str));
+
+    str = "0x123";
+    res = 999;
+    endptr = &f;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x123);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_max(void)
+{
+    char *str = g_strdup_printf("%d", INT_MAX);
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert(endptr == str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoi_overflow(void)
+{
+    const char *str = "99999999999999999999999999999999999999999999";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_underflow(void)
+{
+    const char *str = "-99999999999999999999999999999999999999999999";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err  = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MIN);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_negative(void)
+{
+    const char *str = "  \t -321";
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, -321);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_full_correct(void)
+{
+    const char *str = "123";
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 123);
+}
+
+static void test_qemu_strtoi_full_null(void)
+{
+    char f = 'X';
+    const char *endptr = &f;
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(NULL, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == NULL);
+}
+
+static void test_qemu_strtoi_full_empty(void)
+{
+    const char *str = "";
+    int res = 999L;
+    int err;
+
+    err =  qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+}
+
+static void test_qemu_strtoi_full_negative(void)
+{
+    const char *str = " \t -321";
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, -321);
+}
+
+static void test_qemu_strtoi_full_trailing(void)
+{
+    const char *str = "123xxx";
+    int res;
+    int err;
+
+    err = qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+}
+
+static void test_qemu_strtoi_full_max(void)
+{
+    char *str = g_strdup_printf("%d", INT_MAX);
+    int res;
+    int err;
+
+    err = qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_free(str);
+}
+
+static void test_qemu_strtoui_correct(void)
+{
+    const char *str = "12345 foo";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 12345);
+    g_assert(endptr == str + 5);
+}
+
+static void test_qemu_strtoui_null(void)
+{
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(NULL, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == NULL);
+}
+
+static void test_qemu_strtoui_empty(void)
+{
+    const char *str = "";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtoui_whitespace(void)
+{
+    const char *str = "  \t  ";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtoui_invalid(void)
+{
+    const char *str = "   xxxx  \t abc";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtoui_trailing(void)
+{
+    const char *str = "123xxx";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 123);
+    g_assert(endptr == str + 3);
+}
+
+static void test_qemu_strtoui_octal(void)
+{
+    const char *str = "0123";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 8, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0123);
+    g_assert(endptr == str + strlen(str));
+
+    res = 999;
+    endptr = &f;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0123);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoui_decimal(void)
+{
+    const char *str = "0123";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 10, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 123);
+    g_assert(endptr == str + strlen(str));
+
+    str = "123";
+    res = 999;
+    endptr = &f;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 123);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoui_hex(void)
+{
+    const char *str = "0123";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 16, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmphex(res, ==, 0x123);
+    g_assert(endptr == str + strlen(str));
+
+    str = "0x123";
+    res = 999;
+    endptr = &f;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmphex(res, ==, 0x123);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoui_max(void)
+{
+    char *str = g_strdup_printf("%u", UINT_MAX);
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmphex(res, ==, UINT_MAX);
+    g_assert(endptr == str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoui_overflow(void)
+{
+    const char *str = "99999999999999999999999999999999999999999999";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmphex(res, ==, UINT_MAX);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoui_underflow(void)
+{
+    const char *str = "-99999999999999999999999999999999999999999999";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err  = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, (unsigned int)-1);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoui_negative(void)
+{
+    const char *str = "  \t -321";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, (unsigned int)-321);
+    g_assert(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoui_full_correct(void)
+{
+    const char *str = "123";
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 123);
+}
+
+static void test_qemu_strtoui_full_null(void)
+{
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(NULL, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+}
+
+static void test_qemu_strtoui_full_empty(void)
+{
+    const char *str = "";
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+}
+static void test_qemu_strtoui_full_negative(void)
+{
+    const char *str = " \t -321";
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, NULL, 0, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, (unsigned int)-321);
+}
+
+static void test_qemu_strtoui_full_trailing(void)
+{
+    const char *str = "123xxx";
+    unsigned int res;
+    int err;
+
+    err = qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+}
+
+static void test_qemu_strtoui_full_max(void)
+{
+    char *str = g_strdup_printf("%u", UINT_MAX);
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmphex(res, ==, UINT_MAX);
+    g_free(str);
+}
+
 static void test_qemu_strtol_correct(void)
 {
     const char *str = "12345 foo";
@@ -1612,6 +2185,86 @@ int main(int argc, char **argv)
     g_test_add_func("/cutils/parse_uint_full/correct",
                     test_parse_uint_full_correct);
 
+    /* qemu_strtoi() tests */
+    g_test_add_func("/cutils/qemu_strtoi/correct",
+                    test_qemu_strtoi_correct);
+    g_test_add_func("/cutils/qemu_strtoi/null",
+                    test_qemu_strtoi_null);
+    g_test_add_func("/cutils/qemu_strtoi/empty",
+                    test_qemu_strtoi_empty);
+    g_test_add_func("/cutils/qemu_strtoi/whitespace",
+                    test_qemu_strtoi_whitespace);
+    g_test_add_func("/cutils/qemu_strtoi/invalid",
+                    test_qemu_strtoi_invalid);
+    g_test_add_func("/cutils/qemu_strtoi/trailing",
+                    test_qemu_strtoi_trailing);
+    g_test_add_func("/cutils/qemu_strtoi/octal",
+                    test_qemu_strtoi_octal);
+    g_test_add_func("/cutils/qemu_strtoi/decimal",
+                    test_qemu_strtoi_decimal);
+    g_test_add_func("/cutils/qemu_strtoi/hex",
+                    test_qemu_strtoi_hex);
+    g_test_add_func("/cutils/qemu_strtoi/max",
+                    test_qemu_strtoi_max);
+    g_test_add_func("/cutils/qemu_strtoi/overflow",
+                    test_qemu_strtoi_overflow);
+    g_test_add_func("/cutils/qemu_strtoi/underflow",
+                    test_qemu_strtoi_underflow);
+    g_test_add_func("/cutils/qemu_strtoi/negative",
+                    test_qemu_strtoi_negative);
+    g_test_add_func("/cutils/qemu_strtoi_full/correct",
+                    test_qemu_strtoi_full_correct);
+    g_test_add_func("/cutils/qemu_strtoi_full/null",
+                    test_qemu_strtoi_full_null);
+    g_test_add_func("/cutils/qemu_strtoi_full/empty",
+                    test_qemu_strtoi_full_empty);
+    g_test_add_func("/cutils/qemu_strtoi_full/negative",
+                    test_qemu_strtoi_full_negative);
+    g_test_add_func("/cutils/qemu_strtoi_full/trailing",
+                    test_qemu_strtoi_full_trailing);
+    g_test_add_func("/cutils/qemu_strtoi_full/max",
+                    test_qemu_strtoi_full_max);
+
+    /* qemu_strtoui() tests */
+    g_test_add_func("/cutils/qemu_strtoui/correct",
+                    test_qemu_strtoui_correct);
+    g_test_add_func("/cutils/qemu_strtoui/null",
+                    test_qemu_strtoui_null);
+    g_test_add_func("/cutils/qemu_strtoui/empty",
+                    test_qemu_strtoui_empty);
+    g_test_add_func("/cutils/qemu_strtoui/whitespace",
+                    test_qemu_strtoui_whitespace);
+    g_test_add_func("/cutils/qemu_strtoui/invalid",
+                    test_qemu_strtoui_invalid);
+    g_test_add_func("/cutils/qemu_strtoui/trailing",
+                    test_qemu_strtoui_trailing);
+    g_test_add_func("/cutils/qemu_strtoui/octal",
+                    test_qemu_strtoui_octal);
+    g_test_add_func("/cutils/qemu_strtoui/decimal",
+                    test_qemu_strtoui_decimal);
+    g_test_add_func("/cutils/qemu_strtoui/hex",
+                    test_qemu_strtoui_hex);
+    g_test_add_func("/cutils/qemu_strtoui/max",
+                    test_qemu_strtoui_max);
+    g_test_add_func("/cutils/qemu_strtoui/overflow",
+                    test_qemu_strtoui_overflow);
+    g_test_add_func("/cutils/qemu_strtoui/underflow",
+                    test_qemu_strtoui_underflow);
+    g_test_add_func("/cutils/qemu_strtoui/negative",
+                    test_qemu_strtoui_negative);
+    g_test_add_func("/cutils/qemu_strtoui_full/correct",
+                    test_qemu_strtoui_full_correct);
+    g_test_add_func("/cutils/qemu_strtoui_full/null",
+                    test_qemu_strtoui_full_null);
+    g_test_add_func("/cutils/qemu_strtoui_full/empty",
+                    test_qemu_strtoui_full_empty);
+    g_test_add_func("/cutils/qemu_strtoui_full/negative",
+                    test_qemu_strtoui_full_negative);
+    g_test_add_func("/cutils/qemu_strtoui_full/trailing",
+                    test_qemu_strtoui_full_trailing);
+    g_test_add_func("/cutils/qemu_strtoui_full/max",
+                    test_qemu_strtoui_full_max);
+
     /* qemu_strtol() tests */
     g_test_add_func("/cutils/qemu_strtol/correct",
                     test_qemu_strtol_correct);
diff --git a/util/cutils.c b/util/cutils.c
index b33ede83d1..9f05b331d9 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -297,6 +297,110 @@ static int check_strtox_error(const char *nptr, char *ep,
     return -libc_errno;
 }
 
+/**
+ * Convert string @nptr to a long integer, and store it in @result.
+ *
+ * This is a wrapper around strtol() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtol() with differences
+ * noted below.
+ *
+ * @nptr may be null, and no conversion is performed then.
+ *
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
+ *
+ * If @endptr is null, and the string isn't fully converted, return
+ * -EINVAL.  This is the case when the pointer that would be stored in
+ * a non-null @endptr points to a character other than '\0'.
+ *
+ * If the conversion overflows @result, store INT_MAX in @result,
+ * and return -ERANGE.
+ *
+ * If the conversion underflows @result, store INT_MIN in @result,
+ * and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
+ */
+int qemu_strtoi(const char *nptr, const char **endptr, int base,
+                int *result)
+{
+    char *ep;
+    long lresult;
+
+    if (!nptr) {
+        if (endptr) {
+            *endptr = nptr;
+        }
+        return -EINVAL;
+    }
+
+    errno = 0;
+    lresult = strtol(nptr, &ep, base);
+    if (lresult < INT_MIN) {
+        *result = INT_MIN;
+    } else if (lresult > INT_MAX) {
+        *result = INT_MAX;
+    } else {
+        *result = lresult;
+    }
+    return check_strtox_error(nptr, ep, endptr, errno);
+}
+
+/**
+ * Convert string @nptr to an unsigned int, and store it in @result.
+ *
+ * This is a wrapper around strtoul() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtoul() with differences
+ * noted below.
+ *
+ * @nptr may be null, and no conversion is performed then.
+ *
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
+ *
+ * If @endptr is null, and the string isn't fully converted, return
+ * -EINVAL.  This is the case when the pointer that would be stored in
+ * a non-null @endptr points to a character other than '\0'.
+ *
+ * If the conversion overflows @result, store UINT_MAX in @result,
+ * and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
+ *
+ * Note that a number with a leading minus sign gets converted without
+ * the minus sign, checked for overflow (see above), then negated (in
+ * @result's type).  This is exactly how strtoul() works.
+ */
+int qemu_strtoui(const char *nptr, const char **endptr, int base,
+                 unsigned int *result)
+{
+    char *ep;
+    long lresult;
+
+    if (!nptr) {
+        if (endptr) {
+            *endptr = nptr;
+        }
+        return -EINVAL;
+    }
+
+    errno = 0;
+    lresult = strtol(nptr, &ep, base);
+    /* Windows returns 1 for negative out-of-range values.  */
+    if (errno == ERANGE) {
+        *result = -1;
+    } else {
+        if (lresult > UINT_MAX) {
+            *result = UINT_MAX;
+        } else if (lresult < INT_MIN) {
+            *result = UINT_MAX;
+        } else {
+            *result = lresult;
+        }
+    }
+    return check_strtox_error(nptr, ep, endptr, errno);
+}
+
 /**
  * Convert string @nptr to a long integer, and store it in @result.
  *
-- 
2.14.3
