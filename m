Received: from eggs.gnu.org ([2001:4830:134:3::10]:46620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fxh9H-0008DQ-O9
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 19:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fxh9C-0001eq-ME
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 19:23:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53444
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fxh9C-0001du-Ek
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 19:23:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w85NMSl3147054
	for <qemu-devel@nongnu.org>; Wed, 5 Sep 2018 19:23:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2marrq814s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 19:23:41 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 5 Sep 2018 17:23:40 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <951d1c8265e9ef6b36d61358fd01f267a9b83ca7.1533639095.git.tgolembi@redhat.com>
References: <cover.1533639095.git.tgolembi@redhat.com>
	<951d1c8265e9ef6b36d61358fd01f267a9b83ca7.1533639095.git.tgolembi@redhat.com>
Date: Wed, 05 Sep 2018 18:21:07 -0500
Message-Id: <153618966719.28231.7120762050650762023@sif>
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
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2018-08-07 05:51:37)
> The guest-get-fsinfo command collects also information about PCI
> controller where the disk is attached. When this fails for some reasons
> it tries to return just the partial information. However in certain
> cases the pointer to the structure was not initialized and was set to
> NULL. This breaks the serializer and lead to crasehs of the guest agent.
> =

> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 36d76c22c0..995f62c2e4 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -642,15 +642,32 @@ static GuestDiskAddressList *build_guest_disk_info(=
char *guid, Error **errp)
>          g_debug("getting pci-controller info");
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
> +                slog("failed to get PCI controller info: %s",
> +                    error_get_pretty(local_err));

slog() is more for logging/auditing events that a guest administrator might
be interested in knowing about, like when qga is accessing files, freezing
filesystems, etc. General qga-side error reporting and debug logging should
go through the normal g_debug/g_warning/etc interfaces to be captured in
qga's log file.

We should also moved patch 1 after this so we don't expose a breakage
prior to the fix.

How often are you seeing failures with the pci info? And does the
information for the non-failures look valid to you? I tried to fix the
CONFIG_QGA_NTDDSCSI naming screw-up a while back and some values like
PCI func/bus/etc looked bogus, SPDRP_BUSNUMBER/SPDRP_ADDRESS/SPDRP_BUSNUMBER
didn't seem to be returning what the current code thinks they are. If that's
still the case it would be good to fix that before we final re-enable this
code.

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
>      }
> =

>      list =3D g_malloc0(sizeof(*list));
> -- =

> 2.18.0
>=20
