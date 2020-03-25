Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0357AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C367F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs50Cd4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C367F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2eX-0002C5-Qu
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jH2bc-000707-UP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jH2bb-0006jV-LR
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:45:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jH2bb-0006jE-HM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585129547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YatZZOyuZ308lN1KRkU5kMjJAmYX5A2P6ON3GllVG4o=;
 b=Gs50Cd4gZkFKksUJ+kJN1yv5UdVFtOQYHTiES7eJ7muHx/BorjCrMDEu3M5KRNbLUJQtdg
 U2FecvDW0iUAQcPS5a60z/ZIepK36RZJmSmxjw5wAoSdrFXfFZBxnOaW0IV9xbjj8myKtP
 WgDVAvnDaIJMMq7gk065GrXYeu1atNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-AafgimZ8NRKDIR0c-HQK7w-1; Wed, 25 Mar 2020 05:45:32 -0400
X-MC-Unique: AafgimZ8NRKDIR0c-HQK7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 345901005509;
 Wed, 25 Mar 2020 09:45:31 +0000 (UTC)
Received: from redhat.com (ovpn-115-2.ams2.redhat.com [10.36.115.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6631C5DA7B;
 Wed, 25 Mar 2020 09:45:29 +0000 (UTC)
Date: Wed, 25 Mar 2020 09:45:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH 3/3] crypto: Redundant type conversion for AES_KEY pointer
Message-ID: <20200325094526.GA3722209@redhat.com>
References: <20200325092137.24020-1-kuhn.chenqun@huawei.com>
 <20200325092137.24020-4-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200325092137.24020-4-kuhn.chenqun@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, laurent@vivier.eu,
 Euler Robot <euler.robot@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 05:21:37PM +0800, Chen Qun wrote:
> Fix: eaec903c5b8
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> ---
>  crypto/cipher-builtin.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
> index bf8413e71a..99d6280a16 100644
> --- a/crypto/cipher-builtin.c
> +++ b/crypto/cipher-builtin.c
> @@ -133,8 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const void=
 *ctx,
>  {
>      const QCryptoCipherBuiltinAESContext *aesctx =3D ctx;
> =20
> -    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
> -                                   src, dst, length);
> +    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
>  }
> =20
> =20
> @@ -145,8 +144,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const void=
 *ctx,
>  {
>      const QCryptoCipherBuiltinAESContext *aesctx =3D ctx;
> =20
> -    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
> -                                   src, dst, length);
> +    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
>  }
> =20
> =20
> --=20
> 2.23.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


