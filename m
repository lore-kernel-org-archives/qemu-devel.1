Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D9C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3CC24249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJMVOqir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3CC24249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icmTK-0003K1-ND
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 03:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icmSR-0002iD-V2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icmSP-0005HO-H8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:25:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icmSP-0005BR-7Q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575534351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iovAgDzLApHKkhwDRertF6O/pdmbXMRB7Tf8Qv2QnWU=;
 b=JJMVOqirPec7dyMxjE+cBqehkCdhIcqAwwMamADLz0T6v8aq2BgLnUlvPLK8KVv5XG70sG
 DWFv8YSjofLpwvAtgJf7M7jUhnZVEsRk5qi96RVdObgt9Vtnsdt2UbM/UKnifkHhQSei/4
 qMMX41+SzKjqLa9frjC+vFf6lyH/+xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-hxeAPRbaM5Oo_FimxBVrXQ-1; Thu, 05 Dec 2019 03:25:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E2B5107ACC7;
 Thu,  5 Dec 2019 08:25:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D87BE5C1B5;
 Thu,  5 Dec 2019 08:25:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D1E41138606; Thu,  5 Dec 2019 09:25:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Han Han <hhan@redhat.com>
Subject: Re: [PATCH v2] Revert "qemu-options.hx: Update for reboot-timeout
 parameter"
References: <20191205024821.245435-1-hhan@redhat.com>
Date: Thu, 05 Dec 2019 09:25:47 +0100
In-Reply-To: <20191205024821.245435-1-hhan@redhat.com> (Han Han's message of
 "Thu, 5 Dec 2019 10:48:21 +0800")
Message-ID: <878snri3g4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: hxeAPRbaM5Oo_FimxBVrXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Han Han <hhan@redhat.com> writes:

> This reverts commit bbd9e6985ff342cbe15b9cb7eb30e842796fbbe8.
>
> In 20a1922032 we allowed reboot-timeout=3D-1 again, so update the doc
> accordingly.
>
> Signed-off-by: Han Han <hhan@redhat.com>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 65c9473b..e14d88e9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -327,8 +327,8 @@ format(true color). The resolution should be supporte=
d by the SVGA mode, so
>  the recommended is 320x240, 640x480, 800x640.
> =20
>  A timeout could be passed to bios, guest will pause for @var{rb_timeout}=
 ms
> -when boot failed, then reboot. If @option{reboot-timeout} is not set,
> -guest will not reboot by default. Currently Seabios for X86
> +when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will n=
ot
> +reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
>  system support it.
> =20
>  Do strict boot via @option{strict=3Don} as far as firmware/BIOS

Reviewed-by: Markus Armbruster <armbru@redhat.com>


