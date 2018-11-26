Received: from eggs.gnu.org ([2001:4830:134:3::10]:46983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gR7Wj-00052l-Q5
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gR7Wf-0005Ed-Ow
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:25:37 -0500
Received: from pv33p00im-asmtp001.me.com ([17.142.194.250]:18114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1gR7Wf-0005DI-FX
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 22:25:33 -0500
Received: from process-dkim-sign-daemon.pv33p00im-asmtp001.me.com by
	pv33p00im-asmtp001.me.com
	(Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built
	May 31 2018)) id <0PIS004005QPTQ00@pv33p00im-asmtp001.me.com> for
	qemu-devel@nongnu.org; Mon, 26 Nov 2018 03:25:15 +0000 (GMT)
From: Chen Zhang <tgfbeta@me.com>
Message-id: <5DEFDB4A-2E16-4432-A9D7-66CD1BD6341A@me.com>
MIME-version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Date: Mon, 26 Nov 2018 11:24:52 +0800
In-reply-to: <9F7BCFFB-FCD5-4B6D-8536-E85D16D1A691@me.com>
References: <20181113090249.15658-1-kraxel@redhat.com>
	<0EE77C7B-02AF-4666-90D3-53BF09585EBD@me.com>
	<9F7BCFFB-FCD5-4B6D-8536-E85D16D1A691@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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

Update refresh interval upon frame tick;
Add callback of window state events to adjust refresh rate during =
iconified.
The callback handle is saved in struct VirtualConsole for its removal =
when the window is iconified.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 include/ui/gtk.h |  1 +
 ui/gtk.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 99edd3c..c1f7655 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -76,6 +76,7 @@ typedef struct VirtualConsole {
     GtkWidget *tab_item;
     GtkWidget *focus;
     VirtualConsoleType type;
+    guint frame_tick_cb;
     union {
         VirtualGfxConsole gfx;
 #if defined(CONFIG_VTE)
diff --git a/ui/gtk.c b/ui/gtk.c
index 579990b..9bc5812 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1661,6 +1661,43 @@ static gboolean gd_configure(GtkWidget *widget,
     return FALSE;
 }
=20
+static gboolean gd_frame_tick(GtkWidget *widget,
+                              GdkFrameClock *frame_clock,
+                              gpointer opaque)
+{
+    VirtualConsole *vc =3D opaque;
+    gint64 interval;
+    gdk_frame_clock_get_refresh_info(frame_clock,
+            0,
+            &interval,
+            NULL);
+    interval =3D interval / 1000;
+    if (vc->gfx.dcl.update_interval !=3D interval) {
+        update_displaychangelistener(&vc->gfx.dcl, interval);
+    }
+    return G_SOURCE_CONTINUE;
+}
+
+static void gd_window_state_event(GtkWidget *widget,
+                           GdkEventWindowState *event,
+                           GtkDisplayState *s)
+{
+    if (event->changed_mask & GDK_WINDOW_STATE_ICONIFIED) {
+        bool iconified =3D (event->new_window_state & =
GDK_WINDOW_STATE_ICONIFIED) !=3D 0;
+        VirtualConsole *vc =3D gd_vc_find_current(s);
+        if (iconified) {
+            gtk_widget_remove_tick_callback(vc->gfx.drawing_area,
+                                            vc->frame_tick_cb);
+            update_displaychangelistener(&vc->gfx.dcl, =
GUI_REFRESH_INTERVAL_IDLE);
+        } else {
+            vc->frame_tick_cb =3D
+                gtk_widget_add_tick_callback(vc->gfx.drawing_area,
+                                             gd_frame_tick, vc, NULL);
+            update_displaychangelistener(&vc->gfx.dcl, =
GUI_REFRESH_INTERVAL_DEFAULT);
+        }
+    }
+}
+
 /** Virtual Console Callbacks **/
=20
 static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole *vc,
@@ -1911,6 +1948,17 @@ static void =
gd_connect_vc_gfx_signals(VirtualConsole *vc)
                          G_CALLBACK(gd_focus_out_event), vc);
         g_signal_connect(vc->gfx.drawing_area, "configure-event",
                          G_CALLBACK(gd_configure), vc);
+        if (1 /* make that a config option ??? */) {
+            update_displaychangelistener(&vc->gfx.dcl,
+                                         GUI_REFRESH_INTERVAL_IDLE);
+            vc->frame_tick_cb =3D
+                    gtk_widget_add_tick_callback(vc->gfx.drawing_area,
+                                                 gd_frame_tick, vc, =
NULL);
+
+            gtk_widget_add_events(vc->s->window, GDK_STRUCTURE_MASK);
+            g_signal_connect(vc->s->window, "window-state-event",
+                             G_CALLBACK(gd_window_state_event), vc->s);
+        }
     } else {
         g_signal_connect(vc->gfx.drawing_area, "key-press-event",
                          G_CALLBACK(gd_text_key_down), vc);
--=20
2.7.4


> On Nov 14, 2018, at 5:40 PM, Chen Zhang <tgfbeta@me.com> wrote:
>=20
> Additionally, the aforementioned patch performs OK for non-vfio OpenGL =
enabled GTK displays, and fails DMA Buf iGVT-g display only, so far as I =
could tell.
>=20
> Perhaps a change like the following is better?
>=20
>  static gboolean gd_frame_tick(GtkWidget *widget,
>                                GdkFrameClock *frame_clock,
>                                gpointer opaque)
>  {
>      VirtualConsole *vc =3D opaque;
> -
> -    vc->gfx.dcl.ops->dpy_refresh(&vc->gfx.dcl);
> +    gint64 interval;
> +    gdk_frame_clock_get_refresh_info(frame_clock,
> +            0,
> +            &interval,
> +            NULL);
> +    interval /=3D 1000;
> +    if (vc->gfx.dcl.update_interval !=3D interval) {
> +        update_displaychangelistener(&vc->gfx.dcl, interval);
> +    }
>      return G_SOURCE_CONTINUE;
>  }
>=20
>=20
>> On Nov 14, 2018, at 11:10 AM, Chen Zhang <tgfbeta@me.com =
<mailto:tgfbeta@me.com>> wrote:
>>=20
>> Hi,
>>=20
>> I have briefly tested this patch. Unfortunately, it apparently caused =
deteriorated performance on a previously working Windows 10 guest with =
DMA Buf.
>>=20
>> The patched qemu not only clogged up graphics drawing, but also =
obstructed the guest OS. The boot time and latency for guest operations =
(e.g. clicking Start menu in guest) dramatically increased. My best =
guess would be that GTK update events messed up with some polling in =
main_loop_wait(false), leading to blocked IO, or conversely the GUI =
being blocked by IO.
>>=20
>> Best regards,
>>=20
>> --
>> P.S:
>>=20
>> The arguments for qemu:
>>=20
>> /tmp/qemu-system-x86_64 -nodefaults -machine =
pc,accel=3Dkvm,usb=3Doff,kernel_irqchip=3Don \
>>  -vga none -display gtk,gl=3Don  -rtc base=3Dlocaltime \
>>  -device =
vfio-pci,sysfsdev=3D/sys/bus/pci/devices/0000:00:02.0/{UUID-FOR-MDEV},x-ig=
d-opregion=3Don,display=3Don,rombar=3D0 \
>>  -m 3000 -realtime mlock=3Doff -smp 3,sockets=3D1,cores=3D1 \
>>  -drive file=3D/home/user/disk.img,format=3Dqcow2,media=3Ddisk,if=3Dide=
 \
>>  -usb -device qemu-xhci,id=3Dxhci -device usb-tablet,bus=3Dxhci.0 \
>>  -cpu host -monitor stdio
>>=20
>> The host runs a Ubuntu 18.04 desktop.
>>=20
>>> On Nov 13, 2018, at 5:02 PM, Gerd Hoffmann <kraxel@redhat.com =
<mailto:kraxel@redhat.com>> wrote:
>>>=20
>>> Reduce console refresh timer to idle refresh rate.  Register a frame
>>> tick callback (called by gtk on each display frame) and use that to =
kick
>>> display updates instead.
>>>=20
>>> That should sync qemu refresh rate to display refresh rate.  It'll =
also
>>> stop updating the qemu display in case the qemu is not visible (gtk
>>> stops calling the frame tick callback then).
>>>=20
>>> Buglink: https://bugs.launchpad.net/bugs/1802915 =
<https://bugs.launchpad.net/bugs/1802915>
>>> Suggested-by: Chen Zhang <tgfbeta@me.com <mailto:tgfbeta@me.com>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com =
<mailto:kraxel@redhat.com>>
>>> ---
>>> ui/gtk.c | 16 ++++++++++++++++
>>> 1 file changed, 16 insertions(+)
>>>=20
>>> diff --git a/ui/gtk.c b/ui/gtk.c
>>> index 579990b865..8f79dfe42c 100644
>>> --- a/ui/gtk.c
>>> +++ b/ui/gtk.c
>>> @@ -1661,6 +1661,16 @@ static gboolean gd_configure(GtkWidget =
*widget,
>>>    return FALSE;
>>> }
>>>=20
>>> +static gboolean gd_frame_tick(GtkWidget *widget,
>>> +                              GdkFrameClock *frame_clock,
>>> +                              gpointer opaque)
>>> +{
>>> +    VirtualConsole *vc =3D opaque;
>>> +
>>> +    vc->gfx.dcl.ops->dpy_refresh(&vc->gfx.dcl);
>>> +    return G_SOURCE_CONTINUE;
>>> +}
>>> +
>>> /** Virtual Console Callbacks **/
>>>=20
>>> static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole =
*vc,
>>> @@ -1911,6 +1921,12 @@ static void =
gd_connect_vc_gfx_signals(VirtualConsole *vc)
>>>                         G_CALLBACK(gd_focus_out_event), vc);
>>>        g_signal_connect(vc->gfx.drawing_area, "configure-event",
>>>                         G_CALLBACK(gd_configure), vc);
>>> +        if (1 /* make that a config option ??? */) {
>>> +            update_displaychangelistener(&vc->gfx.dcl,
>>> +                                         =
GUI_REFRESH_INTERVAL_IDLE);
>>> +            gtk_widget_add_tick_callback(vc->gfx.drawing_area,
>>> +                                         gd_frame_tick, vc, NULL);
>>> +        }
>>>    } else {
>>>        g_signal_connect(vc->gfx.drawing_area, "key-press-event",
>>>                         G_CALLBACK(gd_text_key_down), vc);
>>> --=20
>>> 2.9.3
>>>=20
>>=20
>=20
