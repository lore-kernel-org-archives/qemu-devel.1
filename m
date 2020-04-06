Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80252C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54617206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgQC0mcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54617206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLY1q-0000aS-FF
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 16:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jLY1E-00008F-T5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jLY1D-0007pU-HP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:06:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jLY1D-0007pM-EE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586203611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpOFHQTDjt1rdb6S1hf6LDVP/m9yjtsl2Sb/QUktZ4U=;
 b=AgQC0mcORhW0yDXRwYzfU5b0vAzewYkGw2RCXx80rl+iH03xs8ts83kg921099/Dl7dzW8
 L7W83YE+Stc6+dqKFJpqnJazNVRz0GI879Yb1CWBCyBhR9XQU6aLKe6uLmcLlxpV5yuOdh
 63DKh511Nty5O/ya/TCuWCNCw3tfGaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-fPNT_YCmOXiWlsEk7GeWwQ-1; Mon, 06 Apr 2020 16:06:44 -0400
X-MC-Unique: fPNT_YCmOXiWlsEk7GeWwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B5111085933;
 Mon,  6 Apr 2020 20:06:43 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1403562697;
 Mon,  6 Apr 2020 20:06:43 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 v2 37/54] scripts/coccinelle: Add script to catch
 missing error_propagate() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-38-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0bae945b-b7df-93a1-bc78-d29870cdabcb@redhat.com>
Date: Mon, 6 Apr 2020 15:06:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-38-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 12:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> In some places in we put an error into a local Error*, but forget
> to check for failure and pass it back to the caller.
> Add a Coccinelle patch to catch automatically add the missing code.

s/catch/catch and/

>=20
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   .../add-missing-error_propagate.cocci         | 30 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 31 insertions(+)
>   create mode 100644 scripts/coccinelle/add-missing-error_propagate.cocci
>=20
> diff --git a/scripts/coccinelle/add-missing-error_propagate.cocci b/scrip=
ts/coccinelle/add-missing-error_propagate.cocci
> new file mode 100644
> index 0000000000..7991c9e2c2
> --- /dev/null
> +++ b/scripts/coccinelle/add-missing-error_propagate.cocci
> @@ -0,0 +1,30 @@
> +// Add missing error-propagation code where caller provide a Error* argu=
ment

provides

> +//
> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
> +// This work is licensed under the terms of the GNU GPLv2 or later.
> +//
> +// spatch \
> +//  --macro-file scripts/cocci-macro-file.h --include-headers \
> +//  --sp-file scripts/coccinelle/add-missing-error_propagate.cocci \
> +//  --keep-comments --in-place
> +//
> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691=
638.html
> +
> +
> +@ add_missing_error_propagate @
> +typedef Error;
> +Error *local_err;
> +identifier func, errp, errfunc1, errfunc2;
> +@@
> +func(..., Error **errp)
> +{
> +    <...
> +    errfunc1(..., &local_err);
> ++   if (local_err) {
> ++       error_propagate(errp, local_err);
> ++       return;

Do we have to ensure that 'func' returns void?  But then again, I guess=20
it's easy enough to validate whether things still compile after this=20
script makes cleanups.

> ++   }
> +    ... when !=3D local_err
> +    errfunc2(..., &local_err);
> +    ...>
> +}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b58f02efb..14de2a31dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2053,6 +2053,7 @@ F: include/qemu/error-report.h
>   F: qapi/error.json
>   F: util/error.c
>   F: util/qemu-error.c
> +F: scripts/coccinelle/add-missing-error_propagate.cocci
>   F: scripts/coccinelle/err-bad-newline.cocci
>   F: scripts/coccinelle/error-use-after-free.cocci
>   F: scripts/coccinelle/error_propagate_null.cocci
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


