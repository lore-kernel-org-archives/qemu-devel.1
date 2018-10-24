Received: from eggs.gnu.org ([2001:4830:134:3::10]:46187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gFHRu-0000w4-Aa
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gFHRq-000487-20
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gFHRp-00047V-QD
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:35:37 -0400
References: <1540365080-6844-1-git-send-email-liq3ea@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4d64d42a-8727-81aa-6015-a9db92abca76@redhat.com>
Date: Wed, 24 Oct 2018 13:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <1540365080-6844-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg_reboot: ensure reboot_time is
 nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 10/24/18 09:11, Li Qiang wrote:
> This can avoid setting a negative value to
> etc/boot-fail-wait.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/nvram/fw_cfg.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index f4a52d8..276dcb1 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -199,12 +199,17 @@ static void fw_cfg_reboot(FWCfgState *s)
>              reboot_timeout = strtol(p, &p, 10);
>          }
>      }
> -    /* validate the input */
> -    if (reboot_timeout > 0xffff) {
> -        error_report("reboot timeout is larger than 65535, force it to 65535.");
> -        reboot_timeout = 0xffff;
> +
> +    if (reboot_timeout >= 0) {
> +        /* validate the input */
> +        if (reboot_timeout > 0xffff) {
> +            error_report("reboot timeout is larger than 65535,"
> +                         "force it to 65535.");
> +            reboot_timeout = 0xffff;
> +        }
> +        fw_cfg_add_file(s, "etc/boot-fail-wait",
> +                        g_memdup(&reboot_timeout, 4), 4);
>      }
> -    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout, 4), 4);
>  }
>  
>  static void fw_cfg_write(FWCfgState *s, uint8_t value)
> 

I don't feel strongly about fixing this issue.

However, if we decide to fix it, we should start with the bare-bones
strtol() call, visible at the top of the context. I'm not up-to-date on
what's the best QEMU helper function for this, but I seem to remember it
checks for trailing garbage, and perhaps even for range. Maybe we should
even use a different (better) option parsing facility thatn
qemu_opt_get(). Adding Eric and Markus.

Also, I would suggest forcing negative values (that were explicitly
specified) to some sensible positive default, such as 5 seconds or so.

Thanks
Laszlo
