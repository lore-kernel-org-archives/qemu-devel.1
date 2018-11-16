Received: from eggs.gnu.org ([2001:4830:134:3::10]:50647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNUb6-0000uz-C0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNUb5-0006Qe-Cu
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:15:08 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gNUb5-0006QK-6C
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:15:07 -0500
Received: by mail-io1-xd41.google.com with SMTP id m1-v6so5240570ioc.13
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 19:15:07 -0800 (PST)
MIME-Version: 1.0
References: <1542272663-6619-1-git-send-email-liq3ea@gmail.com>
	<87bm6qh3kc.fsf@dusky.pond.sub.org>
In-Reply-To: <87bm6qh3kc.fsf@dusky.pond.sub.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 16 Nov 2018 11:14:30 +0800
Message-ID: <CAKXe6SLv4ob4NqnbwwEYfYbf3D=v9mNvAzxe329tMR52PZfiQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8815=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:29=E5=86=99=E9=81=93=EF=BC=
=9A

> Li Qiang <liq3ea@gmail.com> writes:
>
> > When the parse_keyboard_layout() find a "include " line
> > in the keyboard layout file, it will call parse_keyboard_layout()
> > to perform a recursive parse. If the keyboard layout is malformed
> > by adding a line include itself, this can cause an infinite parse.
> > Thus cause qemu a segv. This patch avoid this.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  ui/keymaps.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/ui/keymaps.c b/ui/keymaps.c
> > index 085889b555..564893a9f3 100644
> > --- a/ui/keymaps.c
> > +++ b/ui/keymaps.c
> > @@ -38,6 +38,8 @@ struct kbd_layout_t {
> >      GHashTable *hash;
> >  };
> >
> > +GList *keyboard_files;
> > +
> >  static int get_keysym(const name2keysym_t *table,
> >                        const char *name)
> >  {
> > @@ -80,6 +82,11 @@ static void add_keysym(char *line, int keysym, int
> keycode, kbd_layout_t *k)
> >      trace_keymap_add(keysym, keycode, line);
> >  }
> >
> > +static gint compare_string(gconstpointer a, gconstpointer b)
> > +{
> > +    return g_strcmp0(a, b);
> > +}
> > +
> >  static int parse_keyboard_layout(kbd_layout_t *k,
> >                                   const name2keysym_t *table,
> >                                   const char *language, Error **errp)
> > @@ -94,12 +101,18 @@ static int parse_keyboard_layout(kbd_layout_t *k,
> >      filename =3D qemu_find_file(QEMU_FILE_TYPE_KEYMAP, language);
> >      trace_keymap_parse(filename);
> >      f =3D filename ? fopen(filename, "r") : NULL;
> > -    g_free(filename);
> >      if (!f) {
> > +        g_free(filename);
> >          error_setg(errp, "could not read keymap file: '%s'", language)=
;
> >          return -1;
> >      }
> >
> > +    if (g_list_find_custom(keyboard_files, filename, compare_string)) =
{
> > +        error_setg(errp, "find recursive keyboard layout: %s'",
> filename);
>
> Suggest something like "Inclusion loop for %s".
>
> > +        g_free(filename);
> > +        return -1;
> > +    }
> > +    keyboard_files =3D g_list_append(keyboard_files, filename);
> >      for(;;) {
> >          if (fgets(line, 1024, f) =3D=3D NULL) {
> >              break;
> > @@ -168,6 +181,8 @@ static int parse_keyboard_layout(kbd_layout_t *k,
> >      ret =3D 0;
> >  out:
> >      fclose(f);
> > +    keyboard_files =3D g_list_remove(keyboard_files, filename);
> > +    g_free(filename);
> >      return ret;
> >  }
>
> There's no real need to make @keyboard_files global.  I'd make it local
> to init_keyboard_layout(), and pass it as argument to
> parse_keyboard_layout().



Thanks Markus,
Finally, Gerd decide remove the support of "include" in keymaps.

Thanks,
Li Qiang


> Matter of taste.  Gerd is the maintainer, not
> me.
>
