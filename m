Received: from eggs.gnu.org ([2001:4830:134:3::10]:52620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAAQ4-0006Bq-R8
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAAQ1-0003Rq-Ll
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:04:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAAQ1-0003R2-DL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:04:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so4785399wrt.10
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 02:04:37 -0700 (PDT)
References: <f8c0f859-2d70-b53e-a39a-48c2bf253be6@redhat.com>
	<1539155198-5873-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d67eb57-0530-5ecf-5d86-65a16f9d0d9c@redhat.com>
Date: Wed, 10 Oct 2018 11:04:34 +0200
MIME-Version: 1.0
In-Reply-To: <1539155198-5873-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/cris/translate: Get rid of
 qemu_log_separate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-trivial@nongnu.org

On 10/10/2018 09:06, Thomas Huth wrote:
> The gen_BUG() function calls already cpu_abort(), which prints the
> information to stderr and the log already. So instead of additionally
> printing the dc->pc via fprintf() and qemu_log here, too, we can
> simply pass this information to cpu_abort() instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use "pc=" instead of "dc->pc=" in the string as suggested by Phil

Thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>  target/cris/translate.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 4ae1c04..11b2c11 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -137,11 +137,7 @@ typedef struct DisasContext {
>  
>  static void gen_BUG(DisasContext *dc, const char *file, int line)
>  {
> -    fprintf(stderr, "BUG: pc=%x %s %d\n", dc->pc, file, line);
> -    if (qemu_log_separate()) {
> -        qemu_log("BUG: pc=%x %s %d\n", dc->pc, file, line);
> -    }
> -    cpu_abort(CPU(dc->cpu), "%s:%d\n", file, line);
> +    cpu_abort(CPU(dc->cpu), "%s:%d pc=%x\n", file, line, dc->pc);
>  }
>  
>  static const char *regnames_v32[] =
> 
