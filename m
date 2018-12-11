Received: from eggs.gnu.org ([2001:4830:134:3::10]:59717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkfJ-0000gK-4H
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkfG-0006XC-CT
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:13:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWkfG-0006WS-5A
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:13:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so9353254wmd.1
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:13:42 -0800 (PST)
References: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
	<1542777026-2788-2-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e319b73f-6f42-24f4-1480-8b124a26a720@redhat.com>
Date: Tue, 11 Dec 2018 17:13:39 +0100
MIME-Version: 1.0
In-Reply-To: <1542777026-2788-2-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] fw_cfg: fix -boot bootsplash error
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, armbru@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com
Cc: qemu-devel@nongnu.org

On 11/21/18 6:10 AM, Li Qiang wrote:
> fw_cfg_bootsplash() gets option parameter "splash-time"
> with qemu_opt_get(), then converts it to an integer by hand.
> It neglects to check that conversion for errors. This is
> needlessly complicated and error-prone. But as "splash-time
> not specified" is not the same as "splash-time=T" for any T,
> we need use qemu_opt_get() to check if splash time exists.
> This patch also make the qemu exit when finding or loading
> splash file failed.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v1->v2: drop error_report when read_splashfile() fails
> 
>  hw/nvram/fw_cfg.c | 35 +++++++++++++----------------------
>  vl.c              |  2 +-
>  2 files changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 946f765f7f..83d66818f6 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -118,47 +118,38 @@ error:
>  
>  static void fw_cfg_bootsplash(FWCfgState *s)
>  {
> -    int boot_splash_time = -1;
>      const char *boot_splash_filename = NULL;
> -    char *p;
> +    const char *boot_splash_time = NULL;
>      char *filename, *file_data;
>      gsize file_size;
>      int file_type;
> -    const char *temp;
>  
>      /* get user configuration */
>      QemuOptsList *plist = qemu_find_opts("boot-opts");
>      QemuOpts *opts = QTAILQ_FIRST(&plist->head);
> -    if (opts != NULL) {
> -        temp = qemu_opt_get(opts, "splash");
> -        if (temp != NULL) {
> -            boot_splash_filename = temp;
> -        }
> -        temp = qemu_opt_get(opts, "splash-time");
> -        if (temp != NULL) {
> -            p = (char *)temp;
> -            boot_splash_time = strtol(p, &p, 10);
> -        }
> -    }
> +    boot_splash_filename = qemu_opt_get(opts, "splash");
> +    boot_splash_time = qemu_opt_get(opts, "splash-time");
>  
>      /* insert splash time if user configurated */
> -    if (boot_splash_time >= 0) {
> +    if (boot_splash_time) {
> +        int64_t bst_val = qemu_opt_get_number(opts, "splash-time", -1);
>          /* validate the input */
> -        if (boot_splash_time > 0xffff) {
> -            error_report("splash time is big than 65535, force it to 65535.");
> -            boot_splash_time = 0xffff;
> +        if (bst_val < 0 || bst_val > 0xffff) {
> +            error_report("splash-time is invalid,"
> +                         "it should be a value between 0 and 65535");
> +            exit(1);
>          }
>          /* use little endian format */
> -        qemu_extra_params_fw[0] = (uint8_t)(boot_splash_time & 0xff);
> -        qemu_extra_params_fw[1] = (uint8_t)((boot_splash_time >> 8) & 0xff);
> +        qemu_extra_params_fw[0] = (uint8_t)(bst_val & 0xff);
> +        qemu_extra_params_fw[1] = (uint8_t)((bst_val >> 8) & 0xff);
>          fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw, 2);
>      }
>  
>      /* insert splash file if user configurated */
> -    if (boot_splash_filename != NULL) {
> +    if (boot_splash_filename) {
>          filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, boot_splash_filename);
>          if (filename == NULL) {
> -            error_report("failed to find file '%s'.", boot_splash_filename);
> +            error_report("failed to find file '%s'", boot_splash_filename);
>              return;
>          }
>  
> diff --git a/vl.c b/vl.c
> index fa25d1ae2d..96ac0ddcf6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -336,7 +336,7 @@ static QemuOptsList qemu_boot_opts = {
>              .type = QEMU_OPT_STRING,
>          }, {
>              .name = "splash-time",
> -            .type = QEMU_OPT_STRING,
> +            .type = QEMU_OPT_NUMBER,
>          }, {
>              .name = "reboot-timeout",
>              .type = QEMU_OPT_STRING,
> 
