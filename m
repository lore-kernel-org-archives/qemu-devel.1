Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7744BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC1321734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5PHjjx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC1321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inGN2-0002Ez-An
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 01:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inGML-0001qU-II
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inGMK-0007Hv-DY
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:22:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inGMK-0007Eq-96
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578032575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfFSmBKae3/zLj5v2RdvYTC1WBjwJd0h4eNUZomxFE4=;
 b=T5PHjjx94R5VYJ1XG8tAIIqqeldlR/XjQymVOKOdsjrfvBtAXjgDQzbSpqdipPFiih+YXr
 hBLqM8z8/BXohGn7OVhXXVTxex7dETYt+4cjrsb9usRfHgM5UdsCiTKz67IHin0E0C5T9l
 ytuOz/sDdKR1WQS4YAQUQw0aLZY9RPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-cLUzxSIGP5mO_kJYDOoBeQ-1; Fri, 03 Jan 2020 01:22:51 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so13291664wrm.18
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 22:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3jKTHNAhsGo6DW31dJGHGvqV9bxIgrnbeke4M6heIEU=;
 b=NccrrYf4l2VI/3VEEKQGtE6NLoF/1St8MrIoz9OLA16MMon2jKCbATaLtr1gnIunpq
 g0UUcYe6RBPLZC0/MUgCmsdTABMcTmVEexPTuEI4XnRtnI7GZwiBs326xWCZ5bztYnYl
 J15/LnG9qsUZ1bkiOFgNMfa1DXeodTZHMijCXXIek10QZw1FoGnGZELxdRPzOIsidiY1
 FS/6dMS+Wxa3koJA4qtUGjUtdlvXTdhytLAPRjJHw+5b08V7JcActr3iubAOF2pbT+6R
 Liaackjdg5gQFITM4n2KkNPFusQs78C6q2JJUv0bOl6rjY8Lflnnrz6QAXR4gqCTyIPn
 5qkQ==
X-Gm-Message-State: APjAAAViLjmsbHbX4/WjL9+dCgqfooqAe79eExNrg9S7InvPd9VbPVWG
 gLYhF1mJX1MHXC5N5SV2wh97AkkTDUhL41zr9ZQBbdPG/by9n13+6EfOQEddDU05AcA7Vjhkrjy
 y+OAQ78UM5IiuZjY=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr16866944wmi.166.1578032570654; 
 Thu, 02 Jan 2020 22:22:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYMEEheecB0NGvzzEkNMOGIG/77/ZoKVSfUEqpoN0IK5BwLdBztGuu8x332vi2WEQZPGCnCw==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr16866919wmi.166.1578032570391; 
 Thu, 02 Jan 2020 22:22:50 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b10sm61053406wrt.90.2020.01.02.22.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 22:22:49 -0800 (PST)
Subject: Re: [PATCH v3 09/29] plugins: Include trace/mem.h in api.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191228231124.18307-1-richard.henderson@linaro.org>
 <20191228231124.18307-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e93e6b71-60ca-3fb1-7030-a68b3877b8ea@redhat.com>
Date: Fri, 3 Jan 2020 07:22:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191228231124.18307-10-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: cLUzxSIGP5mO_kJYDOoBeQ-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 12/29/19 12:11 AM, Richard Henderson wrote:
> Code movement in an upcoming patch will show that this file
> was implicitly depending on trace/mem.h being included beforehand.

Ah, it uses the TRACE_MEM_* macros from "trace/mem-internal.h", which is=20
include by "trace/mem.h". OK.

Which part requires "trace-root.h"? Isn't it "trace/mem-internal.h" that=20
should include "trace-root.h"?

>=20
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   plugins/api.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/plugins/api.c b/plugins/api.c
> index fa1d9f276d..cb7098ce79 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -46,6 +46,8 @@
>   #include "qemu/plugin-memory.h"
>   #include "hw/boards.h"
>   #endif
> +#include "trace-root.h"
> +#include "trace/mem.h"
>  =20
>   /* Uninstall and Reset handlers */
>  =20
>=20


