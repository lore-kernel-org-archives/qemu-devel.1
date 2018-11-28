Received: from eggs.gnu.org ([2001:4830:134:3::10]:54848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRvv2-0001T3-Nh
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRvux-0002EU-GZ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:14:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gRvux-0002Cb-76
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:13:59 -0500
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so1747140wmb.2
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 01:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20181128082243.29841-1-fziglio@redhat.com>
	<20181128082243.29841-2-fziglio@redhat.com>
In-Reply-To: <20181128082243.29841-2-fziglio@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Nov 2018 13:13:45 +0400
Message-ID: <CAJ+F1CJEt6z2Psp0k5ium1FhZVS4vNxrbKtU_VO7km13Xi=gtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH 2/2] spice: Bump required
 spice-server version to 0.12.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: spice-devel <spice-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Wed, Nov 28, 2018 at 12:23 PM Frediano Ziglio <fziglio@redhat.com> wrote=
:
>
> Version 0.12.6 was released on 12th June 2015.
>
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
>  chardev/spice.c         | 12 ------------
>  configure               |  4 ++--
>  hw/display/qxl.c        | 27 ---------------------------
>  hw/display/qxl.h        |  2 --
>  include/ui/qemu-spice.h | 12 ------------
>  ui/spice-core.c         |  8 --------
>  ui/spice-display.c      | 10 ----------
>  7 files changed, 2 insertions(+), 73 deletions(-)
>
> diff --git a/chardev/spice.c b/chardev/spice.c
> index e66e3ad568..e0b44474f5 100644
> --- a/chardev/spice.c
> +++ b/chardev/spice.c
> @@ -77,7 +77,6 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8=
_t *buf, int len)
>      return bytes;
>  }
>
> -#if SPICE_SERVER_VERSION >=3D 0x000c02
>  static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
>  {
>      SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
> @@ -95,7 +94,6 @@ static void vmc_event(SpiceCharDeviceInstance *sin, uin=
t8_t event)
>      trace_spice_vmc_event(chr_event);
>      qemu_chr_be_event(chr, chr_event);
>  }
> -#endif
>
>  static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
>  {
> @@ -119,12 +117,8 @@ static SpiceCharDeviceInterface vmc_interface =3D {
>      .state              =3D vmc_state,
>      .write              =3D vmc_write,
>      .read               =3D vmc_read,
> -#if SPICE_SERVER_VERSION >=3D 0x000c02
>      .event              =3D vmc_event,
> -#endif
> -#if SPICE_SERVER_VERSION >=3D 0x000c06
>      .flags              =3D SPICE_CHAR_DEVICE_NOTIFY_WRITABLE,
> -#endif
>  };
>
>
> @@ -223,9 +217,7 @@ static void char_spice_finalize(Object *obj)
>      }
>
>      g_free((char *)s->sin.subtype);
> -#if SPICE_SERVER_VERSION >=3D 0x000c02
>      g_free((char *)s->sin.portname);
> -#endif
>  }
>
>  static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
> @@ -240,7 +232,6 @@ static void spice_vmc_set_fe_open(struct Chardev *chr=
, int fe_open)
>
>  static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
>  {
> -#if SPICE_SERVER_VERSION >=3D 0x000c02
>      SpiceChardev *s =3D SPICE_CHARDEV(chr);
>
>      if (fe_open) {
> @@ -248,7 +239,6 @@ static void spice_port_set_fe_open(struct Chardev *ch=
r, int fe_open)
>      } else {
>          spice_server_port_event(&s->sin, SPICE_PORT_EVENT_CLOSED);
>      }
> -#endif
>  }
>
>  static void spice_chr_accept_input(struct Chardev *chr)
> @@ -298,7 +288,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
>      chr_open(chr, type);
>  }
>
> -#if SPICE_SERVER_VERSION >=3D 0x000c02
>  static void qemu_chr_open_spice_port(Chardev *chr,
>                                       ChardevBackend *backend,
>                                       bool *be_opened,
> @@ -331,7 +320,6 @@ void qemu_spice_register_ports(void)
>          vmc_register_interface(s);
>      }
>  }
> -#endif
>
>  static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend *bac=
kend,
>                                       Error **errp)
> diff --git a/configure b/configure
> index 0a3c6a72c3..b8f1fd053d 100755
> --- a/configure
> +++ b/configure
> @@ -4563,8 +4563,8 @@ int main(void) { spice_server_new(); return 0; }
>  EOF
>    spice_cflags=3D$($pkg_config --cflags spice-protocol spice-server 2>/d=
ev/null)
>    spice_libs=3D$($pkg_config --libs spice-protocol spice-server 2>/dev/n=
ull)
> -  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
> -     $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
> +  if $pkg_config --atleast-version=3D0.12.6 spice-server && \
> +     $pkg_config --atleast-version=3D0.12.10 spice-protocol && \

Why do you bump spice-protocol?

>       compile_prog "$spice_cflags" "$spice_libs" ; then
>      spice=3D"yes"
>      libs_softmmu=3D"$libs_softmmu $spice_libs"
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 9087db5dee..9387061ecb 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -276,11 +276,9 @@ static void qxl_spice_monitors_config_async(PCIQXLDe=
vice *qxl, int replay)
>                      QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG,
>                      0));
>      } else {
> -#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
>          if (qxl->max_outputs) {
>              spice_qxl_set_max_monitors(&qxl->ssd.qxl, qxl->max_outputs);
>          }
> -#endif
>          qxl->guest_monitors_config =3D qxl->ram->monitors_config;
>          spice_qxl_monitors_config_async(&qxl->ssd.qxl,
>                  qxl->ram->monitors_config,
> @@ -544,22 +542,6 @@ static void interface_set_compression_level(QXLInsta=
nce *sin, int level)
>      qxl_rom_set_dirty(qxl);
>  }
>
> -#if SPICE_NEEDS_SET_MM_TIME
> -static void interface_set_mm_time(QXLInstance *sin, uint32_t mm_time)
> -{
> -    PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, ssd.qxl);
> -
> -    if (!qemu_spice_display_is_running(&qxl->ssd)) {
> -        return;
> -    }
> -
> -    trace_qxl_interface_set_mm_time(qxl->id, mm_time);
> -    qxl->shadow_rom.mm_clock =3D cpu_to_le32(mm_time);
> -    qxl->rom->mm_clock =3D cpu_to_le32(mm_time);
> -    qxl_rom_set_dirty(qxl);
> -}
> -#endif
> -
>  static void interface_get_init_info(QXLInstance *sin, QXLDevInitInfo *in=
fo)
>  {
>      PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, ssd.qxl);
> @@ -1106,12 +1088,10 @@ static int interface_client_monitors_config(QXLIn=
stance *sin,
>          return 1;
>      }
>
> -#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
>      /* limit number of outputs based on setting limit */
>      if (qxl->max_outputs && qxl->max_outputs <=3D max_outputs) {
>          max_outputs =3D qxl->max_outputs;
>      }
> -#endif
>
>      config_changed =3D qxl_rom_monitors_config_changed(rom,
>                                                       monitors_config,
> @@ -1160,9 +1140,6 @@ static const QXLInterface qxl_interface =3D {
>
>      .attache_worker          =3D interface_attach_worker,
>      .set_compression_level   =3D interface_set_compression_level,
> -#if SPICE_NEEDS_SET_MM_TIME
> -    .set_mm_time             =3D interface_set_mm_time,
> -#endif
>      .get_init_info           =3D interface_get_init_info,
>
>      /* the callbacks below are called from spice server thread context *=
/
> @@ -1189,9 +1166,7 @@ static void qxl_enter_vga_mode(PCIQXLDevice *d)
>          return;
>      }
>      trace_qxl_enter_vga_mode(d->id);
> -#if SPICE_SERVER_VERSION >=3D 0x000c03 /* release 0.12.3 */
>      spice_qxl_driver_unload(&d->ssd.qxl);
> -#endif
>      graphic_console_set_hwops(d->ssd.dcl.con, d->vga.hw_ops, &d->vga);
>      update_displaychangelistener(&d->ssd.dcl, GUI_REFRESH_INTERVAL_DEFAU=
LT);
>      qemu_spice_create_host_primary(&d->ssd);
> @@ -2443,9 +2418,7 @@ static Property qxl_properties[] =3D {
>          DEFINE_PROP_UINT32("vram64_size_mb", PCIQXLDevice, vram_size_mb,=
 -1),
>          DEFINE_PROP_UINT32("vgamem_mb", PCIQXLDevice, vgamem_size_mb, 16=
),
>          DEFINE_PROP_INT32("surfaces", PCIQXLDevice, ssd.num_surfaces, 10=
24),
> -#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
>          DEFINE_PROP_UINT16("max_outputs", PCIQXLDevice, max_outputs, 0),
> -#endif
>          DEFINE_PROP_UINT32("xres", PCIQXLDevice, xres, 0),
>          DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
>          DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmst=
ate, false),
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index 6f9d1f21fa..0cba6c1875 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -102,9 +102,7 @@ typedef struct PCIQXLDevice {
>      QXLModes           *modes;
>      uint32_t           rom_size;
>      MemoryRegion       rom_bar;
> -#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
>      uint16_t           max_outputs;
> -#endif
>
>      /* vram pci bar */
>      uint64_t           vram_size;
> diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
> index c6d50eb87a..c10c211a07 100644
> --- a/include/ui/qemu-spice.h
> +++ b/include/ui/qemu-spice.h
> @@ -40,19 +40,7 @@ int qemu_spice_set_passwd(const char *passwd,
>  int qemu_spice_set_pw_expire(time_t expires);
>  int qemu_spice_migrate_info(const char *hostname, int port, int tls_port=
,
>                              const char *subject);
> -
> -#if !defined(SPICE_SERVER_VERSION) || (SPICE_SERVER_VERSION < 0xc06)
> -#define SPICE_NEEDS_SET_MM_TIME 1
> -#else
> -#define SPICE_NEEDS_SET_MM_TIME 0
> -#endif
> -
> -#if SPICE_SERVER_VERSION >=3D 0x000c02
>  void qemu_spice_register_ports(void);
> -#else
> -static inline Chardev *qemu_chr_open_spice_port(const char *name)
> -{ return NULL; }
> -#endif
>
>  #else  /* CONFIG_SPICE */
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 9d45d895ed..525e0929b9 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -745,13 +745,7 @@ void qemu_spice_init(void)
>      }
>
>      if (qemu_opt_get_bool(opts, "disable-agent-file-xfer", 0)) {
> -#if SPICE_SERVER_VERSION >=3D 0x000c04
>          spice_server_set_agent_file_xfer(spice_server, false);
> -#else
> -        error_report("this qemu build does not support the "
> -                     "\"disable-agent-file-xfer\" option");
> -        exit(1);
> -#endif
>      }
>
>      compression =3D SPICE_IMAGE_COMPRESSION_AUTO_GLZ;
> @@ -817,9 +811,7 @@ void qemu_spice_init(void)
>      g_free(x509_cert_file);
>      g_free(x509_cacert_file);
>
> -#if SPICE_SERVER_VERSION >=3D 0x000c02
>      qemu_spice_register_ports();
> -#endif
>
>  #ifdef HAVE_SPICE_GL
>      if (qemu_opt_get_bool(opts, "gl", 0)) {
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 52f8cb5ae1..15a3796d58 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -509,13 +509,6 @@ static void interface_set_compression_level(QXLInsta=
nce *sin, int level)
>      /* nothing to do */
>  }
>
> -#if SPICE_NEEDS_SET_MM_TIME
> -static void interface_set_mm_time(QXLInstance *sin, uint32_t mm_time)
> -{
> -    /* nothing to do */
> -}
> -#endif
> -
>  static void interface_get_init_info(QXLInstance *sin, QXLDevInitInfo *in=
fo)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(sin, SimpleSpiceDisplay, qx=
l);
> @@ -711,9 +704,6 @@ static const QXLInterface dpy_interface =3D {
>
>      .attache_worker          =3D interface_attach_worker,
>      .set_compression_level   =3D interface_set_compression_level,
> -#if SPICE_NEEDS_SET_MM_TIME
> -    .set_mm_time             =3D interface_set_mm_time,
> -#endif
>      .get_init_info           =3D interface_get_init_info,
>
>      /* the callbacks below are called from spice server thread context *=
/
> --
> 2.17.2
>
> _______________________________________________
> Spice-devel mailing list
> Spice-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/spice-devel



--=20
Marc-Andr=C3=A9 Lureau
