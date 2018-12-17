Received: from eggs.gnu.org ([2001:4830:134:3::10]:44980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYsLh-0008IP-Gd
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:50:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYsLe-00081Q-8V
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:50:17 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 17 Dec 2018 12:50:11 +0000
Message-ID: <a3de4105b65041e188fae80a3dfad688@AMSPEX02CL02.citrite.net>
References: <1545046848-14891-1-git-send-email-paul.durrant@citrix.com>
	<1545046848-14891-10-git-send-email-paul.durrant@citrix.com>
	<20181217122820.GA5866@perard.uk.xensource.com>
In-Reply-To: <20181217122820.GA5866@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v5 09/18] xen: remove
 unnecessary code from dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 17 December 2018 12:28
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Stefano
> Stabellini <sstabellini@kernel.org>; Stefan Hajnoczi
> <stefanha@redhat.com>; Max Reitz <mreitz@redhat.com>
> Subject: Re: [Xen-devel] [PATCH v5 09/18] xen: remove unnecessary code
> from dataplane/xen-block.c
>=20
> On Mon, Dec 17, 2018 at 11:40:39AM +0000, Paul Durrant wrote:
> > Not all of the code duplicated from xen_disk.c is required as the basis
> for
> > the new dataplane implementation so this patch removes extraneous code,
> > along with the legacy #includes and calls to the legacy xen_pv_printf()
> > function. Error messages are changed to be reported using
> error_report().
> >
> > NOTE: The code is still not yet built. Further transformations will be
> >       required to make it correctly interface to the new
> XenBus/XenDevice
> >       framework. They will be delivered in a subsequent patch.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Acked-by: Anthony Perard <anthony.perard@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Max Reitz <mreitz@redhat.com>
> >
> > v2:
> >  - Leave existing boilerplate alone, other than removing the now-
> incorrect
> >    description
> > ---
> >  hw/block/dataplane/xen-block.c | 409 ++-------------------------------=
-
> -------
> >  1 file changed, 16 insertions(+), 393 deletions(-)
> >
> > diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-
> block.c
> > index 9fae505..98f987d 100644
> > --- a/hw/block/dataplane/xen-block.c
> > +++ b/hw/block/dataplane/xen-block.c
> > @@ -1,6 +1,4 @@
> >  /*
> > - *  xen paravirt block device backend
> > - *
> >   *  (c) Gerd Hoffmann <kraxel@redhat.com>
> >   *
> >   *  This program is free software; you can redistribute it and/or
> modify
> > @@ -19,26 +17,12 @@
> >   *  GNU GPL, version 2 or (at your option) any later version.
> >   */
> >
> > -#include "qemu/osdep.h"
> > -#include "qemu/units.h"
> > -#include <sys/ioctl.h>
> > -#include <sys/uio.h>
> > -
> > -#include "hw/hw.h"
> > -#include "hw/xen/xen_backend.h"
> > -#include "xen_blkif.h"
> > -#include "sysemu/blockdev.h"
> > -#include "sysemu/iothread.h"
> > -#include "sysemu/block-backend.h"
> > -#include "qapi/error.h"
> > -#include "qapi/qmp/qdict.h"
> > -#include "qapi/qmp/qstring.h"
> > -#include "trace.h"
> > -
> > -/* ------------------------------------------------------------- */
> > -
> > -#define BLOCK_SIZE  512
> > -#define IOCB_COUNT  (BLKIF_MAX_SEGMENTS_PER_REQUEST + 2)
> > +/*
> > + * Copyright (c) 2018  Citrix Systems Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
>=20
> This patch obviously comes from v3 of the patch series. v4 was fine.
> Please check comments on v1 v2 and v3.

Damn it. Somehow my local 'qom29' repo had diverged from xenbits. I'll repl=
ace that patch from there.

  Paul

>=20
> Thanks,
>=20
> --
> Anthony PERARD
