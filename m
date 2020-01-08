Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DCAC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B81206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTnIw7o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B81206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAvj-0008Lh-Gu
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipAe2-0007U1-MU
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipAe0-0000r2-Qp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:41:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipAe0-0000py-Df
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578487263;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drb6UlehP5y1rExTaDfbtm98JP6wewZBv78zWf913qU=;
 b=QTnIw7o+yBPviNsgBFwSWa5ovj1URD/ZffYJwPVpmSadxq0zSlXtE0y34OsltrnFc3PyFg
 B/oG8yo5tgcnaGMMRGB0iEZCynA7dz7f5qbF1M5ayFSdCHcTA/79sLCJc/pkuchaS5qjC0
 ZSSLA+A3FkigXCbGzwNfD6yZo38fN6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-aggE3JvuNWKvwQj-d5UKcQ-1; Wed, 08 Jan 2020 07:41:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC1E3107ACC7
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 12:40:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2FB860BE2;
 Wed,  8 Jan 2020 12:40:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/4] qemu-file: Don't do IO after shutdown
In-Reply-To: <20200108094944.GA3184@work-vm> (David Alan Gilbert's message of
 "Wed, 8 Jan 2020 09:49:44 +0000")
References: <20191218050439.5989-1-quintela@redhat.com>
 <20191218050439.5989-2-quintela@redhat.com>
 <20191218122702.GF3707@work-vm> <20200108094944.GA3184@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 08 Jan 2020 13:40:55 +0100
Message-ID: <87d0bui0iw.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: aggE3JvuNWKvwQj-d5UKcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> * Juan Quintela (quintela@redhat.com) wrote:
>> > Be sure that we are not doing neither read/write after shutdown of the
>> > QEMUFile.
>> >=20
>> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>> > ---
>> >  migration/qemu-file.c | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >=20
>> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> > index 26fb25ddc1..1e5543a279 100644
>> > --- a/migration/qemu-file.c
>> > +++ b/migration/qemu-file.c
>> > @@ -53,6 +53,8 @@ struct QEMUFile {
>> > =20
>> >      int last_error;
>> >      Error *last_error_obj;
>> > +    /* has the file has been shutdown */
>> > +    bool shutdown;
>> >  };
>> > =20
>> >  /*
>> > @@ -61,6 +63,7 @@ struct QEMUFile {
>> >   */
>> >  int qemu_file_shutdown(QEMUFile *f)
>> >  {
>> > +    f->shutdown =3D true;
>> >      if (!f->ops->shut_down) {
>> >          return -ENOSYS;
>> >      }
>> > @@ -214,6 +217,9 @@ void qemu_fflush(QEMUFile *f)
>> >          return;
>> >      }
>> > =20
>> > +    if (f->shutdown) {
>> > +        return;
>> > +    }
>>=20
>> OK, I did wonder if you need to free the iovec.
>>=20
>> >      if (f->iovcnt > 0) {
>> >          expect =3D iov_size(f->iov, f->iovcnt);
>> >          ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f=
->pos,
>> > @@ -328,6 +334,10 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
>> >      f->buf_index =3D 0;
>> >      f->buf_size =3D pending;
>> > =20
>> > +    if (f->shutdown) {
>> > +        return 0;
>> > +    }
>>=20
>> I also wondered if perhaps an error would be reasonable here; but I'm
>> not sure what a read(2) does after a shutdown(2).
>>=20
>> Still,
>>=20
>>=20
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Actually, it turns out this breaks an assumption - 'shutdown' must cause
> reads/writes/etc to fail and for the qemu_file to go into error state.
> There's a few places we loop doing IO until we either change migration
> state or the file goes into error.
>
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 1e5543a279..bbb2b63927 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -63,11 +63,18 @@ struct QEMUFile {
>   */
>  int qemu_file_shutdown(QEMUFile *f)
>  {
> +    int ret;
> +
>      f->shutdown =3D true;
>      if (!f->ops->shut_down) {
>          return -ENOSYS;
>      }
> -    return f->ops->shut_down(f->opaque, true, true, NULL);
> +    ret =3D f->ops->shut_down(f->opaque, true, true, NULL);
> +
> +    if (!f->last_error) {
> +        qemu_file_set_error(f, -EIO);
> +    }
> +    return ret;
>  }
> =20
>  /*
>
>
> seems to fix it for me.

will gve it a try later.

Thanks.


