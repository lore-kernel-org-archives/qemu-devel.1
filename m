Received: from eggs.gnu.org ([2001:4830:134:3::10]:39340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNh48-0003PT-CT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNh44-00069M-32
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNh43-00065v-Rj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:33:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181110034115.103335-1-liq3ea@163.com>
	<20181110034115.103335-2-liq3ea@163.com>
Date: Fri, 16 Nov 2018 17:33:34 +0100
In-Reply-To: <20181110034115.103335-2-liq3ea@163.com> (Li Qiang's message of
	"Fri, 9 Nov 2018 19:41:14 -0800")
Message-ID: <87pnv50yox.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: fw_cfg: refactor
 fw_cfg_bootsplash()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@163.com> writes:

> Currently when the splash-time value is bigger than 0xffff
> we report and correct it, when it is less than 0 we just ingore it.

s/ingore/ignore/

> Also we use qemu_opt_get() to get 'splash-time', then convert it to a number
> ourselves. This is wrong.

Well, doing it that way isn't wrong, it's just needlessly complicated
and error-prone.

Suggest starting a new paragraph right here.

>                           This patch does following:
> 1. use qemu_opt_get_number() to parse 'splash-time'
> 2. exit when the splash-time is invalid or loading the splash file failed
> 3. simplify code
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/nvram/fw_cfg.c | 40 ++++++++++++++++------------------------
>  vl.c              |  2 +-
>  2 files changed, 17 insertions(+), 25 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 946f765f7f..78f43dad93 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -118,55 +118,47 @@ error:
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

You first get "splash-time" as a string, and then ...
>  
>      /* insert splash time if user configurated */
> -    if (boot_splash_time >= 0) {
> +    if (boot_splash_time) {
> +        int64_t bst_val = qemu_opt_get_number(opts, "splash-time", -1);

... you get it again as a number.  I figure you do that because
"splash-time not specified" is not the same as "splash-time=T" for any
T.  I don't like such interfaces.  Not this patch's fault.

Just noticed: qemu_extra_params_fw[] has external linkage, but is used
only in this function.  Care to make it static in this function in a
separate patch?

>          /* validate the input */
> -        if (boot_splash_time > 0xffff) {
> -            error_report("splash time is big than 65535, force it to 65535.");
> -            boot_splash_time = 0xffff;
> +        if (bst_val < 0 || bst_val > 0xffff) {
> +            error_report("splash time is invalid,"
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
> -            return;
> +            error_report("failed to find file '%s'", boot_splash_filename);
> +            exit(1);
>          }
>  
>          /* loading file data */
>          file_data = read_splashfile(filename, &file_size, &file_type);
>          if (file_data == NULL) {
>              g_free(filename);
> -            return;
> +            error_report("failed to read file '%s'", boot_splash_filename);
> +            exit(1);
>          }
>          g_free(boot_splash_filedata);
>          boot_splash_filedata = (uint8_t *)file_data;
> diff --git a/vl.c b/vl.c
> index 55bab005b6..be37da46f0 100644
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
