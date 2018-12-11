Received: from eggs.gnu.org ([2001:4830:134:3::10]:33079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkjC-0006Mv-NZ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkjA-0002J4-3O
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:17:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWkj9-0002IY-T5
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:17:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so14657516wrt.13
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:17:43 -0800 (PST)
References: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
	<1542777026-2788-3-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0958dd77-6a71-2b7e-f258-f3216c6abc91@redhat.com>
Date: Tue, 11 Dec 2018 17:17:40 +0100
MIME-Version: 1.0
In-Reply-To: <1542777026-2788-3-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] fw_cfg: fix -boot reboot-timeout
 error checking
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
> fw_cfg_reboot() gets option parameter "reboot-timeout" with
> qemu_opt_get(), then converts it to an integer by hand. It neglects to
> check that conversion for errors, and fails to reject negative values.
> Positive values above the limit get reported and replaced by the limit.
> This patch checks for conversion errors properly, and reject all values
> outside 0...0xffff.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> v1->v2: commit typo fix
> 
>  hw/nvram/fw_cfg.c | 27 +++++++++++++--------------
>  vl.c              |  2 +-
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 83d66818f6..aafa96721f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -177,26 +177,25 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>  
>  static void fw_cfg_reboot(FWCfgState *s)
>  {
> -    int reboot_timeout = -1;
> -    char *p;
> -    const char *temp;
> +    const char *reboot_timeout = NULL;
> +    int64_t rt_val = -1;
>  
>      /* get user configuration */
>      QemuOptsList *plist = qemu_find_opts("boot-opts");
>      QemuOpts *opts = QTAILQ_FIRST(&plist->head);
> -    if (opts != NULL) {
> -        temp = qemu_opt_get(opts, "reboot-timeout");
> -        if (temp != NULL) {
> -            p = (char *)temp;
> -            reboot_timeout = strtol(p, &p, 10);
> +    reboot_timeout = qemu_opt_get(opts, "reboot-timeout");
> +
> +    if (reboot_timeout) {
> +        rt_val = qemu_opt_get_number(opts, "reboot-timeout", -1);
> +        /* validate the input */
> +        if (rt_val < 0 || rt_val > 0xffff) {
> +            error_report("reboot timeout is invalid,"
> +                         "it should be a value between 0 and 65535");
> +            exit(1);
>          }
>      }
> -    /* validate the input */
> -    if (reboot_timeout > 0xffff) {
> -        error_report("reboot timeout is larger than 65535, force it to 65535.");
> -        reboot_timeout = 0xffff;
> -    }
> -    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout, 4), 4);
> +
> +    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
>  }
>  
>  static void fw_cfg_write(FWCfgState *s, uint8_t value)
> diff --git a/vl.c b/vl.c
> index 96ac0ddcf6..38a1759461 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -339,7 +339,7 @@ static QemuOptsList qemu_boot_opts = {
>              .type = QEMU_OPT_NUMBER,
>          }, {
>              .name = "reboot-timeout",
> -            .type = QEMU_OPT_STRING,
> +            .type = QEMU_OPT_NUMBER,
>          }, {
>              .name = "strict",
>              .type = QEMU_OPT_BOOL,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
