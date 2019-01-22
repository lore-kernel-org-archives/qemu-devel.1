Received: from eggs.gnu.org ([209.51.188.92]:48563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gm1qE-00025S-AU
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gm1qD-0003OH-88
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:36:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gm1qD-0003NE-1l
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:36:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so15427203wmc.1
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:36:08 -0800 (PST)
References: <20190118223152.24183-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8f1a9bdb-bb9f-8a67-7d9c-76951c87e864@redhat.com>
Date: Tue, 22 Jan 2019 13:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190118223152.24183-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix the life cycle and the name of
 "qemu_extra_params_fw"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Li Qiang <liq3ea@gmail.com>

On 1/18/19 11:31 PM, Laszlo Ersek wrote:
> Commit 19bcc4bc3213 ("fw_cfg: Make qemu_extra_params_fw locally",
> 2019-01-04) changed the storage duration of the "qemu_extra_params_fw"
> array from static to automatic. This broke the interface contract on the
> fw_cfg_add_file() function, which is documented as follows, in
> "include/hw/nvram/fw_cfg.h":
> 
>> [...] The data referenced by the starting pointer is only linked, NOT
>> copied, into the data structure of the fw_cfg device. [...]
> 
> As a result, when guest firmware fetches the "etc/boot-menu-wait" fw_cfg
> file, it now sees garbage. Fix the regression by changing the storage
> duration to allocated. (The call is reached at most once, on the realize
> path of the board-specific fw_cfg sysbus device.)

Hopefully you catched this in time. This also demonstrate my testing is
poor. This will be improved.

> 
> While at it, clean up the name and the assignment of the object as well.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Fixes: 19bcc4bc3213e78c303ad480a7a578f62258252d
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 53e8e010a8b7..7fdf04adc97f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -118,7 +118,6 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>  {
>      const char *boot_splash_filename = NULL;
>      const char *boot_splash_time = NULL;
> -    uint8_t qemu_extra_params_fw[2];
>      char *filename, *file_data;
>      gsize file_size;
>      int file_type;
> @@ -132,6 +131,8 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>      /* insert splash time if user configurated */
>      if (boot_splash_time) {
>          int64_t bst_val = qemu_opt_get_number(opts, "splash-time", -1);
> +        uint16_t bst_le16;
> +
>          /* validate the input */
>          if (bst_val < 0 || bst_val > 0xffff) {
>              error_report("splash-time is invalid,"
> @@ -139,9 +140,9 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>              exit(1);
>          }
>          /* use little endian format */
> -        qemu_extra_params_fw[0] = (uint8_t)(bst_val & 0xff);
> -        qemu_extra_params_fw[1] = (uint8_t)((bst_val >> 8) & 0xff);
> -        fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw, 2);
> +        bst_le16 = cpu_to_le16(bst_val);

I had a similar patch staged using the ldst API, however using the
cpu_to API is more consistent with the rest of this file.

> +        fw_cfg_add_file(s, "etc/boot-menu-wait",
> +                        g_memdup(&bst_le16, sizeof bst_le16), sizeof bst_le16);

Using the heap and not worrying about releasing it is also consistent
with the rest of this file, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Sorry for having you going throught this bug, and thanks for fixing it!

Phil.

>      }
>  
>      /* insert splash file if user configurated */
> 
