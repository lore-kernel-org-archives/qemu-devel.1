Received: from eggs.gnu.org ([2001:4830:134:3::10]:60166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUSxP-0007xT-Ka
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUSxO-0004UG-RY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:54:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUSxO-0004Tg-KI
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:54:58 -0500
Received: by mail-wr1-x441.google.com with SMTP id z5so18749580wrt.11
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 00:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
	<20181204131802.16885-5-marcandre.lureau@redhat.com>
	<874lbs1i0g.fsf@dusky.pond.sub.org>
In-Reply-To: <874lbs1i0g.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Dec 2018 12:54:45 +0400
Message-ID: <CAJ+F1CLBueWzyFJtm+GxfO1rc-KcEpcz_qwo=O3mmW68zyN0eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/6] monitor: check if chardev can
 switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Wed, Dec 5, 2018 at 12:43 PM Markus Armbruster <armbru@redhat.com> wrote=
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
> >
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
>
> Aha, this answers my question on the previous patch: yes, it is possible
> to trip the new assertion.
>
> Are there any ways other than this one?

Good question, if there are, we have latent bugs if switching gcontext
on a non-capable chardev.

Doing a quick review of qemu_chr_fe_set_handlers() for context !=3D NULL
reveals net/colo-compare.c:

I think we should have the capability check added to find_and_check_chardev=
().

I don't see other candidates. Considering the problem is pre-existing,
I can either update the patch or add a follow-up patch.

>
> We could squash the two patches.  But I figure you kept the previous
> patch separate on purpose.  That's okay, but it should mention the
> assertion can be tripped, and the next patch (this one) will fix it.
>


--=20
Marc-Andr=C3=A9 Lureau
