Received: from eggs.gnu.org ([2001:4830:134:3::10]:55001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gAOW0-0001JT-54
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gAOVw-0008Q0-7F
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:07:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60910
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gAOVv-0008Pc-Rl
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:07:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9B047n8108638
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 20:07:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n1tym1bku-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 20:07:38 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 10 Oct 2018 20:07:38 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <0ad2a56e767a04f8fd2c8cb32ed6c1bc0f1c2497.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
	<0ad2a56e767a04f8fd2c8cb32ed6c1bc0f1c2497.1538652143.git.tgolembi@redhat.com>
Date: Wed, 10 Oct 2018 18:35:50 -0500
Message-Id: <153921455074.28130.1953306136051172522@sif>
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
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>

Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2018-10-04 06:22:28)
> The guest-get-fsinfo command collects also information about PCI
> controller where the disk is attached. When this fails for some reasons
> it tries to return just the partial information. However in certain
> cases the pointer to the structure was not initialized and was set to
> NULL. This breaks the serializer and leads to a crash of the guest agent.
> =

> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 98d9735389..9c959122d9 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -633,15 +633,32 @@ static GuestDiskAddressList *build_guest_disk_info(=
char *guid, Error **errp)
>           * https://technet.microsoft.com/en-us/library/ee851589(v=3Dws.1=
0).aspx */
>          if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi=
_ad,
>                              sizeof(SCSI_ADDRESS), &len, NULL)) {
> +            Error *local_err =3D NULL;
>              disk->unit =3D addr.Lun;
>              disk->target =3D addr.TargetId;
>              disk->bus =3D addr.PathId;
> -            disk->pci_controller =3D get_pci_info(name, errp);
> +            g_debug("unit=3D%lld target=3D%lld bus=3D%lld",
> +                disk->unit, disk->target, disk->bus);
> +            disk->pci_controller =3D get_pci_info(name, &local_err);
> +
> +            if (local_err) {
> +                g_debug("failed to get PCI controller info: %s",
> +                    error_get_pretty(local_err));
> +                error_free(local_err);
> +            } else if (disk->pci_controller !=3D NULL) {
> +                g_debug("pci: domain=3D%lld bus=3D%lld slot=3D%lld funct=
ion=3D%lld",
> +                    disk->pci_controller->domain,
> +                    disk->pci_controller->bus,
> +                    disk->pci_controller->slot,
> +                    disk->pci_controller->function);
> +            }
>          }
> -        /* We do not set error in this case, because we still have enough
> -         * information about volume. */
> -    } else {
> -         disk->pci_controller =3D NULL;
> +    }
> +    /* We do not set error in case pci_controller is NULL, because we st=
ill
> +     * have enough information about volume. */
> +    if (disk->pci_controller =3D=3D NULL) {
> +        g_debug("no PCI controller info");
> +        disk->pci_controller =3D g_malloc0(sizeof(GuestPCIAddress));

Initializing to 0 would be wrong. I pointed out a patch from Sameeh in
v3 that initializes to -1. I'd recommend either picking up his patch,
or perhaps the schema change. But if we do go to the extent of a
non-backward-compatible schema change, I think we should also consider
just deprecating the current GuestDiskAddress list completely:

{ 'struct': 'GuestDiskAddress',
  'data': {'pci-controller': 'GuestPCIAddress',
           'bus-type': 'GuestDiskBusType',
           'bus': 'int', 'target': 'int', 'unit': 'int'} }

and defining something more modular. Some these there don't make a lot
of sense, like how GuestDiskBusType varies between scsi, ide, usb, etc,
but we still have the same bus/target/unit fields. I think each bus type =

should have it's own addressing units associated with it. The original
code made use of the fact that IDE/SATA/SCSI/SAS/etc could all be
retrieved via IOCTL_SCSI_GET_ADDRESS with those units but making sense
of them is sort of Windows magic that isn't good from an API perspective
and then there's all the other bus types where those units may or may
not be sensible. And on POSIX you basically have to look at the code
to figure out where each unit is/isn't being plucked from...

So for now I'd recommend just hard-setting the PCI fields to -1 like
in Sameeh's patch, and I'll do some testing and send a follow-up patch
to do the same for bus-type if that seems needed. We can explore better
options after 3.1.

>      }
> =

>      list =3D g_malloc0(sizeof(*list));
> -- =

> 2.19.0
>=20
