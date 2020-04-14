Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D4DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB34E206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVLBERbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB34E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOL1q-0004Bf-UK
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOL11-0003ij-Vx
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOL10-0003hr-MH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:50:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30404
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOL0z-0003hd-Vl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=184h+RwXs9C9bTLBHlfQPjj/Z4dSHvMoH1VfWUXXFII=;
 b=CVLBERbo4JHrsqbm8JFFUKyAtm5aeRj+rNA9eCUz3dsQ2ew0lI8BQ23yfKRx+WOcgnp4VI
 vrSzqB5YKDqEaBtniQnnRfGCq92CMpzpghd4fJnOBgrh3r07DZ7sw03YKxvNbJ5VAhKftf
 VlZr+CIOaQHjSQpyIdcGe3WpudwCrjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-mZlPNQIxOpCJCAS45dpVWw-1; Tue, 14 Apr 2020 08:50:07 -0400
X-MC-Unique: mZlPNQIxOpCJCAS45dpVWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC63B80256A;
 Tue, 14 Apr 2020 12:50:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75280116D8D;
 Tue, 14 Apr 2020 12:50:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC28F11385C8; Tue, 14 Apr 2020 14:50:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v3 3/7] scripts/coccinelle: Find eventually
 missing error_propagate() calls
References: <20200413205040.518-1-f4bug@amsat.org>
Date: Tue, 14 Apr 2020 14:50:04 +0200
In-Reply-To: <20200413205040.518-1-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 Apr 2020 22:50:40
 +0200")
Message-ID: <87k12is03n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> In some places in we put an error into a local Error*, but
> forget to use it. Add a Coccinelle patch to find such cases
> and report them.
>
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  .../find-missing-error_propagate.cocci        | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 scripts/coccinelle/find-missing-error_propagate.cocci
>
> diff --git a/scripts/coccinelle/find-missing-error_propagate.cocci b/scri=
pts/coccinelle/find-missing-error_propagate.cocci
> new file mode 100644
> index 0000000000..8b75b37b64
> --- /dev/null
> +++ b/scripts/coccinelle/find-missing-error_propagate.cocci
> @@ -0,0 +1,53 @@
> +// Find places likely missing error-propagation code, but code is too
> +// complex for automatic transformation, so manual analysis is required.
> +//
> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
> +// This work is licensed under the terms of the GNU GPLv2 or later.
> +//
> +// spatch \
> +//  --macro-file scripts/cocci-macro-file.h --include-headers \
> +//  --sp-file scripts/coccinelle/find-missing-error_propagate.cocci
> +//
> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691=
638.html
> +
> +
> +// First match two subsequent calls using local Error*
> +// in function provided a Error** argument
> +//
> +@discard_func_with_errp_argument@
> +typedef Error;
> +Error *local_err;
> +identifier func, errp, errfunc1, errfunc2;
> +@@
> +void func(..., Error **errp)
> +{
> + <+...
> + errfunc1(..., &local_err);
> + ... when !=3D local_err          // local_err is not used between the c=
alls
> + errfunc2(..., &local_err);
> + ...+>
> +}
> +
> +
> +// Again, match two subsequent calls using local Error*
> +// but ignoring within functions provided a Error** argument
> +//
> +@manual depends on never discard_func_with_errp_argument@
> +Error *local_err;
> +identifier errfunc1, errfunc2;
> +position p;
> +@@
> + errfunc1@p(..., &local_err);
> + ... when !=3D local_err
> + errfunc2(..., &local_err);
> +
> +
> +// As it is likely too complex to transform, report the hit
> +//
> +@script:python@
> +f << manual.errfunc1;
> +p << manual.p;
> +@@
> +print("[[manual check required: "
> +      "error_propagate() might be missing in {}() {}:{}:{}]]".format(
> +            f, p[0].file, p[0].line, p[0].column))

You report matches of the second rule only, i.e. only within functions
that doin't take an Error ** argument.  Why not everywhere?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77b93612bc..1150ec95a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2058,6 +2058,7 @@ F: scripts/coccinelle/add-missing-error_propagate.c=
occi
>  F: scripts/coccinelle/err-bad-newline.cocci
>  F: scripts/coccinelle/error-use-after-free.cocci
>  F: scripts/coccinelle/error_propagate_null.cocci
> +F: scripts/coccinelle/find-missing-error_propagate.cocci
>  F: scripts/coccinelle/remove_local_err.cocci
>  F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>  F: scripts/coccinelle/use-error_abort-in-instance_init.cocci


