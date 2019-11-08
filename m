Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936A7C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6135D2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQHaafWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6135D2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0ZJ-0005OT-Af
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Ye-0004tH-Bj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Yc-0004bb-Pk
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:27:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT0Yc-0004bM-Mh
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573205274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Op0JSEpoFVsy5CrFqhnRIG0u0fzbg7cEH2uNdU/Xnn8=;
 b=VQHaafWmrzddJ38OOn28p8D6ukfBLOREdfqquCgT2VzKMuS7HFGqFQM4hTu50c9YsgBsog
 MgUco4oUdpKcGQSHhqPLq5w3hUV2P2iMBpS33sommFK7ZtO95/qkkNWakSxCQBQvVlXXxr
 fsyB4V23qTb8yySHWaiMTqZz28ZPBjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-eVII036MMpahiO5Sb_k4Vg-1; Fri, 08 Nov 2019 04:27:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 812BB107ACC3;
 Fri,  8 Nov 2019 09:27:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACF7D19757;
 Fri,  8 Nov 2019 09:27:27 +0000 (UTC)
Message-ID: <ec9879d5319d169f410e8c68bf9a880c0bc6b572.camel@redhat.com>
Subject: Re: [PATCH v2 07/11] block: add x-blockdev-amend qmp command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 11:27:26 +0200
In-Reply-To: <931af700-bb9a-ae84-bd01-215560f66494@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-8-mlevitsk@redhat.com>
 <931af700-bb9a-ae84-bd01-215560f66494@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: eVII036MMpahiO5Sb_k4Vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-10-04 at 20:53 +0200, Max Reitz wrote:
> On 13.09.19 00:30, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/Makefile.objs       |   2 +-
> >  block/amend.c             | 116 ++++++++++++++++++++++++++++++++++++++
> >  include/block/block_int.h |  23 ++++++--
> >  qapi/block-core.json      |  26 +++++++++
> >  qapi/job.json             |   4 +-
> >  5 files changed, 163 insertions(+), 8 deletions(-)
> >  create mode 100644 block/amend.c
>=20
> I think I=E2=80=99d move this (and everything to belongs to it) to a diff=
erent
> series.
I already kind of do this, patches prior to this one fully implement
the existing amend code path, while this and patches after this
one implement the qmp x-blockdev-amend code path.

i don't mind sending this as two separate patch series, now that
first refactoring patch series is committed upsteam.


>=20
> > diff --git a/block/Makefile.objs b/block/Makefile.objs
> > index 35f3bca4d9..10d0308792 100644
> > --- a/block/Makefile.objs
> > +++ b/block/Makefile.objs
> > @@ -18,7 +18,7 @@ block-obj-y +=3D block-backend.o snapshot.o qapi.o
> >  block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
> >  block-obj-$(CONFIG_POSIX) +=3D file-posix.o
> >  block-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
> > -block-obj-y +=3D null.o mirror.o commit.o io.o create.o
> > +block-obj-y +=3D null.o mirror.o commit.o io.o create.o amend.o
> >  block-obj-y +=3D throttle-groups.o
> >  block-obj-$(CONFIG_LINUX) +=3D nvme.o
> > =20
> > diff --git a/block/amend.c b/block/amend.c
> > new file mode 100644
> > index 0000000000..9bd28e08e7
> > --- /dev/null
> > +++ b/block/amend.c
> > @@ -0,0 +1,116 @@
> > +/*
> > + * Block layer code related to image options amend
> > + *
> > + * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
> > + * Copyright (c) 2019 Maxim Levitsky <mlevitsk@redhat.com>
> > + *
> > + * Heavily based on create.c
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "block/block_int.h"
> > +#include "qemu/job.h"
> > +#include "qemu/main-loop.h"
> > +#include "qapi/qapi-commands-block-core.h"
> > +#include "qapi/qapi-visit-block-core.h"
> > +#include "qapi/clone-visitor.h"
> > +#include "qapi/error.h"
> > +
> > +typedef struct BlockdevAmendJob {
> > +    Job common;
> > +    BlockdevCreateOptions *opts;
> > +    BlockDriverState *bs;
> > +    bool force;
> > +} BlockdevAmendJob;
> > +
> > +static int coroutine_fn blockdev_amend_run(Job *job, Error **errp)
> > +{
> > +    BlockdevAmendJob *s =3D container_of(job, BlockdevAmendJob, common=
);
> > +    int ret;
> > +
> > +    job_progress_set_remaining(&s->common, 1);
> > +    ret =3D s->bs->drv->bdrv_co_amend(s->bs, s->opts, s->force, errp);
> > +    job_progress_update(&s->common, 1);
>=20
> It would be nice if the amend job could make use of the progress
> reporting that we have in place for amend.

I also thought about it, but is it worth it?

I looked through the status reporting of the qcow2 amend
code (which doesn't really allowed to be run through
qmp blockdev-amend, due to complexity of changing=20
the qcow2 format on the fly).



>=20
> > +
> > +    qapi_free_BlockdevCreateOptions(s->opts);
> > +
> > +    return ret;
> > +}
> > +
> > +static const JobDriver blockdev_amend_job_driver =3D {
> > +    .instance_size =3D sizeof(BlockdevAmendJob),
> > +    .job_type      =3D JOB_TYPE_AMEND,
> > +    .run           =3D blockdev_amend_run,
> > +};
> > +
> > +void qmp_x_blockdev_amend(const char *job_id,
> > +                        const char *node_name,
> > +                        BlockdevCreateOptions *options,
> > +                        bool has_force,
> > +                        bool force,
> > +                        Error **errp)
> > +{
> > +    BlockdevAmendJob *s;
> > +    const char *fmt =3D BlockdevDriver_str(options->driver);
> > +    BlockDriver *drv =3D bdrv_find_format(fmt);
> > +    BlockDriverState *bs =3D bdrv_find_node(node_name);
> > +
> > +    /*
> > +     * If the driver is in the schema, we know that it exists. But it =
may not
> > +     * be whitelisted.
> > +     */
> > +    assert(drv);
> > +    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
> > +        error_setg(errp, "Driver is not whitelisted");
> > +        return;
> > +    }
> > +
> > +    if (bs->drv !=3D drv) {
> > +        error_setg(errp,
> > +                   "x-blockdev-amend doesn't support changing the bloc=
k driver");
> > +        return;
> > +
> > +    }
> > +
> > +    /* Error out if the driver doesn't support .bdrv_co_amend */
> > +    if (!drv->bdrv_co_amend) {
> > +        error_setg(errp, "Driver does not support x-blockdev-amend");
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Create the block job
> > +     * TODO Running in the main context. Block drivers need to error o=
ut or add
> > +     * locking when they use a BDS in a different AioContext.
>=20
> Why shouldn=E2=80=99t the job just run in the node=E2=80=99s context?

This is shameless copy&pasta from the blockdev-create code
(which I did note in the copyright of the file)


Best regards,
=09Maxim Levitsky

>=20
> Max
>=20



