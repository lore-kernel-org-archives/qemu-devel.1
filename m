Received: from eggs.gnu.org ([2001:4830:134:3::10]:56666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cJkCe-0002ZG-21
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cJkCb-00041u-0H
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:57:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cJkCa-00040o-Nl
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:57:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBLGsBMX080886
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 11:57:15 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27fwdk91p3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 11:57:15 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 21 Dec 2016 11:57:12 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1155cdbb-6699-7c4e-c8af-fca97a907bf1@redhat.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481762701-4587-21-git-send-email-mdroth@linux.vnet.ibm.com>
	<1155cdbb-6699-7c4e-c8af-fca97a907bf1@redhat.com>
Date: Wed, 21 Dec 2016 10:56:57 -0600
Message-Id: <20161221165657.8280.37657@loki>
Subject: Re: [Qemu-devel] [PATCH 20/67] ahci: clear aiocb in ncq_cb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeff Cody <jcody@redhat.com>

Quoting John Snow (2016-12-19 17:07:17)
> Hi, some more considerations:
> =

> =

> e7bd708ec85e40fd51569bb90c52d6613ffd8f45
> atapi: classify read_cd as conditionally returning data
> =

> This fixes problems with certain operating systems being unable to read
> from the CDROM.

applied.

> =

> =

> 99868af3d0a75cf6a515a9aa81bf0d7bcb39eadb
> dma-helpers: explicitly pass alignment into DMA helpers
> =

> I believe this does fix MACIO for some platforms, but I'm not sure how
> annoying it would be to backport due to the DMA alignment changes. Low
> priority.

Seems to apply cleanly, but change seems mechanical. I assume the macio fix
comes from the follow-up be1e343995ef81fc05d9a4e1ec263ca171d842e7.

both applied.

> =

> =

> c47ee043dc2cc85da710e87524144a720598c096
> block-backend: Always notify on blk_eject
> =

> This fixes a legitimate bug in some versions of libvirt.

applied, but modified to avoid the need for 2d76e724 since that
requires qapi api changes.

> =

> =

> ca44141d5fb801dd5903102acefd0f2d8e8bb6a1
> ide: Fix memory leak in ide_register_restart_cb()
> =

> Not important, but not risky or hard to backport either. Skippable.

applied.

> =

> =

> 9da82227caa74fb6fbea224dad91fe5b7cc115a5
> ide: fix DMA register transitions
> =

> This is only theoretical. Safely skipped.

Slight chance some OSs might not deal with this as expected so I'd opt
to leave it out if there haven't been any observed bugs around it.

> =

> =

> e305a16510afa74eec20390479e349402e55ef4c portio: keep references on portio
> =

> Doesn't look important as it doesn't actually FIX a leak.

Agreed, but went ahead and pulled it in since it's a context dependency for
ca44141.

> =

> =

> There were some fixes for Transactional Block Jobs as well in the 2.8
> window, but as we still haven't quite finished nailing down incremental
> backups, it may not be too important to backport to 2.7 -- I don't think
> anyone is using this yet.
> =

> The series in question is:
> https://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg01392.html

There are some interdependencies between this and bae8196+ that I don't
trust myself to properly untangle. And backporting bae8196 seems risky.
I think I'd need a direct backport for 2.7, but at this point there's not
really any time left for all that so I'll opt to leave these out for
2.7.1.

Thanks for all the suggestions.

> =

> On 12/14/2016 07:44 PM, Michael Roth wrote:
> > From: John Snow <jsnow@redhat.com>
> > =

> > Similar to existing fixes for IDE (87ac25fd) and ATAPI (7f951b2d), the
> > AIOCB must be cleared in the callback. Otherwise, we may accidentally
> > try to reset a dangling pointer in bdrv_aio_cancel() from a port reset.
> > =

> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-id: 1474575040-32079-2-git-send-email-jsnow@redhat.com
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > (cherry picked from commit df403bc58859c893ebd0accda07678e84d15dc5d)
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  hw/ide/ahci.c | 1 +
> >  1 file changed, 1 insertion(+)
> > =

> > diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> > index f3438ad..63ead21 100644
> > --- a/hw/ide/ahci.c
> > +++ b/hw/ide/ahci.c
> > @@ -948,6 +948,7 @@ static void ncq_cb(void *opaque, int ret)
> >      NCQTransferState *ncq_tfs =3D (NCQTransferState *)opaque;
> >      IDEState *ide_state =3D &ncq_tfs->drive->port.ifs[0];
> >  =

> > +    ncq_tfs->aiocb =3D NULL;
> >      if (ret =3D=3D -ECANCELED) {
> >          return;
> >      }
> > =

> =

> -- =

> =E2=80=94js
>=20
