Received: from eggs.gnu.org ([2001:4830:134:3::10]:60997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1er2dF-0002Tb-GW
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1er2dC-000167-7r
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:22:57 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1er2dC-00013w-1X
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:22:54 -0500
Received: by mail-qk0-f195.google.com with SMTP id y137so3149248qka.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 06:22:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228133357.1848600-1-arnd@arndb.de>
References: <20180228133357.1848600-1-arnd@arndb.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Feb 2018 15:22:51 +0100
Message-ID: <CAMxuvayxXG2526Z6p7-fEJM_sVefn8EkjWnY=ZozuiS_UiJS2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: avoid unused function warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Vasyl Gomonovych <gomonovych@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi

On Wed, Feb 28, 2018 at 2:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly introduced fw_cfg_dma_transfer() function is unused when
> CONFIG_CRASH_CORE is disabled:
>
> drivers/firmware/qemu_fw_cfg.c:89:16: error: 'fw_cfg_dma_transfer' defined but not used [-Werror=unused-function]
>  static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
>
> This moves it into the #ifdef section that hides its caller to avoid the
> warning.
>
> Fixes: 47e78bfb5426 ("fw_cfg: write vmcoreinfo details")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I don't know from which tree you found this, I suppose from
mst/linux-next (which btw, I don't know which version got partially
applied).

This is a regression in v13, because dma read is last patch now, as RFC.
Fixed in upcoming v16.

thanks

> ---
>  drivers/firmware/qemu_fw_cfg.c | 60 +++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 3015e77aebca..f002bb40519b 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -66,6 +66,36 @@ static void fw_cfg_sel_endianness(u16 key)
>                 iowrite16(key, fw_cfg_reg_ctrl);
>  }
>
> +/* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
> +static ssize_t fw_cfg_read_blob(u16 key,
> +                               void *buf, loff_t pos, size_t count)
> +{
> +       u32 glk = -1U;
> +       acpi_status status;
> +
> +       /* If we have ACPI, ensure mutual exclusion against any potential
> +        * device access by the firmware, e.g. via AML methods:
> +        */
> +       status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> +       if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
> +               /* Should never get here */
> +               WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
> +               memset(buf, 0, count);
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&fw_cfg_dev_lock);
> +       fw_cfg_sel_endianness(key);
> +       while (pos-- > 0)
> +               ioread8(fw_cfg_reg_data);
> +       ioread8_rep(fw_cfg_reg_data, buf, count);
> +       mutex_unlock(&fw_cfg_dev_lock);
> +
> +       acpi_release_global_lock(glk);
> +       return count;
> +}
> +
> +#ifdef CONFIG_CRASH_CORE
>  static inline bool fw_cfg_dma_enabled(void)
>  {
>         return (fw_cfg_rev & FW_CFG_VERSION_DMA) && fw_cfg_reg_dma;
> @@ -124,36 +154,6 @@ static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
>         return ret;
>  }
>
> -/* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
> -static ssize_t fw_cfg_read_blob(u16 key,
> -                               void *buf, loff_t pos, size_t count)
> -{
> -       u32 glk = -1U;
> -       acpi_status status;
> -
> -       /* If we have ACPI, ensure mutual exclusion against any potential
> -        * device access by the firmware, e.g. via AML methods:
> -        */
> -       status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> -       if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
> -               /* Should never get here */
> -               WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
> -               memset(buf, 0, count);
> -               return -EINVAL;
> -       }
> -
> -       mutex_lock(&fw_cfg_dev_lock);
> -       fw_cfg_sel_endianness(key);
> -       while (pos-- > 0)
> -               ioread8(fw_cfg_reg_data);
> -       ioread8_rep(fw_cfg_reg_data, buf, count);
> -       mutex_unlock(&fw_cfg_dev_lock);
> -
> -       acpi_release_global_lock(glk);
> -       return count;
> -}
> -
> -#ifdef CONFIG_CRASH_CORE
>  /* write chunk of given fw_cfg blob (caller responsible for sanity-check) */
>  static ssize_t fw_cfg_write_blob(u16 key,
>                                  void *buf, loff_t pos, size_t count)
> --
> 2.9.0
>
