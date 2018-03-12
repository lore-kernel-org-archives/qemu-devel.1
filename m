Received: from eggs.gnu.org ([2001:4830:134:3::10]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMtq-00057I-OL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMtm-0007kh-RD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:49:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evMtm-0007jN-Jr
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:49:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D20134023150
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 12:49:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 12 Mar 2018 12:49:32 +0000
Message-Id: <20180312124939.20562-3-berrange@redhat.com>
In-Reply-To: <20180312124939.20562-1-berrange@redhat.com>
References: <20180312124939.20562-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/9] cutils: add qemu_strtoi & qemu_strtoui
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
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

There are qemu_strtoNN functions for various sized integers. This adds tw=
o
more for plain int & unsigned int types, with suitable range checking.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/qemu/cutils.h |   4 +
 tests/test-cutils.c   | 657 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 util/cutils.c         | 108 +++++++++
 3 files changed, 769 insertions(+)

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
index f64a49b7fb..64a489c2e9 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -223,6 +223,583 @@ static void test_parse_uint_full_correct(void)
     g_assert_cmpint(i, =3D=3D, 123);
 }
=20
+static void test_qemu_strtoi_correct(void)
+{
+    const char *str =3D "12345 foo";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 12345);
+    g_assert(endptr =3D=3D str + 5);
+}
+
+static void test_qemu_strtoi_null(void)
+{
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(NULL, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D NULL);
+}
+
+static void test_qemu_strtoi_empty(void)
+{
+    const char *str =3D "";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
+}
+
+static void test_qemu_strtoi_whitespace(void)
+{
+    const char *str =3D "  \t  ";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
+}
+
+static void test_qemu_strtoi_invalid(void)
+{
+    const char *str =3D "   xxxx  \t abc";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
+}
+
+static void test_qemu_strtoi_trailing(void)
+{
+    const char *str =3D "123xxx";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 123);
+    g_assert(endptr =3D=3D str + 3);
+}
+
+static void test_qemu_strtoi_octal(void)
+{
+    const char *str =3D "0123";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 8, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 0123);
+    g_assert(endptr =3D=3D str + strlen(str));
+
+    res =3D 999;
+    endptr =3D &f;
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 0123);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoi_decimal(void)
+{
+    const char *str =3D "0123";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 10, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 123);
+    g_assert(endptr =3D=3D str + strlen(str));
+
+    str =3D "123";
+    res =3D 999;
+    endptr =3D &f;
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 123);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoi_hex(void)
+{
+    const char *str =3D "0123";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 16, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 0x123);
+    g_assert(endptr =3D=3D str + strlen(str));
+
+    str =3D "0x123";
+    res =3D 999;
+    endptr =3D &f;
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 0x123);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoi_max(void)
+{
+    char *str =3D g_strdup_printf("%d", INT_MAX);
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, INT_MAX);
+    g_assert(endptr =3D=3D str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoi_overflow(void)
+{
+    char *str =3D g_strdup_printf("%lld", (long long)INT_MAX + 1ll);
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -ERANGE);
+    g_assert_cmpint(res, =3D=3D, INT_MAX);
+    g_assert(endptr =3D=3D str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoi_underflow(void)
+{
+    char *str =3D g_strdup_printf("%lld", (long long)INT_MIN - 1ll);
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err  =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -ERANGE);
+    g_assert_cmpint(res, =3D=3D, INT_MIN);
+    g_assert(endptr =3D=3D str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoi_negative(void)
+{
+    const char *str =3D "  \t -321";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, -321);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoi_full_correct(void)
+{
+    const char *str =3D "123";
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, 123);
+}
+
+static void test_qemu_strtoi_full_null(void)
+{
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(NULL, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D NULL);
+}
+
+static void test_qemu_strtoi_full_empty(void)
+{
+    const char *str =3D "";
+    int res =3D 999L;
+    int err;
+
+    err =3D  qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+}
+
+static void test_qemu_strtoi_full_negative(void)
+{
+    const char *str =3D " \t -321";
+    int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, -321);
+}
+
+static void test_qemu_strtoi_full_trailing(void)
+{
+    const char *str =3D "123xxx";
+    int res;
+    int err;
+
+    err =3D qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+}
+
+static void test_qemu_strtoi_full_max(void)
+{
+    char *str =3D g_strdup_printf("%d", INT_MAX);
+    int res;
+    int err;
+
+    err =3D qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpint(res, =3D=3D, INT_MAX);
+    g_free(str);
+}
+
+static void test_qemu_strtoui_correct(void)
+{
+    const char *str =3D "12345 foo";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, 12345);
+    g_assert(endptr =3D=3D str + 5);
+}
+
+static void test_qemu_strtoui_null(void)
+{
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(NULL, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D NULL);
+}
+
+static void test_qemu_strtoui_empty(void)
+{
+    const char *str =3D "";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
+}
+
+static void test_qemu_strtoui_whitespace(void)
+{
+    const char *str =3D "  \t  ";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
+}
+
+static void test_qemu_strtoui_invalid(void)
+{
+    const char *str =3D "   xxxx  \t abc";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
+}
+
+static void test_qemu_strtoui_trailing(void)
+{
+    const char *str =3D "123xxx";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, 123);
+    g_assert(endptr =3D=3D str + 3);
+}
+
+static void test_qemu_strtoui_octal(void)
+{
+    const char *str =3D "0123";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 8, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, 0123);
+    g_assert(endptr =3D=3D str + strlen(str));
+
+    res =3D 999;
+    endptr =3D &f;
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, 0123);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoui_decimal(void)
+{
+    const char *str =3D "0123";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 10, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, 123);
+    g_assert(endptr =3D=3D str + strlen(str));
+
+    str =3D "123";
+    res =3D 999;
+    endptr =3D &f;
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, 123);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoui_hex(void)
+{
+    const char *str =3D "0123";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 16, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmphex(res, =3D=3D, 0x123);
+    g_assert(endptr =3D=3D str + strlen(str));
+
+    str =3D "0x123";
+    res =3D 999;
+    endptr =3D &f;
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmphex(res, =3D=3D, 0x123);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoui_max(void)
+{
+    char *str =3D g_strdup_printf("%u", UINT_MAX);
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmphex(res, =3D=3D, UINT_MAX);
+    g_assert(endptr =3D=3D str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoui_overflow(void)
+{
+    char *str =3D g_strdup_printf("%lld", (long long)UINT_MAX + 1ll);
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -ERANGE);
+    g_assert_cmphex(res, =3D=3D, UINT_MAX);
+    g_assert(endptr =3D=3D str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoui_underflow(void)
+{
+    char *str =3D g_strdup_printf("%lld", (long long)INT_MIN - 1ll);
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err  =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -ERANGE);
+    g_assert_cmpuint(res, =3D=3D, (unsigned int)-1);
+    g_assert(endptr =3D=3D str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoui_negative(void)
+{
+    const char *str =3D "  \t -321";
+    char f =3D 'X';
+    const char *endptr =3D &f;
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, (unsigned int)-321);
+    g_assert(endptr =3D=3D str + strlen(str));
+}
+
+static void test_qemu_strtoui_full_correct(void)
+{
+    const char *str =3D "123";
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, 123);
+}
+
+static void test_qemu_strtoui_full_null(void)
+{
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(NULL, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+}
+
+static void test_qemu_strtoui_full_empty(void)
+{
+    const char *str =3D "";
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+}
+static void test_qemu_strtoui_full_negative(void)
+{
+    const char *str =3D " \t -321";
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, NULL, 0, &res);
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmpuint(res, =3D=3D, (unsigned int)-321);
+}
+
+static void test_qemu_strtoui_full_trailing(void)
+{
+    const char *str =3D "123xxx";
+    unsigned int res;
+    int err;
+
+    err =3D qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, -EINVAL);
+}
+
+static void test_qemu_strtoui_full_max(void)
+{
+    char *str =3D g_strdup_printf("%u", UINT_MAX);
+    unsigned int res =3D 999;
+    int err;
+
+    err =3D qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, =3D=3D, 0);
+    g_assert_cmphex(res, =3D=3D, UINT_MAX);
+    g_free(str);
+}
+
 static void test_qemu_strtol_correct(void)
 {
     const char *str =3D "12345 foo";
@@ -1612,6 +2189,86 @@ int main(int argc, char **argv)
     g_test_add_func("/cutils/parse_uint_full/correct",
                     test_parse_uint_full_correct);
=20
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
index b33ede83d1..774d5f7362 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -297,6 +297,114 @@ static int check_strtox_error(const char *nptr, cha=
r *ep,
     return -libc_errno;
 }
=20
+/**
+ * Convert string @nptr to an integer, and store it in @result.
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
+            *endptr =3D nptr;
+        }
+        return -EINVAL;
+    }
+
+    errno =3D 0;
+    lresult =3D strtol(nptr, &ep, base);
+    if (lresult < INT_MIN) {
+        *result =3D INT_MIN;
+        errno =3D ERANGE;
+    } else if (lresult > INT_MAX) {
+        *result =3D INT_MAX;
+        errno =3D ERANGE;
+    } else {
+        *result =3D lresult;
+    }
+    return check_strtox_error(nptr, ep, endptr, errno);
+}
+
+/**
+ * Convert string @nptr to an unsigned integer, and store it in @result.
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
+            *endptr =3D nptr;
+        }
+        return -EINVAL;
+    }
+
+    errno =3D 0;
+    lresult =3D strtoul(nptr, &ep, base);
+    /* Windows returns 1 for negative out-of-range values.  */
+    if (errno =3D=3D ERANGE) {
+        *result =3D -1;
+    } else {
+        if (lresult > UINT_MAX) {
+            *result =3D UINT_MAX;
+            errno =3D ERANGE;
+        } else if (lresult < INT_MIN) {
+            *result =3D UINT_MAX;
+            errno =3D ERANGE;
+        } else {
+            *result =3D lresult;
+        }
+    }
+    return check_strtox_error(nptr, ep, endptr, errno);
+}
+
 /**
  * Convert string @nptr to a long integer, and store it in @result.
  *
--=20
2.14.3
