Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D071C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CD820674
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrZpL/6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CD820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUx7-0003Ay-M3
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itUhX-00067y-TY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itUhT-0002x8-Qf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:54:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itUhT-0002v0-MK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579517668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaGoOo0m/FslmdmY168PM6k7mbCIuXVq3zfdRR9RvUs=;
 b=DrZpL/6HuDzp4CoD9eszJr64TOK+fc8zr5waaXO+d14XmutTFamhJMBOEpYXRuuo3LRPbT
 XlxOFHIyjjgyLUB+VNs4WB6bNzzLiRURKU9nz5SCZ1XiMaaZDLBvLz/Dslf305X2ZxuUyR
 45jINQvD834qIgJDsTt3/U2pHfYCsMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-tlbntA6aOAWujuyJqYwy9g-1; Mon, 20 Jan 2020 05:54:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA5F610054E3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:54:24 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E093260BF7;
 Mon, 20 Jan 2020 10:54:16 +0000 (UTC)
Date: Mon, 20 Jan 2020 10:54:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
Message-ID: <20200120105413.GH2827@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-85-dgilbert@redhat.com>
 <874kwq8lyy.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <874kwq8lyy.fsf@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tlbntA6aOAWujuyJqYwy9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Sergio Lopez (slp@redhat.com) wrote:
>=20
> Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:
>=20
> > From: Liu Bo <bo.liu@linux.alibaba.com>
> >
> > For fuse's queueinfo, both queueinfo array and queueinfos are allocated=
 in
> > fv_queue_set_started() but not cleaned up when the daemon process quits=
.
> >
> > This fixes the leak in proper places.
> >
> > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> > ---
> >  tools/virtiofsd/fuse_virtio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virti=
o.c
> > index 7b22ae8d4f..a364f23d5d 100644
> > --- a/tools/virtiofsd/fuse_virtio.c
> > +++ b/tools/virtiofsd/fuse_virtio.c
> > @@ -671,6 +671,8 @@ static void fv_queue_set_started(VuDev *dev, int qi=
dx, bool started)
> >          }
> >          close(ourqi->kill_fd);
> >          ourqi->kick_fd =3D -1;
> > +        free(vud->qi[qidx]);
> > +        vud->qi[qidx] =3D NULL;
> >      }
> >  }
> > =20
> > @@ -878,6 +880,13 @@ int virtio_session_mount(struct fuse_session *se)
> >  void virtio_session_close(struct fuse_session *se)
> >  {
> >      close(se->vu_socketfd);
> > +
> > +    if (!se->virtio_dev) {
> > +        return;
> > +    }
> > +
> > +    close(se->vu_socketfd);
> > +    free(se->virtio_dev->qi);
> >      free(se->virtio_dev);
> >      se->virtio_dev =3D NULL;
> >  }
>=20
> There's a duplicated "close(se->vu_socketfd);" statement here.

Yep, already spotted/fixed:
  https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg02901.html

Dave

> Sergio.


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


