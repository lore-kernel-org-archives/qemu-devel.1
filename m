Received: from eggs.gnu.org ([2001:4830:134:3::10]:45932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNhMm-0001hp-9L
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNhMi-0001Sa-9o
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:53:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNhMi-0001SA-2K
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:53:08 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181110034115.103335-1-liq3ea@163.com>
	<20181110034115.103335-3-liq3ea@163.com>
Date: Fri, 16 Nov 2018 17:52:58 +0100
In-Reply-To: <20181110034115.103335-3-liq3ea@163.com> (Li Qiang's message of
	"Fri, 9 Nov 2018 19:41:15 -0800")
Message-ID: <87k1ld0xsl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] hw: fw_cfg: refactor fw_cfg_reboot()
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

> Currently the user can set a negative reboot_timeout.
> Also it is wrong to parse 'reboot-timeout' with qemu_opt_get() and then
> convert it to number.

Again, it's not wrong per se, just needlessly complicated and
error-prone.  What makes it wrong is ...

> convert it to number. This patch refactor this function by following:
> 1. ensure reboot_timeout is in 0~0xffff
> 2. use qemu_opt_get_number() to parse reboot_timeout
> 3. simlify code
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/nvram/fw_cfg.c | 23 +++++++++++------------
>  vl.c              |  2 +-
>  2 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 78f43dad93..6aca80846a 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -178,24 +178,23 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>  
>  static void fw_cfg_reboot(FWCfgState *s)
>  {
> -    int reboot_timeout = -1;
> -    char *p;
> -    const char *temp;
> +    const char *reboot_timeout = NULL;
>  
>      /* get user configuration */
>      QemuOptsList *plist = qemu_find_opts("boot-opts");
>      QemuOpts *opts = QTAILQ_FIRST(&plist->head);
> -    if (opts != NULL) {
> -        temp = qemu_opt_get(opts, "reboot-timeout");
> -        if (temp != NULL) {
> -            p = (char *)temp;
> -            reboot_timeout = strtol(p, &p, 10);

... the total lack of error checking here.  Same in PATCH 1.

Here's my attempt at a clearer commit message:

    fw_cfg: Fix -boot reboot-timeout error checking

    fw_cfg_reboot() gets option parameter "reboot-timeout" with
    qemu_opt_get(), then converts it to an integer by hand.  It neglects
    to check that conversion for errors, and fails to reject negative
    values.  Positive values above the limit get reported and replaced
    by the limit.

    Check for conversion errors properly, and reject all values outside
    0..0xffff.

PATCH 1's commit message could be improved the same way.

> -        }
> +    reboot_timeout = qemu_opt_get(opts, "reboot-timeout");
> +
> +    if (reboot_timeout == NULL) {
> +        return;
>      }
> +    int64_t rt_val = qemu_opt_get_number(opts, "reboot-timeout", -1);
> +
>      /* validate the input */
> -    if (reboot_timeout > 0xffff) {
> -        error_report("reboot timeout is larger than 65535, force it to 65535.");
> -        reboot_timeout = 0xffff;
> +    if (rt_val < 0 || rt_val > 0xffff) {
> +        error_report("reboot timeout is invalid,"
> +                     "it should be a value between 0 and 65535");
> +        exit(1);
>      }
>      fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout, 4), 4);
>  }

Change in behavior when "reboot-timeout" isn't specified.

Before your patch, we fw_cfg_add_file() with a value of -1.

After your patch, we don't fw_cfg_add_file().

Why is that okay?

> diff --git a/vl.c b/vl.c
> index be37da46f0..086127ff0b 100644
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
