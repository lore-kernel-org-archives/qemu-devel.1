Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7580C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706EE2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEXNWVWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706EE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8x5-0000aX-M6
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jU8tL-000682-Cg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jU8r6-0001sK-Ia
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:06:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36977
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jU8r6-0001rl-4h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588251835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/F4/VBPCtHvYU8ictDT6UlmthGjt0VB8SUMG9UUKbVs=;
 b=jEXNWVWlLCBo9aUVjDEVcQw5jcuIeMLh2bQO/faC2TeTMxlbd1bwbAcYOqzMdtdPn8AJap
 jW0PoPBOTxvwCEOrLEBxnwa/Zt19xuWaIiNGjFYmlT4eEcj2hPfYJhuBxUESHBwgN5ruJN
 0ig9+NRXsV6asurAyWw1zJWA1G1sfSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-wdQVFn9EO6qRvUWKp998-w-1; Thu, 30 Apr 2020 09:03:53 -0400
X-MC-Unique: wdQVFn9EO6qRvUWKp998-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAD9E835B8C;
 Thu, 30 Apr 2020 13:03:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B6FF6606F;
 Thu, 30 Apr 2020 13:03:51 +0000 (UTC)
Message-ID: <cbb54ad47e8da413d7529783332dd7c854f3b199.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] block/crypto: better error message when creating
 too large files
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 Apr 2020 16:03:50 +0300
In-Reply-To: <20200420092951.24578-2-mlevitsk@redhat.com>
References: <20200420092951.24578-1-mlevitsk@redhat.com>
 <20200420092951.24578-2-mlevitsk@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-04-20 at 12:29 +0300, Maxim Levitsky wrote:
> Currently if you attampt to create too large file with luks you
> get the following error message:
>=20
> Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=3Dsec=
0
> qemu-img: test.luks: Could not resize file: File too large
>=20
> While for raw format the error message is
> qemu-img: test.img: The image size is too large for file format 'raw'
>=20
>=20
> The reason for this is that qemu-img checks for errono of the failure,
> and presents the later error when it is -EFBIG
>=20
> However crypto generic code 'swallows' the errno and replaces it
> with -EIO.
>=20
> As an attempt to make it better, we can make luks driver,
> detect -EFBIG and in this case present a better error message,
> which is what this patch does
>=20
> The new error message is:
>=20
> qemu-img: error creating test.luks: The requested file size is too large
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/crypto.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index d577f89659..f9f5dc11a7 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -104,18 +104,35 @@ static ssize_t block_crypto_init_func(QCryptoBlock =
*block,
>                                        Error **errp)
>  {
>      struct BlockCryptoCreateData *data =3D opaque;
> +    Error *local_err =3D NULL;
> +    int ret;
> =20
>      if (data->size > INT64_MAX || headerlen > INT64_MAX - data->size) {
> -        error_setg(errp, "The requested file size is too large");
> -        return -EFBIG;
> +        ret =3D -EFBIG;
> +        goto error;
>      }
> =20
>      /* User provided size should reflect amount of space made
>       * available to the guest, so we must take account of that
>       * which will be used by the crypto header
>       */
> -    return blk_truncate(data->blk, data->size + headerlen, false,
> -                        data->prealloc, errp);
> +    ret =3D blk_truncate(data->blk, data->size + headerlen, false,
> +                        data->prealloc, &local_err);
> +
> +    if (ret >=3D 0) {
> +        return ret;
> +    }
> +
> +error:
> +    if (ret =3D=3D -EFBIG) {
> +        /* Replace the error message with a better one */
> +        error_free(local_err);
> +        error_setg(errp, "The requested file size is too large");
> +    } else {
> +        error_propagate(errp, local_err);
> +    }
> +
> +    return ret;
>  }
> =20
> =20
Could someone pick that patch now that the freeze is over?
Best regards,
=09Maxim Levitsky


