Received: from eggs.gnu.org ([2001:4830:134:3::10]:35160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehIX0-0004Kv-TV
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehIWx-0006wA-9P
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:20:14 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehIWx-0006uQ-3K
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:20:11 -0500
Received: by mail-wr0-f194.google.com with SMTP id y3so9989616wrh.3
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 09:20:10 -0800 (PST)
References: <20180201084535.26721-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c09ffc0-0a85-d2c3-fd94-7753ee3ca74d@redhat.com>
Date: Thu, 1 Feb 2018 12:20:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180201084535.26721-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 01/02/2018 03:45, Gerd Hoffmann wrote:
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h | 21 ---------------------
>  ui/vnc-stubs.c       | 21 +++++++++++++++++++++
>  ui/Makefile.objs     |  1 +
>  3 files changed, 22 insertions(+), 21 deletions(-)
>  create mode 100644 ui/vnc-stubs.c
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

Better, since vnc need not be linked into tools or user-mode emulation:

common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o

Paolo

>  common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
>  common-obj-y += input.o input-keymap.o input-legacy.o
> 
