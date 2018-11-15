Received: from eggs.gnu.org ([2001:4830:134:3::10]:43585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNHiA-0008J1-ED
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNHi6-0001iX-NT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNHi6-0001hW-IA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:29:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1542272663-6619-1-git-send-email-liq3ea@gmail.com>
Date: Thu, 15 Nov 2018 14:29:23 +0100
In-Reply-To: <1542272663-6619-1-git-send-email-liq3ea@gmail.com> (Li Qiang's
	message of "Thu, 15 Nov 2018 01:04:23 -0800")
Message-ID: <87bm6qh3kc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] keymaps: detect recursive keyboard layout
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@gmail.com> writes:

> When the parse_keyboard_layout() find a "include " line
> in the keyboard layout file, it will call parse_keyboard_layout()
> to perform a recursive parse. If the keyboard layout is malformed
> by adding a line include itself, this can cause an infinite parse.
> Thus cause qemu a segv. This patch avoid this.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  ui/keymaps.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 085889b555..564893a9f3 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -38,6 +38,8 @@ struct kbd_layout_t {
>      GHashTable *hash;
>  };
>  
> +GList *keyboard_files;
> +
>  static int get_keysym(const name2keysym_t *table,
>                        const char *name)
>  {
> @@ -80,6 +82,11 @@ static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
>      trace_keymap_add(keysym, keycode, line);
>  }
>  
> +static gint compare_string(gconstpointer a, gconstpointer b)
> +{
> +    return g_strcmp0(a, b);
> +}
> +
>  static int parse_keyboard_layout(kbd_layout_t *k,
>                                   const name2keysym_t *table,
>                                   const char *language, Error **errp)
> @@ -94,12 +101,18 @@ static int parse_keyboard_layout(kbd_layout_t *k,
>      filename = qemu_find_file(QEMU_FILE_TYPE_KEYMAP, language);
>      trace_keymap_parse(filename);
>      f = filename ? fopen(filename, "r") : NULL;
> -    g_free(filename);
>      if (!f) {
> +        g_free(filename);
>          error_setg(errp, "could not read keymap file: '%s'", language);
>          return -1;
>      }
>  
> +    if (g_list_find_custom(keyboard_files, filename, compare_string)) {
> +        error_setg(errp, "find recursive keyboard layout: %s'", filename);

Suggest something like "Inclusion loop for %s".

> +        g_free(filename);
> +        return -1;
> +    }
> +    keyboard_files = g_list_append(keyboard_files, filename);
>      for(;;) {
>          if (fgets(line, 1024, f) == NULL) {
>              break;
> @@ -168,6 +181,8 @@ static int parse_keyboard_layout(kbd_layout_t *k,
>      ret = 0;
>  out:
>      fclose(f);
> +    keyboard_files = g_list_remove(keyboard_files, filename);
> +    g_free(filename);
>      return ret;
>  }

There's no real need to make @keyboard_files global.  I'd make it local
to init_keyboard_layout(), and pass it as argument to
parse_keyboard_layout().  Matter of taste.  Gerd is the maintainer, not
me.
