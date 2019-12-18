Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836AEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA312176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS+dhSb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA312176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53995 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ2R-0000Zv-TL
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ihYQ5-0005z7-Rq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ihYQ2-0005MU-Ay
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:27:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30575
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ihYQ1-0005Gi-PG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576672028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eY6sTNMi4ypiygjdxSG6FWqJfzN//VgRFgNTClFRDpM=;
 b=NS+dhSb7Swb4JfpBxWTRzfqc5lxcMC2t5wbrm6VZOdoZe4HzYTnSHtD/es5NKmmnzbME5x
 HdVTYQTENF2PVNcKykFeNfSk3GeOl/SL681M6MLbVOUEUMuFVI79Gl1WPz269r8Wx1wm8d
 IGPt2dzQYwpUzW1ringxfy/w+CqvcYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-YCmp4DdzPHC8HHD5xiF7kA-1; Wed, 18 Dec 2019 07:27:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B195E8D5730
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 12:27:05 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 861365C1B0;
 Wed, 18 Dec 2019 12:27:04 +0000 (UTC)
Date: Wed, 18 Dec 2019 12:27:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 1/4] qemu-file: Don't do IO after shutdown
Message-ID: <20191218122702.GF3707@work-vm>
References: <20191218050439.5989-1-quintela@redhat.com>
 <20191218050439.5989-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218050439.5989-2-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YCmp4DdzPHC8HHD5xiF7kA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

* Juan Quintela (quintela@redhat.com) wrote:
> Be sure that we are not doing neither read/write after shutdown of the
> QEMUFile.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 26fb25ddc1..1e5543a279 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -53,6 +53,8 @@ struct QEMUFile {
> =20
>      int last_error;
>      Error *last_error_obj;
> +    /* has the file has been shutdown */
> +    bool shutdown;
>  };
> =20
>  /*
> @@ -61,6 +63,7 @@ struct QEMUFile {
>   */
>  int qemu_file_shutdown(QEMUFile *f)
>  {
> +    f->shutdown =3D true;
>      if (!f->ops->shut_down) {
>          return -ENOSYS;
>      }
> @@ -214,6 +217,9 @@ void qemu_fflush(QEMUFile *f)
>          return;
>      }
> =20
> +    if (f->shutdown) {
> +        return;
> +    }

OK, I did wonder if you need to free the iovec.

>      if (f->iovcnt > 0) {
>          expect =3D iov_size(f->iov, f->iovcnt);
>          ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->p=
os,
> @@ -328,6 +334,10 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
>      f->buf_index =3D 0;
>      f->buf_size =3D pending;
> =20
> +    if (f->shutdown) {
> +        return 0;
> +    }

I also wondered if perhaps an error would be reasonable here; but I'm
not sure what a read(2) does after a shutdown(2).

Still,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      len =3D f->ops->get_buffer(f->opaque, f->buf + pending, f->pos,
>                               IO_BUF_SIZE - pending, &local_error);
>      if (len > 0) {
> @@ -642,6 +652,9 @@ int64_t qemu_ftell(QEMUFile *f)
> =20
>  int qemu_file_rate_limit(QEMUFile *f)
>  {
> +    if (f->shutdown) {
> +        return 1;
> +    }
>      if (qemu_file_get_error(f)) {
>          return 1;
>      }
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


