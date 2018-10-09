Received: from eggs.gnu.org ([2001:4830:134:3::10]:43330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gA9rl-0005IV-VB
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gA9rh-00051q-WC
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:29:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gA9rh-00050i-Pa
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:29:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so4645105wru.9
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 01:29:07 -0700 (PDT)
Date: Tue, 9 Oct 2018 14:38:38 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20181009143838.23f19a4c@fiorina>
In-Reply-To: <CAMxuvayviBgZXJJRiXNTd9Z2=tJZtkSjL-8RJODRM9NAtUufgA@mail.gmail.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
	<b004cd17d0fa02ed169c5b101fdbbb7fa2b6b633.1538652143.git.tgolembi@redhat.com>
	<CAMxuvayviBgZXJJRiXNTd9Z2=tJZtkSjL-8RJODRM9NAtUufgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>, sjubran@redhat.com, okrishtal@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, 4 Oct 2018 17:20:50 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Hi
>=20
> On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com> wrote:
> >
> > It was not obvious what exactly the cryptic string copying does to the
> > GUID. This change makes the intent clearer.
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> =
=20
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
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
> > +        name =3D g_strdup(&guid[4]); =20
>=20
> I find "guid + 4" easier to read though

I will change that, no problem.

>=20
> > +    } else {
> > +        name =3D g_strdup(guid);
> > +    }
> >
> >      if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
> >          error_setg_win32(errp, GetLastError(), "failed to get dos devi=
ce name");
> > --
> > 2.19.0
> > =20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
