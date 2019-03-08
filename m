Received: from eggs.gnu.org ([209.51.188.92]:34908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2DUG-0006Ij-Rd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2DUF-0000ED-1E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:16:24 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-13-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <639f6fd4-3155-0238-612b-e3ec6479340c@redhat.com>
Date: Fri, 8 Mar 2019 12:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/18] hw/nvram/fw_cfg: Keep reference
 of file_data in FWCfgState
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
> The 'file_data' is allocated by read_splashfile() (introduced in
> commit 3d3b8303c6f8).  It is then used by fw_cfg_add_file(). Due
> to the contract interface of fw_cfg_add_file(), it has to be valid
> for the lifetime of the FwCfg object.
>=20
> Keep a reference of 'file_data' in FWCfgState to be able to
> free this memory in fw_cfg_common_unrealize().
> We can now remove the res_free() from the main() loop.
> The global boot_splash_filedata is now unused, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c         | 10 ++++++----
>  include/hw/nvram/fw_cfg.h |  1 +
>  include/sysemu/sysemu.h   |  1 -
>  vl.c                      |  9 ---------
>  4 files changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 3ac6687a04..fc392cb7e0 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -215,16 +215,16 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>              g_free(filename);
>              return;
>          }
> -        g_free(boot_splash_filedata);
> -        boot_splash_filedata =3D (uint8_t *)file_data;
> +        g_free(s->boot_splash.file_data);
> +        s->boot_splash.file_data =3D file_data;
> =20
>          /* insert data */
>          if (file_type =3D=3D JPG_FILE) {
>              fw_cfg_add_file(s, "bootsplash.jpg",
> -                            boot_splash_filedata, file_size);
> +                            s->boot_splash.file_data, file_size);
>          } else {
>              fw_cfg_add_file(s, "bootsplash.bmp",
> -                            boot_splash_filedata, file_size);
> +                            s->boot_splash.file_data, file_size);
>          }
>          g_free(filename);
>      }
> @@ -974,6 +974,8 @@ static void fw_cfg_common_unrealize(DeviceState *de=
v, Error **errp)
> =20
>      g_free(s->files);
> =20
> +    g_free(s->boot_splash.file_data);
> +
>      g_free(s->entries[0]);
>      g_free(s->entries[1]);
>      g_free(s->entry_order);
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index fcb771186c..83a0540b6c 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -56,6 +56,7 @@ struct FWCfgState {
> =20
>      uint32_t reboot_timeout;
>      struct {
> +        char *file_data;
>          uint16_t time_le16;
>      } boot_splash;
>  };
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 6065d9e420..3cd856b015 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -109,7 +109,6 @@ extern int no_shutdown;
>  extern int old_param;
>  extern int boot_menu;
>  extern bool boot_strict;
> -extern uint8_t *boot_splash_filedata;
>  extern bool enable_mlock;
>  extern bool enable_cpu_pm;
>  extern QEMUClockType rtc_clock;
> diff --git a/vl.c b/vl.c
> index fad6fec38c..47dd63a309 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -187,7 +187,6 @@ unsigned int nb_prom_envs =3D 0;
>  const char *prom_envs[MAX_PROM_ENVS];
>  int boot_menu;
>  bool boot_strict;
> -uint8_t *boot_splash_filedata;
>  bool wakeup_suspend_enabled;
> =20
>  int icount_align_option;
> @@ -558,12 +557,6 @@ const char *qemu_get_vm_name(void)
>      return qemu_name;
>  }
> =20
> -static void res_free(void)
> -{
> -    g_free(boot_splash_filedata);
> -    boot_splash_filedata =3D NULL;
> -}
> -
>  static int default_driver_check(void *opaque, QemuOpts *opts, Error **=
errp)
>  {
>      const char *driver =3D qemu_opt_get(opts, "driver");
> @@ -4591,8 +4584,6 @@ int main(int argc, char **argv, char **envp)
>      job_cancel_sync_all();
>      bdrv_close_all();
> =20
> -    res_free();
> -
>      /* vhost-user must be cleaned up before chardevs.  */
>      tpm_cleanup();
>      net_cleanup();
>=20

Referring to the earlier thread

  [Qemu-devel] [PATCH] hw/nvram/fw_cfg: Move boot_splash_filedata
                       variables into fw_cfg.c
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg599282.html

my opinion is that *all* of the g_free() calls touched in this patch are
presently -- that is, pre-patch -- bogus:

- As I wrote earlier, res_free() may be reached, but the freeing it does
is useless.

- Furthermore, the g_free() call in fw_cfg_bootsplash() never frees
anything in reality. It is only called from fw_cfg_common_realize(), and
we only have one fw_cfg object (which is never destructed, for now).

So, first I would kill these bogus g_free()s altogether, in a separate
patch (in the separate series that I've recommended elsewhere). Then, in
a second patch (in the separate series), I would include the boot splash
image among the dynamically tracked allocations. Just add it to a linked
list, and when the fw_cfg object is destroyed, release it with the rest.

(Another note (and I should have made it earlier): fw_cfg_modify_i16()
will face a challenge; it will have to update the tracker data structure
too.)

Thanks
Laszlo
