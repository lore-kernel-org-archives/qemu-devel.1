Received: from eggs.gnu.org ([2001:4830:134:3::10]:47771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehC5z-0001kb-Lt
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehC5l-0006EJ-D1
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:27:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ehC5l-0006Cy-4d
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:27:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8417C0587DB
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 10:27:39 +0000 (UTC)
Date: Thu, 1 Feb 2018 10:27:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180201102734.GF22810@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180201084535.26721-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201084535.26721-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vnc: use stubs for CONFIG_VNC=n dummy
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, Feb 01, 2018 at 09:45:35AM +0100, Gerd Hoffmann wrote:
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h | 21 ---------------------
>  ui/vnc-stubs.c       | 21 +++++++++++++++++++++
>  ui/Makefile.objs     |  1 +
>  3 files changed, 22 insertions(+), 21 deletions(-)
>  create mode 100644 ui/vnc-stubs.c

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 7b35778444..de57e8363a 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -468,31 +468,10 @@ static inline void cocoa_display_init(DisplayState *ds, int full_screen)
>  void vnc_display_init(const char *id);
>  void vnc_display_open(const char *id, Error **errp);
>  void vnc_display_add_client(const char *id, int csock, bool skipauth);
> -#ifdef CONFIG_VNC
>  int vnc_display_password(const char *id, const char *password);
>  int vnc_display_pw_expire(const char *id, time_t expires);
>  QemuOpts *vnc_parse(const char *str, Error **errp);
>  int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
> -#else
> -static inline int vnc_display_password(const char *id, const char *password)
> -{
> -    return -ENODEV;
> -}
> -static inline int vnc_display_pw_expire(const char *id, time_t expires)
> -{
> -    return -ENODEV;
> -};
> -static inline QemuOpts *vnc_parse(const char *str, Error **errp)
> -{
> -    error_setg(errp, "VNC support is disabled");
> -    return NULL;
> -}
> -static inline int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
> -{
> -    error_setg(errp, "VNC support is disabled");
> -    return -1;
> -}
> -#endif
>  
>  /* curses.c */
>  #ifdef CONFIG_CURSES
> diff --git a/ui/vnc-stubs.c b/ui/vnc-stubs.c
> new file mode 100644
> index 0000000000..f51280549a
> --- /dev/null
> +++ b/ui/vnc-stubs.c
> @@ -0,0 +1,21 @@
> +#include "qemu/osdep.h"
> +#include "ui/console.h"
> +
> +int vnc_display_password(const char *id, const char *password)
> +{
> +    return -ENODEV;
> +}
> +int vnc_display_pw_expire(const char *id, time_t expires)
> +{
> +    return -ENODEV;
> +};
> +QemuOpts *vnc_parse(const char *str, Error **errp)
> +{
> +    error_setg(errp, "VNC support is disabled");
> +    return NULL;
> +}
> +int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    error_setg(errp, "VNC support is disabled");
> +    return -1;
> +}
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index 99195884b0..09a275aed1 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -6,6 +6,7 @@ vnc-obj-y += vnc-auth-vencrypt.o
>  vnc-obj-$(CONFIG_VNC_SASL) += vnc-auth-sasl.o
>  vnc-obj-y += vnc-ws.o
>  vnc-obj-y += vnc-jobs.o
> +stub-obj-y += vnc-stubs.o
>  
>  common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
>  common-obj-y += input.o input-keymap.o input-legacy.o
> -- 
> 2.9.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
