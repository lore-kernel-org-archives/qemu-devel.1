Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F2CC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3666920773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOjzA0hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3666920773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHOl-0004dv-Am
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKHNG-0002wH-V3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:40:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKHNF-0003jO-9e
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600677636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6H8T/07ppLF1qD9jQtcpbeScZ48vpizivVNIMlvNl10=;
 b=bOjzA0hcXO5+BtWNd7SV2wu/Im6Gz4zZyUaKzk5zfvtlBtx4qv3fCP/Ezwu7OdzxJP5WdX
 +HEgcROEXxZjfKhMXS7xK3z4Ms9O9ME7golJTKnLtvRzTy3WI34KfCyiW0r9IKeU3lo4WF
 tot3hXwEHFfOXiWGcn4pyvVoUkIijtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-z2Xdu6ShMcazLFPZPHuHpg-1; Mon, 21 Sep 2020 04:40:34 -0400
X-MC-Unique: z2Xdu6ShMcazLFPZPHuHpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9545E1091063;
 Mon, 21 Sep 2020 08:40:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55FA060C13;
 Mon, 21 Sep 2020 08:40:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD8071132E9A; Mon, 21 Sep 2020 10:40:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
References: <20200918174117.180057-1-f4bug@amsat.org>
 <20200918174117.180057-4-f4bug@amsat.org>
Date: Mon, 21 Sep 2020 10:40:31 +0200
In-Reply-To: <20200918174117.180057-4-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 18 Sep 2020 19:41:14
 +0200")
Message-ID: <874knra5fk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:53:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> As it is legal to WRITE/ERASE the address/block 0,
> change the value of this definition to an illegal
> address: UINT32_MAX.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
>
> Same problem I had with the pflash device last year...
> This break migration :(
> What is the best way to do this?

Remind me: did we solve the problem with pflash, and if yes, how?

> ---
>  hw/sd/sd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 30ae435d669..4c05152f189 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -53,7 +53,7 @@
> =20
>  #define SDSC_MAX_CAPACITY   (2 * GiB)
> =20
> -#define INVALID_ADDRESS     0
> +#define INVALID_ADDRESS     UINT32_MAX
> =20
>  typedef enum {
>      sd_r0 =3D 0,    /* no response */
> @@ -666,8 +666,8 @@ static int sd_vmstate_pre_load(void *opaque)
> =20
>  static const VMStateDescription sd_vmstate =3D {
>      .name =3D "sd-card",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .pre_load =3D sd_vmstate_pre_load,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(mode, SDState),


