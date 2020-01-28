Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F45DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04AE20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy7YNpIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04AE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUGA-0008Mb-0p
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwUDW-00061B-3J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwUDU-0002Ji-UB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:59:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwUDU-0002JU-RB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580230796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvBaPIXc5PCJfMfdm25hJkRsbNnlwXKEvHC3036e2fU=;
 b=Cy7YNpIolzXe4y5+NfD/rCgg7ADpXfWoiPsj+hrqJmvFejrv0NJJRY94xwY/RwjVmi2G99
 babWUQ5V90XqG3yzzq30rzJ9vM9cvVoY4RH8ij1M/CVJVI+4XerRtD3QcuO6dcDf48tZiy
 OiaV7eLBHHa2qhqhj0rALUhUnjyIHZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-hI3W9f6wNACut-1TXhoI-A-1; Tue, 28 Jan 2020 11:59:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC87FDB4C;
 Tue, 28 Jan 2020 16:59:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10E16619E1;
 Tue, 28 Jan 2020 16:59:37 +0000 (UTC)
Date: Tue, 28 Jan 2020 16:59:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 01/13] qcrypto: add generic infrastructure for crypto
 options amendment
Message-ID: <20200128165934.GT1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-2-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114193350.10830-2-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hI3W9f6wNACut-1TXhoI-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 09:33:38PM +0200, Maxim Levitsky wrote:
> This will be used first to implement luks keyslot management.
>=20
> block_crypto_amend_opts_init will be used to convert
> qemu-img cmdline to QCryptoBlockAmendOptions
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c         | 17 +++++++++++++++++
>  block/crypto.h         |  3 +++
>  crypto/block.c         | 31 +++++++++++++++++++++++++++++++
>  crypto/blockpriv.h     |  8 ++++++++
>  include/crypto/block.h | 22 ++++++++++++++++++++++
>  qapi/crypto.json       | 16 ++++++++++++++++
>  6 files changed, 97 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index b2a4cff683..9faebd03d4 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -309,3 +309,19 @@
>    'base': 'QCryptoBlockInfoBase',
>    'discriminator': 'format',
>    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> +
> +
> +
> +##
> +# @QCryptoBlockAmendOptions:
> +#
> +# The options that are available for all encryption formats
> +# when initializing a new volume

minor point, the comment needs updating

> +#
> +# Since: 5.0
> +##
> +{ 'union': 'QCryptoBlockAmendOptions',
> +  'base': 'QCryptoBlockOptionsBase',
> +  'discriminator': 'format',
> +  'data': {
> +            } }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


