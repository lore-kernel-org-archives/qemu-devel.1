Received: from eggs.gnu.org ([2001:4830:134:3::10]:44959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cROez-0002JH-Ik
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cROew-0002MF-FD
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:34:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cROew-0002KL-86
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:34:10 -0500
References: <148412457273.22750.983275587432075569.stgit@bahia>
From: John Snow <jsnow@redhat.com>
Message-ID: <72abfa88-da99-568b-9376-1289d5afbb37@redhat.com>
Date: Wed, 11 Jan 2017 14:34:06 -0500
MIME-Version: 1.0
In-Reply-To: <148412457273.22750.983275587432075569.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libqtest: handle zero length
 memwrite/memread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>



On 01/11/2017 03:49 AM, Greg Kurz wrote:
> Some recently added tests pass a zero length to qtest_memwrite().
> Unfortunately, the qtest protocol doesn't implement an on-the-wire
> syntax for zero-length writes and the current code happily sends
> garbage to QEMU. This causes intermittent failures.
> 
> It isn't worth the pain to enhance the protocol, so this patch
> simply fixes the issue by "just return, doing nothing". The same
> fix is applied to qtest_memread() since the issue also exists in
> the QEMU part of the "memread" command.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  qtest.c          |    2 ++
>  tests/libqtest.c |   12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/qtest.c b/qtest.c
> index 46b99aed5291..bd9d4178129b 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -430,6 +430,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          g_assert(words[1] && words[2]);
>          g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
>          g_assert(qemu_strtoull(words[2], NULL, 0, &len) == 0);
> +        /* We'd send garbage to libqtest if len is 0 */
> +        g_assert(len);
>  
>          data = g_malloc(len);
>          cpu_physical_memory_read(addr, data, len);
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 6f6975248fae..d8fba6647a17 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -768,6 +768,10 @@ void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
>      gchar **args;
>      size_t i;
>  
> +    if (!size) {
> +        return;
> +    }
> +
>      qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
>      args = qtest_rsp(s, 2);
>  
> @@ -858,7 +862,13 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
>  {
>      const uint8_t *ptr = data;
>      size_t i;
> -    char *enc = g_malloc(2 * size + 1);
> +    char *enc;
> +
> +    if (!size) {
> +        return;
> +    }
> +
> +    enc = g_malloc(2 * size + 1);
>  
>      for (i = 0; i < size; i++) {
>          sprintf(&enc[i * 2], "%02x", ptr[i]);
> 
> 

Reviewed-by: John Snow <jsnow@redhat.com>
