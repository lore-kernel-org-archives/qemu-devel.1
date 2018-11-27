Received: from eggs.gnu.org ([2001:4830:134:3::10]:37625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRX6x-0007ak-3e
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRX6u-0006e9-04
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:44:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRX6t-0006e5-Ri
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:44:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1541052148-28752-1-git-send-email-liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 07:44:35 +0100
In-Reply-To: <1541052148-28752-1-git-send-email-liq3ea@gmail.com> (Li Qiang's
	message of "Wed, 31 Oct 2018 23:02:28 -0700")
Message-ID: <874lc3f298.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@gmail.com> writes:

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

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Philippe, I assume you'll take this.
