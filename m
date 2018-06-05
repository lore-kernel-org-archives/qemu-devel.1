Received: from eggs.gnu.org ([2001:4830:134:3::10]:46565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ2pU-0005Rs-8a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ2pQ-0002Fz-2k
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:40:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQ2pP-0002FY-T2
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:40:12 -0400
Date: Tue, 5 Jun 2018 11:39:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180605033958.GC32701@xz-mi>
References: <20180604080630.10946-1-peterx@redhat.com>
	<CAJ+F1CLkDdMSQ6cyMNv8Gwf1AtdgfKV9Zz-F+ZT=FUVTERuevg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLkDdMSQ6cyMNv8Gwf1AtdgfKV9Zz-F+ZT=FUVTERuevg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jun 04, 2018 at 05:01:21PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jun 4, 2018 at 10:06 AM, Peter Xu <peterx@redhat.com> wrote:
> > Previously we cleanup the queues when we got CLOSED event.  It was us=
ed
> > to make sure we won't leftover replies/events of a old client to a ne=
w
> > client.  Now this patch postpones that until OPENED.
> >
> > In most cases, it does not really matter much since either way will m=
ake
> > sure that the new client won't receive unexpected old events/response=
s.
> > However there can be a very rare race condition with the old way when=
 we
> > use QMP with stdio and pipelines (which is quite common in iotests).
> > The problem is that, we can easily have something like this in script=
s:
> >
> >   cat $QMP_COMMANDS | qemu -qmp stdio ... | filter_commands
> >
> > In most cases, a QMP session will be based on a bidirectional
> > channel (read/write to a TCP port, for example), so IN and OUT are
> > sharing some fundamentally same thing.  However that's untrue for pip=
es
> > above - the IN is the "cat" program, while the "OUT" is directed to t=
he
> > "filter_commands" which is actually another process.
> >
> > Now when we received the CLOSED event, we cleanup the queues (includi=
ng
> > the QMP response queue).  That means, if we kill/stop the "cat" proce=
ss
> > faster than the filter_commands process, the filter_commands process =
is
> > possible to miss some responses/events that should belong to it.
> >
> > In practise, I encountered a very strange SHUTDOWN event missing when
> > running test with iotest 087.  Without this patch, iotest 078 will ha=
ve
> > ~10% chance to miss the SHUTDOWN event and fail when with Out-Of-Band
> > enabled:
> >
> > 087 8s ... - output mismatch (see 087.out.bad)
> > --- /home/peterx/git/qemu/tests/qemu-iotests/087.out    2018-06-01 18=
:44:22.378982462 +0800
> > +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad    2018-=
06-01 18:53:44.267840928 +0800
> > @@ -8,7 +8,6 @@
> >  {"return": {}}
> >  {"error": {"class": "GenericError", "desc": "'node-name' must be spe=
cified for the root node"}}
> >  {"return": {}}
> > -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "SHUTDOWN", "data": {"guest": false}}
> >
> >  =3D=3D=3D Duplicate ID =3D=3D=3D
> > @@ -53,7 +52,6 @@
> >  {"return": {}}
> >  {"return": {}}
> >  {"return": {}}
> > -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "SHUTDOWN", "data": {"guest": false}}
> >
> > This patch fixes the problem.
> >
> > Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 46814af533..6f26108108 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4354,6 +4354,7 @@ static void monitor_qmp_event(void *opaque, int=
 event)
> >
> >      switch (event) {
> >      case CHR_EVENT_OPENED:
> > +        monitor_qmp_cleanup_queues(mon);
> >          mon->qmp.commands =3D &qmp_cap_negotiation_commands;
> >          monitor_qmp_caps_reset(mon);
> >          data =3D get_qmp_greeting(mon);
> > @@ -4362,7 +4363,6 @@ static void monitor_qmp_event(void *opaque, int=
 event)
> >          mon_refcount++;
> >          break;
> >      case CHR_EVENT_CLOSED:
> > -        monitor_qmp_cleanup_queues(mon);
> >          json_message_parser_destroy(&mon->qmp.parser);
> >          json_message_parser_init(&mon->qmp.parser, handle_qmp_comman=
d);
> >          mon_refcount--;
> > --
> > 2.17.0
> >
> >
>=20
> Drawback, we will not clean up pending commands until next client.

IMHO that's fine.

>=20
> Perhaps we could have something more specific to the stdio case (untest=
ed):

Yeah if we can fix that from the QIO layer that'll be good to me too,
though...

>=20
>=20
> diff --git a/include/io/channel-file.h b/include/io/channel-file.h
> index ebfe54ec70..04a20bc2ed 100644
> --- a/include/io/channel-file.h
> +++ b/include/io/channel-file.h
> @@ -90,4 +90,12 @@ qio_channel_file_new_path(const char *path,
>                            mode_t mode,
>                            Error **errp);
>=20
> +/**
> + * qio_channel_file_is_opened:
> + *
> + * Returns: true if the associated file descriptor is valid & opened.
> + */
> +bool
> +qio_channel_file_is_opened(QIOChannelFile *ioc);
> +
>  #endif /* QIO_CHANNEL_FILE_H */
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index 2c9b2ce567..bf9803b4c9 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -59,7 +59,10 @@ static gboolean fd_chr_read(QIOChannel *chan,
> GIOCondition cond, void *opaque)
>          chan, (gchar *)buf, len, NULL);
>      if (ret =3D=3D 0) {
>          remove_fd_in_watch(chr);
> -        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +        if (!qio_channel_file_is_opened(s->ioc_out)) {
> +            /* only send close event if both in & out channels are clo=
sed */
> +            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);

... here what if we close READ file first then WRITE file?  Will we
miss one CLOSED event then for the channel?

Regards,

> +        }
>          return FALSE;
>      }
>      if (ret > 0) {
> diff --git a/io/channel-file.c b/io/channel-file.c
> index db948abc3e..1a02f99abf 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -63,6 +63,12 @@ qio_channel_file_new_path(const char *path,
>      return ioc;
>  }
>=20
> +bool
> +qio_channel_file_is_opened(QIOChannelFile *ioc)
> +{
> +    errno =3D 0;
> +    return ioc->fd !=3D -1 && (fcntl(ioc->fd, F_GETFD) !=3D -1 || errn=
o !=3D EBADF);
> +}
>=20
>  static void qio_channel_file_init(Object *obj)
>  {
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

--=20
Peter Xu
