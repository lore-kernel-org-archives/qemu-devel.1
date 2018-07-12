Received: from eggs.gnu.org ([2001:4830:134:3::10]:40496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcBq-0007KN-Vx
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcBl-0005t2-Af
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:03:27 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcBl-0005sR-6T
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:03:21 -0400
Received: by mail-qt0-x244.google.com with SMTP id e19-v6so9932419qtp.8
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:03:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-11-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ca9997d-42dc-60ee-c8b9-e3d4db562481@amsat.org>
Date: Thu, 12 Jul 2018 11:03:15 -0300
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/20] tests: Pass literal format strings
 directly to qmp_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 07/12/2018 08:12 AM, Markus Armbruster wrote:
> The qmp_FOO() take a printf-like format string.  In a few places, we
> assign a string literal to a variable and pass that instead of simply
> passing the literal.  Clean that up.
> 
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/ahci-test.c | 4 +---
>  tests/ide-test.c  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/ahci-test.c b/tests/ahci-test.c
> index 7e3491b5bd..19a7ab1bca 100644
> --- a/tests/ahci-test.c
> +++ b/tests/ahci-test.c
> @@ -1352,7 +1352,6 @@ static void test_flush_migrate(void)
>      AHCIQState *src, *dst;
>      AHCICommand *cmd;
>      uint8_t px;
> -    const char *s;
>      char *uri = g_strdup_printf("unix:%s", mig_socket);
>  
>      prepare_blkdebug_script(debug_path, "flush_to_disk");
> @@ -1388,8 +1387,7 @@ static void test_flush_migrate(void)
>      ahci_migrate(src, dst, uri);
>  
>      /* Complete the command */
> -    s = "{'execute':'cont' }";
> -    qmp_send(s);
> +    qmp_send("{'execute':'cont' }");
>      qmp_eventwait("RESUME");
>      ahci_command_wait(dst, cmd);
>      ahci_command_verify(dst, cmd);
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index 2384c2c3e2..834ee9005b 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -694,7 +694,6 @@ static void test_retry_flush(const char *machine)
>      QPCIDevice *dev;
>      QPCIBar bmdma_bar, ide_bar;
>      uint8_t data;
> -    const char *s;
>  
>      prepare_blkdebug_script(debug_path, "flush_to_disk");
>  
> @@ -722,8 +721,7 @@ static void test_retry_flush(const char *machine)
>      qmp_eventwait("STOP");
>  
>      /* Complete the command */
> -    s = "{'execute':'cont' }";
> -    qmp_discard_response(s);
> +    qmp_discard_response("{'execute':'cont' }");
>  
>      /* Check registers */
>      data = qpci_io_readb(dev, ide_bar, reg_device);
> 
