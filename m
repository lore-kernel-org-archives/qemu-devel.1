Received: from eggs.gnu.org ([2001:4830:134:3::10]:48271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cUYvF-0000gK-Ps
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cUYvE-0001h6-Ru
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:08:05 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:33242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cUYvE-0001ft-MX
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:08:04 -0500
Received: by mail-yb0-x243.google.com with SMTP id 123so7055584ybe.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 05:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170118160332.13390-24-marcandre.lureau@redhat.com>
	<1484814026.15364.15.camel@redhat.com>
In-Reply-To: <1484814026.15364.15.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 20 Jan 2017 13:07:51 +0000
Message-ID: <CAJ+F1CLeTaXgja-g_00LmxxiVSDZK5DeHStXPfgpcMNeLYX7Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 23/25] console: make screendump async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Hi

On Thu, Jan 19, 2017 at 12:21 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mi, 2017-01-18 at 20:03 +0400, Marc-Andr=C3=A9 Lureau wrote:
> > +    surface =3D qemu_console_surface(con);
> > +
> > +    /* FIXME: async save with coroutine? it would have to copy or
> > lock
> > +     * the surface. */
> > +    ppm_save(filename, surface, &err);
> > +
>
> No need to lock or copy.
>
> ppm_save() uses the pixman image (surface->image) only anyway, so
> changing it to accept a pixman image instead of the surface is easy.
>
> pixman images are reference counted, so you can just grab a reference
> using pixman_image_ref() and run with it, without risking it'll be
> released underneath your feet, then unref when done.
>
>
If you only ref, you could have the image being modified while it is being
saved asynchronously, this could result in tearing artefacts, no?

--=20
Marc-Andr=C3=A9 Lureau
