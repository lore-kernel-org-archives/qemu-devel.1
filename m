Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B7AC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A39206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3h31d07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A39206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7z5-0005GX-GU
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ip7yN-0004ju-1O
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ip7yL-00009S-SP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:49:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ip7yL-00008g-OF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578476993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZZqHyGVXERU8+XlJN0gCgc+GIB1y7en5mXNC1Z9+9I=;
 b=a3h31d07GjmTLpk+csLsaj478LJvBXem/iNBTHCkK/dTyg5Mf9YLVTOXNuoODmvXgSCk2F
 XoKhC56OyJdgGgZ6CBahHHnyvzcp2PrQCLZgJuDGXNy5cAh5bIBzHCC5ZXYdnsCa9db8qD
 i3QKNu3tLoMfbaCC+ur6X/xbOCLb1ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-_pSL_fgKMFOIR3BQj-ipUw-1; Wed, 08 Jan 2020 04:49:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE7A318A079F
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 09:49:47 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89C6B5F700;
 Wed,  8 Jan 2020 09:49:46 +0000 (UTC)
Date: Wed, 8 Jan 2020 09:49:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 1/4] qemu-file: Don't do IO after shutdown
Message-ID: <20200108094944.GA3184@work-vm>
References: <20191218050439.5989-1-quintela@redhat.com>
 <20191218050439.5989-2-quintela@redhat.com>
 <20191218122702.GF3707@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191218122702.GF3707@work-vm>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _pSL_fgKMFOIR3BQj-ipUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > Be sure that we are not doing neither read/write after shutdown of the
> > QEMUFile.
> >=20
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/qemu-file.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index 26fb25ddc1..1e5543a279 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -53,6 +53,8 @@ struct QEMUFile {
> > =20
> >      int last_error;
> >      Error *last_error_obj;
> > +    /* has the file has been shutdown */
> > +    bool shutdown;
> >  };
> > =20
> >  /*
> > @@ -61,6 +63,7 @@ struct QEMUFile {
> >   */
> >  int qemu_file_shutdown(QEMUFile *f)
> >  {
> > +    f->shutdown =3D true;
> >      if (!f->ops->shut_down) {
> >          return -ENOSYS;
> >      }
> > @@ -214,6 +217,9 @@ void qemu_fflush(QEMUFile *f)
> >          return;
> >      }
> > =20
> > +    if (f->shutdown) {
> > +        return;
> > +    }
>=20
> OK, I did wonder if you need to free the iovec.
>=20
> >      if (f->iovcnt > 0) {
> >          expect =3D iov_size(f->iov, f->iovcnt);
> >          ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f-=
>pos,
> > @@ -328,6 +334,10 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
> >      f->buf_index =3D 0;
> >      f->buf_size =3D pending;
> > =20
> > +    if (f->shutdown) {
> > +        return 0;
> > +    }
>=20
> I also wondered if perhaps an error would be reasonable here; but I'm
> not sure what a read(2) does after a shutdown(2).
>=20
> Still,
>=20
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Actually, it turns out this breaks an assumption - 'shutdown' must cause
reads/writes/etc to fail and for the qemu_file to go into error state.
There's a few places we loop doing IO until we either change migration
state or the file goes into error.


diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 1e5543a279..bbb2b63927 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -63,11 +63,18 @@ struct QEMUFile {
  */
 int qemu_file_shutdown(QEMUFile *f)
 {
+    int ret;
+
     f->shutdown =3D true;
     if (!f->ops->shut_down) {
         return -ENOSYS;
     }
-    return f->ops->shut_down(f->opaque, true, true, NULL);
+    ret =3D f->ops->shut_down(f->opaque, true, true, NULL);
+
+    if (!f->last_error) {
+        qemu_file_set_error(f, -EIO);
+    }
+    return ret;
 }
=20
 /*


seems to fix it for me.

Dave

> >      len =3D f->ops->get_buffer(f->opaque, f->buf + pending, f->pos,
> >                               IO_BUF_SIZE - pending, &local_error);
> >      if (len > 0) {
> > @@ -642,6 +652,9 @@ int64_t qemu_ftell(QEMUFile *f)
> > =20
> >  int qemu_file_rate_limit(QEMUFile *f)
> >  {
> > +    if (f->shutdown) {
> > +        return 1;
> > +    }
> >      if (qemu_file_get_error(f)) {
> >          return 1;
> >      }
> > --=20
> > 2.23.0
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


