Received: from eggs.gnu.org ([2001:4830:134:3::10]:56279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOOcm-00036G-2O
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 07:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOOci-0002Fk-B9
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 07:55:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOOci-0002FY-5C
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 07:55:28 -0500
Date: Tue, 3 Jan 2017 12:55:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170103125522.GA518@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20161201094117.16407-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201094117.16407-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ui: use evdev keymap when running under
 wayland
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>

CC'ing Gerd as the ui/ maintainer

On Thu, Dec 01, 2016 at 09:41:17AM +0000, Daniel P. Berrange wrote:
> Wayland always uses evdev as its input source, so QEMU
> can use the existing evdev keymap data
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> 
> Changed in v2
> 
>  - Actually add all changed files to commit - gtk.h :-)
> 
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
> index e816428..81dba57 100644
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
> 2.9.3
> 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
