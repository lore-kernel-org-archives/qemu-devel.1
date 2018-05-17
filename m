Received: from eggs.gnu.org ([2001:4830:134:3::10]:35430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJIGR-0006Uo-0M
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJIGN-0006F3-NH
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:44:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fJIGN-0006Ep-Ib
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:44:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6ECFBB405
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:44:06 +0000 (UTC)
Date: Thu, 17 May 2018 13:44:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180517124403.GJ5657@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Thu, May 17, 2018 at 02:39:42PM +0200, Paolo Bonzini wrote:
> x_keymap.o is common to the SDL and GTK+ modules, and it causes the
> QEMU binary to link to the X11 libraries.  Add it separately to the
> modules to keep the main QEMU binary smaller.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  ui/Makefile.objs | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index cc78434..00f6976 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -15,10 +15,6 @@ common-obj-$(CONFIG_COCOA) += cocoa.o
>  common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
>  common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
>  
> -common-obj-$(CONFIG_X11) += x_keymap.o
> -x_keymap.o-cflags := $(X11_CFLAGS)
> -x_keymap.o-libs := $(X11_LIBS)
> -
>  # ui-sdl module
>  common-obj-$(CONFIG_SDL) += sdl.mo
>  ifeq ($(CONFIG_SDLABI),1.2)
> @@ -46,6 +42,13 @@ gtk.mo-objs += gtk-gl-area.o
>  endif
>  endif
>  
> +ifeq ($(CONFIG_X11),y)
> +sdl.mo-objs += x_keymap.o
> +gtk.mo-objs += x_keymap.o

Would this cause symbol clash if both sdl & gtk modules are loaded
at the same time, or have we used linker scripts to limit what symbols
each module exposes ?

> +x_keymap.o-cflags := $(X11_CFLAGS)
> +x_keymap.o-libs := $(X11_LIBS)
> +endif
> +
>  common-obj-$(CONFIG_CURSES) += curses.mo
>  curses.mo-objs := curses.o
>  curses.mo-cflags := $(CURSES_CFLAGS)
> -- 
> 1.8.3.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
