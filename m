Received: from eggs.gnu.org ([2001:4830:134:3::10]:44182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUn4t-0000mY-Lp
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUn4o-00012e-I9
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:24:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gUn4o-00011f-AJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:23:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so25184851qtn.3
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 22:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-5-marcandre.lureau@redhat.com>
	<87bm5zkx0o.fsf@dusky.pond.sub.org>
In-Reply-To: <87bm5zkx0o.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 6 Dec 2018 10:23:45 +0400
Message-ID: <CAMxuvazPAjrEt2nyEVSwsVhap-dEGGXSa-N1GcdgK-UuhMfN+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/7] monitor: check if chardev
 can switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, lizhijian@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, zhangckid@gmail.com, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Bonzini,
	Paolo" <pbonzini@redhat.com>

Hi
On Thu, Dec 6, 2018 at 10:08 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> One more question...
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Not all backends are able to switch gcontext. Those backends cannot
> > drive a OOB monitor (the monitor would then be blocking on main
> > thread).
> >
> > For example, ringbuf, spice, or more esoteric input chardevs like
> > braille or MUX.
>
> These chardevs don't provide QEMU_CHAR_FEATURE_GCONTEXT.
>
> > We currently forbid MUX because not all frontends are ready to run
> > outside main loop. Extend to add a context-switching feature check.
>
> Why check CHARDEV_IS_MUX() when chardev-mux already fails the
> qemu_char_feature_gcontext(chr, QEMU_CHAR_FEATURE_GCONTEXT) check?
>


It currently fails, but with "[PATCH 4/9] char: update the mux
hanlders in class callback", it won't.

But the main reason to keep an explicit check on mux is that the
monitor frontend doesn't know if other mux frontends can be called
from any context (when you set a context, it is set on the backend
side, events are dispatched by the backend).

We may want to mix this extra frontend-side capability limitation with
FEATURE_GCONTEXT flag, but they are fundamentally different: to be
able to set a backend context VS attached mux frontends can be
dispatched from any context.


> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 79afe99079..25cf4223e8 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4562,9 +4562,11 @@ void monitor_init(Chardev *chr, int flags)
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
