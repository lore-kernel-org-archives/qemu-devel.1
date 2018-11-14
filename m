Received: from eggs.gnu.org ([2001:4830:134:3::10]:60535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gMlbB-0000ei-VZ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 22:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gMlb8-0003No-0z
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 22:12:13 -0500
Received: from st13p11im-asmtp004.me.com ([17.164.40.219]:54095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1gMlb7-0003DL-SZ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 22:12:09 -0500
Received: from process-dkim-sign-daemon.st13p11im-asmtp004.me.com by
	st13p11im-asmtp004.me.com
	(Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built
	May 31 2018)) id <0PI500H00XYVWY00@st13p11im-asmtp004.me.com> for
	qemu-devel@nongnu.org; Wed, 14 Nov 2018 03:11:07 +0000 (GMT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
From: Chen Zhang <tgfbeta@me.com>
In-reply-to: <20181113090249.15658-1-kraxel@redhat.com>
Date: Wed, 14 Nov 2018 11:10:57 +0800
Content-transfer-encoding: quoted-printable
Message-id: <0EE77C7B-02AF-4666-90D3-53BF09585EBD@me.com>
References: <20181113090249.15658-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] gtk: sync guest display updates to host
 display refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, tgfbeta@me.com

Hi,

I have briefly tested this patch. Unfortunately, it apparently caused =
deteriorated performance on a previously working Windows 10 guest with =
DMA Buf.

The patched qemu not only clogged up graphics drawing, but also =
obstructed the guest OS. The boot time and latency for guest operations =
(e.g. clicking Start menu in guest) dramatically increased. My best =
guess would be that GTK update events messed up with some polling in =
main_loop_wait(false), leading to blocked IO, or conversely the GUI =
being blocked by IO.

Best regards,

--
P.S:

The arguments for qemu:

/tmp/qemu-system-x86_64 -nodefaults -machine =
pc,accel=3Dkvm,usb=3Doff,kernel_irqchip=3Don \
  -vga none -display gtk,gl=3Don  -rtc base=3Dlocaltime \
  -device =
vfio-pci,sysfsdev=3D/sys/bus/pci/devices/0000:00:02.0/{UUID-FOR-MDEV},x-ig=
d-opregion=3Don,display=3Don,rombar=3D0 \
  -m 3000 -realtime mlock=3Doff -smp 3,sockets=3D1,cores=3D1 \
  -drive file=3D/home/user/disk.img,format=3Dqcow2,media=3Ddisk,if=3Dide =
\
  -usb -device qemu-xhci,id=3Dxhci -device usb-tablet,bus=3Dxhci.0 \
  -cpu host -monitor stdio

The host runs a Ubuntu 18.04 desktop.

> On Nov 13, 2018, at 5:02 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> Reduce console refresh timer to idle refresh rate.  Register a frame
> tick callback (called by gtk on each display frame) and use that to =
kick
> display updates instead.
>=20
> That should sync qemu refresh rate to display refresh rate.  It'll =
also
> stop updating the qemu display in case the qemu is not visible (gtk
> stops calling the frame tick callback then).
>=20
> Buglink: https://bugs.launchpad.net/bugs/1802915
> Suggested-by: Chen Zhang <tgfbeta@me.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> ui/gtk.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>=20
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 579990b865..8f79dfe42c 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1661,6 +1661,16 @@ static gboolean gd_configure(GtkWidget *widget,
>     return FALSE;
> }
>=20
> +static gboolean gd_frame_tick(GtkWidget *widget,
> +                              GdkFrameClock *frame_clock,
> +                              gpointer opaque)
> +{
> +    VirtualConsole *vc =3D opaque;
> +
> +    vc->gfx.dcl.ops->dpy_refresh(&vc->gfx.dcl);
> +    return G_SOURCE_CONTINUE;
> +}
> +
> /** Virtual Console Callbacks **/
>=20
> static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole *vc,
> @@ -1911,6 +1921,12 @@ static void =
gd_connect_vc_gfx_signals(VirtualConsole *vc)
>                          G_CALLBACK(gd_focus_out_event), vc);
>         g_signal_connect(vc->gfx.drawing_area, "configure-event",
>                          G_CALLBACK(gd_configure), vc);
> +        if (1 /* make that a config option ??? */) {
> +            update_displaychangelistener(&vc->gfx.dcl,
> +                                         GUI_REFRESH_INTERVAL_IDLE);
> +            gtk_widget_add_tick_callback(vc->gfx.drawing_area,
> +                                         gd_frame_tick, vc, NULL);
> +        }
>     } else {
>         g_signal_connect(vc->gfx.drawing_area, "key-press-event",
>                          G_CALLBACK(gd_text_key_down), vc);
> --=20
> 2.9.3
>=20
