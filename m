Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F6C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC742054F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECn10LUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC742054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSxc-0007HK-Ju
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:19:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTSuU-0003Zz-F8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTStH-0004zb-Gg
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:16:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTStG-0004yi-So
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588090520;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZQK/tt3uqEBs/AZI9JDgSJecOUhI5aO8chjZCjBEzg=;
 b=ECn10LUzDlyCEod3vFI79lD9dJNhTGHWRR+LpOnLjpYujsWXB67ist21wwaSus+T6N5/v4
 dtIseAvEdQwkqjNGMUyum6kOPcJo/r3i2ugFgRDQdCZiC0wfzkWmF3BZmZzeTDRupBmXgs
 tB3XlbpBQlgNoyxnuYQUEY5Uf4fR6Ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-tW9BclUjOJOwTCULxsZWjQ-1; Tue, 28 Apr 2020 12:15:18 -0400
X-MC-Unique: tW9BclUjOJOwTCULxsZWjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE92800D24;
 Tue, 28 Apr 2020 16:15:17 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11482611A9;
 Tue, 28 Apr 2020 16:15:14 +0000 (UTC)
Date: Tue, 28 Apr 2020 17:15:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 07/14] block/crypto: implement the encryption key
 management
Message-ID: <20200428161511.GD1467943@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-8-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308151903.25941-8-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 05:18:56PM +0200, Maxim Levitsky wrote:
> This implements the encryption key management using the generic code in
> qcrypto layer and exposes it to the user via qemu-img
>=20
> This code adds another 'write_func' because the initialization
> write_func works directly on the underlying file, and amend
> works on instance of luks device.
>=20
> This commit also adds a 'hack/workaround' I and Kevin Wolf (thanks)
> made to make the driver both support write sharing (to avoid breaking the=
 users),
> and be safe against concurrent  metadata update (the keyslots)
>=20
> Eventually the write sharing for luks driver will be deprecated
> and removed together with this hack.
>=20
> The hack is that we ask (as a format driver) for BLK_PERM_CONSISTENT_READ
> and then when we want to update the keys, we unshare that permission.
> So if someone else has the image open, even readonly, encryption
> key update will fail gracefully.
>=20
> Also thanks to Daniel Berrange for the idea of
> unsharing read, rather that write permission which allows
> to avoid cases when the other user had opened the image read-only.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++--
>  block/crypto.h |  44 +++++++++++++++--
>  2 files changed, 163 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


> @@ -661,6 +693,95 @@ block_crypto_get_specific_info_luks(BlockDriverState=
 *bs, Error **errp)
>      return spec_info;
>  }
> =20
> +static int
> +block_crypto_amend_options_luks(BlockDriverState *bs,
> +                           QemuOpts *opts,
> +                           BlockDriverAmendStatusCB *status_cb,
> +                           void *cb_opaque,
> +                           bool force,
> +                           Error **errp)

Nitpick - align options after the "("


> @@ -81,11 +86,40 @@
>          .help =3D "Name of encryption hash algorithm",     \
>      }
> =20
> -#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(prefix)           \
> -    {                                                         \
> -        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,       \
> -        .type =3D QEMU_OPT_NUMBER,                              \
> -        .help =3D "Time to spend in PBKDF in milliseconds",     \
> +#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(prefix)        \
> +    {                                                      \
> +        .name =3D prefix BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,    \
> +        .type =3D QEMU_OPT_NUMBER,                           \
> +        .help =3D "Time to spend in PBKDF in milliseconds",  \
> +    }

Nitpick - no need to change whitespace here

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


