Received: from eggs.gnu.org ([2001:4830:134:3::10]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g96qU-0005oE-AM
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g96qT-0007o4-Am
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:03:34 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:36912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1g96qS-0007kT-Pt
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:03:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id c22-v6so15175156edc.4
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<b004cd17d0fa02ed169c5b101fdbbb7fa2b6b633.1538652143.git.tgolembi@redhat.com>
	<CAMxuvayviBgZXJJRiXNTd9Z2=tJZtkSjL-8RJODRM9NAtUufgA@mail.gmail.com>
In-Reply-To: <CAMxuvayviBgZXJJRiXNTd9Z2=tJZtkSjL-8RJODRM9NAtUufgA@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 7 Oct 2018 14:03:16 +0300
Message-ID: <CAKPgXcFv47bgxnBzgq0reBgnfaRz-FZiPtieRqnZ1yrddosdiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/11] qga-win: demystify namespace
 striping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: tgolembi@redhat.com, Sameeh Jubran <sjubran@redhat.com>, okrishtal@virtuozzo.com, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

+1, this is much clearer.
On Thu, Oct 4, 2018 at 4:34 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com> wrote:
> >
> > It was not obvious what exactly the cryptic string copying does to the
> > GUID. This change makes the intent clearer.
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  qga/commands-win32.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index d0d969d0ce..82881aa749 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -507,7 +507,14 @@ static GuestPCIAddress *get_pci_info(char *guid, E=
rror **errp)
> >      char dev_name[MAX_PATH];
> >      char *buffer =3D NULL;
> >      GuestPCIAddress *pci =3D NULL;
> > -    char *name =3D g_strdup(&guid[4]);
> > +    char *name =3D NULL;
> > +
> > +    if ((g_str_has_prefix(guid, "\\\\.\\") =3D=3D TRUE) ||
> > +        (g_str_has_prefix(guid, "\\\\?\\") =3D=3D TRUE)) {
> > +        name =3D g_strdup(&guid[4]);
>
> I find "guid + 4" easier to read though
>
> > +    } else {
> > +        name =3D g_strdup(guid);
> > +    }
> >
> >      if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
> >          error_setg_win32(errp, GetLastError(), "failed to get dos devi=
ce name");
> > --
> > 2.19.0
> >
>


--=20
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.
