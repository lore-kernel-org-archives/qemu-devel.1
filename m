Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1BFC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B82206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8CBUc3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B82206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QGi-0000Bq-9n
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1QFY-0007k4-Vv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1QFW-0003j3-1i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:46:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31325
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1QFU-0003ge-AI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581407183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26dFwx9L/my938M3jo7V/TindfjBRws1JRENV627x1w=;
 b=S8CBUc3ggdET81uFqvmZZWDy2im46FevpW2H148nkSqvDwjd6FCCX+YFzOE/sjJzdiAeMl
 xjry56lcsKtlfcstSwBTnwzxZ6hZewD1SfJhlaowsUgkBYOknZJ1//1h+ExB0FE3yUlUvX
 eiPDnoODgX8x4QL577gj8aXgphJWEY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-PQs8PqGNNTGma-3M49ZxkA-1; Tue, 11 Feb 2020 02:46:21 -0500
Received: by mail-wm1-f71.google.com with SMTP id 7so967920wmf.9
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=26dFwx9L/my938M3jo7V/TindfjBRws1JRENV627x1w=;
 b=poJp/UIsXO45nCme2Roc5h7Cl5QcYHnp3qbVnWTkXaUrfqZ9zBdHRA8sNucuR68p35
 LSObfSd0+SHK1Sx7dxOVDtdTcyWmljk9F1qgpXapk96UlDEkhTcc+bd4LQd+JVGfljUY
 ymb4QhKuob1adJJc2icgUwU832k3MWr5R1CCHxJNSaFcitqC6Gt0NEshdtHQ9pMlD7po
 3x54he4QYS+NAx0yyFqJClBQLho+EufO0ywf8HBC3G5SMo74lJNNdZkTo0I/mMiWqgel
 sgo+gbUX4iR7/vJdDS8QaHvzTcHFXPWtgJg/AvK61aAjhxUvQnFd4ia/IZXAJST2HLQH
 BIXw==
X-Gm-Message-State: APjAAAWju1uADDzUqbMuEgIdXto2oGwd8MD8ddOI/fyZEbuVHqeLTaV7
 hgx6z9M2mBvFwPi3Qf9QUNJixM3b7BdXiLBe97jMfarKI3WPVEegcAbNK5GW/Mzw/3b67KGLj0W
 8SqYy1vXsKDFZnm0=
X-Received: by 2002:a05:6000:1208:: with SMTP id
 e8mr7217018wrx.351.1581407180354; 
 Mon, 10 Feb 2020 23:46:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0yTtXjH+0rlrnDlJmS1B91dMK/E3ilRdTLpy2x86rmyL8nVDJO/+pmBXxGqaxJOqYk9amVA==
X-Received: by 2002:a05:6000:1208:: with SMTP id
 e8mr7216992wrx.351.1581407179997; 
 Mon, 10 Feb 2020 23:46:19 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id r6sm3974553wrp.95.2020.02.10.23.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:46:19 -0800 (PST)
Subject: Re: [RFC PATCH 60/66] Hexagon HVX instruction utility functions
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-61-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c4fc675b-c538-e107-ec29-fc9dd44aeecd@redhat.com>
Date: Tue, 11 Feb 2020 08:46:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-61-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: PQs8PqGNNTGma-3M49ZxkA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Functions to support scatter/gather
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/mmvec/system_ext_mmvec.c | 265 ++++++++++++++++++++++++++++++++
>   target/hexagon/mmvec/system_ext_mmvec.h |  38 +++++
>   2 files changed, 303 insertions(+)
>   create mode 100644 target/hexagon/mmvec/system_ext_mmvec.c
>   create mode 100644 target/hexagon/mmvec/system_ext_mmvec.h
> 
> diff --git a/target/hexagon/mmvec/system_ext_mmvec.c b/target/hexagon/mmvec/system_ext_mmvec.c
> new file mode 100644
> index 0000000..f80ae3d
> --- /dev/null
> +++ b/target/hexagon/mmvec/system_ext_mmvec.c
> @@ -0,0 +1,265 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>

Similarly, drop previous includes.

> +#include "qemu/osdep.h"
> +#include "opcodes.h"
> +#include "insn.h"
> +#include "mmvec/macros.h"
> +#include "qemu.h"
> +
> +#define TYPE_LOAD 'L'
> +#define TYPE_STORE 'S'
> +#define TYPE_FETCH 'F'
> +#define TYPE_ICINVA 'I'
> +
> +enum mem_access_types {
> +    access_type_INVALID = 0,
> +    access_type_unknown = 1,
> +    access_type_load = 2,
> +    access_type_store = 3,
> +    access_type_fetch = 4,
> +    access_type_dczeroa = 5,
> +    access_type_dccleana = 6,
> +    access_type_dcinva = 7,
> +    access_type_dccleaninva = 8,
> +    access_type_icinva = 9,
> +    access_type_ictagr = 10,
> +    access_type_ictagw = 11,
> +    access_type_icdatar = 12,
> +    access_type_dcfetch = 13,
> +    access_type_l2fetch = 14,
> +    access_type_l2cleanidx = 15,
> +    access_type_l2cleaninvidx = 16,
> +    access_type_l2tagr = 17,
> +    access_type_l2tagw = 18,
> +    access_type_dccleanidx = 19,
> +    access_type_dcinvidx = 20,
> +    access_type_dccleaninvidx = 21,
> +    access_type_dctagr = 22,
> +    access_type_dctagw = 23,
> +    access_type_k0unlock = 24,
> +    access_type_l2locka = 25,
> +    access_type_l2unlocka = 26,
> +    access_type_l2kill = 27,
> +    access_type_l2gclean = 28,
> +    access_type_l2gcleaninv = 29,
> +    access_type_l2gunlock = 30,
> +    access_type_synch = 31,
> +    access_type_isync = 32,
> +    access_type_pause = 33,
> +    access_type_load_phys = 34,
> +    access_type_load_locked = 35,
> +    access_type_store_conditional = 36,
> +    access_type_barrier = 37,
> +    access_type_memcpy_load = 39,
> +    access_type_memcpy_store = 40,
> +
> +    NUM_CORE_ACCESS_TYPES
> +};
> +
> +enum ext_mem_access_types {
> +    access_type_vload = NUM_CORE_ACCESS_TYPES,
> +    access_type_vstore,
> +    access_type_vload_nt,
> +    access_type_vstore_nt,
> +    access_type_vgather_load,
> +    access_type_vscatter_store,
> +    access_type_vscatter_release,
> +    access_type_vgather_release,
> +    access_type_vfetch,
> +    NUM_EXT_ACCESS_TYPES
> +};
> +
> +static inline
> +target_ulong mem_init_access(CPUHexagonState *env, int slot, size4u_t vaddr,
> +                             int width, enum mem_access_types mtype,
> +                             int type_for_xlate)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    /* Nothing to do for Linux user mode in qemu */
> +    return vaddr;
> +#else
> +#error System mode not yet implemented for Hexagon

Do you plan to contribute system mode? :)

> +#endif
> +}
> +
[...]


