Received: from eggs.gnu.org ([2001:4830:134:3::10]:57655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gRw1s-0005EF-Ir
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gRw1p-0002WI-ET
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:21:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gRw1p-0002Ve-6x
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:21:05 -0500
Date: Wed, 28 Nov 2018 04:21:03 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <1556568312.46074808.1543396863497.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAJ+F1CJEt6z2Psp0k5ium1FhZVS4vNxrbKtU_VO7km13Xi=gtg@mail.gmail.com>
References: <20181128082243.29841-1-fziglio@redhat.com>
	<20181128082243.29841-2-fziglio@redhat.com>
	<CAJ+F1CJEt6z2Psp0k5ium1FhZVS4vNxrbKtU_VO7km13Xi=gtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: spice-devel <spice-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>

> 
> On Wed, Nov 28, 2018 at 12:23 PM Frediano Ziglio <fziglio@redhat.com> wrote:
> >
> > Version 0.12.6 was released on 12th June 2015.
> >
> > Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> > ---
> >  chardev/spice.c         | 12 ------------
> >  configure               |  4 ++--
> >  hw/display/qxl.c        | 27 ---------------------------
> >  hw/display/qxl.h        |  2 --
> >  include/ui/qemu-spice.h | 12 ------------
> >  ui/spice-core.c         |  8 --------
> >  ui/spice-display.c      | 10 ----------
> >  7 files changed, 2 insertions(+), 73 deletions(-)
> >
> > diff --git a/chardev/spice.c b/chardev/spice.c
> > index e66e3ad568..e0b44474f5 100644
> > --- a/chardev/spice.c
> > +++ b/chardev/spice.c
> > @@ -77,7 +77,6 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8_t
> > *buf, int len)
> >      return bytes;
> >  }
> >
> > -#if SPICE_SERVER_VERSION >= 0x000c02
> >  static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
> >  {
> >      SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
> > @@ -95,7 +94,6 @@ static void vmc_event(SpiceCharDeviceInstance *sin,
> > uint8_t event)
> >      trace_spice_vmc_event(chr_event);
> >      qemu_chr_be_event(chr, chr_event);
> >  }
> > -#endif
> >
> >  static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
> >  {
> > @@ -119,12 +117,8 @@ static SpiceCharDeviceInterface vmc_interface = {
> >      .state              = vmc_state,
> >      .write              = vmc_write,
> >      .read               = vmc_read,
> > -#if SPICE_SERVER_VERSION >= 0x000c02
> >      .event              = vmc_event,
> > -#endif
> > -#if SPICE_SERVER_VERSION >= 0x000c06
> >      .flags              = SPICE_CHAR_DEVICE_NOTIFY_WRITABLE,
> > -#endif
> >  };
> >
> >
> > @@ -223,9 +217,7 @@ static void char_spice_finalize(Object *obj)
> >      }
> >
> >      g_free((char *)s->sin.subtype);
> > -#if SPICE_SERVER_VERSION >= 0x000c02
> >      g_free((char *)s->sin.portname);
> > -#endif
> >  }
> >
> >  static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
> > @@ -240,7 +232,6 @@ static void spice_vmc_set_fe_open(struct Chardev *chr,
> > int fe_open)
> >
> >  static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
> >  {
> > -#if SPICE_SERVER_VERSION >= 0x000c02
> >      SpiceChardev *s = SPICE_CHARDEV(chr);
> >
> >      if (fe_open) {
> > @@ -248,7 +239,6 @@ static void spice_port_set_fe_open(struct Chardev *chr,
> > int fe_open)
> >      } else {
> >          spice_server_port_event(&s->sin, SPICE_PORT_EVENT_CLOSED);
> >      }
> > -#endif
> >  }
> >
> >  static void spice_chr_accept_input(struct Chardev *chr)
> > @@ -298,7 +288,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
> >      chr_open(chr, type);
> >  }
> >
> > -#if SPICE_SERVER_VERSION >= 0x000c02
> >  static void qemu_chr_open_spice_port(Chardev *chr,
> >                                       ChardevBackend *backend,
> >                                       bool *be_opened,
> > @@ -331,7 +320,6 @@ void qemu_spice_register_ports(void)
> >          vmc_register_interface(s);
> >      }
> >  }
> > -#endif
> >
> >  static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend
> >  *backend,
> >                                       Error **errp)
> > diff --git a/configure b/configure
> > index 0a3c6a72c3..b8f1fd053d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -4563,8 +4563,8 @@ int main(void) { spice_server_new(); return 0; }
> >  EOF
> >    spice_cflags=$($pkg_config --cflags spice-protocol spice-server
> >    2>/dev/null)
> >    spice_libs=$($pkg_config --libs spice-protocol spice-server 2>/dev/null)
> > -  if $pkg_config --atleast-version=0.12.0 spice-server && \
> > -     $pkg_config --atleast-version=0.12.3 spice-protocol && \
> > +  if $pkg_config --atleast-version=0.12.6 spice-server && \
> > +     $pkg_config --atleast-version=0.12.10 spice-protocol && \
> 
> Why do you bump spice-protocol?
> 

Why not? spice-server 0.12.6 requires spice-protocol 0.12.10.

Frediano
