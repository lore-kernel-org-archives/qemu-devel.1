Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD9C2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE05208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWPiw61s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE05208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3G2-0001K2-3X
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1if3Ex-0000ka-W3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1if3Ew-0003IR-C1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:45:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1if3Ew-0003GF-5H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576075520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=4aJjamctqMyrJrduHQMjmFHKX87+PUspY03vPhNAqXQ=;
 b=GWPiw61sSKO2+Yr/BxTgVfk89plDqYhMXIXtOSUQY+jDnnDUvdhIYVIjbudJGwk9cpvgOI
 uz93Ws0Ers17fFE6skuYvvS7q8Dm94TT2vn+tzEJqeeUTL8T2YYTtCqlJL5Xd4adeHrh9f
 XG8h/bTFZBsifV4jqcCjhsR7i1RAl6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-c4wqAx-QPyC4FclpPsfhUQ-1; Wed, 11 Dec 2019 09:45:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 118B98DFC71;
 Wed, 11 Dec 2019 14:45:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-11.ams2.redhat.com [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 975295D6A3;
 Wed, 11 Dec 2019 14:45:14 +0000 (UTC)
Subject: Re: [PATCH] tests: skip block layer tests if !CONFIG_TOOLS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576074293-53357-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2bf62e63-5f05-49bd-17f6-aa3754561491@redhat.com>
Date: Wed, 11 Dec 2019 15:45:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576074293-53357-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: c4wqAx-QPyC4FclpPsfhUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/2019 15.24, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> The block tests, as well as ahci-test needs qemu-img.  Do not run
> them if it wasn't built.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/Makefile.include | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 8566f5f..f07c761 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -169,7 +169,9 @@ check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/i=
vshmem-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF=
)
>  check-qtest-i386-y +=3D tests/fdc-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/ide-test$(EXESUF)
> +ifeq ($(CONFIG_TOOLS),y)
>  check-qtest-i386-y +=3D tests/ahci-test$(EXESUF)
> +endif

Please use "check-qtest-i386-$(CONFIG_TOOLS) +=3D ..." instead.

 Thomas


