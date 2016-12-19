Received: from eggs.gnu.org ([2001:4830:134:3::10]:57644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cJ71g-0007rW-8i
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 18:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cJ71b-0006Ti-Bh
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 18:07:24 -0500
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481762701-4587-21-git-send-email-mdroth@linux.vnet.ibm.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1155cdbb-6699-7c4e-c8af-fca97a907bf1@redhat.com>
Date: Mon, 19 Dec 2016 18:07:17 -0500
MIME-Version: 1.0
In-Reply-To: <1481762701-4587-21-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 20/67] ahci: clear aiocb in ncq_cb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeff Cody <jcody@redhat.com>

Hi, some more considerations:


e7bd708ec85e40fd51569bb90c52d6613ffd8f45
atapi: classify read_cd as conditionally returning data

This fixes problems with certain operating systems being unable to read
from the CDROM.


99868af3d0a75cf6a515a9aa81bf0d7bcb39eadb
dma-helpers: explicitly pass alignment into DMA helpers

I believe this does fix MACIO for some platforms, but I'm not sure how
annoying it would be to backport due to the DMA alignment changes. Low
priority.


c47ee043dc2cc85da710e87524144a720598c096
block-backend: Always notify on blk_eject

This fixes a legitimate bug in some versions of libvirt.


ca44141d5fb801dd5903102acefd0f2d8e8bb6a1
ide: Fix memory leak in ide_register_restart_cb()

Not important, but not risky or hard to backport either. Skippable.


9da82227caa74fb6fbea224dad91fe5b7cc115a5
ide: fix DMA register transitions

This is only theoretical. Safely skipped.


e305a16510afa74eec20390479e349402e55ef4c portio: keep references on porti=
o

Doesn't look important as it doesn't actually FIX a leak.


There were some fixes for Transactional Block Jobs as well in the 2.8
window, but as we still haven't quite finished nailing down incremental
backups, it may not be too important to backport to 2.7 -- I don't think
anyone is using this yet.

The series in question is:
https://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg01392.html

On 12/14/2016 07:44 PM, Michael Roth wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> Similar to existing fixes for IDE (87ac25fd) and ATAPI (7f951b2d), the
> AIOCB must be cleared in the callback. Otherwise, we may accidentally
> try to reset a dangling pointer in bdrv_aio_cancel() from a port reset.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 1474575040-32079-2-git-send-email-jsnow@redhat.com
> Signed-off-by: John Snow <jsnow@redhat.com>
> (cherry picked from commit df403bc58859c893ebd0accda07678e84d15dc5d)
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/ide/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index f3438ad..63ead21 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -948,6 +948,7 @@ static void ncq_cb(void *opaque, int ret)
>      NCQTransferState *ncq_tfs =3D (NCQTransferState *)opaque;
>      IDEState *ide_state =3D &ncq_tfs->drive->port.ifs[0];
> =20
> +    ncq_tfs->aiocb =3D NULL;
>      if (ret =3D=3D -ECANCELED) {
>          return;
>      }
>=20

--=20
=97js
