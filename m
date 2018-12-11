Received: from eggs.gnu.org ([2001:4830:134:3::10]:42778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkE0-0000DF-G7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkDw-0006jE-Ds
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:45:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWkDw-0006iO-6v
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:45:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so2730751wmd.0
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:45:27 -0800 (PST)
References: <1541052148-28752-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02074c61-857e-8e02-f4e4-f2ed76030d63@redhat.com>
Date: Tue, 11 Dec 2018 16:45:24 +0100
MIME-Version: 1.0
In-Reply-To: <1541052148-28752-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: fw_cfg: Improve error message when
 can't load splash file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, armbru@redhat.com, lersek@redhat.com
Cc: qemu-devel@nongnu.org

On 11/1/18 7:02 AM, Li Qiang wrote:
> read_splashfile() reports "failed to read splash file" without
> further details. Get the details from g_file_get_contents(), and
> include them in the error message. Also remove unnecessary 'res'
> variable.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/nvram/fw_cfg.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 946f765..3fcfa35 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -68,15 +68,14 @@ static char *read_splashfile(char *filename, gsize *file_sizep,
>                               int *file_typep)
>  {
>      GError *err = NULL;
> -    gboolean res;
>      gchar *content;
>      int file_type;
>      unsigned int filehead;
>      int bmp_bpp;
>  
> -    res = g_file_get_contents(filename, &content, file_sizep, &err);
> -    if (res == FALSE) {
> -        error_report("failed to read splash file '%s'", filename);
> +    if (!g_file_get_contents(filename, &content, file_sizep, &err)) {
> +        error_report("failed to read splash file '%s': %s",
> +                     filename, err->message);
>          g_error_free(err);
>          return NULL;
>      }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

and queued, thanks!

Phil.
