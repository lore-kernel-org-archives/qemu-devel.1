Received: from eggs.gnu.org ([2001:4830:134:3::10]:57735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZG74-0003vr-P3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZG70-0003uC-Ri
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:12:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZG6y-0003sZ-Q2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:12:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so16082368wrr.0
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
	<20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
In-Reply-To: <20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Dec 2018 18:04:39 +0400
Message-ID: <CAJ+F1CJtFJ_vk817tQsGEi3B+xC4bH3eGxA+tRPayyj3F0gnsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi

On Tue, Aug 7, 2018 at 6:30 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > spice arguments over time.  So if we want auto-launching of a remote =
app,
> > > I think it is preferrable to do it via extra args to the existing
> > > "-display spice" format. eg we could add a "client=3Dyes|no" to contr=
ol
> > > launching the client
> > >
> > >    -display spice,client=3Dyes
> >
> > There is no -display spice, atm.
> >
> > However there is a -display vnc.
>
> That should not be there.  Now that we have a deprecation process
> I should probably actually deprecate it in favor of -vnc.
>
> > It's a bit unclear to me the relation between -display and
> > -vnc/-spice/-curses etc. In the end, I tend to think of -display foo
> > as a shortcut for a longer -foo configuration.
>
> -display is for builtin UIs.  You can have exactly one of these.
>
> -spice and -vnc is for remote protocols.  They can be used together with
> builtin UIs (even though that isn't a typical use case).  Configuring
> both spice and vnc works too.
>
> -sdl and -curses are shortcuts for -display sdl and -display curses.
>
> > So -display spice,client=3Dyes is a reasonable proposal to me, making i=
t
> > clear that it will run spice. (client=3Dyes is less clear to me but
> > fine)
>
> Hmm, this will both configure some standard stuff and start an external
> application.  Doesn't really fit with "-spice ...".
>
> Adding "-display remote-client" doesn't really fit either.  But still

I would rather keep the shorter "-display app" version. If you feel
strongly about "remote-client", I'll rename it.

> looks better to me.  Or we just create a new -remote-client top level
> switch.  Adding higher-level config options (protocol=3Dspice/vnc,
> monitor=3Don/off, serial=3Don/off, ...) is less confusing then (especiall=
y
> vnc support :) ), compared to have a bunch of more -spice options which
> only have an effect with client=3Dyes.
>
> Also:  remote-viewer accepts config files.  I'd suggest to write one, so
> it is easy to restart remote-viewer.  Also I would not use a temp dir

Where should it be written? Should the location be printed on stdout,
or given by the user, on command line? What should be the content of
the .vv file? Should it use a template to avoid proxying all the
options?

I think this can be considered for a later improvement.

> for the files and sockets, but some fixed location.
> /run/user/$uid/qemu/$vmname for example (where $vmname is whatever you
> passed to qemu using -name).

That's easy enough, although if no -name is given, I suppose a
temporary location is still better than a fixed location. I'll update
the patch.

thanks



--=20
Marc-Andr=C3=A9 Lureau
