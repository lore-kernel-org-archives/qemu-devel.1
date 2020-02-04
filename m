Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B87C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC8620730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Br96ImTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC8620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iysZP-0004yt-GR
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 02:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iysXl-0003z7-0q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iysXi-00023c-Oc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:22:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iysXi-00020E-J3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580800961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dqzUGqH7/PB3msIW7d31kaWFbh+hgYZsETG4HQx8Oo=;
 b=Br96ImTMrGNB08A36f12SxnyTblNBxTYrx3ployQmZY5R+eS/wtX+ZRrC1H1CmTLUGFM1p
 7FhAxVqvFzeIla0ED5XhF2MUzlw+zG0TZLSRvkOVPHrGLAC+faP1Td2b9zZGQLM35chRB1
 vg4G8vbVdSjhAieVhhallptmFFL4Mrc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-zw4ONn3yM4-0rw2kY6f4zQ-1; Tue, 04 Feb 2020 02:22:37 -0500
Received: by mail-wm1-f69.google.com with SMTP id s25so925925wmj.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 23:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dqzUGqH7/PB3msIW7d31kaWFbh+hgYZsETG4HQx8Oo=;
 b=brCBkKd1UaXb+uBFDlViKG4mZiiesYb0oJE2jhL8bDnD/ecLbcNV3yMteFKwDwR3cm
 F60jEas79S03cRzk4xfZyFctHzCnTY1+lyyCh3UGu1Dr6J8je4mxP0HaYERpAmAheFZx
 UtyFo1m9g4oJ4gCA49dLF0z0BhvkF88GJgacsmoGjAnf2VhkQZCX03+lbEok1WnYs9aD
 iishtSdcPt2g3t/Ar+vLzRQJQwoNKD3AMdJMPLcJAuOgl7Dy+QsTprH0GcY3inz86/H5
 R6q25/z8PfWNk65MAQyHF1/JoBMxyc7ZghP3GKMxaeF+GBGPYEKPbK+Ko30LyT0mrdk4
 DenA==
X-Gm-Message-State: APjAAAWMgShm8GdPocffaFiaHo8Hybriy+EitUAEx6SvrUHpfCwYqwE3
 jXzKzmniV00VkUYGUy57hjeutzuXCmUCK/lFFEWMND0yFvOAJb5t+inyMMGgx43idTNLwsXi1n9
 W9xc4GIhDFu7LMtQ=
X-Received: by 2002:adf:b310:: with SMTP id j16mr20615811wrd.361.1580800956128; 
 Mon, 03 Feb 2020 23:22:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8zuybw1GI3Whf18XmncrUzcWwoTkLAreEMmWMVAw3owKgPJNzg6alEW6lh//I8IDgzlI/TQ==
X-Received: by 2002:adf:b310:: with SMTP id j16mr20615782wrd.361.1580800955703; 
 Mon, 03 Feb 2020 23:22:35 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id 133sm2929695wmd.5.2020.02.03.23.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 23:22:35 -0800 (PST)
Subject: Re: [PULL 3/3] target/mips: Separate FPU-related helpers into their
 own file
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580798552-703-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580798552-703-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <217483d9-14ad-25f0-e28d-791bd76ab00f@redhat.com>
Date: Tue, 4 Feb 2020 08:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580798552-703-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: zw4ONn3yM4-0rw2kY6f4zQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 7:42 AM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> For clarity and easier maintenence, create target/mips/fpu_helper.c, and
> move all FPU-related content form target/mips/op_helper.c to that file.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Message-Id: <1580745443-24650-3-git-send-email-aleksandar.markovic@rt-rk.com>
> ---
>   target/mips/Makefile.objs |    2 +-
>   target/mips/fpu_helper.c  | 1911 +++++++++++++++++++++++++++++++++++++++++++++
>   target/mips/op_helper.c   | 1877 --------------------------------------------
>   3 files changed, 1912 insertions(+), 1878 deletions(-)
>   create mode 100644 target/mips/fpu_helper.c
> 
> diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
> index 3ca2bde..91eb691 100644
> --- a/target/mips/Makefile.objs
> +++ b/target/mips/Makefile.objs
> @@ -1,5 +1,5 @@
>   obj-y += translate.o cpu.o gdbstub.o helper.o
> -obj-y += op_helper.o cp0_helper.o
> +obj-y += op_helper.o cp0_helper.o fpu_helper.o
>   obj-y += dsp_helper.o lmi_helper.o msa_helper.o
>   obj-$(CONFIG_SOFTMMU) += mips-semi.o
>   obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
> diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
> new file mode 100644
> index 0000000..0d5769e
> --- /dev/null
> +++ b/target/mips/fpu_helper.c
> @@ -0,0 +1,1911 @@
> +/*
> + *  Helpers for emulation of CP0-related MIPS instructions.

Isn't it "FPU"?

> + *
> + *  Copyright (C) 2004-2005  Jocelyn Mayer
> + *  Copyright (C) 2020  Wave Computing, Inc.
> + *  Copyright (C) 2020  Aleksandar Markovic <amarkovic@wavecomp.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "cpu.h"
> +#include "internal.h"
> +#include "qemu/host-utils.h"
> +#include "exec/helper-proto.h"
> +#include "exec/exec-all.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/memop.h"
> +#include "sysemu/kvm.h"
> +#include "fpu/softfloat.h"


