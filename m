Received: from eggs.gnu.org ([2001:4830:134:3::10]:43341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gA9ro-0005Il-DR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gA9rk-00054E-47
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:29:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gA9rj-00052D-Sp
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:29:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so4672087wrw.3
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 01:29:11 -0700 (PDT)
Date: Tue, 9 Oct 2018 13:07:23 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20181009130723.76f3c6f2@fiorina>
In-Reply-To: <CAMxuvay-g7rokzGhjZqk0mrithEAHD-g2pBTHrAouuEXzgt6rQ@mail.gmail.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
	<0ad2a56e767a04f8fd2c8cb32ed6c1bc0f1c2497.1538652143.git.tgolembi@redhat.com>
	<CAMxuvay-g7rokzGhjZqk0mrithEAHD-g2pBTHrAouuEXzgt6rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/11] qga-win: fix crashes when PCI
 info cannot be retrived
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

On Thu, 4 Oct 2018 17:21:32 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Hi
> On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com> wrote:
> >
> > The guest-get-fsinfo command collects also information about PCI
> > controller where the disk is attached. When this fails for some reasons
> > it tries to return just the partial information. However in certain
> > cases the pointer to the structure was not initialized and was set to
> > NULL. This breaks the serializer and leads to a crash of the guest agen=
t.
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-win32.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 98d9735389..9c959122d9 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -633,15 +633,32 @@ static GuestDiskAddressList *build_guest_disk_inf=
o(char *guid, Error **errp)
> >           * https://technet.microsoft.com/en-us/library/ee851589(v=3Dws=
.10).aspx */
> >          if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, sc=
si_ad,
> >                              sizeof(SCSI_ADDRESS), &len, NULL)) {
> > +            Error *local_err =3D NULL;
> >              disk->unit =3D addr.Lun;
> >              disk->target =3D addr.TargetId;
> >              disk->bus =3D addr.PathId;
> > -            disk->pci_controller =3D get_pci_info(name, errp);
> > +            g_debug("unit=3D%lld target=3D%lld bus=3D%lld",
> > +                disk->unit, disk->target, disk->bus);
> > +            disk->pci_controller =3D get_pci_info(name, &local_err);
> > +
> > +            if (local_err) {
> > +                g_debug("failed to get PCI controller info: %s",
> > +                    error_get_pretty(local_err));
> > +                error_free(local_err);
> > +            } else if (disk->pci_controller !=3D NULL) {
> > +                g_debug("pci: domain=3D%lld bus=3D%lld slot=3D%lld fun=
ction=3D%lld",
> > +                    disk->pci_controller->domain,
> > +                    disk->pci_controller->bus,
> > +                    disk->pci_controller->slot,
> > +                    disk->pci_controller->function);
> > +            }
> >          }
> > -        /* We do not set error in this case, because we still have eno=
ugh
> > -         * information about volume. */
> > -    } else {
> > -         disk->pci_controller =3D NULL;
> > +    }
> > +    /* We do not set error in case pci_controller is NULL, because we =
still
> > +     * have enough information about volume. */
> > +    if (disk->pci_controller =3D=3D NULL) {
> > +        g_debug("no PCI controller info");
> > +        disk->pci_controller =3D g_malloc0(sizeof(GuestPCIAddress));
> >      } =20
>=20
> Shouldn't pci-controller be made optional in the schema instead?

It should, but that requires API change.=20
Eric suggested that previously too:

https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08599.html

I will do that in next version.

    Tomas

>=20
> >
> >      list =3D g_malloc0(sizeof(*list));
> > --
> > 2.19.0
> > =20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
