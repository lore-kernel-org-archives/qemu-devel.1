Received: from eggs.gnu.org ([2001:4830:134:3::10]:35475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFS8d-000673-3J
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 19:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFS8V-0003gZ-Ku
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 19:00:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFS8Q-0003My-Cc
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 19:00:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so7016605wmw.2
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 16:00:11 -0700 (PDT)
References: <1540357921-4199-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9943c62b-3d87-3359-a17f-d975ae228c0c@redhat.com>
Date: Thu, 25 Oct 2018 01:00:09 +0200
MIME-Version: 1.0
In-Reply-To: <1540357921-4199-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: print error message when reading
 splashfile failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

On 24/10/18 7:12, Li Qiang wrote:
> Also remove unnecessary 'res' variable.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>   hw/nvram/fw_cfg.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 946f765..f4a52d8 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -68,15 +68,14 @@ static char *read_splashfile(char *filename, gsize *file_sizep,
>                                int *file_typep)
>   {
>       GError *err = NULL;
> -    gboolean res;
>       gchar *content;
>       int file_type;
>       unsigned int filehead;
>       int bmp_bpp;
>   
> -    res = g_file_get_contents(filename, &content, file_sizep, &err);
> -    if (res == FALSE) {
> -        error_report("failed to read splash file '%s'", filename);
> +    if (!g_file_get_contents(filename, &content, file_sizep, &err)) {
> +        error_report("failed to read splash file '%s', %s",

Can you use a column like the rest of the codebase?

i.e.: "failed to read splash file '%s': %s"

The maintainer taking this patch can do this minor change, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +                     filename, err->message);
>           g_error_free(err);
>           return NULL;
>       }
> 
