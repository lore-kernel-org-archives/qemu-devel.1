Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FD3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21AB218AE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFKc/yY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21AB218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMs1p-0008PX-S4
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMs0q-0007VV-Nc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMs0p-00040a-F8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:07:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMs0p-000406-Aw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571742458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYsIYejLBmq20xs8yX4+wh5VMq1C6VL0Rq641kjG718=;
 b=ZFKc/yY3ja/f8BjEujXynHpgo8RdEtb2YRnKK48Qm/6VgjvKLkEP1FICu5WNgQchlrLdZH
 MkW+QQSA2q9s/A6Pvt0FVBnqkAzR7VNPsge3cYrQsEGi4Ahzwhw3asSIEnWkxsPBNjOuff
 yUgyReBQAjdZ/zMlBB6G7Ueb2fKZmd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-SNZogyQgPQav9JOBdJQXEA-1; Tue, 22 Oct 2019 07:07:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB5DF107AD31;
 Tue, 22 Oct 2019 11:07:35 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 477D45D6A5;
 Tue, 22 Oct 2019 11:07:28 +0000 (UTC)
Date: Tue, 22 Oct 2019 12:07:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 17/30] virtiofsd: Add main virtio loop
Message-ID: <20191022110725.GF2815@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191021105832.36574-18-dgilbert@redhat.com>
 <CAJ+F1CKmujLfL=n-UPLeps7BcQ=WcibHzsCWt+Pff3zLbSwvYA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKmujLfL=n-UPLeps7BcQ=WcibHzsCWt+Pff3zLbSwvYA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SNZogyQgPQav9JOBdJQXEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 piaojun@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> On Mon, Oct 21, 2019 at 1:26 PM Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Processes incoming requests on the vhost-user fd.
>=20
> Is there a reason to avoid using glib & its main loop?

Not particularly;  would it actually work out any easier?
Is there an easy way to get the glib loop to check something like
the fuse_session_exited at each iteration.

I probably didn't originally because I wasn't sure if this code
was going back into libfuse or staying here; and libfuse doesn't
use glib.

Dave

> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/virtiofsd/fuse_virtio.c | 42 ++++++++++++++++++++++++++++++---
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_v=
irtio.c
> > index 22f71d260f..9c58f11634 100644
> > --- a/contrib/virtiofsd/fuse_virtio.c
> > +++ b/contrib/virtiofsd/fuse_virtio.c
> > @@ -11,12 +11,14 @@
> >   * See the file COPYING.LIB
> >   */
> >
> > +#include "fuse_virtio.h"
> >  #include "fuse_i.h"
> >  #include "fuse_kernel.h"
> >  #include "fuse_misc.h"
> >  #include "fuse_opt.h"
> > -#include "fuse_virtio.h"
> >
> > +#include <assert.h>
> > +#include <errno.h>
> >  #include <stdint.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > @@ -80,15 +82,49 @@ static const VuDevIface fv_iface =3D {
> >      .queue_is_processed_in_order =3D fv_queue_order,
> >  };
> >
> > +/*
> > + * Main loop; this mostly deals with events on the vhost-user
> > + * socket itself, and not actual fuse data.
> > + */
> >  int virtio_loop(struct fuse_session *se)
> >  {
> >      fuse_log(FUSE_LOG_INFO, "%s: Entry\n", __func__);
> >
> > -    while (1) {
> > -        /* TODO: Add stuffing */
> > +    while (!fuse_session_exited(se)) {
> > +        struct pollfd pf[1];
> > +        pf[0].fd =3D se->vu_socketfd;
> > +        pf[0].events =3D POLLIN;
> > +        pf[0].revents =3D 0;
> > +
> > +        fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for VU event\n", __func_=
_);
> > +        int poll_res =3D ppoll(pf, 1, NULL, NULL);
> > +
> > +        if (poll_res =3D=3D -1) {
> > +            if (errno =3D=3D EINTR) {
> > +                fuse_log(FUSE_LOG_INFO, "%s: ppoll interrupted, going =
around\n",
> > +                         __func__);
> > +                continue;
> > +            }
> > +            fuse_log(FUSE_LOG_ERR, "virtio_loop ppoll: %m\n");
> > +            break;
> > +        }
> > +        assert(poll_res =3D=3D 1);
> > +        if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> > +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x\n",=
 __func__,
> > +                     pf[0].revents);
> > +            break;
> > +        }
> > +        assert(pf[0].revents & POLLIN);
> > +        fuse_log(FUSE_LOG_DEBUG, "%s: Got VU event\n", __func__);
> > +        if (!vu_dispatch(&se->virtio_dev->dev)) {
> > +            fuse_log(FUSE_LOG_ERR, "%s: vu_dispatch failed\n", __func_=
_);
> > +            break;
> > +        }
> >      }
> >
> >      fuse_log(FUSE_LOG_INFO, "%s: Exit\n", __func__);
> > +
> > +    return 0;
> >  }
> >
> >  int virtio_session_mount(struct fuse_session *se)
> > --
> > 2.23.0
> >
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


