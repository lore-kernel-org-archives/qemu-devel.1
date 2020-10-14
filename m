Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50DEC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B857821582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGg1oXoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B857821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbh7-0003yc-FZ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSbgU-0003YU-Pk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSbgS-0004xV-9X
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602662331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psc0tXP/2uQj5R5dCGzzuUplUIdW0TOXOCJPz7ts3Z8=;
 b=dGg1oXoUYSs7ZxWsyeZeYWk2mRhyAyN+nGyY1yalu4B1o/COf+iaVzPjqULiU849UEHOGt
 RsYD5e2ZWuxeDbW4Dz5nh8Z2Q4I5HvdFsJm0d7GRp6RJYWq/X0Ea2uc7AOoFy0NxluAli9
 Bpa3JBf8cRErXOptadZOhQxCZfkVEDU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-J4s5_-lhOla07EGfMwdv2g-1; Wed, 14 Oct 2020 03:58:49 -0400
X-MC-Unique: J4s5_-lhOla07EGfMwdv2g-1
Received: by mail-wm1-f69.google.com with SMTP id l15so254137wmh.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 00:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=psc0tXP/2uQj5R5dCGzzuUplUIdW0TOXOCJPz7ts3Z8=;
 b=qgaKL9pkW+eM20RAw3O0tyus0TA8dqzNsFJBok+5mwEyxuO64J7bD8X5K49tW+7Xh6
 kCT9hP4tS44MTd7BEsXHG096Glw5yXdUP7qLog5LdSmRmOEUuLjyPACDmswB09lkAv5N
 Q2jLiPpop7JlpRzRwfItGZMb6Gqx8jkBayiy1rJjxwcqNK1r5eY+ORgTyqu2O+ra1he+
 bFzYDcG4I+qZwXp5gUR0AMP1O6Fhu1hQnyOwt8sBj/Ee4DiLKBmvPauH6lJv8N1sKQjs
 rjyhwFNqqzMIjwGGy1lZjWq5d94nwSb3ZhjICKU9bK4lOHwTLuLiQ/v6MQXAAUmNLAla
 L0JQ==
X-Gm-Message-State: AOAM531wXCe0i7BZgIDxE9t8HuQKrd7JYbhMxpPtGJf3rFQ68MqlPOfB
 fUOyopTcdWuzkSAqO4Tf0m0hLje0xFT9W8vvnwrDEStTJ6+P2nZzZ3twp8+waPYKJPK4vJlTrWH
 x65ua43G5zphGlpc=
X-Received: by 2002:adf:90c4:: with SMTP id i62mr3751132wri.98.1602662328216; 
 Wed, 14 Oct 2020 00:58:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKGIY3KKkIsTt2iiPQh651hEQZWNlLCnQ8vNyt9AEb13QU4xxMklUJRL8wuh7TTJCkRB55zw==
X-Received: by 2002:adf:90c4:: with SMTP id i62mr3751102wri.98.1602662327835; 
 Wed, 14 Oct 2020 00:58:47 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y4sm3481280wrp.74.2020.10.14.00.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 00:58:47 -0700 (PDT)
Subject: Re: [RFC v1 1/2] accel/tcg: split CpusAccel into three TCG variants
To: Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201014073605.6155-1-cfontana@suse.de>
 <20201014073605.6155-2-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64b1e350-ed12-ffee-24a1-a6abfccc53ce@redhat.com>
Date: Wed, 14 Oct 2020 09:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014073605.6155-2-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:36 AM, Claudio Fontana wrote:
> split up the CpusAccel tcg_cpus into three TCG variants:
> 
> tcg_cpus_rr (single threaded, round robin cpus)
> tcg_cpus_icount (same as rr, but with instruction counting enabled)
> tcg_cpus_mttcg (multi-threaded cpus)
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   accel/tcg/meson.build       |   9 +-
>   accel/tcg/tcg-all.c         |   8 +-
>   accel/tcg/tcg-cpus-icount.c | 145 +++++++++++
>   accel/tcg/tcg-cpus-icount.h |  20 ++
>   accel/tcg/tcg-cpus-mttcg.c  | 118 +++++++++
>   accel/tcg/tcg-cpus-mttcg.h  |  25 ++
>   accel/tcg/tcg-cpus-rr.c     | 270 ++++++++++++++++++++
>   accel/tcg/tcg-cpus-rr.h     |  23 ++
>   accel/tcg/tcg-cpus.c        | 478 ++----------------------------------
>   accel/tcg/tcg-cpus.h        |   9 +-
>   softmmu/icount.c            |   2 +-
>   11 files changed, 647 insertions(+), 460 deletions(-)
>   create mode 100644 accel/tcg/tcg-cpus-icount.c
>   create mode 100644 accel/tcg/tcg-cpus-icount.h
>   create mode 100644 accel/tcg/tcg-cpus-mttcg.c
>   create mode 100644 accel/tcg/tcg-cpus-mttcg.h
>   create mode 100644 accel/tcg/tcg-cpus-rr.c
>   create mode 100644 accel/tcg/tcg-cpus-rr.h
...

> diff --git a/accel/tcg/tcg-cpus-icount.c b/accel/tcg/tcg-cpus-icount.c
> new file mode 100644
> index 0000000000..43505e8f1f
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-icount.c
> @@ -0,0 +1,145 @@
> +/*
> + * QEMU System Emulator

"QEMU single threaded vCPUs implementation using instruction counting"?

> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2014 Red Hat Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
...

> diff --git a/accel/tcg/tcg-cpus-icount.h b/accel/tcg/tcg-cpus-icount.h
> new file mode 100644
> index 0000000000..e2e25674c2
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-icount.h
> @@ -0,0 +1,20 @@
> +/*
> + * Accelerator CPUS Interface

Ditto.

> + *
> + * Copyright 2020 SUSE LLC
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TCG_CPUS_ICOUNT_H
> +#define TCG_CPUS_ICOUNT_H
> +
> +extern const CpusAccel tcg_cpus_icount;
> +
> +int64_t tcg_get_icount_limit(void);
> +void handle_icount_deadline(void);
> +void prepare_icount_for_run(CPUState *cpu);
> +void process_icount_data(CPUState *cpu);
> +
> +#endif /* TCG_CPUS_ICOUNT_H */
> diff --git a/accel/tcg/tcg-cpus-mttcg.c b/accel/tcg/tcg-cpus-mttcg.c
> new file mode 100644
> index 0000000000..2f5317d767
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-mttcg.c
> @@ -0,0 +1,118 @@
> +/*
> + * QEMU System Emulator

"QEMU multi-threaded vCPUs implementation"?

> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2014 Red Hat Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
...

> diff --git a/accel/tcg/tcg-cpus-mttcg.h b/accel/tcg/tcg-cpus-mttcg.h
> new file mode 100644
> index 0000000000..c8966b2f8a
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-mttcg.h
> @@ -0,0 +1,25 @@
> +/*
> + * Accelerator CPUS Interface

Ditto.

> + *
> + * Copyright 2020 SUSE LLC
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TCG_CPUS_MTTCG_H
> +#define TCG_CPUS_MTTCG_H
> +
> +extern const CpusAccel tcg_cpus_mttcg;
> +
> +/*
> + * Multi-threaded TCG
> + *
> + * In the multi-threaded case each vCPU has its own thread. The TLS
> + * variable current_cpu can be used deep in the code to find the
> + * current CPUState for a given thread.
> + */
> +
> +void *tcg_cpu_thread_fn(void *arg);
> +
> +#endif /* TCG_CPUS_MTTCG_H */
> diff --git a/accel/tcg/tcg-cpus-rr.c b/accel/tcg/tcg-cpus-rr.c
> new file mode 100644
> index 0000000000..b8fd33d9d3
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-rr.c
> @@ -0,0 +1,270 @@
> +/*
> + * QEMU System Emulator

"QEMU single threaded (using round robin) vCPUs implementation"?

> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2014 Red Hat Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
...

> diff --git a/accel/tcg/tcg-cpus-rr.h b/accel/tcg/tcg-cpus-rr.h
> new file mode 100644
> index 0000000000..155510cfd4
> --- /dev/null
> +++ b/accel/tcg/tcg-cpus-rr.h
> @@ -0,0 +1,23 @@
> +/*
> + * Accelerator CPUS Interface

Ditto.

> + *
> + * Copyright 2020 SUSE LLC
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TCG_CPUS_RR_H
> +#define TCG_CPUS_RR_H
> +
> +extern const CpusAccel tcg_cpus_rr;
> +
> +#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
> +
> +/* Kick all RR vCPUs. */
> +void qemu_cpu_kick_rr_cpus(CPUState *unused);
> +
> +/* Single-threaded TCG */
> +void *tcg_rr_cpu_thread_fn(void *arg);
> +
> +#endif /* TCG_CPUS_RR_H */
...

> diff --git a/accel/tcg/tcg-cpus.h b/accel/tcg/tcg-cpus.h
> index 8b1d9d2abc..871e58507d 100644
> --- a/accel/tcg/tcg-cpus.h
> +++ b/accel/tcg/tcg-cpus.h
> @@ -12,6 +12,13 @@
>   
>   #include "sysemu/cpus.h"
>   
> -extern const CpusAccel tcg_cpus;
> +#include "tcg-cpus-rr.h"
> +#include "tcg-cpus-icount.h"
> +#include "tcg-cpus-mttcg.h"

Why do we need to include the implementation declarations?

> +
> +void tcg_start_vcpu_thread(CPUState *cpu);
> +void qemu_tcg_destroy_vcpu(CPUState *cpu);
> +int tcg_cpu_exec(CPUState *cpu);
> +void tcg_handle_interrupt(CPUState *cpu, int mask);
>   
>   #endif /* TCG_CPUS_H */
> diff --git a/softmmu/icount.c b/softmmu/icount.c
> index 020a201a01..dbcd8c3594 100644
> --- a/softmmu/icount.c
> +++ b/softmmu/icount.c
> @@ -396,7 +396,7 @@ void icount_start_warp_timer(void)
>   
>   void icount_account_warp_timer(void)
>   {
> -    if (!icount_enabled() || !icount_sleep) {
> +    if (!icount_sleep) {
>           return;
>       }
>   
> 


