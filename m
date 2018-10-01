Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g6x3A-00015D-EP
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g6x37-0007no-4G
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:11:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g6x36-0007nO-TT
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:11:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so8545693wmc.0
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 05:11:40 -0700 (PDT)
Date: Mon, 1 Oct 2018 14:11:35 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20181001141135.2b8edfaa@fiorina>
In-Reply-To: <CAEJSYa5V2EJvf2f9c_xzkRgxMjFQNOgn6jxDVJiVn5fMyF=+HQ@mail.gmail.com>
References: <cover.1536320522.git.tgolembi@redhat.com>
	<a8cf3b35e7559bfaf20f2d71a0b4809fdd4f38e6.1536320522.git.tgolembi@redhat.com>
	<153798214847.23852.9604404244034052003@sif>
	<20180927110620.0e8502b3@fiorina>
	<CAEJSYa5V2EJvf2f9c_xzkRgxMjFQNOgn6jxDVJiVn5fMyF=+HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qga: win32: fix crashes when PCI
 info cannot be retrived
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sjubran@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, eblake@redhat.com, okrishtal@virtuozzo.com, marcandre.lureau@redhat.com

On Thu, 27 Sep 2018 18:16:04 +0300
Sameeh Jubran <sjubran@redhat.com> wrote:

> On Thu, Sep 27, 2018 at 12:06 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgole=
mbi@redhat.com>
> wrote:
>=20
> > Hi Michael,
> >
> > thanks for looking into this. My comments are below.
> >
> > Adding Sameeh...
> >
> >
> > On Wed, 26 Sep 2018 12:15:48 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > =20
> > > Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2018-09-07 06:42:09) =20
> > > > The guest-get-fsinfo command collects also information about PCI
> > > > controller where the disk is attached. When this fails for some rea=
sons
> > > > it tries to return just the partial information. However in certain
> > > > cases the pointer to the structure was not initialized and was set =
to
> > > > NULL. This breaks the serializer and leads to a crash of the guest =
=20
> > agent. =20
> > > >
> > > > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.c=
om> =20
> > >
> > > For a win10 guest started with:
> > >
> > > qemu-system-x86_64 -m 2G -smp 2,cores=3D2,sockets=3D1 -drive =20
> > file=3D/home/mdroth/vm/win10_pro_n_snap0.qcow2,if=3Dvirtio -drive
> > file=3D/home/mdroth/vm/virtio-win-0.1.102.iso,if=3Dide,media=3Dcdrom -r=
tc
> > base=3Dlocaltime,driftfix=3Dslew -vga std -boot d -name vm4 -netdev
> > tap,script=3D/etc/qemu-ifup,vhost=3Don,id=3Dvnet0 -device
> > virtio-net-pci,mac=3D52:54:00:12:34:04,id=3Dvnic0,netdev=3Dvnet0,disabl=
e-modern=3Dtrue
> > -vnc :4 -device virtio-serial -balloon virtio -mon chardev=3Dhmp0 -char=
dev
> > socket,path=3D/tmp/vm4-hmp0.sock,server,nowait,id=3Dhmp0 -mon
> > chardev=3Dqmp0,mode=3Dcontrol -chardev
> > socket,path=3D/tmp/vm4-qmp0.sock,server,nowait,id=3Dqmp0 -device
> > virtserialport,chardev=3Dvs0,name=3Dvs0,id=3Dvs_vs0 -chardev
> > socket,path=3D/tmp/vm4-vs0.sock,server,nowait,id=3Dvs0 -device
> > virtserialport,chardev=3Dvs1,name=3Dvs1,id=3Dvs_vs1 -chardev
> > socket,path=3D/tmp/vm4-vs1.sock,server,nowait,id=3Dvs1 -device
> > virtserialport,chardev=3Dqga,name=3Dorg.qemu.guest_agent.0,id=3Dvs_qga =
-chardev
> > socket,path=3D/tmp/vm4-qga.sock,server,nowait,id=3Dqga -device
> > isa-serial,chardev=3Dserial0,id=3Dserial_serial0 -chardev
> > socket,path=3D/tmp/vm4-serial0.sock,server,nowait,id=3Dserial0 -L
> > /home/mdroth/w/build/qemu-2.11.2-build/pc-bios --enable-kvm =20
> > >
> > > this yields the following:
> > >
> > > {'execute':'guest-get-fsinfo'}
> > > {"return": [{"name": =20
> > "\\\\?\\Volume{83835b2d-0032-11e6-a84f-806e6f6e6963}\\", "total-bytes":
> > 160755712, "mountpoint": "D:\\", "disk": [{"bus-type": "ide", "bus": 0,
> > "unit": 0, "pci-controller": {"bus": 0, "slot": 0, "domain": 0, "functi=
on":
> > 0}, "target": 0}], "used-bytes": 160755712, "type": "CDFS"}, {"name":
> > "\\\\?\\Volume{2ea839c6-0000-0000-0000-80620c000000}\\", "mountpoint":
> > "System Reserved", "disk": [{"bus-type": "scsi", "bus": 0, "unit": 0,
> > "pci-controller": {"bus": 0, "slot": 0, "domain": 0, "function": 0},
> > "target": 0}], "type": "NTFS"}, {"name":
> > "\\\\?\\Volume{2ea839c6-0000-0000-0000-501f00000000}\\", "total-bytes":
> > 52665839616, "mountpoint": "C:\\", "disk": [{"bus-type": "scsi", "bus":=
 0,
> > "unit": 0, "pci-controller": {"bus": 0, "slot": 0, "domain": 0, "functi=
on":
> > 0}, "target": 0}], "used-bytes": 25265487872, "type": "NTFS"}, {"name":
> > "\\\\?\\Volume{2ea839c6-0000-0000-0000-100000000000}\\", "mountpoint":
> > "System Reserved", "disk": [{"bus-type": "scsi", "bus": 0, "unit": 0,
> > "pci-controller": {"bus": 0, "slot": 0, "domain": 0, "function": 0},
> > "target": 0}], "type": "NTFS"}]} =20
> > >
> > > domain/bus/slot/function=3D0 are valid PCI addresses so initializing =
to 0 =20
> > is =20
> > > wrong. Sameeh had a previous series that initializes to -1 that I thi=
nk
> > > is more appropriate (it hasn't gone in yet since we opted not to enab=
le
> > > CONFIG_QGA_NTDDSCSI for 3.0 since the PCI stuff seems be generally
> > > broken for Windows, also because the 2nd patch needs some fixups: =20
> > =20
> Can you please elaborate? What kind of fixups? I can see no comments of
> this in the 2nd patch
>=20

I think he refers to this fix:

https://github.com/mdroth/qemu/commit/201db36b56d7d1ba5ff720eedcb3b62b75306=
fde

Plus there seems to be an issue when "calculating" function number as
described below. (Maybe related to casting addr from -1 to uint and
back?)

> > >
> > >   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07500.html=
 =20
> >
> > I wasn't aware of that. I is trying to "fix" the same issue.
> >
> > I've been also thinking about using -1, but I didn't know what is/isn't
> > correct PCI address.
> > =20
> > >
> > > With that series (and some fixups I have on top at
> > > https://github.com/mdroth/qemu/commits/qga-test), we get the following
> > > output: =20
> >
> > Should I rebase on that and drop my patch?
> > =20
> > >
> > > {'execute':'guest-get-fsinfo'}
> > > {"return": [{"name": =20
> > "\\\\?\\Volume{83835b2d-0032-11e6-a84f-806e6f6e6963}\\", "total-bytes":
> > 160755712, "mountpoint": "D:\\", "disk": [{"bus-type": "ide", "bus": 0,
> > "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": -1,
> > "function": -1}, "target": 0}], "used-bytes": 160755712, "type": "CDFS"=
},
> > {"name": "\\\\?\\Volume{2ea839c6-0000-0000-0000-80620c000000}\\",
> > "mountpoint": "System Reserved", "disk": [{"bus-type": "scsi", "bus": 0,
> > "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": 0,
> > "function": 3}, "target": 0}], "type": "NTFS"}, {"name":
> > "\\\\?\\Volume{2ea839c6-0000-0000-0000-501f00000000}\\", "total-bytes":
> > 52665839616, "mountpoint": "C:\\", "disk": [{"bus-type": "scsi", "bus":=
 0,
> > "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": 0,
> > "function": 2}, "target": 0}], "used-bytes": 25267560448, "type": "NTFS=
"},
> > {"name": "\\\\?\\Volume{2ea839c6-0000-0000-0000-100000000000}\\",
> > "mountpoint": "System Reserved", "disk": [{"bus-type": "scsi", "bus": 0,
> > "unit": 0, "pci-controller": {"bus": -1, "slot": -1, "domain": 0,
> > "function": 1}, "target": 0}], "type": "NTFS"}]} =20
> > >
> > > Here we see the non-sensical PCI topology info I mentioned previously.
> > > There are values like '"function": 3' even though there are no
> > > multifunction devices present. This will be exposed to users if we
> > > enable CONFIG_QGA_NTDDSCSI with things as they stand. =20
> >
> > Sadly, I have no idea how to properly fix this code. But patch 5 of the
> > series IMHO brings it one step closer to proper solution. The original
> > code tries to fetch the addr/bus/domain/slot for volume handle (which
> > fails on missing properties) instead of disk handle. =20
>=20
>=20
> > The remaining issue is that when listing the disks the entries are
> > cryptic names like "\Device\0000001d" instead of "\PhysicalDriveX" or
> > "\HarddiskX". And I don't know how to map one name to the other.
> > =20
>     char *name =3D g_strdup(&guid[4]);
> This needs some investigation...
>=20

This is to strip first 4 characters from UNC names.

    "\\?\abcdef" -> "\abcdef"


> > =20
> > > Currently we
> > > just get an empty array for "disk" field of GuestFilesystemInfo
> > > for w32, which fortunately aligns with the current QAPI schema (it's
> > > an array since the volume can span multiple disks). =20
> >
> > No. You get array with one item and useless data. Unless I missed
> > something.
> >
> > =20
> > > I'm not about the
> > > SCSI bus/unit/target data either. It's a real mess (maybe things
> > > work a bit better when an actual SCSI controller is used?) and I'm
> > > not sure why/how I didn't notice during initial testing. =20
> >
> > I think unit/target should work. At least with all patches from my
> > series (well notably the last patch). But please, do verify that if you
> > can.
> >
> > =20
> > > I think all this needs to be addressed before we enable
> > > CONFIG_QGA_NTDDSCSI (in terms of what that's used for in the current
> > > code at least, i.e. enabling everything reported by
> > > GuestFilesystemInfo.disk).
> > >
> > > What is the oVirt use-case? It doesn't seem like you need PCI topolog=
y,
> > > but what about SCSI topology (and if so, does that information seem
> > > correct to you)? Or is just a list a serials/dev paths by themselves
> > > all that's needed? Trying to see how we might decouple things from the
> > > broken PCI topology stuff. May need to deprecate
> > > GuestFilesystemInfo.disk in favor of something less monolithic if all
> > > of this isn't fixable in a reasonable-enough timeframe. =20
> >
> > We don't need the PCI info. I've been only trying to fix this to some
> > sort along the way. What we need is to get disk serial number (patch 4)
> > and "name" of the disk of some sort (patch 5). For that I use device
> > node (e.g. /dev/sda) on Linux and UNC for the disk on Windows (e.g.
> > \\?\PhysicalDrive1). But the code relies on CONFIG_QGA_NTDDSCSI being
> > enabled.
> > =20
> This is already enabled in downstream version of qga-win, I don't think it
> should be
> enabled upstream if it's not necessary. ( Actually I'm not sure why it is
> disabled in the first place? I supposed because it is not stable)

So can we enable CONFIG_QGA_NTDDSCSI and disable PCI controller info by
different means?

>=20
> >
> >     Tomas
> > =20
> > >
> > > =20
> > > > ---
> > > >  qga/commands-win32.c | 27 ++++++++++++++++++++++-----
> > > >  1 file changed, 22 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > > > index 98d9735389..9c959122d9 100644
> > > > --- a/qga/commands-win32.c
> > > > +++ b/qga/commands-win32.c
> > > > @@ -633,15 +633,32 @@ static GuestDiskAddressList =20
> > *build_guest_disk_info(char *guid, Error **errp) =20
> > > >           * =20
> > https://technet.microsoft.com/en-us/library/ee851589(v=3Dws.10).aspx */=
 =20
> > > >          if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0=
, =20
> > scsi_ad, =20
> > > >                              sizeof(SCSI_ADDRESS), &len, NULL)) {
> > > > +            Error *local_err =3D NULL;
> > > >              disk->unit =3D addr.Lun;
> > > >              disk->target =3D addr.TargetId;
> > > >              disk->bus =3D addr.PathId;
> > > > -            disk->pci_controller =3D get_pci_info(name, errp);
> > > > +            g_debug("unit=3D%lld target=3D%lld bus=3D%lld",
> > > > +                disk->unit, disk->target, disk->bus);
> > > > +            disk->pci_controller =3D get_pci_info(name, &local_err=
);
> > > > +
> > > > +            if (local_err) {
> > > > +                g_debug("failed to get PCI controller info: %s",
> > > > +                    error_get_pretty(local_err));
> > > > +                error_free(local_err);
> > > > +            } else if (disk->pci_controller !=3D NULL) {
> > > > +                g_debug("pci: domain=3D%lld bus=3D%lld slot=3D%lld=
 =20
> > function=3D%lld", =20
> > > > +                    disk->pci_controller->domain,
> > > > +                    disk->pci_controller->bus,
> > > > +                    disk->pci_controller->slot,
> > > > +                    disk->pci_controller->function);
> > > > +            }
> > > >          }
> > > > -        /* We do not set error in this case, because we still have=
 =20
> > enough =20
> > > > -         * information about volume. */
> > > > -    } else {
> > > > -         disk->pci_controller =3D NULL;
> > > > +    }
> > > > +    /* We do not set error in case pci_controller is NULL, because=
 we =20
> > still =20
> > > > +     * have enough information about volume. */
> > > > +    if (disk->pci_controller =3D=3D NULL) {
> > > > +        g_debug("no PCI controller info");
> > > > +        disk->pci_controller =3D g_malloc0(sizeof(GuestPCIAddress)=
);
> > > >      }
> > > >
> > > >      list =3D g_malloc0(sizeof(*list));
> > > > --
> > > > 2.18.0
> > > > =20
> >
> >
> > --
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > =20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
