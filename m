Received: from eggs.gnu.org ([2001:4830:134:3::10]:37878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvPcF-00020h-OS
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvPcE-0005RJ-35
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:16:15 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fvPcD-0005Qx-Oe
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:16:14 -0400
Received: by mail-wm0-x243.google.com with SMTP id y139-v6so2554035wmc.2
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 09:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-3-marcandre.lureau@redhat.com>
	<87wos7zyx6.fsf@dusky.pond.sub.org>
In-Reply-To: <87wos7zyx6.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 30 Aug 2018 18:16:00 +0200
Message-ID: <CAJ+F1CJKDpHpx29XccWcZv8eBvQHAH33N4G2w3-OGQgmbYtuzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/9] chardev: mark the calls that allow an
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi
On Thu, Aug 30, 2018 at 4:58 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > This is mostly for readability of the code. Let's make it clear which
> > callers can create an implicit monitor when the chardev is muxed.
> >
> > This will also enforce a safer behaviour, as we don't really support
> > creating monitor anywhere/anytime at the moment. Add an assert() to
> > make sure the programmer explicitely wanted that behaviour.
> >
> > There are documented cases, such as: -serial/-parallel/-virtioconsole
> > and to less extent -debugcon.
> >
> > Less obvious and questionable ones are -gdb, SLIRP -guestfwd and Xen
> > console. Add a FIXME note for those, but keep the support for now.
> >
> > Other qemu_chr_new() callers either have a fixed parameter/filename
> > string or do not need it, such as -qtest:
> >
> > * qtest.c: qtest_init()
> >   Afaik, only used by tests/libqtest.c, without mux. I don't think we
> >   support it outside of qemu testing: drop support for implicit mux
> >   monitor (qemu_chr_new() call: no implicit mux now).
> >
> > * hw/
> >   All with literal @filename argument that doesn't enable mux monitor.
> >
> > * tests/
> >   All with @filename argument that doesn't enable mux monitor.
> >
> > On a related note, the list of monitor creation places:
> >
> > - the chardev creators listed above: all from command line (except
> >   perhaps Xen console?)
> >
> > - -gdb & hmp gdbserver will create a "GDB monitor command" chardev
> >   that is wired to an HMP monitor.
> >
> > - -mon command line option
> >
> > From this short study, I would like to think that a monitor may only
> > be created in the main thread today, though I remain skeptical :)
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/chardev/char.h | 24 ++++++++++++++++++++----
> >  chardev/char.c         | 32 +++++++++++++++++++++++++-------
> >  gdbstub.c              |  6 +++++-
> >  hw/char/xen_console.c  |  5 ++++-
> >  net/slirp.c            |  5 ++++-
> >  vl.c                   | 10 +++++-----
> >  6 files changed, 63 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> > index 3e4fe6dad0..268daaa90b 100644
> > --- a/include/chardev/char.h
> > +++ b/include/chardev/char.h
> > @@ -105,14 +105,27 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opt=
s,
> >   * @filename: the URI
> >   *
> >   * Create a new character backend from a URI.
> > + * Do not implicitly initialize a monitor if the chardev is muxed.
> >   *
> >   * Returns: a new character backend
> >   */
> >  Chardev *qemu_chr_new(const char *label, const char *filename);
> >
> >  /**
> > - * qemu_chr_change:
> > - * @opts: the new backend options
> > + * qemu_chr_new_mux_mon:
> > + * @label: the name of the backend
> > + * @filename: the URI
> > + *
> > + * Create a new character backend from a URI.
> > + * Implicitly initialize a monitor if the chardev is muxed.
> > + *
> > + * Returns: a new character backend
> > + */
> > +Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename)=
;
> > +
> > +/**
> > +* qemu_chr_change:
> > +* @opts: the new backend options
> >   *
> >   * Change an existing character backend
> >   */
> > @@ -129,6 +142,7 @@ void qemu_chr_cleanup(void);
> >   * qemu_chr_new_noreplay:
> >   * @label: the name of the backend
> >   * @filename: the URI
> > + * @with_mux_mon: if chardev is muxed, initialize a monitor
> >   *
> >   * Create a new character backend from a URI.
> >   * Character device communications are not written
> > @@ -136,7 +150,8 @@ void qemu_chr_cleanup(void);
> >   *
> >   * Returns: a new character backend
> >   */
> > -Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
);
> > +Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
,
> > +                               bool with_mux_mon);
> >
> >  /**
> >   * qemu_chr_be_can_write:
> > @@ -194,7 +209,8 @@ bool qemu_chr_has_feature(Chardev *chr,
> >                            ChardevFeature feature);
> >  void qemu_chr_set_feature(Chardev *chr,
> >                            ChardevFeature feature);
> > -QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e);
> > +QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e,
> > +                                bool with_mux_mon);
> >  int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write=
_all);
> >  #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, tr=
ue)
> >  int qemu_chr_wait_connected(Chardev *chr, Error **errp);
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 76d866e6fe..c1b89b6638 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -329,7 +329,8 @@ int qemu_chr_wait_connected(Chardev *chr, Error **e=
rrp)
> >      return 0;
> >  }
> >
> > -QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e)
> > +QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e,
> > +                                bool with_mux_mon)
> >  {
> >      char host[65], port[33], width[8], height[8];
> >      int pos;
> > @@ -344,6 +345,10 @@ QemuOpts *qemu_chr_parse_compat(const char *label,=
 const char *filename)
> >      }
> >
> >      if (strstart(filename, "mon:", &p)) {
> > +        if (!with_mux_mon) {
> > +            error_report("mon: isn't supported in this context");
> > +            return NULL;
> > +        }
> >          filename =3D p;
> >          qemu_opt_set(opts, "mux", "on", &error_abort);
> >          if (strcmp(filename, "stdio") =3D=3D 0) {
>
> Perhaps @permit_mux_mon would be a better name.  Your choice.

ok

>
> > @@ -683,7 +688,8 @@ out:
> >      return chr;
> >  }
> >
> > -Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
)
> > +Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
,
> > +                               bool with_mux_mon)
> >  {
> >      const char *p;
> >      Chardev *chr;
> > @@ -694,25 +700,27 @@ Chardev *qemu_chr_new_noreplay(const char *label,=
 const char *filename)
> >          return qemu_chr_find(p);
> >      }
> >
> > -    opts =3D qemu_chr_parse_compat(label, filename);
> > +    opts =3D qemu_chr_parse_compat(label, filename, with_mux_mon);
> >      if (!opts)
> >          return NULL;
> >
> >      chr =3D qemu_chr_new_from_opts(opts, &err);
> >      if (err) {
> >          error_report_err(err);
> > -    }
> > -    if (chr && qemu_opt_get_bool(opts, "mux", 0)) {
> > +    } else if (qemu_opt_get_bool(opts, "mux", 0)) {
> > +        assert(with_mux_mon);
> >          monitor_init(chr, MONITOR_USE_READLINE);
> >      }
> >      qemu_opts_del(opts);
> >      return chr;
> >  }
>
> Took me a second look to understand.  I'd prefer
>
>        chr =3D qemu_chr_new_from_opts(opts, &err);
>        if (!chr) {
>            error_report_err(err);
>            goto out;
>        }
>        if (qemu_opt_get_bool(opts, "mux", 0)) {
>            assert(with_mux_mon);
>            monitor_init(chr, MONITOR_USE_READLINE);
>        }
>
>    out:
>        qemu_opts_del(opts);
>        return chr;
>
> or
>
>        mux =3D qemu_opt_get_bool(opts, "mux", 0);
>        chr =3D qemu_chr_new_from_opts(opts, &err);
>        qemu_opts_del(opts);
>        if (!chr) {
>            error_report_err(err);
>            return NULL;
>        }
>        if (mux) {
>            monitor_init(chr, MONITOR_USE_READLINE);
>        }
>        return chr;
>
> Your choice, of course.

I prefer the first version, ok

>
> >
> > -Chardev *qemu_chr_new(const char *label, const char *filename)
> > +static Chardev *qemu_chr_new_with_mux_mon(const char *label,
> > +                                          const char *filename,
> > +                                          bool with_mux_mon)
> >  {
> >      Chardev *chr;
> > -    chr =3D qemu_chr_new_noreplay(label, filename);
> > +    chr =3D qemu_chr_new_noreplay(label, filename, with_mux_mon);
> >      if (chr) {
> >          if (replay_mode !=3D REPLAY_MODE_NONE) {
> >              qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> > @@ -726,6 +734,16 @@ Chardev *qemu_chr_new(const char *label, const cha=
r *filename)
> >      return chr;
> >  }
> >
> > +Chardev *qemu_chr_new(const char *label, const char *filename)
> > +{
> > +    return qemu_chr_new_with_mux_mon(label, filename, false);
> > +}
> > +
> > +Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename)
> > +{
> > +    return qemu_chr_new_with_mux_mon(label, filename, true);
> > +}
> > +
> >  static int qmp_query_chardev_foreach(Object *obj, void *data)
> >  {
> >      Chardev *chr =3D CHARDEV(obj);
> > diff --git a/gdbstub.c b/gdbstub.c
> > index d6ab95006c..c8478de8f5 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -2038,7 +2038,11 @@ int gdbserver_start(const char *device)
> >              sigaction(SIGINT, &act, NULL);
> >          }
> >  #endif
> > -        chr =3D qemu_chr_new_noreplay("gdb", device);
> > +        /*
> > +         * FIXME: it's a bit weird to allow using a mux chardev here
> > +         * and implicitly setup a monitor. We may want to break this.
> > +         */
> > +        chr =3D qemu_chr_new_noreplay("gdb", device, true);
> >          if (!chr)
> >              return -1;
> >      }
> > diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> > index 8b4b4bf523..6a231d487b 100644
> > --- a/hw/char/xen_console.c
> > +++ b/hw/char/xen_console.c
> > @@ -207,7 +207,10 @@ static int con_init(struct XenDevice *xendev)
> >      } else {
> >          snprintf(label, sizeof(label), "xencons%d", con->xendev.dev);
> >          qemu_chr_fe_init(&con->chr,
> > -                         qemu_chr_new(label, output), &error_abort);
> > +                         /*
> > +                          * FIXME: should it support implicit muxed mo=
nitors?
>
> This sounds like it didn't, but perhaps it should.  Actually, it does,
> but perhaps it shouldn't.  Suggest something like "FIXME sure we want to
> support implicit muxed monitors here".
>

ok

> > +                          */
> > +                         qemu_chr_new_mux_mon(label, output), &error_a=
bort);
> >      }
> >
> >      xenstore_store_pv_console_info(con->xendev.dev,
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 1e14318b4d..677dc36fe4 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -836,7 +836,10 @@ static int slirp_guestfwd(SlirpState *s, const cha=
r *config_str,
> >          }
> >      } else {
> >          Error *err =3D NULL;
> > -        Chardev *chr =3D qemu_chr_new(buf, p);
> > +        /*
> > +         * FIXME: should it support implicit muxed monitors?
> > +         */
>
> Likewise.
>
> > +        Chardev *chr =3D qemu_chr_new_mux_mon(buf, p);
> >
> >          if (!chr) {
> >              error_setg(errp, "Could not open guest forwarding device '=
%s'",
> > diff --git a/vl.c b/vl.c
> > index 5ba06adf78..b38e49ca43 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2353,7 +2353,7 @@ static void monitor_parse(const char *optarg, con=
st char *mode, bool pretty)
> >      } else {
> >          snprintf(label, sizeof(label), "compat_monitor%d",
> >                   monitor_device_index);
> > -        opts =3D qemu_chr_parse_compat(label, optarg);
> > +        opts =3D qemu_chr_parse_compat(label, optarg, true);
> >          if (!opts) {
> >              error_report("parse error: %s", optarg);
> >              exit(1);
> > @@ -2425,7 +2425,7 @@ static int serial_parse(const char *devname)
> >      snprintf(label, sizeof(label), "serial%d", index);
> >      serial_hds =3D g_renew(Chardev *, serial_hds, index + 1);
> >
> > -    serial_hds[index] =3D qemu_chr_new(label, devname);
> > +    serial_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
> >      if (!serial_hds[index]) {
> >          error_report("could not connect serial device"
> >                       " to character backend '%s'", devname);
> > @@ -2461,7 +2461,7 @@ static int parallel_parse(const char *devname)
> >          exit(1);
> >      }
> >      snprintf(label, sizeof(label), "parallel%d", index);
> > -    parallel_hds[index] =3D qemu_chr_new(label, devname);
> > +    parallel_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
> >      if (!parallel_hds[index]) {
> >          error_report("could not connect parallel device"
> >                       " to character backend '%s'", devname);
> > @@ -2492,7 +2492,7 @@ static int virtcon_parse(const char *devname)
> >      qemu_opt_set(dev_opts, "driver", "virtconsole", &error_abort);
> >
> >      snprintf(label, sizeof(label), "virtcon%d", index);
> > -    virtcon_hds[index] =3D qemu_chr_new(label, devname);
> > +    virtcon_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
> >      if (!virtcon_hds[index]) {
> >          error_report("could not connect virtio console"
> >                       " to character backend '%s'", devname);
> > @@ -2508,7 +2508,7 @@ static int debugcon_parse(const char *devname)
> >  {
> >      QemuOpts *opts;
> >
> > -    if (!qemu_chr_new("debugcon", devname)) {
> > +    if (!qemu_chr_new_mux_mon("debugcon", devname)) {
> >          exit(1);
> >      }
> >      opts =3D qemu_opts_create(qemu_find_opts("device"), "debugcon", 1,=
 NULL);
>
> I have a couple of suggestions, but nothing to withhold my
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

thanks

--=20
Marc-Andr=C3=A9 Lureau
