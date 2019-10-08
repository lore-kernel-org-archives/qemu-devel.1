Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C760C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576B5206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnUtJDyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576B5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrlI-0002iQ-HB
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrjq-0001WV-Gq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrjo-0007UG-53
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:49:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHrjn-0007T8-V7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:49:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so11280741wrv.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DneTQRyBgymEBp6x4/DlSmRg1dzrjulY9OKBfCHd5o4=;
 b=BnUtJDyGjBIt2gITEuYmVSYTeJ1bSslMbsxbbSqHL/0tO/LuX1h5cMEBMTGMURnMZh
 YSoXiaiW1rrRC2AihpNXYhd2wm/Ma3WFKU+aQpjHLtYJ006iLwRdfMrJWQnm5SUMQ9V3
 5gkgkMjVM3c9+nSc8HcgZQq3iCYru8UQdpetBKD0XxJdSKBMwz5jxyNZ6PtQYxZ0ozcC
 6cGYrryZAoahBJ0nHu2wYvkM47h/unjzPeRb7a2ZnzR/GKo8mTa+tnJWkKs3+7iVRrfm
 uxJ9cuyQwNP8RcE19u+oMfclTNQqSWfAIZxKMPoVvwKpYWOpY6RmpiAq3RJcrPCc7aFn
 D7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DneTQRyBgymEBp6x4/DlSmRg1dzrjulY9OKBfCHd5o4=;
 b=bpeZ5zGdQN+Dt+uNP9/gvkcBkevMolXz+ChidnQjlnc7fOrgcNFf47dbu+I7FCJacc
 /TJV96sta3j+TKjDVhsm0083B/OJNrxmbiYvPJb0ZBSUQaESlciX9UYm0fdnMgjTOpnt
 PC6/4tfpeudaaYuBaZKpuzdPpsokDbowojGVLNwqD7S36UrZGOA/hDvm1mgu9g+f6RtP
 GLPpfmaJ0bfgAGH95LYvWz7g1IdC6FP+pbSyUXnSZAMt8mrEsNJsyGv7KzqXbL9T9+9s
 m69TdWDHJYkl2lSA5334x7FU+MgiTsy/Mn5FDqQgCVTlvdBTMe4iGphHNng0f3gsR5Uq
 jriA==
X-Gm-Message-State: APjAAAWDzLDxq06diRgWoyWK0Ey6HCH25J7x6x2M/8fxUWJCyX/Hv/EV
 82ou92MuXReR648sIsmb1bdvKQ==
X-Google-Smtp-Source: APXvYqwz4yPaL2AWCZQiqY+Fi5CgltOCEO01Im8Ht+vM+OFTiQF0s8hNvWx5ja33jIgh5BEokyRt7w==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr27063733wrv.350.1570549762463; 
 Tue, 08 Oct 2019 08:49:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r6sm3862678wmh.38.2019.10.08.08.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 08:49:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2FE991FF87;
 Tue,  8 Oct 2019 16:49:21 +0100 (BST)
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-7-alex.bennee@linaro.org>
 <174fe11d-e3f5-011b-0beb-b3c237d0d9e6@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 06/13] debug: add -d tb_stats to control TBStatistics
 collection:
In-reply-to: <174fe11d-e3f5-011b-0beb-b3c237d0d9e6@linaro.org>
Date: Tue, 08 Oct 2019 16:49:21 +0100
Message-ID: <87imozi6f2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/7/19 11:28 AM, Alex Benn=C3=A9e wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>
>>  -d tb_stats[[,level=3D(+all+jit+exec+time)][,dump_limit=3D<number>]]
>>
>> "dump_limit" is used to limit the number of dumped TBStats in
>> linux-user mode.
>>
>> [all+jit+exec+time] control the profilling level used
>> by the TBStats. Can be used as follow:
>>
>> -d tb_stats
>> -d tb_stats,level=3Djit+time
>> -d tb_stats,dump_limit=3D15
>> ...
>>
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Message-Id: <20190829173437.5926-7-vandersonmr2@gmail.com>
>> [AJB: fix authorship, reword title]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> AJB:
>>   - reword title
>>   - add stubs for enabling
>>   - move things across to tb-stats-flags.h
>> ---
>>  accel/tcg/tb-stats.c          |  5 +++++
>>  include/exec/gen-icount.h     |  1 +
>>  include/exec/tb-stats-flags.h | 29 +++++++++++++++++++++++++++++
>>  include/exec/tb-stats.h       | 16 +++-------------
>>  include/qemu/log.h            |  1 +
>>  stubs/Makefile.objs           |  1 +
>>  stubs/tb-stats.c              | 27 +++++++++++++++++++++++++++
>>  util/log.c                    | 35 +++++++++++++++++++++++++++++++++++
>>  8 files changed, 102 insertions(+), 13 deletions(-)
>>  create mode 100644 include/exec/tb-stats-flags.h
>>  create mode 100644 stubs/tb-stats.c
>>
>> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>> index f431159fd2..1c66e03979 100644
>> --- a/accel/tcg/tb-stats.c
>> +++ b/accel/tcg/tb-stats.c
>> @@ -193,3 +193,8 @@ uint32_t get_default_tbstats_flag(void)
>>  {
>>      return default_tbstats_flag;
>>  }
>> +
>> +void set_default_tbstats_flag(uint32_t flags)
>> +{
>> +    default_tbstats_flag =3D flags;
>> +}
>> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
>> index be006383b9..3987adfb0e 100644
>> --- a/include/exec/gen-icount.h
>> +++ b/include/exec/gen-icount.h
>> @@ -2,6 +2,7 @@
>>  #define GEN_ICOUNT_H
>>
>>  #include "qemu/timer.h"
>> +#include "tb-stats-flags.h"
>>
>>  /* Helpers for instruction counting code generation.  */
>>
>> diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags=
.h
>> new file mode 100644
>> index 0000000000..8455073048
>> --- /dev/null
>> +++ b/include/exec/tb-stats-flags.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * QEMU System Emulator, Code Quality Monitor System
>> + *
>> + * We define the flags and control bits here to avoid complications of
>> + * including TCG/CPU information in common code.
>> + *
>> + * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef TB_STATS_FLAGS
>> +#define TB_STATS_FLAGS
>> +
>> +#define TB_NOTHING    (1 << 0)
>
> Repeating my question about TB_NOTHING -- what is it?
>
>> +#define TB_EXEC_STATS (1 << 1)
>> +#define TB_JIT_STATS  (1 << 2)
>> +#define TB_JIT_TIME   (1 << 3)
>> +
>> +/* TBStatistic collection controls */
>> +void enable_collect_tb_stats(void);
>> +void disable_collect_tb_stats(void);
>> +void pause_collect_tb_stats(void);
>> +bool tb_stats_collection_enabled(void);
>> +bool tb_stats_collection_paused(void);
>> +
>> +uint32_t get_default_tbstats_flag(void);
>> +void set_default_tbstats_flag(uint32_t);
>
> Is a get/set really better than an exported variable?

It makes things easier for log.c which is used for multiple binaries
although I never actually used empty inlines instead having stubs. I'll
have to check if the tools define CONFIG_TCG anyway.

>
> Should we have created this header in the first place,
> rather than moving stuff here in patch 6?

Yes. I'll move it.

>
> Surely TB_ALL_STATS?
>
>> +                } else if (g_str_equal(*level_tmp, "all")) {
>> +                    flags |=3D TB_JIT_STATS | TB_EXEC_STATS | TB_JIT_TI=
ME;
>
> Likewise.
>
>
> r~

Thanks,

--
Alex Benn=C3=A9e

