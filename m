Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8256B2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afZADn0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8256B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMr1M-0006aw-Cx
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMqzB-0004iZ-Dd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMqzA-0000In-4E
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:01:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMqz9-0000IJ-T7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vkmro+l3+G+1mWsXlcDgUxYskuq0EJbbcrOVWe9fqCo=;
 b=afZADn0XFbZhnmqPOBQ1xXDig4XuwdeK1PKBIpIF+DLN56hH+kXfGQtFVkC8BrcZGrqhmp
 pmaXbhMMbT4RPtehxWuBpTDNP7pKkaMoCcn42S2RIvzmh9/cUgxbiVXkiiQvMunkY5hll+
 gB0QoE7BOERr7v8q/Dxu/rokO+xCUFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-TnAh9E7bNxW28sOC9bpa1g-1; Tue, 22 Oct 2019 06:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF1AE107AD31;
 Tue, 22 Oct 2019 10:01:46 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D746B5D6A5;
 Tue, 22 Oct 2019 10:01:39 +0000 (UTC)
Date: Tue, 22 Oct 2019 11:01:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 11/30] virtiofsd: fuse: Make iov_length usable outside
 fuse_lowlevel.c
Message-ID: <20191022100137.GC2815@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191021105832.36574-12-dgilbert@redhat.com>
 <CAJ+F1CKqbj-FgfyFTwDwwQgrE-D-UJJd4wHT2KjZ1HmrqHbNRw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKqbj-FgfyFTwDwwQgrE-D-UJJd4wHT2KjZ1HmrqHbNRw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: TnAh9E7bNxW28sOC9bpa1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> Hi
>=20
> On Mon, Oct 21, 2019 at 1:24 PM Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Similar function already exists in util/iov.c, iov_size()
>=20
> Perhaps you could link with util/iov.o and others to avoid code duplicati=
on.

Done.
(It's a shame there's no iov_* functions in glib; every project
reinvents iov_ functions).

Dave

>=20
> > ---
> >  contrib/virtiofsd/fuse_lowlevel.c | 2 +-
> >  contrib/virtiofsd/fuse_lowlevel.h | 9 +++++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse=
_lowlevel.c
> > index 5ea113ab49..ff68ec0c9d 100644
> > --- a/contrib/virtiofsd/fuse_lowlevel.c
> > +++ b/contrib/virtiofsd/fuse_lowlevel.c
> > @@ -74,7 +74,7 @@ static void convert_attr(const struct fuse_setattr_in=
 *attr, struct stat *stbuf)
> >         ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
> >  }
> >
> > -static size_t iov_length(const struct iovec *iov, size_t count)
> > +size_t iov_length(const struct iovec *iov, size_t count)
> >  {
> >         size_t seg;
> >         size_t ret =3D 0;
> > diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse=
_lowlevel.h
> > index 018e7c0be0..84379a4761 100644
> > --- a/contrib/virtiofsd/fuse_lowlevel.h
> > +++ b/contrib/virtiofsd/fuse_lowlevel.h
> > @@ -2000,6 +2000,15 @@ void fuse_session_process_buf(struct fuse_sessio=
n *se,
> >   */
> >  int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf =
*buf);
> >
> > +/**
> > + * General utility to get the length of an iov, not Fuse specific
> > + *
> > + * @param iov The iovec to get the length of
> > + * @param count Number of entries in the iovec
> > + * @return the total length of iov in bytes
> > + */
> > +size_t iov_length(const struct iovec *iov, size_t count);
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
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


