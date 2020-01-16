Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41232C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A29720748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0ZaxlpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A29720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is49f-0007yP-T1
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1is48D-0006VM-Js
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1is48A-0005Li-2f
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1is489-0005L3-Hx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579177208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxhUiDZZUaHXh0NjW2DYBeNSfQuvC0Z5AGDqz7TFIUw=;
 b=h0ZaxlpTb2LtmEAqrmIS50L4hPPi4m9YdFJu2WrlWoQMXeuZChW98/8vM5ekHR7LgJMLVw
 5iIfwfWio2AfwyhAtS7YKYvuhpi3xAjVYDBJ8QsdUDdOCwNHU8JjMOiZMZztnWs1Meuzv3
 TNzwai78HYLwG+983ApTVXUDUNzstKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-xZq4ahY-O1upgTp8yH8PJg-1; Thu, 16 Jan 2020 07:20:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4820B8017CC;
 Thu, 16 Jan 2020 12:20:04 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29198100E7E3;
 Thu, 16 Jan 2020 12:19:58 +0000 (UTC)
Date: Thu, 16 Jan 2020 12:19:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
Message-ID: <20200116121956.GC3108@work-vm>
References: <20191212163904.159893-85-dgilbert@redhat.com>
 <20200115112006.32659-1-misono.tomohiro@jp.fujitsu.com>
 <20200115165712.GE3811@work-vm>
 <OSBPR01MB4582846F726005E9405A84C2E5360@OSBPR01MB4582.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB4582846F726005E9405A84C2E5360@OSBPR01MB4582.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xZq4ahY-O1upgTp8yH8PJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* misono.tomohiro@fujitsu.com (misono.tomohiro@fujitsu.com) wrote:
> > * Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > > > From: Liu Bo <bo.liu@linux.alibaba.com>
> > > >
> > > > For fuse's queueinfo, both queueinfo array and queueinfos are
> > > > allocated in
> > > > fv_queue_set_started() but not cleaned up when the daemon process q=
uits.
> > > >
> > > > This fixes the leak in proper places.
> > > >
> > > > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > > > Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> > > > ---
> > > >  tools/virtiofsd/fuse_virtio.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/tools/virtiofsd/fuse_virtio.c
> > > > b/tools/virtiofsd/fuse_virtio.c index 7b22ae8d4f..a364f23d5d 100644
> > > > --- a/tools/virtiofsd/fuse_virtio.c
> > > > +++ b/tools/virtiofsd/fuse_virtio.c
> > > > @@ -671,6 +671,8 @@ static void fv_queue_set_started(VuDev *dev, in=
t qidx, bool started)
> > > >          }
> > > >          close(ourqi->kill_fd);
> > > >          ourqi->kick_fd =3D -1;
> > > > +        free(vud->qi[qidx]);
> > > > +        vud->qi[qidx] =3D NULL;
> > > >      }
> > > >  }
> > > >
> > > > @@ -878,6 +880,13 @@ int virtio_session_mount(struct fuse_session
> > > > *se)  void virtio_session_close(struct fuse_session *se)  {
> > > >      close(se->vu_socketfd);
> > >
> > > I beleve above close() should be removed as it is called 6 line below=
.
> >=20
> > You're right, I think that's my fault from when I merged this patch wit=
h 'Virtiofsd: fix segfault when quit before dev init'.
> >=20
> > Fixed.
>=20
> Given that:
>  Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Thank you!

Dave

> Thanks.
>=20
> > Thanks.
> >=20
> > Dave
> >=20
> > > > +
> > > > +    if (!se->virtio_dev) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    close(se->vu_socketfd);
> > > > +    free(se->virtio_dev->qi);
> > > >      free(se->virtio_dev);
> > > >      se->virtio_dev =3D NULL;
> > > >  }
> > > > --
> > > > 2.23.0
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


