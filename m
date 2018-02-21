Received: from eggs.gnu.org ([2001:4830:134:3::10]:54876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoVX9-0002nb-5o
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoVX1-0007zR-Ci
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:38:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eoVX1-0007zA-76
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:38:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D085240201A0
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:38:02 +0000 (UTC)
Date: Wed, 21 Feb 2018 14:38:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180221143800.GW17096@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180220150357.324-1-kraxel@redhat.com>
	<20180220150357.324-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180220150357.324-3-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] keymap: use glib hash for
 kbd_layout_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Feb 20, 2018 at 04:03:54PM +0100, Gerd Hoffmann wrote:
> Drop home-grown lookup code, which is a strange mix of a lookup table
> and a list.  Use standard glib hash instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/keymaps.c    | 79 +++++++++++++++++++++++++++------------------------------
>  ui/trace-events |  2 +-
>  2 files changed, 38 insertions(+), 43 deletions(-)


> 
> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 134958a197..bef1405576 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -28,26 +28,28 @@
>  #include "trace.h"
>  #include "qemu/error-report.h"
>  
> -#define MAX_NORMAL_KEYCODE 512
> -#define MAX_EXTRA_COUNT 256
> -
>  struct key_range {
>      int start;
>      int end;
>      struct key_range *next;
>  };
>  
> +struct keysym2code {
> +    uint16_t keycode;
> +};
> +
>  struct kbd_layout_t {
> -    uint16_t keysym2keycode[MAX_NORMAL_KEYCODE];
> -    struct {
> -        int keysym;
> -        uint16_t keycode;
> -    } keysym2keycode_extra[MAX_EXTRA_COUNT];
> -    int extra_count;
> +    GHashTable *hash;
>      struct key_range *keypad_range;
>      struct key_range *numlock_range;
>  };
>  
> +static inline gpointer hashkey(int keysym)
> +{
> +    intptr_t ptr = keysym;
> +    return (gpointer)(ptr);
> +}
> +
>  static int get_keysym(const name2keysym_t *table,
>                        const char *name)
>  {
> @@ -91,23 +93,19 @@ static void add_to_key_range(struct key_range **krp, int code) {
>      }
>  }
>  
> -static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k) {
> -    if (keysym < MAX_NORMAL_KEYCODE) {
> -        trace_keymap_add("normal", keysym, keycode, line);
> -        k->keysym2keycode[keysym] = keycode;
> -    } else {
> -        if (k->extra_count >= MAX_EXTRA_COUNT) {
> -            warn_report("Could not assign keysym %s (0x%x)"
> -                        " because of memory constraints.", line, keysym);
> -        } else {
> -            trace_keymap_add("extra", keysym, keycode, line);
> -            k->keysym2keycode_extra[k->extra_count].
> -            keysym = keysym;
> -            k->keysym2keycode_extra[k->extra_count].
> -            keycode = keycode;
> -            k->extra_count++;
> -        }
> +static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
> +{
> +    struct keysym2code *keysym2code;
> +
> +    keysym2code = g_hash_table_lookup(k->hash, hashkey(keysym));

FYI, the glib2 GINT_TO_POINTER() macro is intended to cover this
usecase of storing integers as hash keys. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
