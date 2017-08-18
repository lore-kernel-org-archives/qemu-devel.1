Received: from eggs.gnu.org ([2001:4830:134:3::10]:36363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diowW-0006Mk-NR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diowR-00028o-Qw
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:36:36 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diowR-00028a-L6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:36:31 -0400
Received: by mail-qt0-x244.google.com with SMTP id 57so527953qtu.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:36:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-6-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11a95823-71bf-a94b-2e72-e536a4817775@amsat.org>
Date: Fri, 18 Aug 2017 18:36:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170818211542.5380-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/13] libqtest: Use qemu_strtoul()
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

On 08/18/2017 06:15 PM, Eric Blake wrote:
> This will keep checkpatch happy when the next patch does code motion.
> Fix the include order to match HACKING when adding the needed header.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/libqtest.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index a6ce21d7f9..438a22678d 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -15,12 +15,13 @@
>    *
>    */
>   #include "qemu/osdep.h"
> -#include "libqtest.h"
> 
>   #include <sys/socket.h>
>   #include <sys/wait.h>
>   #include <sys/un.h>
> 
> +#include "libqtest.h"
> +#include "qemu/cutils.h"
>   #include "qapi/error.h"
>   #include "qapi/qmp/json-parser.h"
>   #include "qapi/qmp/json-streamer.h"
> @@ -333,12 +334,14 @@ redo:
>       g_string_free(line, TRUE);
> 
>       if (strcmp(words[0], "IRQ") == 0) {
> -        int irq;
> +        long irq;
> +        int ret;
> 
>           g_assert(words[1] != NULL);
>           g_assert(words[2] != NULL);
> 
> -        irq = strtoul(words[2], NULL, 0);
> +        ret = qemu_strtol(words[2], NULL, 0, &irq);
> +        g_assert(!ret);
>           g_assert_cmpint(irq, >=, 0);
>           g_assert_cmpint(irq, <, MAX_IRQ);
> 
> @@ -701,11 +704,13 @@ void qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
>   static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
>   {
>       gchar **args;
> -    uint32_t value;
> +    int ret;
> +    unsigned long value;
> 
>       qtest_sendf(s, "%s 0x%x\n", cmd, addr);
>       args = qtest_rsp(s, 2);
> -    value = strtoul(args[1], NULL, 0);
> +    ret = qemu_strtoul(args[1], NULL, 0, &value);
> +    g_assert(!ret && value <= UINT32_MAX);
>       g_strfreev(args);
> 
>       return value;
> @@ -756,11 +761,13 @@ void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
>   static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
>   {
>       gchar **args;
> +    int ret;
>       uint64_t value;
> 
>       qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
>       args = qtest_rsp(s, 2);
> -    value = strtoull(args[1], NULL, 0);
> +    ret = qemu_strtou64(args[1], NULL, 0, &value);
> +    g_assert(!ret);
>       g_strfreev(args);
> 
>       return value;
> 
