Received: from eggs.gnu.org ([209.51.188.92]:48812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2CO4-0001iK-BG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2CO3-0007Jz-AU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:05:56 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-7-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <eb5b1516-9dca-e9bc-4a2b-d5573c14146f@redhat.com>
Date: Fri, 8 Mar 2019 11:05:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/18] hw/nvram/fw_cfg: Remove the
 unnecessary boot_splash_filedata_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
> The 'boot_splash_filedata_size' was introduced as a global variable
> in 3d3b8303c6f. This variable is used as a 'size' argument to the
> fw_cfg_add_file(). This function has an interface contract with his

s/with his/on its/

With that update:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> 'data' argument, but there is no such contract for 'size' (this is
> not a referenced pointer).  We can simply remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c       | 5 ++---
>  include/sysemu/sysemu.h | 1 -
>  vl.c                    | 1 -
>  3 files changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 8eb76a382c..b2dc0a80cb 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -217,15 +217,14 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>          }
>          g_free(boot_splash_filedata);
>          boot_splash_filedata =3D (uint8_t *)file_data;
> -        boot_splash_filedata_size =3D file_size;
> =20
>          /* insert data */
>          if (file_type =3D=3D JPG_FILE) {
>              fw_cfg_add_file(s, "bootsplash.jpg",
> -                    boot_splash_filedata, boot_splash_filedata_size);
> +                            boot_splash_filedata, file_size);
>          } else {
>              fw_cfg_add_file(s, "bootsplash.bmp",
> -                    boot_splash_filedata, boot_splash_filedata_size);
> +                            boot_splash_filedata, file_size);
>          }
>          g_free(filename);
>      }
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 89604a8328..6065d9e420 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -110,7 +110,6 @@ extern int old_param;
>  extern int boot_menu;
>  extern bool boot_strict;
>  extern uint8_t *boot_splash_filedata;
> -extern size_t boot_splash_filedata_size;
>  extern bool enable_mlock;
>  extern bool enable_cpu_pm;
>  extern QEMUClockType rtc_clock;
> diff --git a/vl.c b/vl.c
> index 4c5cc0d8ad..fad6fec38c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -188,7 +188,6 @@ const char *prom_envs[MAX_PROM_ENVS];
>  int boot_menu;
>  bool boot_strict;
>  uint8_t *boot_splash_filedata;
> -size_t boot_splash_filedata_size;
>  bool wakeup_suspend_enabled;
> =20
>  int icount_align_option;
>=20
