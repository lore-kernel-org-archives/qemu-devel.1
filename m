Received: from eggs.gnu.org ([2001:4830:134:3::10]:34669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH6Jg-0004Is-6g
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH6Jf-00088j-Bt
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:06:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gH6Je-00082Y-WC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:06:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id q12-v6so4964708wmq.0
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 05:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
	<20181009131251.721-5-marcandre.lureau@redhat.com>
	<20181010043700.GO18728@xz-x1>
In-Reply-To: <20181010043700.GO18728@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Oct 2018 16:06:21 +0400
Message-ID: <CAJ+F1CJaERBCgaZUHZ5+KFNBXJfe6Pm52H-D6jF3j0msOSsVWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] monitor: check if chardev can switch
 gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi

On Wed, Oct 10, 2018 at 8:38 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 09, 2018 at 05:12:49PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Note: this patch will conflict with Peter "[PATCH v9 3/6] monitor:
> > remove "x-oob", turn oob on by default", but can be trivially updated.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index a25514490a..c175cf6f0d 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4550,9 +4550,10 @@ void monitor_init(Chardev *chr, int flags)
> >      bool use_oob =3D flags & MONITOR_USE_OOB;
> >
> >      if (use_oob) {
> > -        if (CHARDEV_IS_MUX(chr)) {
> > +        if (!qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
> >              error_report("Monitor out-of-band is not supported with "
> > -                         "MUX typed chardev backend");
> > +                         "%s typed chardev backend",
> > +                         object_get_typename(OBJECT(chr)));
>
> This seems a bit confusing to me at the first glance since we forbid
> mux because not all frontends are ready to run outside main loop (and
> now we have mon_iothread so it'll be odd too to run anything
> non-monitor on that too...), rather than whether the backend can
> dynamically switch its context.
>
> I'm not sure, but do you mean you want to disable oob for backends
> like spice or braille?  I just noticed that it seems even legal if we
> pipe a qmp monitor with a windows mouse...

yes, basically any chardev that doesn't handle the gcontext argument.

They match those that don't implement chr_update_read_handler at this point=
.

> I believe in all cases the commit message can be enhanced on
> explaining "why" of this patch. :)

ok, I'll keep the explicit mux case, even if it overlaps with gcontext
feature, and update commit message.

thanks

>
> Regards,
>
> --
> Peter Xu
>


--=20
Marc-Andr=C3=A9 Lureau
