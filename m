Received: from eggs.gnu.org ([2001:4830:134:3::10]:35457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diotS-0003Vl-Nn
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diotN-0000YU-Mr
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:33:26 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diotN-0000YD-FY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:33:21 -0400
Received: by mail-qk0-x242.google.com with SMTP id u139so2081463qka.3
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:33:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-3-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
Date: Fri, 18 Aug 2017 18:33:17 -0300
MIME-Version: 1.0
In-Reply-To: <20170818211542.5380-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/13] qtest: Don't perform side effects
 inside assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

Hi Eric,

On 08/18/2017 06:15 PM, Eric Blake wrote:
> Assertions should be separate from the side effects, since in
> theory, g_assert() can be disabled (in practice, we can't really
> ever do that).

What about the suggestion on your "Hacks for building on gcc 7 / Fedora 
26" series about avoid building without assertions?

The obvious win is a more readable code.

http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06084.html

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   qtest.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++-------------------
>   1 file changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/qtest.c b/qtest.c
> index 88a09e9afc..cbbfb71114 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -332,10 +332,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>                  strcmp(words[0], "outl") == 0) {
>           unsigned long addr;
>           unsigned long value;
> +        int ret;
> 
>           g_assert(words[1] && words[2]);
> -        g_assert(qemu_strtoul(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtoul(words[2], NULL, 0, &value) == 0);
> +        ret = qemu_strtoul(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> +        ret = qemu_strtoul(words[2], NULL, 0, &value);
> +        g_assert(ret == 0);
>           g_assert(addr <= 0xffff);
> 
>           if (words[0][3] == 'b') {
> @@ -352,9 +355,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           strcmp(words[0], "inl") == 0) {
>           unsigned long addr;
>           uint32_t value = -1U;
> +        int ret;
> 
>           g_assert(words[1]);
> -        g_assert(qemu_strtoul(words[1], NULL, 0, &addr) == 0);
> +        ret = qemu_strtoul(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
>           g_assert(addr <= 0xffff);
> 
>           if (words[0][2] == 'b') {
> @@ -372,10 +377,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>                  strcmp(words[0], "writeq") == 0) {
>           uint64_t addr;
>           uint64_t value;
> +        int ret;
> 
>           g_assert(words[1] && words[2]);
> -        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtou64(words[2], NULL, 0, &value) == 0);
> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> +        ret = qemu_strtou64(words[2], NULL, 0, &value);
> +        g_assert(ret == 0);
> 
>           if (words[0][5] == 'b') {
>               uint8_t data = value;
> @@ -401,9 +409,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>                  strcmp(words[0], "readq") == 0) {
>           uint64_t addr;
>           uint64_t value = UINT64_C(-1);
> +        int ret;
> 
>           g_assert(words[1]);
> -        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> 
>           if (words[0][4] == 'b') {
>               uint8_t data;
> @@ -427,10 +437,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           uint64_t addr, len, i;
>           uint8_t *data;
>           char *enc;
> +        int ret;
> 
>           g_assert(words[1] && words[2]);
> -        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
> +        g_assert(ret == 0);
>           /* We'd send garbage to libqtest if len is 0 */
>           g_assert(len);
> 
> @@ -451,10 +464,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           uint64_t addr, len;
>           uint8_t *data;
>           gchar *b64_data;
> +        int ret;
> 
>           g_assert(words[1] && words[2]);
> -        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
> +        g_assert(ret == 0);
> 
>           data = g_malloc(len);
>           cpu_physical_memory_read(addr, data, len);
> @@ -468,10 +484,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           uint64_t addr, len, i;
>           uint8_t *data;
>           size_t data_len;
> +        int ret;
> 
>           g_assert(words[1] && words[2] && words[3]);
> -        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
> +        g_assert(ret == 0);
> 
>           data_len = strlen(words[3]);
>           if (data_len < 3) {
> @@ -497,11 +516,15 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           uint64_t addr, len;
>           uint8_t *data;
>           unsigned long pattern;
> +        int ret;
> 
>           g_assert(words[1] && words[2] && words[3]);
> -        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
> -        g_assert(qemu_strtoul(words[3], NULL, 0, &pattern) == 0);
> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
> +        g_assert(ret == 0);
> +        ret = qemu_strtoul(words[3], NULL, 0, &pattern);
> +        g_assert(ret == 0);
> 
>           if (len) {
>               data = g_malloc(len);
> @@ -517,10 +540,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           uint8_t *data;
>           size_t data_len;
>           gsize out_len;
> +        int ret;
> 
>           g_assert(words[1] && words[2] && words[3]);
> -        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
> -        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
> +        ret = qemu_strtou64(words[1], NULL, 0, &addr);
> +        g_assert(ret == 0);
> +        ret = qemu_strtou64(words[2], NULL, 0, &len);
> +        g_assert(ret == 0);
> 
>           data_len = strlen(words[3]);
>           if (data_len < 3) {
> @@ -551,11 +577,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>       } else if (strcmp(words[0], "rtas") == 0) {
>           uint64_t res, args, ret;
>           unsigned long nargs, nret;
> +        int rc;
> 
> -        g_assert(qemu_strtoul(words[2], NULL, 0, &nargs) == 0);
> -        g_assert(qemu_strtou64(words[3], NULL, 0, &args) == 0);
> -        g_assert(qemu_strtoul(words[4], NULL, 0, &nret) == 0);
> -        g_assert(qemu_strtou64(words[5], NULL, 0, &ret) == 0);
> +        rc = qemu_strtoul(words[2], NULL, 0, &nargs);
> +        g_assert(rc == 0);
> +        rc = qemu_strtou64(words[3], NULL, 0, &args);
> +        g_assert(rc == 0);
> +        rc = qemu_strtoul(words[4], NULL, 0, &nret);
> +        g_assert(rc == 0);
> +        rc = qemu_strtou64(words[5], NULL, 0, &ret);
> +        g_assert(rc == 0);
>           res = qtest_rtas_call(words[1], nargs, args, nret, ret);
> 
>           qtest_send_prefix(chr);
> @@ -565,7 +596,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>           int64_t ns;
> 
>           if (words[1]) {
> -            g_assert(qemu_strtoi64(words[1], NULL, 0, &ns) == 0);
> +            int ret = qemu_strtoi64(words[1], NULL, 0, &ns);
> +            g_assert(ret == 0);
>           } else {
>               ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
>           }
> @@ -575,9 +607,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>                       (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>       } else if (qtest_enabled() && strcmp(words[0], "clock_set") == 0) {
>           int64_t ns;
> +        int ret;
> 
>           g_assert(words[1]);
> -        g_assert(qemu_strtoi64(words[1], NULL, 0, &ns) == 0);
> +        ret = qemu_strtoi64(words[1], NULL, 0, &ns);
> +        g_assert(ret == 0);
>           qtest_clock_warp(ns);
>           qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK %"PRIi64"\n",
> 
