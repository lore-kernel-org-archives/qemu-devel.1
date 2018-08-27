Received: from eggs.gnu.org ([2001:4830:134:3::10]:49401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fuPNj-00022M-IB
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 17:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fuPNh-00060I-So
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 17:49:07 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fuPNh-0005yH-HR
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 17:49:05 -0400
Received: by mail-wm0-x242.google.com with SMTP id t25-v6so382979wmi.3
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 14:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180822180259.26365-1-marcandre.lureau@redhat.com>
	<87d0u8cj72.fsf@dusky.pond.sub.org>
	<CAJ+F1CKDL6WXSNSW5gBs8c1rOnOaRkS-+rhyG7=4Kgam9DnbQQ@mail.gmail.com>
	<871sakw7qa.fsf@dusky.pond.sub.org>
In-Reply-To: <871sakw7qa.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Aug 2018 23:48:52 +0200
Message-ID: <CAJ+F1C+30UGEhTAjDocZ4b7AOr9FwoN=XCoO3f7qC_ayLOiX8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: chardev: mark the calls that allow an
 implicit mux monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, QEMU <qemu-devel@nongnu.org>, xen-devel@lists.xenproject.org

Hi
On Mon, Aug 27, 2018 at 10:10 AM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> > On Fri, Aug 24, 2018 at 9:37 AM Markus Armbruster <armbru@redhat.com> w=
rote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > This is mostly for readability of the code. Let's make it clear whic=
h
> >> > callers can create an implicit monitor when the chardev is muxed.
> >> >
> >> > This will also enforce a safer behaviour, as we don't really support
> >> > creating monitor anywhere/anytime at the moment.
> >> >
> >> > There are documented cases, such as: -serial/-parallel/-virtioconsol=
e
> >> > and to less extent -debugcon.
> >> >
> >> > Less obvious and questionnable ones are -gdb and Xen console. Add a
> >> > FIXME note for those, but keep the support for now.
> >> >
> >> > Other qemu_chr_new() callers either have a fixed parameter/filename
> >> > string, or do preliminary checks on the string (such as slirp), or d=
o
> >> > not need it, such as -qtest.
> >> >
> >> > On a related note, the list of monitor creation places:
> >> >
> >> > - the chardev creators listed above: all from command line (except
> >> >   perhaps Xen console?)
> >> >
> >> > - -gdb & hmp gdbserver will create a "GDB monitor command" chardev
> >> >   that is wired to an HMP monitor.
> >> >
> >> > - -mon command line option
> >>
> >> Aside: the question "what does it mean to connect a monitor to a chard=
ev
> >> that has an implicit monitor" crosses my mind.  Next thought is "the
> >> day's too short to go there".
> >>
> >> > From this short study, I would like to think that a monitor may only
> >> > be created in the main thread today, though I remain skeptical :)
> >>
> >> Hah!
> >>
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> > ---
> >> >  include/chardev/char.h | 18 +++++++++++++++++-
> >> >  chardev/char.c         | 21 +++++++++++++++++----
> >> >  gdbstub.c              |  6 +++++-
> >> >  hw/char/xen_console.c  |  5 ++++-
> >> >  vl.c                   |  8 ++++----
> >> >  5 files changed, 47 insertions(+), 11 deletions(-)
> >> >
> >> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> >> > index 6f0576e214..be2b9b817e 100644
> >> > --- a/
> >> > +++ b/include/chardev/char.h
> >> > @@ -105,6 +105,7 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *op=
ts,
> >> >   * @qemu_chr_new:
> >> >   *
> >> >   * Create a new character backend from a URI.
> >> > + * Do not implicitely initialize a monitor if the chardev is muxed.
> >> >   *
> >> >   * @label the name of the backend
> >> >   * @filename the URI
> >> > @@ -113,6 +114,19 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *o=
pts,
> >> >   */
> >> >  Chardev *qemu_chr_new(const char *label, const char *filename);
> >> >
> >> > +/**
> >> > + * @qemu_chr_new_mux_mon:
> >> > + *
> >> > + * Create a new character backend from a URI.
> >> > + * Implicitely initialize a monitor if the chardev is muxed.
> >> > + *
> >> > + * @label the name of the backend
> >> > + * @filename the URI
> >>
> >> I'm no friend of GTK-Doc style, but where we use it, we should use it
> >> correctly: put a colon after @param.
> >
> > I copied existing comment... Should I fixed all others in the headers?
>
> Do we expect to actually *use* doc comments for anything?  We haven't in
> a decade or so, but if we still expect to all the same, then not fixing
> them up now merely delays the inevitable.
>
> Do we think adding the colons makes the comments easier to read?  For
> what it's worth, I do.
>
> Decision's up to you.

Let's improve it.

>
> >> > + *
> >> > + * Returns: a new character backend
> >> > + */
> >> > +Chardev *qemu_chr_new_mux_mon(const char *label, const char *filena=
me);
> >> > +
> >> >  /**
> >> >   * @qemu_chr_change:
> >> >   *
> >> > @@ -138,10 +152,12 @@ void qemu_chr_cleanup(void);
> >> >   *
> >> >   * @label the name of the backend
> >> >   * @filename the URI
> >> > + * @with_mux_mon if chardev is muxed, initialize a monitor
> >> >   *
> >> >   * Returns: a new character backend
> >> >   */
> >> > -Chardev *qemu_chr_new_noreplay(const char *label, const char *filen=
ame);
> >> > +Chardev *qemu_chr_new_noreplay(const char *label, const char *filen=
ame,
> >> > +                               bool with_mux_mon);
> >> >
> >> >  /**
> >> >   * @qemu_chr_be_can_write:
> >> > diff --git a/chardev/char.c b/chardev/char.c
> >> > index 76d866e6fe..2c295ad676 100644
> >> > --- a/chardev/char.c
> >> > +++ b/chardev/char.c
> >> > @@ -683,7 +683,8 @@ out:
> >> >      return chr;
> >> >  }
> >> >
> >> > -Chardev *qemu_chr_new_noreplay(const char *label, const char *filen=
ame)
> >> > +Chardev *qemu_chr_new_noreplay(const char *label, const char *filen=
ame,
> >> > +                               bool with_mux_mon)
> >> >  {
> >> >      const char *p;
> >> >      Chardev *chr;
> >> > @@ -702,17 +703,19 @@ Chardev *qemu_chr_new_noreplay(const char *lab=
el, const char *filename)
> >> >      if (err) {
> >> >          error_report_err(err);
> >> >      }
> >> > -    if (chr && qemu_opt_get_bool(opts, "mux", 0)) {
> >> > +    if (with_mux_mon && chr && qemu_opt_get_bool(opts, "mux", 0)) {
> >> >          monitor_init(chr, MONITOR_USE_READLINE);
> >> >      }
> >>
> >> When !chr, the function already failed, so that part of the condition =
is
> >> uninteresting here[*].
> >
> > yeah, hopefully err is always set if the return value is NULL.
> >
> >> That leaves qemu_opt_get_bool(opts, "mux", 0).  Behavior changes when
> >> it's true and with_mux_mon is false: we no longer create a monitor.
> >>
> >> Can this happen?
> >>
> >> If it can, when exactly, and how does it affect externally visible
> >> behavior?
> >
> > we could add an assert() for with_mux_mon || !opt("mux").
>
> Hmm.  See my analysis below.
>
> >> I guess we'll see below.
> >>
> >> >      qemu_opts_del(opts);
> >> >      return chr;
> >> >  }
> >> >
> >> > -Chardev *qemu_chr_new(const char *label, const char *filename)
> >> > +static Chardev *qemu_chr_new_with_mux_mon(const char *label,
> >> > +                                          const char *filename,
> >> > +                                          bool with_mux_mon)
> >> >  {
> >> >      Chardev *chr;
> >> > -    chr =3D qemu_chr_new_noreplay(label, filename);
> >> > +    chr =3D qemu_chr_new_noreplay(label, filename, with_mux_mon);
> >> >      if (chr) {
> >> >          if (replay_mode !=3D REPLAY_MODE_NONE) {
> >> >              qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> >> > @@ -726,6 +729,16 @@ Chardev *qemu_chr_new(const char *label, const =
char *filename)
> >> >      return chr;
> >> >  }
> >> >
> >> > +Chardev *qemu_chr_new(const char *label, const char *filename)
> >> > +{
> >> > +    return qemu_chr_new_with_mux_mon(label, filename, false);
> >> > +}
> >> > +
> >> > +Chardev *qemu_chr_new_mux_mon(const char *label, const char *filena=
me)
> >> > +{
> >> > +    return qemu_chr_new_with_mux_mon(label, filename, true);
> >> > +}
> >> > +
> >> >  static int qmp_query_chardev_foreach(Object *obj, void *data)
> >> >  {
> >> >      Chardev *chr =3D CHARDEV(obj);
> >>
> >> Note for later: qemu_chr_new() changes behavior.  To avoid that, call
> >> qemu_chr_new_mux_mon() instead.
> >>
> >> > diff --git a/gdbstub.c b/gdbstub.c
> >> > index d6ab95006c..963531ea90 100644
> >> > --- a/gdbstub.c
> >> > +++ b/gdbstub.c
> >> > @@ -2038,7 +2038,11 @@ int gdbserver_start(const char *device)
> >> >              sigaction(SIGINT, &act, NULL);
> >> >          }
> >> >  #endif
> >> > -        chr =3D qemu_chr_new_noreplay("gdb", device);
> >> > +        /*
> >> > +         * FIXME: it's a bit weird to allow using a mux chardev her=
e
> >> > +         * and setup implicitely a monitor. We may want to break th=
is.
> >> > +         */
> >> > +        chr =3D qemu_chr_new_noreplay("gdb", device, true);
> >> >          if (!chr)
> >> >              return -1;
> >> >      }
> >>
> >> No behavioral change.  The patch does exactly what the commit message
> >> claims, namely mark potential implicit monitor creation in the source
> >> code.
> >>
> >> > diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> >> > index 8b4b4bf523..6a231d487b 100644
> >> > --- a/hw/char/xen_console.c
> >> > +++ b/hw/char/xen_console.c
> >> > @@ -207,7 +207,10 @@ static int con_init(struct XenDevice *xendev)
> >> >      } else {
> >> >          snprintf(label, sizeof(label), "xencons%d", con->xendev.dev=
);
> >> >          qemu_chr_fe_init(&con->chr,
> >> > -                         qemu_chr_new(label, output), &error_abort)=
;
> >> > +                         /*
> >> > +                          * FIXME: should it support implicit muxed=
 monitors?
> >> > +                          */
> >> > +                         qemu_chr_new_mux_mon(label, output), &erro=
r_abort);
> >> >      }
> >>
> >> Likewise, with a terser comment.
> >>
> >> >
> >> >      xenstore_store_pv_console_info(con->xendev.dev,
> >> > diff --git a/vl.c b/vl.c
> >> > index 16b913f9d5..20b5f321ec 100644
> >> > --- a/vl.c
> >> > +++ b/vl.c
> >> > @@ -2425,7 +2425,7 @@ static int serial_parse(const char *devname)
> >> >      snprintf(label, sizeof(label), "serial%d", index);
> >> >      serial_hds =3D g_renew(Chardev *, serial_hds, index + 1);
> >> >
> >> > -    serial_hds[index] =3D qemu_chr_new(label, devname);
> >> > +    serial_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
> >> >      if (!serial_hds[index]) {
> >> >          error_report("could not connect serial device"
> >> >                       " to character backend '%s'", devname);
> >>
> >> Likewise, without a comment, because implicit monitor is a feature
> >> here.  Correct?
> >
> > right
> >
> >>
> >> > @@ -2461,7 +2461,7 @@ static int parallel_parse(const char *devname)
> >> >          exit(1);
> >> >      }
> >> >      snprintf(label, sizeof(label), "parallel%d", index);
> >> > -    parallel_hds[index] =3D qemu_chr_new(label, devname);
> >> > +    parallel_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
> >> >      if (!parallel_hds[index]) {
> >> >          error_report("could not connect parallel device"
> >> >                       " to character backend '%s'", devname);
> >>
> >> Likewise.
> >>
> >> > @@ -2492,7 +2492,7 @@ static int virtcon_parse(const char *devname)
> >> >      qemu_opt_set(dev_opts, "driver", "virtconsole", &error_abort);
> >> >
> >> >      snprintf(label, sizeof(label), "virtcon%d", index);
> >> > -    virtcon_hds[index] =3D qemu_chr_new(label, devname);
> >> > +    virtcon_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
> >> >      if (!virtcon_hds[index]) {
> >> >          error_report("could not connect virtio console"
> >> >                       " to character backend '%s'", devname);
> >>
> >> Likewise.
> >>
> >> > @@ -2508,7 +2508,7 @@ static int debugcon_parse(const char *devname)
> >> >  {
> >> >      QemuOpts *opts;
> >> >
> >> > -    if (!qemu_chr_new("debugcon", devname)) {
> >> > +    if (!qemu_chr_new_mux_mon("debugcon", devname)) {
> >> >          exit(1);
> >> >      }
> >> >      opts =3D qemu_opts_create(qemu_find_opts("device"), "debugcon",=
 1, NULL);
> >>
> >> Likewise.
> >>
> >> Not visible in the patch: calls of qemu_chr_new() not changed to
> >> qemu_chr_new_mux_mon().  These are:
> >>
> >> * qtest.c: qtest_init()
>
> Calls qemu_chr_new("qtest", qtest_chrdev), where @qtest_chrdev is the
> argument of CLI option -qtest.
>
> I figure -qtest mon:... makes no sense.  But failing an assertion then
> isn't nice.  We need to reject nonsense with a suitable error message.
>
> Perhaps the easiest way to do so would be passing @with_mux_mon to
> qemu_chr_parse_compat(), and reject mon: there unless with_mux_mon.

Done

>
> >> * net/slirp.c: slirp_guestfwd()
>
> Calls qemu_chr_new(buf, p), where @p points into some config string that
> I guess comes from the user, too.  If that's true, same story as for
> qtest_init().

Actually, I got that one wrong, you can use mon: here.. Let's keep it
for now, add a FIXME.

>
> >> * hw/char/xen_console.c: con_init()
>
> Calls qemu_chr_new(label, output), where @output comes from xenstore.
> Same story again.
>
> >> * Several more in hw/, all with literal @filename argument that doesn'=
t
> >>   enable mux.
>
> The assertion can't fire.
>
> Aside: would be nice to bypass parsing (and the possibility of error
> that comes with it) here, but it's probably not worth the trouble to
> change.

Yeah, some othre day :)

> >> * tests/test-char.c
> >>
> >> * tests/vhost-user-test.c
> >>
> >> I figure these are meant to be covered by commit message paragraph
> >>
> >>     Other qemu_chr_new() callers either have a fixed parameter/filenam=
e
> >>     string, or do preliminary checks on the string (such as slirp), or=
 do
> >>     not need it, such as -qtest.
> >>
> >> A non-RFC patch should add enough detail to let the reviewer understan=
d
> >> each case without having to dig through the code himself.  Since I
> >> didn't do that, I can't give my R-by.  I can say I like the idea.
> >
> > ok, I'll update the patch & commit message.
> >
> >>
> >>
> >> [*] Aside: I prefer cleanly separated error paths, like this:
> >>
> >> Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
)
> >> {
> >>     const char *p;
> >>     Chardev *chr;
> >>     QemuOpts *opts;
> >>     Error *err =3D NULL;
> >>     bool mux;
> >>
> >>     if (strstart(filename, "chardev:", &p)) {
> >>         return qemu_chr_find(p);
> >>     }
> >>
> >>     opts =3D qemu_chr_parse_compat(label, filename);
> >>     if (!opts)
> >>         return NULL;
> >>
> >>     mux =3D qemu_opt_get_bool(opts, "mux", 0);
> >>     chr =3D qemu_chr_new_from_opts(opts, &err);
> >>     qemu_opts_del(opts);
> >>     if (!chr) {
> >>         error_report_err(err);
> >>         return NULL;
> >>     }
> >>     if (mux) {
> >>         monitor_init(chr, MONITOR_USE_READLINE);
> >>     }
> >>     return chr;
> >> }
> >>
> >
> > thanks



--=20
Marc-Andr=C3=A9 Lureau
