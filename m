Received: from eggs.gnu.org ([2001:4830:134:3::10]:55950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIvB-0002Ob-Jo
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIv8-0000WP-E2
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:16:25 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIv8-0000WH-9m
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:16:22 -0500
Received: by mail-qk0-x243.google.com with SMTP id p22so11582205qka.3
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 20:16:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-11-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f49e26b1-5698-c55f-f0d4-0214571e3e26@amsat.org>
Date: Sun, 19 Feb 2017 01:16:18 -0300
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/24] tests/test-cutils: Add missing
 qemu_strtosz()... endptr checks
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/test-cutils.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 47cc8a4..2dc6832 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -1393,60 +1393,75 @@ static void test_qemu_strtosz_units(void)
>      const char *t = "1T";
>      const char *p = "1P";
>      const char *e = "1E";
> +    char *endptr = NULL;
>      int64_t res;
>
>      /* default is M */
> -    res = qemu_strtosz(none, NULL);
> +    res = qemu_strtosz(none, &endptr);
>      g_assert_cmpint(res, ==, M_BYTE);
> +    g_assert(endptr == none + 1);
>
> -    res = qemu_strtosz(b, NULL);
> +    res = qemu_strtosz(b, &endptr);
>      g_assert_cmpint(res, ==, 1);
> +    g_assert(endptr == b + 2);
>
> -    res = qemu_strtosz(k, NULL);
> +    res = qemu_strtosz(k, &endptr);
>      g_assert_cmpint(res, ==, K_BYTE);
> +    g_assert(endptr == k + 2);
>
> -    res = qemu_strtosz(m, NULL);
> +    res = qemu_strtosz(m, &endptr);
>      g_assert_cmpint(res, ==, M_BYTE);
> +    g_assert(endptr == m + 2);
>
> -    res = qemu_strtosz(g, NULL);
> +    res = qemu_strtosz(g, &endptr);
>      g_assert_cmpint(res, ==, G_BYTE);
> +    g_assert(endptr == g + 2);
>
> -    res = qemu_strtosz(t, NULL);
> +    res = qemu_strtosz(t, &endptr);
>      g_assert_cmpint(res, ==, T_BYTE);
> +    g_assert(endptr == t + 2);
>
> -    res = qemu_strtosz(p, NULL);
> +    res = qemu_strtosz(p, &endptr);
>      g_assert_cmpint(res, ==, P_BYTE);
> +    g_assert(endptr == p + 2);
>
> -    res = qemu_strtosz(e, NULL);
> +    res = qemu_strtosz(e, &endptr);
>      g_assert_cmpint(res, ==, E_BYTE);
> +    g_assert(endptr == e + 2);
>  }
>
>  static void test_qemu_strtosz_float(void)
>  {
>      const char *str = "12.345M";
> +    char *endptr = NULL;
>      int64_t res;
>
> -    res = qemu_strtosz(str, NULL);
> +    res = qemu_strtosz(str, &endptr);
>      g_assert_cmpint(res, ==, 12.345 * M_BYTE);
> +    g_assert(endptr == str + 7);
>  }
>
>  static void test_qemu_strtosz_erange(void)
>  {
>      const char *str = "10E";
> +    char *endptr = NULL;
>      int64_t res;
>
> -    res = qemu_strtosz(str, NULL);
> +    res = qemu_strtosz(str, &endptr);
>      g_assert_cmpint(res, ==, -ERANGE);
> +    g_assert(endptr == str + 3);
>  }
>
>  static void test_qemu_strtosz_suffix_unit(void)
>  {
>      const char *str = "12345";
> +    char *endptr = NULL;
>      int64_t res;
>
> -    res = qemu_strtosz_suffix_unit(str, NULL,
> +    res = qemu_strtosz_suffix_unit(str, &endptr,
>                                     QEMU_STRTOSZ_DEFSUFFIX_KB, 1000);
>      g_assert_cmpint(res, ==, 12345000);
> +    g_assert(endptr == str + 5);
>  }
>
>  int main(int argc, char **argv)
>
