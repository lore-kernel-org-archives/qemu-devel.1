Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4654C2BB86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930CD206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlQ24gXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930CD206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKxe-0002Qm-QL
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOKwb-0001Vg-U1
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOKwa-0001K9-7c
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:45:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOKwa-0001Jd-3R
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqWcmtqSDhusTHs9Jv9aHVC8BTZx2evKSV2aT6bJkT4=;
 b=DlQ24gXaFJQz3VNK6uDF4upr8GvjaXGhAEARa1uUDtStPYTxCsDc10iPu07nsZO38bc23w
 Nd0c+cdZNPZWJHZvMYcb9SmRx4Kv2PYepHQCIunu+GSmhHFMnZ2soED1RrbNRGEtBnuCL8
 K+Nn1MI13uE0bcaaZoGxs2S7uAb7NzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-0fiSDbJhNpWeVhB-DqdzAA-1; Tue, 14 Apr 2020 08:45:31 -0400
X-MC-Unique: 0fiSDbJhNpWeVhB-DqdzAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADEC78017F5;
 Tue, 14 Apr 2020 12:45:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6608610013A1;
 Tue, 14 Apr 2020 12:45:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD75D11385C8; Tue, 14 Apr 2020 14:45:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v3 1/7] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
References: <20200413204832.404-1-f4bug@amsat.org>
Date: Tue, 14 Apr 2020 14:45:27 +0200
In-Reply-To: <20200413204832.404-1-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 Apr 2020 22:48:32
 +0200")
Message-ID: <87r1wqs0bc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> The instance_init() calls are not suppose to fail. Add a
> Coccinelle script to use &error_abort instead of ignoring
> errors by using a NULL Error*.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3: Improved script (Vladimir Sementsov-Ogievskiy suggestions)
>
>  .../use-error_abort-in-instance_init.cocci    | 45 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 46 insertions(+)
>  create mode 100644 scripts/coccinelle/use-error_abort-in-instance_init.c=
occi
>
> diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.cocci b/=
scripts/coccinelle/use-error_abort-in-instance_init.cocci
> new file mode 100644
> index 0000000000..706c60163c
> --- /dev/null
> +++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
> @@ -0,0 +1,45 @@
> +// Use &error_abort in TypeInfo::instance_init()
> +//
> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
> +// This work is licensed under the terms of the GNU GPLv2 or later.
> +//
> +// spatch \
> +//  --macro-file scripts/cocci-macro-file.h --include-headers \
> +//  --sp-file scripts/coccinelle/use-error_abort-in-instance_init.cocci =
\
> +//  --keep-comments --in-place
> +//
> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg692=
500.html
> +// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg693637.html
> +
> +
> +@ has_qapi_error @
> +@@
> +    #include "qapi/error.h"
> +
> +
> +@ match_instance_init @
> +TypeInfo info;
> +identifier instance_initfn;
> +@@
> +    info.instance_init =3D instance_initfn;
> +
> +
> +@ use_error_abort_in_instance_init @
> +identifier match_instance_init.instance_initfn;
> +identifier func_with_error !=3D {qbus_create_inplace, object_initialize_=
child};
> +position pos;
> +@@
> +void instance_initfn(...)
> +{
> +   <+...
> +   func_with_error@pos(...,
> +-                           NULL);
> ++                           &error_abort);
> +   ...+>
> +}

While I expect the function can't actually fail for most instances of
this pattern, I can't exclude the possibility of "can't fail, but we're
not intested in the Error object".  The transformation is an improvement
in the former case, but incorrect in the latter case.  Patches need
extra-careful review.  Please explain that in both the script and the
commit message.

> +
> +
> +@ depends on use_error_abort_in_instance_init && !has_qapi_error @
> +@@
> +    #include ...
> ++   #include "qapi/error.h"
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f996e72780..77b93612bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2060,6 +2060,7 @@ F: scripts/coccinelle/error-use-after-free.cocci
>  F: scripts/coccinelle/error_propagate_null.cocci
>  F: scripts/coccinelle/remove_local_err.cocci
>  F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
> +F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
>  F: scripts/coccinelle/use-error_fatal.cocci
>  F: scripts/coccinelle/use-error_propagate-in-realize.cocci


