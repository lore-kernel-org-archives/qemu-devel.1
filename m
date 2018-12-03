Received: from eggs.gnu.org ([2001:4830:134:3::10]:45614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gTjqO-0007BB-9P
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gTjqK-0007Xq-9Z
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:44:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gTjqK-0007XR-5J
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:44:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so12811262qtn.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 00:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-5-marcandre.lureau@redhat.com>
	<871s6z81da.fsf@dusky.pond.sub.org>
In-Reply-To: <871s6z81da.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 3 Dec 2018 12:44:27 +0400
Message-ID: <CAMxuvay4ODSSTivjnQ=Fs2iDZujScU9hQkPxLfTCAEADf1m-Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] monitor: check if chardev can
 switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Hi

On Mon, Dec 3, 2018 at 12:23 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Not all backends are able to switch gcontext. Those backends cannot
> > drive a OOB monitor (the monitor would then be blocking on main
> > thread).
> >
> > For example, ringbuf, spice, or more esoteric input chardevs like
> > braille or MUX.
> >
> > We currently forbid MUX because not all frontends are ready to run
> > outside main loop. Extend to add a context-switching feature check.
>
> Double-checking: the reason for forbidding MUX and the reason for
> requiring QEMU_CHAR_FEATURE_GCONTEXT are orthogonal, right?

Yes, to me the mux check is there because other front-end sides (other
than QMP monitor) may not handle dispatch from other threads.

Otoh, the GCONTEXT feature check is there to check if the chardev
(backend) handles switching context.


> > Note: this patch will conflict with Peter "[PATCH v9 3/6] monitor:
> > remove "x-oob", turn oob on by default", but can be trivially updated.
>
> I intend to merge this series first, and drop this sentence.
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 511dd11d1c..fffeb27ef9 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4560,9 +4560,11 @@ void monitor_init(Chardev *chr, int flags)
> >      bool use_oob =3D flags & MONITOR_USE_OOB;
> >
> >      if (use_oob) {
> > -        if (CHARDEV_IS_MUX(chr)) {
> > +        if (CHARDEV_IS_MUX(chr) ||
> > +            !qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
> >              error_report("Monitor out-of-band is not supported with "
> > -                         "MUX typed chardev backend");
> > +                         "%s typed chardev backend",
> > +                         object_get_typename(OBJECT(chr)));
> >              exit(1);
> >          }
> >          if (use_readline) {
>
