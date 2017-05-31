Received: from eggs.gnu.org ([2001:4830:134:3::10]:37186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG3NN-00089k-HR
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG3NK-0003xK-2K
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:09:25 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG3NJ-0003wa-Hg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:09:21 -0400
Received: by mail-lf0-x243.google.com with SMTP id 99so1364419lfu.2
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
	<20170529084546.26500-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170529084546.26500-14-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 13:09:09 +0000
Message-ID: <CAJ+F1CJdFHezQDn7Kx7=UdOvb2xD6gu_cJxTGo-uDJ2rRS8+WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/14] char: make chr_fe_deinit()
 optionaly delete backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org

ping, only patch left in the series without review

thanks

On Mon, May 29, 2017 at 12:56 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> This simplifies removing a backend for a frontend user (no need to
> retrive the associated driver and seperate delete call etc).
>
> NB: many frontends have questionable handling of ending a chardev. They
> should probably delete the backend to prevent broken reusage.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char-fe.h        |  6 ++++--
>  backends/rng-egd.c               |  2 +-
>  chardev/char-fe.c                |  5 ++++-
>  chardev/char-mux.c               |  2 +-
>  gdbstub.c                        | 15 ++-------------
>  hw/char/serial.c                 |  2 +-
>  hw/char/xen_console.c            |  2 +-
>  hw/core/qdev-properties-system.c |  2 +-
>  hw/usb/ccid-card-passthru.c      |  5 +----
>  hw/usb/redirect.c                |  4 +---
>  monitor.c                        |  2 +-
>  net/colo-compare.c               |  8 +++-----
>  net/filter-mirror.c              |  6 +++---
>  net/vhost-user.c                 |  5 +----
>  tests/test-char.c                | 22 ++++++++--------------
>  tests/vhost-user-test.c          |  4 +---
>  16 files changed, 34 insertions(+), 58 deletions(-)
>
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index bd82093218..2cbb262f66 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -30,12 +30,14 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s,
> Error **errp);
>
>  /**
>   * @qemu_chr_fe_deinit:
> - *
> + * @b: a CharBackend
> + * @del: if true, delete the chardev backend
> +*
>   * Dissociate the CharBackend from the Chardev.
>   *
>   * Safe to call without associated Chardev.
>   */
> -void qemu_chr_fe_deinit(CharBackend *b);
> +void qemu_chr_fe_deinit(CharBackend *b, bool del);
>
>  /**
>   * @qemu_chr_fe_get_driver:
> diff --git a/backends/rng-egd.c b/backends/rng-egd.c
> index ad3e1e5edf..e7ce2cac80 100644
> --- a/backends/rng-egd.c
> +++ b/backends/rng-egd.c
> @@ -145,7 +145,7 @@ static void rng_egd_finalize(Object *obj)
>  {
>      RngEgd *s =3D RNG_EGD(obj);
>
> -    qemu_chr_fe_deinit(&s->chr);
> +    qemu_chr_fe_deinit(&s->chr, false);
>      g_free(s->chr_name);
>  }
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 341221d029..3f90f0567c 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -211,7 +211,7 @@ unavailable:
>      return false;
>  }
>
> -void qemu_chr_fe_deinit(CharBackend *b)
> +void qemu_chr_fe_deinit(CharBackend *b, bool del)
>  {
>      assert(b);
>
> @@ -224,6 +224,9 @@ void qemu_chr_fe_deinit(CharBackend *b)
>              MuxChardev *d =3D MUX_CHARDEV(b->chr);
>              d->backends[b->tag] =3D NULL;
>          }
> +        if (del) {
> +            object_unparent(OBJECT(b->chr));
> +        }
>          b->chr =3D NULL;
>      }
>  }
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 106c682e7f..08570b915e 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -266,7 +266,7 @@ static void char_mux_finalize(Object *obj)
>              be->chr =3D NULL;
>          }
>      }
> -    qemu_chr_fe_deinit(&d->chr);
> +    qemu_chr_fe_deinit(&d->chr, false);
>  }
>
>  void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
> diff --git a/gdbstub.c b/gdbstub.c
> index 4251d23898..ec4e4b25be 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1678,9 +1678,6 @@ void gdb_exit(CPUArchState *env, int code)
>  {
>    GDBState *s;
>    char buf[4];
> -#ifndef CONFIG_USER_ONLY
> -  Chardev *chr;
> -#endif
>
>    s =3D gdbserver_state;
>    if (!s) {
> @@ -1690,19 +1687,13 @@ void gdb_exit(CPUArchState *env, int code)
>    if (gdbserver_fd < 0 || s->fd < 0) {
>        return;
>    }
> -#else
> -  chr =3D qemu_chr_fe_get_driver(&s->chr);
> -  if (!chr) {
> -      return;
> -  }
>  #endif
>
>    snprintf(buf, sizeof(buf), "W%02x", (uint8_t)code);
>    put_packet(s, buf);
>
>  #ifndef CONFIG_USER_ONLY
> -  qemu_chr_fe_deinit(&s->chr);
> -  object_unparent(OBJECT(chr));
> +  qemu_chr_fe_deinit(&s->chr, true);
>  #endif
>  }
>
> @@ -2002,9 +1993,7 @@ int gdbserver_start(const char *device)
>                                     NULL, &error_abort);
>          monitor_init(mon_chr, 0);
>      } else {
> -        if (qemu_chr_fe_get_driver(&s->chr)) {
> -            object_unparent(OBJECT(qemu_chr_fe_get_driver(&s->chr)));
> -        }
> +        qemu_chr_fe_deinit(&s->chr, true);
>          mon_chr =3D s->mon_chr;
>          memset(s, 0, sizeof(GDBState));
>          s->mon_chr =3D mon_chr;
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 23e5fe9d18..e1f12507bf 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -905,7 +905,7 @@ void serial_realize_core(SerialState *s, Error **errp=
)
>
>  void serial_exit_core(SerialState *s)
>  {
> -    qemu_chr_fe_deinit(&s->chr);
> +    qemu_chr_fe_deinit(&s->chr, false);
>
>      timer_del(s->modem_status_poll);
>      timer_free(s->modem_status_poll);
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index cb849c2e3e..f9af8cadf4 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -261,7 +261,7 @@ static void con_disconnect(struct XenDevice *xendev)
>  {
>      struct XenConsole *con =3D container_of(xendev, struct XenConsole,
> xendev);
>
> -    qemu_chr_fe_deinit(&con->chr);
> +    qemu_chr_fe_deinit(&con->chr, false);
>      xen_pv_unbind_evtchn(&con->xendev);
>
>      if (con->sring) {
> diff --git a/hw/core/qdev-properties-system.c
> b/hw/core/qdev-properties-system.c
> index a549d39030..3bef41914d 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -225,7 +225,7 @@ static void release_chr(Object *obj, const char *name=
,
> void *opaque)
>      Property *prop =3D opaque;
>      CharBackend *be =3D qdev_get_prop_ptr(dev, prop);
>
> -    qemu_chr_fe_deinit(be);
> +    qemu_chr_fe_deinit(be, false);
>  }
>
>  PropertyInfo qdev_prop_chr =3D {
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index fed3683a50..ac1725eeae 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -264,10 +264,7 @@ static void
> ccid_card_vscard_handle_message(PassthruState *card,
>
>  static void ccid_card_vscard_drop_connection(PassthruState *card)
>  {
> -    Chardev *chr =3D qemu_chr_fe_get_driver(&card->cs);
> -
> -    qemu_chr_fe_deinit(&card->cs);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&card->cs, true);
>      card->vscard_in_pos =3D card->vscard_in_hdr =3D 0;
>  }
>
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index d2b3a84a03..aa22d69216 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1419,10 +1419,8 @@ static void
> usbredir_cleanup_device_queues(USBRedirDevice *dev)
>  static void usbredir_unrealize(USBDevice *udev, Error **errp)
>  {
>      USBRedirDevice *dev =3D USB_REDIRECT(udev);
> -    Chardev *chr =3D qemu_chr_fe_get_driver(&dev->cs);
>
> -    qemu_chr_fe_deinit(&dev->cs);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&dev->cs, true);
>
>      /* Note must be done after qemu_chr_close, as that causes a close
> event */
>      qemu_bh_delete(dev->chardev_close_bh);
> diff --git a/monitor.c b/monitor.c
> index 37f8d5645f..75e7cd26d0 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -578,7 +578,7 @@ static void monitor_data_init(Monitor *mon)
>
>  static void monitor_data_destroy(Monitor *mon)
>  {
> -    qemu_chr_fe_deinit(&mon->chr);
> +    qemu_chr_fe_deinit(&mon->chr, false);
>      if (monitor_is_qmp(mon)) {
>          json_message_parser_destroy(&mon->qmp.parser);
>      }
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 2fb75bcca4..6d500e1dc4 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -801,11 +801,9 @@ static void colo_compare_finalize(Object *obj)
>  {
>      CompareState *s =3D COLO_COMPARE(obj);
>
> -    qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
> -                             s->worker_context, true);
> -    qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
> -                             s->worker_context, true);
> -    qemu_chr_fe_deinit(&s->chr_out);
> +    qemu_chr_fe_deinit(&s->chr_pri_in, false);
> +    qemu_chr_fe_deinit(&s->chr_sec_in, false);
> +    qemu_chr_fe_deinit(&s->chr_out, false);
>
>      g_main_loop_quit(s->compare_loop);
>      qemu_thread_join(&s->thread);
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index a20330475c..52d978fce2 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -178,15 +178,15 @@ static void filter_mirror_cleanup(NetFilterState *n=
f)
>  {
>      MirrorState *s =3D FILTER_MIRROR(nf);
>
> -    qemu_chr_fe_deinit(&s->chr_out);
> +    qemu_chr_fe_deinit(&s->chr_out, false);
>  }
>
>  static void filter_redirector_cleanup(NetFilterState *nf)
>  {
>      MirrorState *s =3D FILTER_REDIRECTOR(nf);
>
> -    qemu_chr_fe_deinit(&s->chr_in);
> -    qemu_chr_fe_deinit(&s->chr_out);
> +    qemu_chr_fe_deinit(&s->chr_in, false);
> +    qemu_chr_fe_deinit(&s->chr_out, false);
>  }
>
>  static void filter_mirror_setup(NetFilterState *nf, Error **errp)
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 526290d8c1..a042ec6a34 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -151,10 +151,7 @@ static void vhost_user_cleanup(NetClientState *nc)
>          s->vhost_net =3D NULL;
>      }
>      if (nc->queue_index =3D=3D 0) {
> -        Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
> -
> -        qemu_chr_fe_deinit(&s->chr);
> -        object_unparent(OBJECT(chr));
> +        qemu_chr_fe_deinit(&s->chr, true);
>      }
>
>      qemu_purge_queued_packets(nc);
> diff --git a/tests/test-char.c b/tests/test-char.c
> index d7ecf1056a..dfe856cb85 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -97,8 +97,7 @@ static void char_stdio_test_subprocess(void)
>      ret =3D qemu_chr_fe_write(&be, (void *)"buf", 4);
>      g_assert_cmpint(ret, =3D=3D, 4);
>
> -    qemu_chr_fe_deinit(&be);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&be, true);
>  }
>
>  static void char_stdio_test(void)
> @@ -146,8 +145,7 @@ static void char_ringbuf_test(void)
>      g_assert_cmpstr(data, =3D=3D, "");
>      g_free(data);
>
> -    qemu_chr_fe_deinit(&be);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&be, true);
>
>      /* check alias */
>      opts =3D qemu_opts_create(qemu_find_opts("chardev"), "memory-label",
> @@ -231,9 +229,8 @@ static void char_mux_test(void)
>      g_assert_cmpint(strlen(data), !=3D, 0);
>      g_free(data);
>
> -    qemu_chr_fe_deinit(&chr_be1);
> -    qemu_chr_fe_deinit(&chr_be2);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&chr_be1, false);
> +    qemu_chr_fe_deinit(&chr_be2, true);
>  }
>
>  typedef struct SocketIdleData {
> @@ -396,8 +393,7 @@ static void char_pipe_test(void)
>      g_assert_cmpint(fe.read_count, =3D=3D, 8);
>      g_assert_cmpstr(fe.read_buf, =3D=3D, "pipe-in");
>
> -    qemu_chr_fe_deinit(&be);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&be, true);
>
>      g_assert(g_unlink(in) =3D=3D 0);
>      g_assert(g_unlink(out) =3D=3D 0);
> @@ -511,8 +507,7 @@ static void char_file_test(void)
>
>          g_assert_cmpint(fe.read_count, =3D=3D, 8);
>          g_assert_cmpstr(fe.read_buf, =3D=3D, "fifo-in");
> -        qemu_chr_fe_deinit(&be);
> -        object_unref(OBJECT(chr));
> +        qemu_chr_fe_deinit(&be, true);
>          g_unlink(fifo);
>          g_free(fifo);
>      }
> @@ -549,7 +544,7 @@ static void char_null_test(void)
>      error_free_or_abort(&err);
>
>      /* deinit & reinit */
> -    qemu_chr_fe_deinit(&be);
> +    qemu_chr_fe_deinit(&be, false);
>      qemu_chr_fe_init(&be, chr, &error_abort);
>
>      qemu_chr_fe_set_open(&be, true);
> @@ -563,8 +558,7 @@ static void char_null_test(void)
>      ret =3D qemu_chr_fe_write(&be, (void *)"buf", 4);
>      g_assert_cmpint(ret, =3D=3D, 4);
>
> -    qemu_chr_fe_deinit(&be);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&be, true);
>  }
>
>  static void char_invalid_test(void)
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 4ca11ae28d..b3cc045765 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -488,10 +488,8 @@ static inline void test_server_connect(TestServer
> *server)
>  static gboolean _test_server_free(TestServer *server)
>  {
>      int i;
> -    Chardev *chr =3D qemu_chr_fe_get_driver(&server->chr);
>
> -    qemu_chr_fe_deinit(&server->chr);
> -    object_unparent(OBJECT(chr));
> +    qemu_chr_fe_deinit(&server->chr, true);
>
>      for (i =3D 0; i < server->fds_num; i++) {
>          close(server->fds[i]);
> --
> 2.13.0.91.g00982b8dd
>
>
> --
Marc-Andr=C3=A9 Lureau
