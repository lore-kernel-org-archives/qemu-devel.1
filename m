Received: from eggs.gnu.org ([2001:4830:134:3::10]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfItH-0001Es-V8
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfItE-0008Dp-Gb
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:14:27 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfItE-0008De-9c
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:14:24 -0500
Received: by mail-qk0-x244.google.com with SMTP id s186so4463168qkb.1
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 20:14:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-7-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f32270d-c853-7db4-1fa9-f7eb64872977@amsat.org>
Date: Sun, 19 Feb 2017 01:14:19 -0300
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/24] util/cutils: Rename qemu_strtoll(),
 qemu_strtoull()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 02/14/2017 07:25 AM, Markus Armbruster wrote:
> The name qemu_strtoll() suggests conversion to long long, but it
> actually converts to int64_t.  Rename to qemu_strtoi64().
>
> The name qemu_strtoull() suggests conversion to unsigned long long,
> but it actually converts to uint64_t.  Rename to qemu_strtou64().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qemu/cutils.h |   6 +-
>  qobject/qdict.c       |   2 +-
>  qtest.c               |  34 ++---
>  tests/test-cutils.c   | 366 +++++++++++++++++++++++++++-----------------------
>  util/cutils.c         |   4 +-
>  util/log.c            |   4 +-
>  6 files changed, 224 insertions(+), 192 deletions(-)
>
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 8033929..f922223 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -130,9 +130,9 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
>                  long *result);
>  int qemu_strtoul(const char *nptr, const char **endptr, int base,
>                   unsigned long *result);
> -int qemu_strtoll(const char *nptr, const char **endptr, int base,
> -                 int64_t *result);
> -int qemu_strtoull(const char *nptr, const char **endptr, int base,
> +int qemu_strtoi64(const char *nptr, const char **endptr, int base,
> +                  int64_t *result);
> +int qemu_strtou64(const char *nptr, const char **endptr, int base,
>                    uint64_t *result);
>
>  int parse_uint(const char *s, unsigned long long *value, char **endptr,
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 197b0fb..4be7d3e 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -767,7 +767,7 @@ static int qdict_is_list(QDict *maybe_list, Error **errp)
>      for (ent = qdict_first(maybe_list); ent != NULL;
>           ent = qdict_next(maybe_list, ent)) {
>
> -        if (qemu_strtoll(ent->key, NULL, 10, &val) == 0) {
> +        if (qemu_strtoi64(ent->key, NULL, 10, &val) == 0) {
>              if (is_list == -1) {
>                  is_list = 1;
>              } else if (!is_list) {
> diff --git a/qtest.c b/qtest.c
> index 1446719..a685827 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -373,8 +373,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          uint64_t value;
>
>          g_assert(words[1] && words[2]);
> -        g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtoull(words[2], NULL, 0, &value) == 0);
> +        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> +        g_assert(qemu_strtou64(words[2], NULL, 0, &value) == 0);
>
>          if (words[0][5] == 'b') {
>              uint8_t data = value;
> @@ -402,7 +402,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          uint64_t value = UINT64_C(-1);
>
>          g_assert(words[1]);
> -        g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
> +        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
>
>          if (words[0][4] == 'b') {
>              uint8_t data;
> @@ -428,8 +428,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          char *enc;
>
>          g_assert(words[1] && words[2]);
> -        g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtoull(words[2], NULL, 0, &len) == 0);
> +        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> +        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
>          /* We'd send garbage to libqtest if len is 0 */
>          g_assert(len);
>
> @@ -452,8 +452,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          gchar *b64_data;
>
>          g_assert(words[1] && words[2]);
> -        g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtoull(words[2], NULL, 0, &len) == 0);
> +        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> +        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
>
>          data = g_malloc(len);
>          cpu_physical_memory_read(addr, data, len);
> @@ -469,8 +469,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          size_t data_len;
>
>          g_assert(words[1] && words[2] && words[3]);
> -        g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtoull(words[2], NULL, 0, &len) == 0);
> +        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> +        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
>
>          data_len = strlen(words[3]);
>          if (data_len < 3) {
> @@ -498,8 +498,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          unsigned long pattern;
>
>          g_assert(words[1] && words[2] && words[3]);
> -        g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtoull(words[2], NULL, 0, &len) == 0);
> +        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> +        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
>          g_assert(qemu_strtoul(words[3], NULL, 0, &pattern) == 0);
>
>          if (len) {
> @@ -518,8 +518,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          gsize out_len;
>
>          g_assert(words[1] && words[2] && words[3]);
> -        g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtoull(words[2], NULL, 0, &len) == 0);
> +        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> +        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
>
>          data_len = strlen(words[3]);
>          if (data_len < 3) {
> @@ -552,9 +552,9 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          unsigned long nargs, nret;
>
>          g_assert(qemu_strtoul(words[2], NULL, 0, &nargs) == 0);
> -        g_assert(qemu_strtoull(words[3], NULL, 0, &args) == 0);
> +        g_assert(qemu_strtou64(words[3], NULL, 0, &args) == 0);
>          g_assert(qemu_strtoul(words[4], NULL, 0, &nret) == 0);
> -        g_assert(qemu_strtoull(words[5], NULL, 0, &ret) == 0);
> +        g_assert(qemu_strtou64(words[5], NULL, 0, &ret) == 0);
>          res = qtest_rtas_call(words[1], nargs, args, nret, ret);
>
>          qtest_send_prefix(chr);
> @@ -564,7 +564,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          int64_t ns;
>
>          if (words[1]) {
> -            g_assert(qemu_strtoll(words[1], NULL, 0, &ns) == 0);
> +            g_assert(qemu_strtoi64(words[1], NULL, 0, &ns) == 0);
>          } else {
>              ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
>          }
> @@ -576,7 +576,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          int64_t ns;
>
>          g_assert(words[1]);
> -        g_assert(qemu_strtoll(words[1], NULL, 0, &ns) == 0);
> +        g_assert(qemu_strtoi64(words[1], NULL, 0, &ns) == 0);
>          qtest_clock_warp(ns);
>          qtest_send_prefix(chr);
>          qtest_sendf(chr, "OK %"PRIi64"\n",
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index ef76792..47cc8a4 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -796,7 +796,7 @@ static void test_qemu_strtoul_full_max(void)
>      g_free(str);
>  }
>
> -static void test_qemu_strtoll_correct(void)
> +static void test_qemu_strtoi64_correct(void)
>  {
>      const char *str = "12345 foo";
>      char f = 'X';
> @@ -804,27 +804,27 @@ static void test_qemu_strtoll_correct(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 12345);
>      g_assert(endptr == str + 5);
>  }
>
> -static void test_qemu_strtoll_null(void)
> +static void test_qemu_strtoi64_null(void)
>  {
>      char f = 'X';
>      const char *endptr = &f;
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(NULL, &endptr, 0, &res);
> +    err = qemu_strtoi64(NULL, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == NULL);
>  }
>
> -static void test_qemu_strtoll_empty(void)
> +static void test_qemu_strtoi64_empty(void)
>  {
>      const char *str = "";
>      char f = 'X';
> @@ -832,13 +832,13 @@ static void test_qemu_strtoll_empty(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == str);
>  }
>
> -static void test_qemu_strtoll_whitespace(void)
> +static void test_qemu_strtoi64_whitespace(void)
>  {
>      const char *str = "  \t  ";
>      char f = 'X';
> @@ -846,13 +846,13 @@ static void test_qemu_strtoll_whitespace(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == str);
>  }
>
> -static void test_qemu_strtoll_invalid(void)
> +static void test_qemu_strtoi64_invalid(void)
>  {
>      const char *str = "   xxxx  \t abc";
>      char f = 'X';
> @@ -860,13 +860,13 @@ static void test_qemu_strtoll_invalid(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == str);
>  }
>
> -static void test_qemu_strtoll_trailing(void)
> +static void test_qemu_strtoi64_trailing(void)
>  {
>      const char *str = "123xxx";
>      char f = 'X';
> @@ -874,14 +874,14 @@ static void test_qemu_strtoll_trailing(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 123);
>      g_assert(endptr == str + 3);
>  }
>
> -static void test_qemu_strtoll_octal(void)
> +static void test_qemu_strtoi64_octal(void)
>  {
>      const char *str = "0123";
>      char f = 'X';
> @@ -889,7 +889,7 @@ static void test_qemu_strtoll_octal(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 8, &res);
> +    err = qemu_strtoi64(str, &endptr, 8, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 0123);
> @@ -897,14 +897,14 @@ static void test_qemu_strtoll_octal(void)
>
>      endptr = &f;
>      res = 999;
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 0123);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoll_decimal(void)
> +static void test_qemu_strtoi64_decimal(void)
>  {
>      const char *str = "0123";
>      char f = 'X';
> @@ -912,7 +912,7 @@ static void test_qemu_strtoll_decimal(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 10, &res);
> +    err = qemu_strtoi64(str, &endptr, 10, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 123);
> @@ -921,14 +921,14 @@ static void test_qemu_strtoll_decimal(void)
>      str = "123";
>      endptr = &f;
>      res = 999;
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 123);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoll_hex(void)
> +static void test_qemu_strtoi64_hex(void)
>  {
>      const char *str = "0123";
>      char f = 'X';
> @@ -936,7 +936,7 @@ static void test_qemu_strtoll_hex(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 16, &res);
> +    err = qemu_strtoi64(str, &endptr, 16, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 0x123);
> @@ -945,14 +945,14 @@ static void test_qemu_strtoll_hex(void)
>      str = "0x123";
>      endptr = &f;
>      res = 999;
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 0x123);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoll_max(void)
> +static void test_qemu_strtoi64_max(void)
>  {
>      char *str = g_strdup_printf("%lld", LLONG_MAX);
>      char f = 'X';
> @@ -960,7 +960,7 @@ static void test_qemu_strtoll_max(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, LLONG_MAX);
> @@ -968,7 +968,7 @@ static void test_qemu_strtoll_max(void)
>      g_free(str);
>  }
>
> -static void test_qemu_strtoll_overflow(void)
> +static void test_qemu_strtoi64_overflow(void)
>  {
>      const char *str = "99999999999999999999999999999999999999999999";
>      char f = 'X';
> @@ -976,14 +976,14 @@ static void test_qemu_strtoll_overflow(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -ERANGE);
>      g_assert_cmpint(res, ==, LLONG_MAX);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoll_underflow(void)
> +static void test_qemu_strtoi64_underflow(void)
>  {
>      const char *str = "-99999999999999999999999999999999999999999999";
>      char f = 'X';
> @@ -991,14 +991,14 @@ static void test_qemu_strtoll_underflow(void)
>      int64_t res = 999;
>      int err;
>
> -    err  = qemu_strtoll(str, &endptr, 0, &res);
> +    err  = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -ERANGE);
>      g_assert_cmpint(res, ==, LLONG_MIN);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoll_negative(void)
> +static void test_qemu_strtoi64_negative(void)
>  {
>      const char *str = "  \t -321";
>      char f = 'X';
> @@ -1006,84 +1006,84 @@ static void test_qemu_strtoll_negative(void)
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, &endptr, 0, &res);
> +    err = qemu_strtoi64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, -321);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoll_full_correct(void)
> +static void test_qemu_strtoi64_full_correct(void)
>  {
>      const char *str = "123";
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, NULL, 0, &res);
> +    err = qemu_strtoi64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, 123);
>  }
>
> -static void test_qemu_strtoll_full_null(void)
> +static void test_qemu_strtoi64_full_null(void)
>  {
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(NULL, NULL, 0, &res);
> +    err = qemu_strtoi64(NULL, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>  }
>
> -static void test_qemu_strtoll_full_empty(void)
> +static void test_qemu_strtoi64_full_empty(void)
>  {
>      const char *str = "";
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, NULL, 0, &res);
> +    err = qemu_strtoi64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>  }
>
> -static void test_qemu_strtoll_full_negative(void)
> +static void test_qemu_strtoi64_full_negative(void)
>  {
>      const char *str = " \t -321";
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, NULL, 0, &res);
> +    err = qemu_strtoi64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, -321);
>  }
>
> -static void test_qemu_strtoll_full_trailing(void)
> +static void test_qemu_strtoi64_full_trailing(void)
>  {
>      const char *str = "123xxx";
>      int64_t res = 999;
>      int err;
>
> -    err = qemu_strtoll(str, NULL, 0, &res);
> +    err = qemu_strtoi64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>  }
>
> -static void test_qemu_strtoll_full_max(void)
> +static void test_qemu_strtoi64_full_max(void)
>  {
>
>      char *str = g_strdup_printf("%lld", LLONG_MAX);
>      int64_t res;
>      int err;
>
> -    err = qemu_strtoll(str, NULL, 0, &res);
> +    err = qemu_strtoi64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpint(res, ==, LLONG_MAX);
>      g_free(str);
>  }
>
> -static void test_qemu_strtoull_correct(void)
> +static void test_qemu_strtou64_correct(void)
>  {
>      const char *str = "12345 foo";
>      char f = 'X';
> @@ -1091,27 +1091,27 @@ static void test_qemu_strtoull_correct(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 12345);
>      g_assert(endptr == str + 5);
>  }
>
> -static void test_qemu_strtoull_null(void)
> +static void test_qemu_strtou64_null(void)
>  {
>      char f = 'X';
>      const char *endptr = &f;
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(NULL, &endptr, 0, &res);
> +    err = qemu_strtou64(NULL, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == NULL);
>  }
>
> -static void test_qemu_strtoull_empty(void)
> +static void test_qemu_strtou64_empty(void)
>  {
>      const char *str = "";
>      char f = 'X';
> @@ -1119,13 +1119,13 @@ static void test_qemu_strtoull_empty(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == str);
>  }
>
> -static void test_qemu_strtoull_whitespace(void)
> +static void test_qemu_strtou64_whitespace(void)
>  {
>      const char *str = "  \t  ";
>      char f = 'X';
> @@ -1133,13 +1133,13 @@ static void test_qemu_strtoull_whitespace(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == str);
>  }
>
> -static void test_qemu_strtoull_invalid(void)
> +static void test_qemu_strtou64_invalid(void)
>  {
>      const char *str = "   xxxx  \t abc";
>      char f = 'X';
> @@ -1147,13 +1147,13 @@ static void test_qemu_strtoull_invalid(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>      g_assert(endptr == str);
>  }
>
> -static void test_qemu_strtoull_trailing(void)
> +static void test_qemu_strtou64_trailing(void)
>  {
>      const char *str = "123xxx";
>      char f = 'X';
> @@ -1161,14 +1161,14 @@ static void test_qemu_strtoull_trailing(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 123);
>      g_assert(endptr == str + 3);
>  }
>
> -static void test_qemu_strtoull_octal(void)
> +static void test_qemu_strtou64_octal(void)
>  {
>      const char *str = "0123";
>      char f = 'X';
> @@ -1176,7 +1176,7 @@ static void test_qemu_strtoull_octal(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 8, &res);
> +    err = qemu_strtou64(str, &endptr, 8, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 0123);
> @@ -1184,14 +1184,14 @@ static void test_qemu_strtoull_octal(void)
>
>      endptr = &f;
>      res = 999;
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 0123);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoull_decimal(void)
> +static void test_qemu_strtou64_decimal(void)
>  {
>      const char *str = "0123";
>      char f = 'X';
> @@ -1199,7 +1199,7 @@ static void test_qemu_strtoull_decimal(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 10, &res);
> +    err = qemu_strtou64(str, &endptr, 10, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 123);
> @@ -1208,14 +1208,14 @@ static void test_qemu_strtoull_decimal(void)
>      str = "123";
>      endptr = &f;
>      res = 999;
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 123);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoull_hex(void)
> +static void test_qemu_strtou64_hex(void)
>  {
>      const char *str = "0123";
>      char f = 'X';
> @@ -1223,7 +1223,7 @@ static void test_qemu_strtoull_hex(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 16, &res);
> +    err = qemu_strtou64(str, &endptr, 16, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 0x123);
> @@ -1232,14 +1232,14 @@ static void test_qemu_strtoull_hex(void)
>      str = "0x123";
>      endptr = &f;
>      res = 999;
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 0x123);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoull_max(void)
> +static void test_qemu_strtou64_max(void)
>  {
>      char *str = g_strdup_printf("%llu", ULLONG_MAX);
>      char f = 'X';
> @@ -1247,7 +1247,7 @@ static void test_qemu_strtoull_max(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, ULLONG_MAX);
> @@ -1255,7 +1255,7 @@ static void test_qemu_strtoull_max(void)
>      g_free(str);
>  }
>
> -static void test_qemu_strtoull_overflow(void)
> +static void test_qemu_strtou64_overflow(void)
>  {
>      const char *str = "99999999999999999999999999999999999999999999";
>      char f = 'X';
> @@ -1263,14 +1263,14 @@ static void test_qemu_strtoull_overflow(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -ERANGE);
>      g_assert_cmpuint(res, ==, ULLONG_MAX);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoull_underflow(void)
> +static void test_qemu_strtou64_underflow(void)
>  {
>      const char *str = "-99999999999999999999999999999999999999999999";
>      char f = 'X';
> @@ -1278,14 +1278,14 @@ static void test_qemu_strtoull_underflow(void)
>      uint64_t res = 999;
>      int err;
>
> -    err  = qemu_strtoull(str, &endptr, 0, &res);
> +    err  = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -ERANGE);
>      g_assert_cmpuint(res, ==, (uint64_t)-1);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoull_negative(void)
> +static void test_qemu_strtou64_negative(void)
>  {
>      const char *str = "  \t -321";
>      char f = 'X';
> @@ -1293,76 +1293,76 @@ static void test_qemu_strtoull_negative(void)
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, &endptr, 0, &res);
> +    err = qemu_strtou64(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, (uint64_t)-321);
>      g_assert(endptr == str + strlen(str));
>  }
>
> -static void test_qemu_strtoull_full_correct(void)
> +static void test_qemu_strtou64_full_correct(void)
>  {
>      const char *str = "18446744073709551614";
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, NULL, 0, &res);
> +    err = qemu_strtou64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 18446744073709551614LLU);
>  }
>
> -static void test_qemu_strtoull_full_null(void)
> +static void test_qemu_strtou64_full_null(void)
>  {
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(NULL, NULL, 0, &res);
> +    err = qemu_strtou64(NULL, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>  }
>
> -static void test_qemu_strtoull_full_empty(void)
> +static void test_qemu_strtou64_full_empty(void)
>  {
>      const char *str = "";
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, NULL, 0, &res);
> +    err = qemu_strtou64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>  }
>
> -static void test_qemu_strtoull_full_negative(void)
> +static void test_qemu_strtou64_full_negative(void)
>  {
>      const char *str = " \t -321";
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, NULL, 0, &res);
> +    err = qemu_strtou64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, 18446744073709551295LLU);
>  }
>
> -static void test_qemu_strtoull_full_trailing(void)
> +static void test_qemu_strtou64_full_trailing(void)
>  {
>      const char *str = "18446744073709551614xxxxxx";
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, NULL, 0, &res);
> +    err = qemu_strtou64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
>  }
>
> -static void test_qemu_strtoull_full_max(void)
> +static void test_qemu_strtou64_full_max(void)
>  {
>      char *str = g_strdup_printf("%lld", ULLONG_MAX);
>      uint64_t res = 999;
>      int err;
>
> -    err = qemu_strtoull(str, NULL, 0, &res);
> +    err = qemu_strtou64(str, NULL, 0, &res);
>
>      g_assert_cmpint(err, ==, 0);
>      g_assert_cmpuint(res, ==, ULLONG_MAX);
> @@ -1471,21 +1471,32 @@ int main(int argc, char **argv)
>                      test_parse_uint_full_correct);
>
>      /* qemu_strtol() tests */
> -    g_test_add_func("/cutils/qemu_strtol/correct", test_qemu_strtol_correct);
> -    g_test_add_func("/cutils/qemu_strtol/null", test_qemu_strtol_null);
> -    g_test_add_func("/cutils/qemu_strtol/empty", test_qemu_strtol_empty);
> +    g_test_add_func("/cutils/qemu_strtol/correct",
> +                    test_qemu_strtol_correct);
> +    g_test_add_func("/cutils/qemu_strtol/null",
> +                    test_qemu_strtol_null);
> +    g_test_add_func("/cutils/qemu_strtol/empty",
> +                    test_qemu_strtol_empty);
>      g_test_add_func("/cutils/qemu_strtol/whitespace",
>                      test_qemu_strtol_whitespace);
> -    g_test_add_func("/cutils/qemu_strtol/invalid", test_qemu_strtol_invalid);
> -    g_test_add_func("/cutils/qemu_strtol/trailing", test_qemu_strtol_trailing);
> -    g_test_add_func("/cutils/qemu_strtol/octal", test_qemu_strtol_octal);
> -    g_test_add_func("/cutils/qemu_strtol/decimal", test_qemu_strtol_decimal);
> -    g_test_add_func("/cutils/qemu_strtol/hex", test_qemu_strtol_hex);
> -    g_test_add_func("/cutils/qemu_strtol/max", test_qemu_strtol_max);
> -    g_test_add_func("/cutils/qemu_strtol/overflow", test_qemu_strtol_overflow);
> +    g_test_add_func("/cutils/qemu_strtol/invalid",
> +                    test_qemu_strtol_invalid);
> +    g_test_add_func("/cutils/qemu_strtol/trailing",
> +                    test_qemu_strtol_trailing);
> +    g_test_add_func("/cutils/qemu_strtol/octal",
> +                    test_qemu_strtol_octal);
> +    g_test_add_func("/cutils/qemu_strtol/decimal",
> +                    test_qemu_strtol_decimal);
> +    g_test_add_func("/cutils/qemu_strtol/hex",
> +                    test_qemu_strtol_hex);
> +    g_test_add_func("/cutils/qemu_strtol/max",
> +                    test_qemu_strtol_max);
> +    g_test_add_func("/cutils/qemu_strtol/overflow",
> +                    test_qemu_strtol_overflow);
>      g_test_add_func("/cutils/qemu_strtol/underflow",
>                      test_qemu_strtol_underflow);
> -    g_test_add_func("/cutils/qemu_strtol/negative", test_qemu_strtol_negative);
> +    g_test_add_func("/cutils/qemu_strtol/negative",
> +                    test_qemu_strtol_negative);
>      g_test_add_func("/cutils/qemu_strtol_full/correct",
>                      test_qemu_strtol_full_correct);
>      g_test_add_func("/cutils/qemu_strtol_full/null",
> @@ -1500,18 +1511,26 @@ int main(int argc, char **argv)
>                      test_qemu_strtol_full_max);
>
>      /* qemu_strtoul() tests */
> -    g_test_add_func("/cutils/qemu_strtoul/correct", test_qemu_strtoul_correct);
> -    g_test_add_func("/cutils/qemu_strtoul/null", test_qemu_strtoul_null);
> -    g_test_add_func("/cutils/qemu_strtoul/empty", test_qemu_strtoul_empty);
> +    g_test_add_func("/cutils/qemu_strtoul/correct",
> +                    test_qemu_strtoul_correct);
> +    g_test_add_func("/cutils/qemu_strtoul/null",
> +                    test_qemu_strtoul_null);
> +    g_test_add_func("/cutils/qemu_strtoul/empty",
> +                    test_qemu_strtoul_empty);
>      g_test_add_func("/cutils/qemu_strtoul/whitespace",
>                      test_qemu_strtoul_whitespace);
> -    g_test_add_func("/cutils/qemu_strtoul/invalid", test_qemu_strtoul_invalid);
> +    g_test_add_func("/cutils/qemu_strtoul/invalid",
> +                    test_qemu_strtoul_invalid);
>      g_test_add_func("/cutils/qemu_strtoul/trailing",
>                      test_qemu_strtoul_trailing);
> -    g_test_add_func("/cutils/qemu_strtoul/octal", test_qemu_strtoul_octal);
> -    g_test_add_func("/cutils/qemu_strtoul/decimal", test_qemu_strtoul_decimal);
> -    g_test_add_func("/cutils/qemu_strtoul/hex", test_qemu_strtoul_hex);
> -    g_test_add_func("/cutils/qemu_strtoul/max", test_qemu_strtoul_max);
> +    g_test_add_func("/cutils/qemu_strtoul/octal",
> +                    test_qemu_strtoul_octal);
> +    g_test_add_func("/cutils/qemu_strtoul/decimal",
> +                    test_qemu_strtoul_decimal);
> +    g_test_add_func("/cutils/qemu_strtoul/hex",
> +                    test_qemu_strtoul_hex);
> +    g_test_add_func("/cutils/qemu_strtoul/max",
> +                    test_qemu_strtoul_max);
>      g_test_add_func("/cutils/qemu_strtoul/overflow",
>                      test_qemu_strtoul_overflow);
>      g_test_add_func("/cutils/qemu_strtoul/underflow",
> @@ -1531,73 +1550,86 @@ int main(int argc, char **argv)
>      g_test_add_func("/cutils/qemu_strtoul_full/max",
>                      test_qemu_strtoul_full_max);
>
> -    /* qemu_strtoll() tests */
> -    g_test_add_func("/cutils/qemu_strtoll/correct", test_qemu_strtoll_correct);
> -    g_test_add_func("/cutils/qemu_strtoll/null", test_qemu_strtoll_null);
> -    g_test_add_func("/cutils/qemu_strtoll/empty", test_qemu_strtoll_empty);
> -    g_test_add_func("/cutils/qemu_strtoll/whitespace",
> -                    test_qemu_strtoll_whitespace);
> -    g_test_add_func("/cutils/qemu_strtoll/invalid", test_qemu_strtoll_invalid);
> -    g_test_add_func("/cutils/qemu_strtoll/trailing",
> -                    test_qemu_strtoll_trailing);
> -    g_test_add_func("/cutils/qemu_strtoll/octal", test_qemu_strtoll_octal);
> -    g_test_add_func("/cutils/qemu_strtoll/decimal", test_qemu_strtoll_decimal);
> -    g_test_add_func("/cutils/qemu_strtoll/hex", test_qemu_strtoll_hex);
> -    g_test_add_func("/cutils/qemu_strtoll/max", test_qemu_strtoll_max);
> -    g_test_add_func("/cutils/qemu_strtoll/overflow",
> -                    test_qemu_strtoll_overflow);
> -    g_test_add_func("/cutils/qemu_strtoll/underflow",
> -                    test_qemu_strtoll_underflow);
> -    g_test_add_func("/cutils/qemu_strtoll/negative",
> -                    test_qemu_strtoll_negative);
> -    g_test_add_func("/cutils/qemu_strtoll_full/correct",
> -                    test_qemu_strtoll_full_correct);
> -    g_test_add_func("/cutils/qemu_strtoll_full/null",
> -                    test_qemu_strtoll_full_null);
> -    g_test_add_func("/cutils/qemu_strtoll_full/empty",
> -                    test_qemu_strtoll_full_empty);
> -    g_test_add_func("/cutils/qemu_strtoll_full/negative",
> -                    test_qemu_strtoll_full_negative);
> -    g_test_add_func("/cutils/qemu_strtoll_full/trailing",
> -                    test_qemu_strtoll_full_trailing);
> -    g_test_add_func("/cutils/qemu_strtoll_full/max",
> -                    test_qemu_strtoll_full_max);
> +    /* qemu_strtoi64() tests */
> +    g_test_add_func("/cutils/qemu_strtoi64/correct",
> +                    test_qemu_strtoi64_correct);
> +    g_test_add_func("/cutils/qemu_strtoi64/null",
> +                    test_qemu_strtoi64_null);
> +    g_test_add_func("/cutils/qemu_strtoi64/empty",
> +                    test_qemu_strtoi64_empty);
> +    g_test_add_func("/cutils/qemu_strtoi64/whitespace",
> +                    test_qemu_strtoi64_whitespace);
> +    g_test_add_func("/cutils/qemu_strtoi64/invalid"
> +                    ,
> +                    test_qemu_strtoi64_invalid);
> +    g_test_add_func("/cutils/qemu_strtoi64/trailing",
> +                    test_qemu_strtoi64_trailing);
> +    g_test_add_func("/cutils/qemu_strtoi64/octal",
> +                    test_qemu_strtoi64_octal);
> +    g_test_add_func("/cutils/qemu_strtoi64/decimal",
> +                    test_qemu_strtoi64_decimal);
> +    g_test_add_func("/cutils/qemu_strtoi64/hex",
> +                    test_qemu_strtoi64_hex);
> +    g_test_add_func("/cutils/qemu_strtoi64/max",
> +                    test_qemu_strtoi64_max);
> +    g_test_add_func("/cutils/qemu_strtoi64/overflow",
> +                    test_qemu_strtoi64_overflow);
> +    g_test_add_func("/cutils/qemu_strtoi64/underflow",
> +                    test_qemu_strtoi64_underflow);
> +    g_test_add_func("/cutils/qemu_strtoi64/negative",
> +                    test_qemu_strtoi64_negative);
> +    g_test_add_func("/cutils/qemu_strtoi64_full/correct",
> +                    test_qemu_strtoi64_full_correct);
> +    g_test_add_func("/cutils/qemu_strtoi64_full/null",
> +                    test_qemu_strtoi64_full_null);
> +    g_test_add_func("/cutils/qemu_strtoi64_full/empty",
> +                    test_qemu_strtoi64_full_empty);
> +    g_test_add_func("/cutils/qemu_strtoi64_full/negative",
> +                    test_qemu_strtoi64_full_negative);
> +    g_test_add_func("/cutils/qemu_strtoi64_full/trailing",
> +                    test_qemu_strtoi64_full_trailing);
> +    g_test_add_func("/cutils/qemu_strtoi64_full/max",
> +                    test_qemu_strtoi64_full_max);
>
> -    /* qemu_strtoull() tests */
> -    g_test_add_func("/cutils/qemu_strtoull/correct",
> -                    test_qemu_strtoull_correct);
> -    g_test_add_func("/cutils/qemu_strtoull/null",
> -                    test_qemu_strtoull_null);
> -    g_test_add_func("/cutils/qemu_strtoull/empty", test_qemu_strtoull_empty);
> -    g_test_add_func("/cutils/qemu_strtoull/whitespace",
> -                    test_qemu_strtoull_whitespace);
> -    g_test_add_func("/cutils/qemu_strtoull/invalid",
> -                    test_qemu_strtoull_invalid);
> -    g_test_add_func("/cutils/qemu_strtoull/trailing",
> -                    test_qemu_strtoull_trailing);
> -    g_test_add_func("/cutils/qemu_strtoull/octal", test_qemu_strtoull_octal);
> -    g_test_add_func("/cutils/qemu_strtoull/decimal",
> -                    test_qemu_strtoull_decimal);
> -    g_test_add_func("/cutils/qemu_strtoull/hex", test_qemu_strtoull_hex);
> -    g_test_add_func("/cutils/qemu_strtoull/max", test_qemu_strtoull_max);
> -    g_test_add_func("/cutils/qemu_strtoull/overflow",
> -                    test_qemu_strtoull_overflow);
> -    g_test_add_func("/cutils/qemu_strtoull/underflow",
> -                    test_qemu_strtoull_underflow);
> -    g_test_add_func("/cutils/qemu_strtoull/negative",
> -                    test_qemu_strtoull_negative);
> -    g_test_add_func("/cutils/qemu_strtoull_full/correct",
> -                    test_qemu_strtoull_full_correct);
> -    g_test_add_func("/cutils/qemu_strtoull_full/null",
> -                    test_qemu_strtoull_full_null);
> -    g_test_add_func("/cutils/qemu_strtoull_full/empty",
> -                    test_qemu_strtoull_full_empty);
> -    g_test_add_func("/cutils/qemu_strtoull_full/negative",
> -                    test_qemu_strtoull_full_negative);
> -    g_test_add_func("/cutils/qemu_strtoull_full/trailing",
> -                    test_qemu_strtoull_full_trailing);
> -    g_test_add_func("/cutils/qemu_strtoull_full/max",
> -                    test_qemu_strtoull_full_max);
> +    /* qemu_strtou64() tests */
> +    g_test_add_func("/cutils/qemu_strtou64/correct",
> +                    test_qemu_strtou64_correct);
> +    g_test_add_func("/cutils/qemu_strtou64/null",
> +                    test_qemu_strtou64_null);
> +    g_test_add_func("/cutils/qemu_strtou64/empty",
> +                    test_qemu_strtou64_empty);
> +    g_test_add_func("/cutils/qemu_strtou64/whitespace",
> +                    test_qemu_strtou64_whitespace);
> +    g_test_add_func("/cutils/qemu_strtou64/invalid",
> +                    test_qemu_strtou64_invalid);
> +    g_test_add_func("/cutils/qemu_strtou64/trailing",
> +                    test_qemu_strtou64_trailing);
> +    g_test_add_func("/cutils/qemu_strtou64/octal",
> +                    test_qemu_strtou64_octal);
> +    g_test_add_func("/cutils/qemu_strtou64/decimal",
> +                    test_qemu_strtou64_decimal);
> +    g_test_add_func("/cutils/qemu_strtou64/hex",
> +                    test_qemu_strtou64_hex);
> +    g_test_add_func("/cutils/qemu_strtou64/max",
> +                    test_qemu_strtou64_max);
> +    g_test_add_func("/cutils/qemu_strtou64/overflow",
> +                    test_qemu_strtou64_overflow);
> +    g_test_add_func("/cutils/qemu_strtou64/underflow",
> +                    test_qemu_strtou64_underflow);
> +    g_test_add_func("/cutils/qemu_strtou64/negative",
> +                    test_qemu_strtou64_negative);
> +    g_test_add_func("/cutils/qemu_strtou64_full/correct",
> +                    test_qemu_strtou64_full_correct);
> +    g_test_add_func("/cutils/qemu_strtou64_full/null",
> +                    test_qemu_strtou64_full_null);
> +    g_test_add_func("/cutils/qemu_strtou64_full/empty",
> +                    test_qemu_strtou64_full_empty);
> +    g_test_add_func("/cutils/qemu_strtou64_full/negative",
> +                    test_qemu_strtou64_full_negative);
> +    g_test_add_func("/cutils/qemu_strtou64_full/trailing",
> +                    test_qemu_strtou64_full_trailing);
> +    g_test_add_func("/cutils/qemu_strtou64_full/max",
> +                    test_qemu_strtou64_full_max);
>
>      g_test_add_func("/cutils/strtosz/simple",
>                      test_qemu_strtosz_simple);
> diff --git a/util/cutils.c b/util/cutils.c
> index 1ae2a08..0dc9b28 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -372,7 +372,7 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
>   * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
>   * and INT_MIN on underflow.
>   */
> -int qemu_strtoll(const char *nptr, const char **endptr, int base,
> +int qemu_strtoi64(const char *nptr, const char **endptr, int base,
>                   int64_t *result)
>  {
>      char *p;
> @@ -396,7 +396,7 @@ int qemu_strtoll(const char *nptr, const char **endptr, int base,
>   *
>   * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
>   */
> -int qemu_strtoull(const char *nptr, const char **endptr, int base,
> +int qemu_strtou64(const char *nptr, const char **endptr, int base,
>                    uint64_t *result)
>  {
>      char *p;
> diff --git a/util/log.c b/util/log.c
> index e077340..96f30dd 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -183,13 +183,13 @@ void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
>              goto out;
>          }
>
> -        if (qemu_strtoull(r, &e, 0, &r1val)
> +        if (qemu_strtou64(r, &e, 0, &r1val)
>              || e != range_op) {
>              error_setg(errp, "Invalid number to the left of %.*s",
>                         (int)(r2 - range_op), range_op);
>              goto out;
>          }
> -        if (qemu_strtoull(r2, NULL, 0, &r2val)) {
> +        if (qemu_strtou64(r2, NULL, 0, &r2val)) {
>              error_setg(errp, "Invalid number to the right of %.*s",
>                         (int)(r2 - range_op), range_op);
>              goto out;
>
