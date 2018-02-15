Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emROd-0003Xy-85
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emROa-0006S6-78
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:48:51 -0500
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:46167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emROa-0006Re-1z
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:48:48 -0500
Received: by mail-qk0-x230.google.com with SMTP id g129so1465778qkb.13
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 13:48:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<20180215212552.26997-7-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b85e13d9-d899-d2df-5780-30e4567b8232@amsat.org>
Date: Thu, 15 Feb 2018 18:48:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180215212552.26997-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] sdhci-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 02/15/2018 06:25 PM, Marc-André Lureau wrote:
> Fix the following ASAN reports:
> 
> ==20125==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x7f0faea03a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
>     #1 0x7f0fae450f75 in g_malloc0 ../glib/gmem.c:124
>     #2 0x562fffd526fc in machine_start /home/elmarco/src/qemu/tests/sdhci-test.c:180
> 
> Indirect leak of 152 byte(s) in 1 object(s) allocated from:
>     #0 0x7f0faea03850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7f0fae450f0c in g_malloc ../glib/gmem.c:94
>     #2 0x562fffd5d21d in qpci_init_pc /home/elmarco/src/qemu/tests/libqos/pci-pc.c:122

Oops my bad, thanks!

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/sdhci-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
> index 493023fd0c..8a7099398c 100644
> --- a/tests/sdhci-test.c
> +++ b/tests/sdhci-test.c
> @@ -209,8 +209,10 @@ static QSDHCI *machine_start(const struct sdhci_t *test)
>  
>  static void machine_stop(QSDHCI *s)
>  {
> +    qpci_free_pc(s->pci.bus);
>      g_free(s->pci.dev);
>      qtest_quit(global_qtest);
> +    g_free(s);
>  }
>  
>  static void test_machine(const void *data)
> 
