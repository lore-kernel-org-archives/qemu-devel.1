Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyEsh-0001Qm-0A
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyEsc-0008H9-1p
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:24:54 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fyEsb-0008Gl-Qu
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:24:49 -0400
Received: by mail-wr1-f51.google.com with SMTP id w11-v6so14616629wrc.5
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 04:24:49 -0700 (PDT)
Date: Fri, 7 Sep 2018 13:24:44 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180907132444.19bdddf8@fiorina>
In-Reply-To: <153618966719.28231.7120762050650762023@sif>
References: <cover.1533639095.git.tgolembi@redhat.com>
	<951d1c8265e9ef6b36d61358fd01f267a9b83ca7.1533639095.git.tgolembi@redhat.com>
	<153618966719.28231.7120762050650762023@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qga: win32: fix crashes when PCI
 info cannot be retrived
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>

On Wed, 05 Sep 2018 18:21:07 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2018-08-07 05:51:37)
> > The guest-get-fsinfo command collects also information about PCI
> > controller where the disk is attached. When this fails for some reasons
> > it tries to return just the partial information. However in certain
> > cases the pointer to the structure was not initialized and was set to
> > NULL. This breaks the serializer and lead to crasehs of the guest agent.
> >=20
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-win32.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 36d76c22c0..995f62c2e4 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -642,15 +642,32 @@ static GuestDiskAddressList *build_guest_disk_inf=
o(char *guid, Error **errp)
> >          g_debug("getting pci-controller info");
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
> > +                slog("failed to get PCI controller info: %s",
> > +                    error_get_pretty(local_err)); =20
>=20
> slog() is more for logging/auditing events that a guest administrator mig=
ht
> be interested in knowing about, like when qga is accessing files, freezing
> filesystems, etc. General qga-side error reporting and debug logging shou=
ld
> go through the normal g_debug/g_warning/etc interfaces to be captured in
> qga's log file.

ok

>=20
> We should also moved patch 1 after this so we don't expose a breakage
> prior to the fix.

ok

>=20
> How often are you seeing failures with the pci info?

On Windows 10 Enterprise every the time. On Windows 8 the original code
fails terribly much sooner.

> And does the
> information for the non-failures look valid to you?

I'll tell you when I see that. :)


> I tried to fix the
> CONFIG_QGA_NTDDSCSI naming screw-up a while back and some values like
> PCI func/bus/etc looked bogus, SPDRP_BUSNUMBER/SPDRP_ADDRESS/SPDRP_BUSNUM=
BER
> didn't seem to be returning what the current code thinks they are. If tha=
t's
> still the case it would be good to fix that before we final re-enable this
> code.

Does that mean the queries for SPDRP_* properties work for you?
The issue is that it fails every time as the request is for a
volume not a disk.

Unfortunately I don't know how to fix that at the moment. See my comment
in the followup version of the series that I will send shortly.

    Tomas

>=20
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
> >      }
> >=20
> >      list =3D g_malloc0(sizeof(*list));
> > --=20
> > 2.18.0
> >  =20
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
