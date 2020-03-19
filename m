Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E0C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4A12071C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4s21Nxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4A12071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEto9-0003Ax-5Q
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEtme-0001ux-Ir
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEtmd-0004bp-Gi
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:56:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51003)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEtmd-0004as-Ck
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584618978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=be0q9ZHIRTRarz/YFy+cCj0leqx5lfgIKYVCSf44jWY=;
 b=O4s21Nxvd4HlQPE5q2qgDK0GtxiPipwQPPbf4hcyos1FgRvGiUPvlFttDiPDoRVq/k6z/3
 vwgPkhlRZZ+onwE8V5O6W0PAhk71aPUMZYTLkLy+EWbMLHYoVQsjkWW9ixHhURyUyHBmRo
 EeNBoKWDHFKSeFgoCyPADo4gYgkgd8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-3YXLigqaPgOiqtyRfnVJxw-1; Thu, 19 Mar 2020 07:56:17 -0400
X-MC-Unique: 3YXLigqaPgOiqtyRfnVJxw-1
Received: by mail-wr1-f70.google.com with SMTP id l17so472836wro.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 04:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4mN8e2YUDMF2Q8E19Xczl63rnrWlCgvY8HgHBpRw48w=;
 b=MEzDmmblhHQF+V5g/H7Primzu6vexz5CFLzpZc7k0WPtBt5y4XW0XE7j8gOMpnv97T
 NmQ9BCzykP2mggscdwzcG2F8QA3AiqeFRgNnoVIoGOaU4b57AB+ZvAYz5XVPloEhOZCX
 QV/ClAS+tEwk1PuFumvSahlTv8l//NWOUYkX8BQmj38isjwUdrNhmUPb66/nONSVWYVA
 MZKJ6Jt7xZysgxblbO+Lx3yEH9TeREmeaZQYAzLjKat5OlFkmyTXQKY39N6TF9T6yZz4
 pRB4qDKcu+8wyHyZQ9rejQSqBIZkMO6SvVnNgk0fTVJ0WJ/eeIek9bUL0bPilWYak2Pb
 MITA==
X-Gm-Message-State: ANhLgQ3ZR/Z2HVJ2G2kTqKEKgL0/jXn/rE8rfl0v3WVJ0ws92hE963vo
 eC4Scliqp+XukXO+MwqRLLZrq9+tOQ4ukGOBbv6KxTsJvKXUENmHfmEpoTeQ/vm1bH6B7pyjYcF
 zYQHXZTuOJ/C1sCM=
X-Received: by 2002:adf:ed86:: with SMTP id c6mr3701201wro.286.1584618975763; 
 Thu, 19 Mar 2020 04:56:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu9vsau8S7NJNU7xSjIVy2lNbs92ldz5OljgBgjULdzoRsFXEFBa/uIGEXkQt8sdVgnV4JEuw==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr3701161wro.286.1584618975402; 
 Thu, 19 Mar 2020 04:56:15 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id y5sm2817683wmi.34.2020.03.19.04.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 04:56:14 -0700 (PDT)
Subject: Re: [PATCH] hw/isa/superio: Correct the license text
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200312213712.16671-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb427089-c7c2-c4d2-ba39-51d79c39484f@redhat.com>
Date: Thu, 19 Mar 2020 12:56:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312213712.16671-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/03/20 22:37, Philippe Mathieu-Daud=C3=A9 wrote:
> The license is the 'GNU General Public License v2.0 or later',
> not 'and':
>=20
>   This program is free software; you can redistribute it and/ori
>   modify it under the terms of the GNU General Public License as
>   published by the Free Software Foundation; either version 2 of
>   the License, or (at your option) any later version.
>=20
> Fix the license comment.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/isa/superio.h   | 2 +-
>  hw/isa/isa-superio.c       | 2 +-
>  hw/isa/smc37c669-superio.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
> index b151dcd753..147cc0a7b7 100644
> --- a/include/hw/isa/superio.h
> +++ b/include/hw/isa/superio.h
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
>   *
> - * This code is licensed under the GNU GPLv2 and later.
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index c4e391916c..180a8b9625 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2011-2012 Andreas F=C3=A4rber
>   * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
>   *
> - * This code is licensed under the GNU GPLv2 and later.
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
> index 901a9f8e65..18287741cb 100644
> --- a/hw/isa/smc37c669-superio.c
> +++ b/hw/isa/smc37c669-superio.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
>   *
> - * This code is licensed under the GNU GPLv2 and later.
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>=20

Queued, thanks.

Paolo


