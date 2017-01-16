Received: from eggs.gnu.org ([2001:4830:134:3::10]:53734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT3qV-0007Kt-Hr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT3qR-0007pk-9P
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:44:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:39418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cT3qR-0007p2-34
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:44:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cT3qO-0001CN-6T
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:44:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1F5D42E80C2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:44:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 09:30:03 -0000
From: Daniel Berrange <1578192@bugs.launchpad.net>
Reply-To: Bug 1578192 <1578192@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160504123823.5625.5258.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170116093004.27129.9561.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1578192] Re: GTK+ interface doesn't translate
 keycodes properly with Wayland backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This issue was fixed already in git master with:

commit a8ffb372a2202c65f42fdb69891ea68a2f274b55
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Thu Dec 1 09:41:17 2016 +0000

    ui: use evdev keymap when running under wayland
    =

    Wayland always uses evdev as its input source, so QEMU
    can use the existing evdev keymap data
    =

    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
    Message-id: 20161201094117.16407-1-berrange@redhat.com
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1578192

Title:
  GTK+ interface doesn't translate keycodes properly with Wayland
  backend

Status in QEMU:
  Fix Committed

Bug description:
  I already posted this on the mailing list
  (https://lists.nongnu.org/archive/html/qemu-
  devel/2016-05/msg00119.html) but I decided to do a formal bug report
  so it can be tracked and doesn't get lost.

  ... I'm no expert, but it looks like GTK+ key events come in at the
  ui/gtk.c:gd_key_event callback function, which calls
  ui/gtk.c:gd_map_keycode to translate the GTK+ keycode into the Qemu
  keycode before sending it on using qemu_input_event_send_key_number.
  The problem is that gd_map_keycode is incomplete when GTK+ is running
  on a backend other than X11.

  static int gd_map_keycode(GtkDisplayState *s, GdkDisplay *dpy, int gdk_ke=
ycode)
  {
      int qemu_keycode;

  #ifdef GDK_WINDOWING_WIN32
      if (GDK_IS_WIN32_DISPLAY(dpy)) {
          qemu_keycode =3D MapVirtualKey(gdk_keycode, MAPVK_VK_TO_VSC);
          switch (qemu_keycode) {
          case 103:   /* alt gr */
              qemu_keycode =3D 56 | SCANCODE_GREY;
              break;
          }
          return qemu_keycode;
      }
  #endif

      if (gdk_keycode < 9) {
          qemu_keycode =3D 0;
      } else if (gdk_keycode < 97) {
          qemu_keycode =3D gdk_keycode - 8;
  #ifdef GDK_WINDOWING_X11
      } else if (GDK_IS_X11_DISPLAY(dpy) && gdk_keycode < 158) {
          if (s->has_evdev) {
              qemu_keycode =3D translate_evdev_keycode(gdk_keycode - 97);
          } else {
              qemu_keycode =3D translate_xfree86_keycode(gdk_keycode - 97);
          }
  #endif
      } else if (gdk_keycode =3D=3D 208) { /* Hiragana_Katakana */
          qemu_keycode =3D 0x70;
      } else if (gdk_keycode =3D=3D 211) { /* backslash */
          qemu_keycode =3D 0x73;
      } else {
          qemu_keycode =3D 0;
      }

      return qemu_keycode;
  }

  In my case, I'm using GTK+'s Wayland backend, so keycodes 97 through
  157 (this includes KEY_HOME(102), KEY_PAGEUP(104), KEY_PAGEDOWN(109),
  KEY_END(107), etc.) are never translated into a qemu_keycode, and the
  final 'else' block is hit, causing gd_map_keycode to return 0, which
  is an invalid keycode and thus cannot be handled by xen-kbdfront. At
  least that's my best guess as to what is happening.

  The solution that comes to mind is provide an alternative to
  translate_{evdev,xfree86}_keycode that is compatable with
  Wayland/libinput, but I don't know exactly which API would provide
  this functionality, much less do I have a patch. Intuition tells me
  that translate_evdev_keycode would probably work under Wayland because
  Weston uses libinput which uses evdev as its backend, but I don't know
  this for a fact, and I don't know if it would be the Right Way (i.e.
  Wayland or libinput might provide an API for this purpose, but I don't
  know).

  I may try to do some testing with translate_evdev_keycode on Wayland
  and also look into any possible APIs for keycode translation, but I
  just wanted to put it out there and get some feedback awhile.

  Qemu 2.2.1 from Xen 4.6.1 (relevant code appears unchanged in Qemu master)
  GTK+ 3.18.7
  Wayland 1.9.0
  Weston 1.9.0
  libinput 1.2.3

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1578192/+subscriptions
