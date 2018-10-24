Received: from eggs.gnu.org ([2001:4830:134:3::10]:46094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gFHSF-0000vg-No
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gFHMr-0000uw-G3
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:30:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gFHMf-0000m0-4z
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:30:20 -0400
References: <1540357921-4199-1-git-send-email-liq3ea@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a78c9c53-e89a-8b39-31a8-f04e98ea9478@redhat.com>
Date: Wed, 24 Oct 2018 13:30:09 +0200
MIME-Version: 1.0
In-Reply-To: <1540357921-4199-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Li Qiang <liq3ea@gmail.com>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

On 10/24/18 07:12, Li Qiang wrote:
> Also remove unnecessary 'res' variable.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/nvram/fw_cfg.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 946f765..f4a52d8 100644
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
> +        error_report("failed to read splash file '%s', %s",
> +                     filename, err->message);
>          g_error_free(err);
>          return NULL;
>      }
> 

Seems to be OK, according to
<https://developer.gnome.org/glib/stable/glib-Error-Reporting.html#glib-Error-Reporting.description>.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
