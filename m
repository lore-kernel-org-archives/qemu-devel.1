Received: from eggs.gnu.org ([209.51.188.92]:48945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtEeE-00017S-9P
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gtEe6-000150-CG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:41:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gtEe0-0000xt-RY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:41:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id o17so1112294wrw.3
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:41:18 -0800 (PST)
MIME-Version: 1.0
References: <CABLmASFLwswYELUGHKjZct6XnEYb4tKn1XEuCAgwniN7NM110g@mail.gmail.com>
	<0be24d4d-19e3-0c4a-e414-ed61b043f1cb@redhat.com>
	<CAFEAcA8zMbX4-5zgH5qOQfbpQ0vpmqUqsbz1-uNYGi6dUvu8og@mail.gmail.com>
In-Reply-To: <CAFEAcA8zMbX4-5zgH5qOQfbpQ0vpmqUqsbz1-uNYGi6dUvu8og@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Feb 2019 17:06:38 +0100
Message-ID: <CAJ+F1CKE5SLt=8AOvr291zeLn7Dxah=6ePvBu8PyjNt-Q6a7yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Bug: Lost slirp functionality on qemu-system-ppc
 build for windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Howard Spoelstra <hsp.cat7@gmail.com>

Hi

On Mon, Feb 11, 2019 at 10:52 AM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
> On Mon, 11 Feb 2019 at 07:57, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 2019-02-10 23:12, Howard Spoelstra wrote:
> > > Hi,
> > >
> > > I just cross compiled Qemu-system-ppc for Windows on Fedora 29 and
> > > discovered slirp does not work anymore. Tap networking works fine.
> > > Bisecting got me here:
> > >
> > > a9d8b3ec4385793815d7121785730422fa3dfb68 is the first bad commit
> > > commit a9d8b3ec4385793815d7121785730422fa3dfb68
> > > Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Date:   Thu Jan 17 15:43:52 2019 +0400
> > >
> > >     slirp: replace remaining qemu headers dependency
> > >
> > >     Except for the migration code which is gated by WITH_QEMU, only
> > >     include our own headers, so libslirp can be built standalone.
> > >
> > >     Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> > >     Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > >
> > > :040000 040000 cd06df21ed96497cd12f2a20adb3d66cb0da8010
> > > ab5afd3f50910e39b2b700722cd47de8f0cf9e2c M    slirp
> >
> > Thanks for bisecting the issue already! ... adding Marc-Andr=C3=A9 and =
Samuel
> > to the thread, maybe they have a clue what might be wrong here...
>
> Probably you've missed something in copying the "work around
> weird Windows host stuff" bits from osdep.h and sysemu/os-win32.h.
> For instance you don't seem to have an equivalent of most of the
> wrapped functions that set errno -- eg os-win32.h defines recv
> to be qemu_recv_wrap, which is a function in util/oslib-win32.c.

It looks like you are right. I am working on a patch set to fix it asap.

thanks

--=20
Marc-Andr=C3=A9 Lureau
