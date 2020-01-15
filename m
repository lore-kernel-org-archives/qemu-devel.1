Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F4C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104D8214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSZQOEV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104D8214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlzf-00045Z-VZ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irlyx-0003SI-AO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irlyt-0006ME-Pd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:57:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irlyt-0006Ll-Lr
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579107443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVyrhZHrO0agem35WKPk/RKUr6mtWsacJTzia33sD6I=;
 b=FSZQOEV5SPResxPIXERlk6/vMS1+8UODmF9Way7X3TmW8jR0B0yeBZtqDFcuNpqqFnUtmn
 yr0DPgjkEY7IjmXlouXgtAefiaBypRjvrvWq7J+4gmmxL5/ZNopS+ObUqVc9Oz3LZbUtDd
 FgE1+qI4NDw0OiGwSoD/WFYJCG0hC5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-39Fm00QKMvSnhHFNt-eUvw-1; Wed, 15 Jan 2020 11:57:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892371922968;
 Wed, 15 Jan 2020 16:57:18 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C24A10841AC;
 Wed, 15 Jan 2020 16:57:15 +0000 (UTC)
Date: Wed, 15 Jan 2020 16:57:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
Message-ID: <20200115165712.GE3811@work-vm>
References: <20191212163904.159893-85-dgilbert@redhat.com>
 <20200115112006.32659-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200115112006.32659-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 39Fm00QKMvSnhHFNt-eUvw-1
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

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: Liu Bo <bo.liu@linux.alibaba.com>
> >=20
> > For fuse's queueinfo, both queueinfo array and queueinfos are allocated=
 in
> > fv_queue_set_started() but not cleaned up when the daemon process quits=
.
> >=20
> > This fixes the leak in proper places.
> >=20
> > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> > ---
> >  tools/virtiofsd/fuse_virtio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
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
>=20
> I beleve above close() should be removed as it is called 6 line below.

You're right, I think that's my fault from when I merged this patch
with 'Virtiofsd: fix segfault when quit before dev init'.

Fixed.
Thanks.

Dave

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
> > --=20
> > 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


