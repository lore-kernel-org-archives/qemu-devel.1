Received: from eggs.gnu.org ([2001:4830:134:3::10]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZb43-0006J1-T2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZb42-00028m-MY
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:35:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZb42-00028O-GG
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:35:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id s12so18927345wrt.4
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 04:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
	<20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
	<CAJ+F1CJtFJ_vk817tQsGEi3B+xC4bH3eGxA+tRPayyj3F0gnsw@mail.gmail.com>
	<20181219071325.c7ayirk564s7kuhn@sirius.home.kraxel.org>
	<CAJ+F1CKzb3DmmuQG5itgsUxvUwM34fh242FsgxKp1Aj-fksrBg@mail.gmail.com>
	<20181219095442.oayncn5ufysvntet@sirius.home.kraxel.org>
In-Reply-To: <20181219095442.oayncn5ufysvntet@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 19 Dec 2018 16:34:50 +0400
Message-ID: <CAJ+F1CJ-jg9fSoE1Z3g3vQvXO8sz320YrBEs7sa_Dr+o-JQAYg@mail.gmail.com>
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

On Wed, Dec 19, 2018 at 1:54 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Dec 19, 2018 at 11:44:07AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > On Wed, Dec 19, 2018 at 11:13 AM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> > >
> > >   Hi,
> > >
> > > > > Also:  remote-viewer accepts config files.  I'd suggest to write =
one, so
> > > > > it is easy to restart remote-viewer.  Also I would not use a temp=
 dir
> > > >
> > > > Where should it be written?
> > >
> > > /run/user/$uid/qemu/$vmname/remote-viewer.vv ?
> > >
> > > > What should be the content of
> > > > the .vv file?
> > >
> > > Everything needed, so launching remote-viewer is
> > > just "remote-viewer /path/to/config.vv".
> >
> > If it's just what is needed to launch the viewer, why not stick to the
> > url syntax?
>
> First, the info needed to launch is located on a fixed & well known
> place on disk then, so it is easy to restart remote-viewer.

It would also be a fixed URI, if we use the spice+unix:// syntax.

Fwiw, yes it's not registered in IANA/IETF, or with a RFC, but it is
considered "standard" withing the spice project. So we could formally
document it, as part of the protocol perhaps?, if it helps.

>
> Second, with a vv file you can do a bit more, for example setting "ca"
> in case TLS is configured, or set enable-{smartcard,usbredir} depending
> on guest configuration.
>
> > .vv files are quite specific to virt-viewer/remote-viewer.
>
> The same is true for the URL syntax.  Trying to pass a URL to vncviewer
> doesn't work ...

For vnc://
https://tools.ietf.org/html/rfc7869

(I recall some docs abourt rdp:// as well)

>
> > > > Should it use a template to avoid proxying all the
> > > > options?
> > >
> > > Is this needed?  virt-viewer has a user settings file,
> > > shouldn't user preferences go there instead?
> >
> > User settings files are quite limited at this point. Afaik, it's only
> > used for the "ask-quit" preference, and "monitor-mapping". Other
> > options are either from command line or .vv files.
>
> Ok.
>
> I think it is more useful to extend that instead of passing through
> options from the qemu command line to virt-viewer.

Hmm, although it limits what you can easily configure per instance as well.=
.

--=20
Marc-Andr=C3=A9 Lureau
