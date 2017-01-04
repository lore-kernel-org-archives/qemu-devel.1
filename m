Received: from eggs.gnu.org ([2001:4830:134:3::10]:36306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOsor-0000AS-TN
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOsop-0003wB-Pb
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:10:01 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cOsop-0003tl-Ht
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:09:59 -0500
Received: by mail-yw0-x242.google.com with SMTP id a10so42933420ywa.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 13:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-9-marcandre.lureau@redhat.com>
	<4f5926bd-557f-de20-025b-d640a6aefa17@redhat.com>
In-Reply-To: <4f5926bd-557f-de20-025b-d640a6aefa17@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 04 Jan 2017 21:09:46 +0000
Message-ID: <CAJ+F1C+EtPLpyLvpEA1Ex6jZnih2uCMTeXbQuXeivTwO9BafhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/54] char: allocate CharDriverState as a
 single object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi

On Wed, Jan 4, 2017 at 9:26 PM Eric Blake <eblake@redhat.com> wrote:

> On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Use a single allocation for CharDriverState, this avoids extra
> > allocations & pointers, and is a step towards more object-oriented
> > CharDriver.
> >
> > Gtk console is a bit peculiar, gd_vc_chr_set_echo
>
> Truncated paragraph?
>

yes, fixed


>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  backends/baum.c       |  23 ++---
> >  backends/msmouse.c    |  16 +--
> >  backends/testdev.c    |  22 ++--
> >  gdbstub.c             |   1 +
> >  hw/bt/hci-csr.c       |  10 +-
> >  qemu-char.c           | 280
> ++++++++++++++++++++++++++------------------------
> >  spice-qemu-char.c     |  39 +++----
> >  ui/console.c          |  21 ++--
> >  ui/gtk.c              |  30 ++++--
> >  include/sysemu/char.h |   2 +-
> >  10 files changed, 230 insertions(+), 214 deletions(-)
> >
> > diff --git a/backends/baum.c b/backends/baum.c
> > index ef6178993a..6244929ac6 100644
> > --- a/backends/baum.c
> > +++ b/backends/baum.c
> > @@ -87,7 +87,7 @@
> >  #define BUF_SIZE 256
> >
> >  typedef struct {
> > -    CharDriverState *chr;
> > +    CharDriverState parent;
> >
> >      brlapi_handle_t *brlapi;
> >      int brlapi_fd;
> > @@ -270,7 +270,7 @@ static int baum_deferred_init(BaumDriverState *baum=
)
> >  /* The serial port can receive more of our data */
> >  static void baum_accept_input(struct CharDriverState *chr)
> >  {
> > -    BaumDriverState *baum =3D chr->opaque;
> > +    BaumDriverState *baum =3D (BaumDriverState *)chr;
>
> It might be a little nicer to use:
>
> BaumDriverState *baum =3D container_of(chr, BaumDriverState, parent);
>
>
The follow-up of the series converts it to the more appropriate
 BaumChardev *baum =3D BAUM_CHARDEV(obj);

So considering that this is temporary commit, do I have to change that?

to avoid a cast and work even if the members are rearranged within the
> structure. You can even write a one-line helper function to hide the
> cast behind a more legible semantic (for example, see to_qov() in
> qobject-output-visitor.c).
>
> (Same comment applies to most other base-to-derived casts in your patch)
>
> > +++ b/hw/bt/hci-csr.c
> > @@ -28,11 +28,11 @@
> >  #include "hw/bt.h"
> >
> >  struct csrhci_s {
> > +    CharDriverState chr;
> >      int enable;
> >      qemu_irq *pins;
> >      int pin_state;
> >      int modem_state;
> > -    CharDriverState chr;
> >  #define FIFO_LEN     4096
> >      int out_start;
> >      int out_len;
> > @@ -314,7 +314,7 @@ static void csrhci_ready_for_next_inpkt(struct
> csrhci_s *s)
> >  static int csrhci_write(struct CharDriverState *chr,
> >                  const uint8_t *buf, int len)
> >  {
> > -    struct csrhci_s *s =3D (struct csrhci_s *) chr->opaque;
> > +    struct csrhci_s *s =3D (struct csrhci_s *)chr;
>
> Wonder if a typedef would make this more legible, but maybe as a
> separate cleanup.
>
> > +++ b/ui/gtk.c
> > @@ -178,6 +178,12 @@ struct GtkDisplayState {
> >      bool ignore_keys;
> >  };
> >
> > +typedef struct VCDriverState {
> > +    CharDriverState parent;
> > +    VirtualConsole *console;
> > +    bool echo;
> > +} VCDriverState;
> > +
> >  static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
> >  static void gd_ungrab_pointer(GtkDisplayState *s);
> >  static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
> > @@ -1675,7 +1681,8 @@ static void gd_vc_adjustment_changed(GtkAdjustmen=
t
> *adjustment, void *opaque)
> >
> >  static int gd_vc_chr_write(CharDriverState *chr, const uint8_t *buf,
> int len)
> >  {
> > -    VirtualConsole *vc =3D chr->opaque;
> > +    VCDriverState *vcd =3D (VCDriverState *)chr;
> > +    VirtualConsole *vc =3D vcd->console;
> >
> >      vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char
> *)buf, len);
> >      return len;
> > @@ -1683,9 +1690,14 @@ static int gd_vc_chr_write(CharDriverState *chr,
> const uint8_t *buf, int len)
> >
> >  static void gd_vc_chr_set_echo(CharDriverState *chr, bool echo)
> >  {
> > -    VirtualConsole *vc =3D chr->opaque;
> > +    VCDriverState *vcd =3D (VCDriverState *)chr;
> > +    VirtualConsole *vc =3D vcd->console;
> >
> > -    vc->vte.echo =3D echo;
> > +    if (vc) {
> > +        vc->vte.echo =3D echo;
> > +    } else {
> > +        vcd->echo =3D echo;
> > +    }
> >  }
> >
> >  static int nb_vcs;
> > @@ -1694,6 +1706,7 @@ static CharDriverState *vcs[MAX_VCS];
> >  static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
> >  {
> >      static const CharDriver gd_vc_driver =3D {
> > +        .instance_size =3D sizeof(VCDriverState),
> >          .kind =3D CHARDEV_BACKEND_KIND_VC,
> >          .chr_write =3D gd_vc_chr_write,
> >          .chr_set_echo =3D gd_vc_chr_set_echo,
> > @@ -1712,9 +1725,6 @@ static CharDriverState *gd_vc_handler(ChardevVC
> *vc, Error **errp)
> >          return NULL;
> >      }
> >
> > -    /* Temporary, until gd_vc_vte_init runs.  */
> > -    chr->opaque =3D g_new0(VirtualConsole, 1);
> > -
>
> Okay, I see the weirdness going on with the 'echo' stuff - you have to
> simulate the temporary placeholder for whether or not to set echo, such
> that gd_vc_chr_set_echo() can now be called with a NULL opaque where it
> used to always have an object to dereference.
>
>
right


> >      vcs[nb_vcs++] =3D chr;
> >
> >      return chr;
> > @@ -1755,14 +1765,12 @@ static GSList *gd_vc_vte_init(GtkDisplayState
> *s, VirtualConsole *vc,
> >      GtkWidget *box;
> >      GtkWidget *scrollbar;
> >      GtkAdjustment *vadjustment;
> > -    VirtualConsole *tmp_vc =3D chr->opaque;
> > +    VCDriverState *vcd =3D (VCDriverState *)chr;
> >
> >      vc->s =3D s;
> > -    vc->vte.echo =3D tmp_vc->vte.echo;
> > -
> > +    vc->vte.echo =3D vcd->echo;
> >      vc->vte.chr =3D chr;
> > -    chr->opaque =3D vc;
> > -    g_free(tmp_vc);
> > +    vcd->console =3D vc;
> >
>
> So it is indeed weird, but looks correct in the end.
>
> >      snprintf(buffer, sizeof(buffer), "vc%d", idx);
> >      vc->label =3D g_strdup_printf("%s", vc->vte.chr->label
> > diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> > index 07dfa59afe..5d8ec982a9 100644
> > --- a/include/sysemu/char.h
> > +++ b/include/sysemu/char.h
> > @@ -93,7 +93,6 @@ struct CharDriverState {
> >      const CharDriver *driver;
> >      QemuMutex chr_write_lock;
> >      CharBackend *be;
> > -    void *opaque;
> >      char *label;
> >      char *filename;
> >      int logfd;
> > @@ -482,6 +481,7 @@ struct CharDriver {
> >                                 ChardevBackend *backend,
> >                                 ChardevReturn *ret, bool *be_opened,
> >                                 Error **errp);
> > +    size_t instance_size;
>
> My biggest gripe is the number of casts that could be container_of()
> instead; but otherwise it looks like a sane conversion.
>
>
thanks, the goal is to get rid of them, but not in this commit :) See
"chardev: qom-ify".
--=20
Marc-Andr=C3=A9 Lureau
