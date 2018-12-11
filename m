Received: from eggs.gnu.org ([2001:4830:134:3::10]:33290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkjq-0006wJ-Qy
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkjo-0002j5-6n
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:18:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWkjn-0002i2-VZ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:18:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so14659825wrt.13
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:18:23 -0800 (PST)
References: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
	<1542777026-2788-4-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75e9d01e-4e95-8660-0a46-cf1958679878@redhat.com>
Date: Tue, 11 Dec 2018 17:18:20 +0100
MIME-Version: 1.0
In-Reply-To: <1542777026-2788-4-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] fw_cfg: make qemu_extra_params_fw
 locally
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

Hi Li,

On 11/21/18 6:10 AM, Li Qiang wrote:
> qemu_extra_params_fw[] has external linkage, but is used
> only in fw_cfg_bootsplash(), it makes sense to make it
> locally.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/nvram/fw_cfg.c       | 1 +
>  include/sysemu/sysemu.h | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index aafa96721f..a71f043b5d 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -120,6 +120,7 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>  {
>      const char *boot_splash_filename = NULL;
>      const char *boot_splash_time = NULL;
> +    uint8_t qemu_extra_params_fw[2];
>      char *filename, *file_data;
>      gsize file_size;
>      int file_type;
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 8d6095d98b..f8608d24d9 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -133,7 +133,6 @@ extern uint8_t *boot_splash_filedata;
>  extern size_t boot_splash_filedata_size;
>  extern bool enable_mlock;
>  extern bool enable_cpu_pm;
> -extern uint8_t qemu_extra_params_fw[2];
>  extern QEMUClockType rtc_clock;
>  extern const char *mem_path;
>  extern int mem_prealloc;
> 

You forgot to remove it from vl.c:

$ git grep qemu_extra_params_fw
vl.c:194:uint8_t qemu_extra_params_fw[2];

I'll simply squash this in your patch when applying:

-- >8 --
--- a/vl.c
+++ b/vl.c
@@ -191,7 +191,6 @@ int boot_menu;
 bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
-uint8_t qemu_extra_params_fw[2];

 int icount_align_option;

---

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
