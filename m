Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2FAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5587920678
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT3meGZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5587920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfmJo-00010m-K0
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 11:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jfmIy-0000A8-RI; Mon, 01 Jun 2020 11:24:48 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jfmIv-0008Nt-5d; Mon, 01 Jun 2020 11:24:48 -0400
Received: by mail-ej1-x643.google.com with SMTP id k11so9561974ejr.9;
 Mon, 01 Jun 2020 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=sxANU6nbFPCt0EhXkd5ZBvlOX0EDFxgYbGWL2UQmxw8=;
 b=aT3meGZ0q2O+/DvzNa1eI9jDNeDtfDBNnfp+nIxVOlgm3PenOJbYLI7lnI2kRdwtqT
 2ozqN1dNVccR2WJJWJedL5075rx7h3jHQRj9PMCuXauiit5mWhoj/ANlWEOEUYsLa5um
 3q4/399Wca9qZR3JnB1/RuLF56gFuzJfx5BSxpZdN4QqFlIYwhqHimJjYuKpjQnGfpGx
 7qqRQ4b653H3zZcHr8GfNddHEKlaxu/i6fLVM1xLE1O5w3ptajY8S1E8PT/SCxMJLWRj
 LN6mvLaPxW2x3yIW7IML7S4HnFdVOzNJ8gGp1+/Tznw+ys1adjB4yMdRIaZ4kEMGceWh
 0U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=sxANU6nbFPCt0EhXkd5ZBvlOX0EDFxgYbGWL2UQmxw8=;
 b=Jefg6hypXpgchgrht3RvNJ/Cvia251Uv98FrLBJhVf+WIVHsSydYS8bdlUyxHuUJ6o
 GovXRlUj3eq2fKDc5QOYl//B5SxaGRL/FvvNE0wrk06pxSKhbslKBibVD8fouMhQbeXb
 8OhWYCdcag52tuBlD0ki1jlwXa03v4bnM0qMxQRz96Oi7+JateGlnOgjWX41+vss0jsR
 yz0j49vA65GvITO4j4O7qMJyMgNW2szVAvVZZ4h/MjpNWbjxPpCswFyNHvcKJFUKMZ2P
 Od3jQFdq7O0spqeN0IjOgV9POOQUghqNGtTty2w20QJlP+OUWkRTtm0XVlgyVIayUSxv
 WXLA==
X-Gm-Message-State: AOAM531P4piAw5UwZoTUWWKP+obIFCApb7yBTbXga+bTdmd23a+QwkiC
 nA3XrPlXNyI5HMeQOJ0MXkE=
X-Google-Smtp-Source: ABdhPJz3eqjQudnsfEu5d5rwNc6qwUF/relN+aNRv0mT/kprvgtDTD/IPYh5uBXdHE8psgE0CfQOaA==
X-Received: by 2002:a17:907:9484:: with SMTP id
 dm4mr21098613ejc.56.1591025082794; 
 Mon, 01 Jun 2020 08:24:42 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id b21sm9163015ejz.28.2020.06.01.08.24.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 08:24:42 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <f4bug@amsat.org>,
 <qemu-devel@nongnu.org>
References: <20200601142930.29408-1-f4bug@amsat.org>
 <20200601142930.29408-8-f4bug@amsat.org>
In-Reply-To: <20200601142930.29408-8-f4bug@amsat.org>
Subject: RE: [PATCH v2 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix
 definitions
Date: Mon, 1 Jun 2020 16:24:40 +0100
Message-ID: <001601d63828$c5b132a0$511397e0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQF4w9KWcHxvvYD3VioCudSt4ChIBAL7l7qKqWbtDxA=
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: paul@xen.org
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Eduardo Habkost' <ehabkost@redhat.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Andrew Jeffery' <andrew@aj.id.au>,
 'Helge Deller' <deller@gmx.de>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?'Herv=C3=A9_Poussineau'?= <hpoussin@reactos.org>,
 'Joel Stanley' <joel@jms.id.au>, 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 'Richard Henderson' <rth@twiddle.net>, qemu-ppc@nongnu.org,
 =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> =
On Behalf Of Philippe Mathieu-Daud=C3=A9
> Sent: 01 June 2020 15:29
> To: qemu-devel@nongnu.org
> Cc: xen-devel@lists.xenproject.org; Anthony Perard =
<anthony.perard@citrix.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Herv=C3=A9 Poussineau <hpoussin@reactos.org>; =
Helge Deller <deller@gmx.de>; qemu-
> arm@nongnu.org; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Stefano =
Stabellini
> <sstabellini@kernel.org>; Michael S. Tsirkin <mst@redhat.com>; Eduardo =
Habkost <ehabkost@redhat.com>;
> Paul Durrant <paul@xen.org>; Andrew Jeffery <andrew@aj.id.au>; =
qemu-trivial@nongnu.org; Peter Maydell
> <peter.maydell@linaro.org>; Joel Stanley <joel@jms.id.au>; C=C3=A9dric =
Le Goater <clg@kaod.org>; qemu-
> ppc@nongnu.org; Richard Henderson <rth@twiddle.net>; Philippe =
Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Subject: [PATCH v2 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix =
definitions
>=20
> IEC binary prefixes ease code review: the unit is explicit.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Paul Durrant <paul@xen.org>

> ---
>  hw/i386/xen/xen-hvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 82ece6b9e7..94fe5d65e9 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -9,6 +9,7 @@
>   */
>=20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>=20
>  #include "cpu.h"
>  #include "hw/pci/pci.h"
> @@ -230,7 +231,7 @@ static void xen_ram_init(PCMachineState *pcms,
>           * Xen does not allocate the memory continuously, it keeps a
>           * hole of the size computed above or passed in.
>           */
> -        block_len =3D (1ULL << 32) + x86ms->above_4g_mem_size;
> +        block_len =3D (4 * GiB) + x86ms->above_4g_mem_size;
>      }
>      memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
>                             &error_fatal);
> --
> 2.21.3



