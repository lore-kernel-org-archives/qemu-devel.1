Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2354FC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15D5206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUlSwHJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15D5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSLw-00012S-UD
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQSKZ-0008S0-6t
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:03:07 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQSKV-0006vF-O0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:03:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32262
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jQSKV-0006qw-AQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587373379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuDnKsa6jordutjLxcaEHrCjefRx+w2HJLj1aCGMGgA=;
 b=LUlSwHJttUrod7KkDjwiWBbAeI/KKKoHPxSFVw3naddAIajxRGm/CnEx0Ik/WLA+XUaAYg
 wt1u4ENnJyq/G8A1eswySRNiVFTPDAQ7Z8h/jj+KEZPE+Oap/iMo5jXHOCi8MGxKuyI8UQ
 UhilfvDfsSH1zE2/WvHRNWT91yktt9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-QeQVyCWOPWuDGtTerv0CCw-1; Mon, 20 Apr 2020 05:02:57 -0400
X-MC-Unique: QeQVyCWOPWuDGtTerv0CCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17F34107ACC9;
 Mon, 20 Apr 2020 09:02:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D397D92FA1;
 Mon, 20 Apr 2020 09:02:54 +0000 (UTC)
Date: Mon, 20 Apr 2020 11:02:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/1] block/crypto: better error message when creating too
 large files
Message-ID: <20200420090253.GA6237@linux.fritz.box>
References: <20200416095019.4406-1-mlevitsk@redhat.com>
 <20200416095019.4406-2-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200416095019.4406-2-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.04.2020 um 11:50 hat Maxim Levitsky geschrieben:
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
> The reason for this is that qemu-img checks for errno of the failure,
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
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  block/crypto.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index d577f89659..1b604beb30 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -104,18 +104,35 @@ static ssize_t block_crypto_init_func(QCryptoBlock =
*block,
>                                        Error **errp)
>  {
>      struct BlockCryptoCreateData *data =3D opaque;
> +    Error *local_error =3D NULL;
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
> +    ret =3D blk_truncate(data->blk, data->size + headerlen, false,
>                          data->prealloc, errp);

I think you intended to use &local_error (which is by the way spelt
local_err in most other places) here instead of passing errp and never
assigning local_err at all.

Kevin

> +
> +    if (ret >=3D 0) {
> +        return ret;
> +    }
> +
> +error:
> +    if (ret =3D=3D -EFBIG) {
> +        /* Replace the error message with a better one */
> +        error_free(local_error);
> +        error_setg(errp, "The requested file size is too large");
> +    } else {
> +        error_propagate(errp, local_error);
> +    }
> +
> +    return ret;
>  }
> =20
> =20
> --=20
> 2.17.2
>=20


