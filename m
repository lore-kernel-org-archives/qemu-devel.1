Received: from eggs.gnu.org ([2001:4830:134:3::10]:49229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT3dP-0004Td-FO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cT3dL-0002cK-MT
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:31:27 -0500
Date: Mon, 16 Jan 2017 09:31:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170116093116.GD13096@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
	<1483967385-12891-3-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483967385-12891-3-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 02/11] ui: use evdev keymap when running
 under wayland
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org

CC qemu-stable

This patch should go into active stable branches given that wayland is
now the default on some OS distro....

On Mon, Jan 09, 2017 at 02:09:36PM +0100, Gerd Hoffmann wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
> 
> Wayland always uses evdev as its input source, so QEMU
> can use the existing evdev keymap data
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 20161201094117.16407-1-berrange@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/gtk.h | 4 ++++
>  ui/gtk.c         | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index 42ca0fe..b3b5005 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -18,6 +18,10 @@
>  #include <X11/XKBlib.h>
>  #endif
>  
> +#ifdef GDK_WINDOWING_WAYLAND
> +#include <gdk/gdkwayland.h>
> +#endif
> +
>  #if defined(CONFIG_OPENGL)
>  #include "ui/egl-helpers.h"
>  #include "ui/egl-context.h"
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 406de4f..356f400 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -90,6 +90,9 @@
>  #ifndef GDK_IS_X11_DISPLAY
>  #define GDK_IS_X11_DISPLAY(dpy) (dpy == dpy)
>  #endif
> +#ifndef GDK_IS_WAYLAND_DISPLAY
> +#define GDK_IS_WAYLAND_DISPLAY(dpy) (dpy == dpy)
> +#endif
>  #ifndef GDK_IS_WIN32_DISPLAY
>  #define GDK_IS_WIN32_DISPLAY(dpy) (dpy == dpy)
>  #endif
> @@ -1054,6 +1057,10 @@ static int gd_map_keycode(GtkDisplayState *s, GdkDisplay *dpy, int gdk_keycode)
>              qemu_keycode = translate_xfree86_keycode(gdk_keycode - 97);
>          }
>  #endif
> +#ifdef GDK_WINDOWING_WAYLAND
> +    } else if (GDK_IS_WAYLAND_DISPLAY(dpy) && gdk_keycode < 158) {
> +        qemu_keycode = translate_evdev_keycode(gdk_keycode - 97);
> +#endif
>      } else if (gdk_keycode == 208) { /* Hiragana_Katakana */
>          qemu_keycode = 0x70;
>      } else if (gdk_keycode == 211) { /* backslash */
> -- 
> 1.8.3.1
> 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
