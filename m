Received: from eggs.gnu.org ([2001:4830:134:3::10]:55302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9mrW-0004Sm-FH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9mrS-0004tH-DG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:55:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9mrS-0004t2-3A
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:55:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so695768wrw.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 00:55:22 -0700 (PDT)
References: <1539071180-2028-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f8c0f859-2d70-b53e-a39a-48c2bf253be6@redhat.com>
Date: Tue, 9 Oct 2018 09:55:19 +0200
MIME-Version: 1.0
In-Reply-To: <1539071180-2028-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/cris/translate: Get rid of
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

Hi Thomas,

On 09/10/2018 09:46, Thomas Huth wrote:
> The gen_BUG() function calls already cpu_abort(), which prints the
> information to stderr and the log already. So instead of additionally
> printing the dc->pc via fprintf() and qemu_log here, too, we can
> simply pass this information to cpu_abort() instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/cris/translate.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 4ae1c04..0ee2c5d 100644
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
> +    cpu_abort(CPU(dc->cpu), "%s:%d dc->pc=%x\n", file, line, dc->pc);

I'd use a simpler format (why display internal "dc->"?):

       cpu_abort(CPU(dc->cpu), "%s:%d BUG: pc=%x\n", ...


>  }
>  
>  static const char *regnames_v32[] =
> 
