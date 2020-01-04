Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9CC2D0C2
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 14:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA61820672
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6Iti2++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA61820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inkcM-00079B-TB
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 09:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inkbe-0006bt-Vw
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 09:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inkba-0005Fu-7d
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 09:40:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inkba-0005Cw-0W
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578148840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWI8Jjepu0pNsJK3UZInaY6ysQMsZH5Wqc7LW8/Byk0=;
 b=b6Iti2++sjh0BM0JKNndzOSUmiEptsFBlrGx9KDGaCehBLu+kuKY5ESm+Wa7JhVXwTsvmQ
 RhB05z8OmME/nqEkSpKjq6WGVqIOVIiu8ibtVeTdcV18YjEBwXM9/wBnuaYVq7tgixq1eq
 LmaoILKFutNaqb0FFTSM0+4UHtCl6f8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-0wUax2_NNuCZTZRMNIplpg-1; Sat, 04 Jan 2020 09:40:37 -0500
Received: by mail-wr1-f71.google.com with SMTP id f15so10258256wrr.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 06:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UjxsiZEkyXk4d1LdZbvocpJ9PTLGslzSzL3FOyUzjKc=;
 b=bE+X59HNTBypeHeqk6m0UiPVpaZfzh5zB8vyPs/3XptJIPtqarSHp9zotm9PLIhEsb
 ZJFY1Y8CG1D+we1kBNPNFS3llXYCXBmZ70f2CmWFCfZSPTaUuKIL34eH0S8oYU21jTYZ
 53qjZSMP0UbZg25beKy5D2+NV0Fnt2TUWdpZhpu7CK57vDYAuprXafeK2KajWUJg8KUz
 u1vczYqWI6Nh4f9FexcAOZzt4cPII66NTNyr3xKtH8crKusCS8YyHOV8cFISxu2byYGw
 OOQBZuq3hp+yF0H9tRK67jsx0+dhbx3xyM7NLuanR6VdRCW2exj0NdJcgNiEvnLpHQLF
 KFoQ==
X-Gm-Message-State: APjAAAW7zrhP7/iPDOElFAKOvIzxJjppYQuQp0VOvR4I97N7JNlqLD6j
 ayaLg4ZYrtNhMO51RsxSKIlHrxlNK8Tvw4KEDoWxpVJE1MIXvnxmR2Ae8K9gBtnxSGgmDy49Iip
 h8MqQil5/LDNPQx8=
X-Received: by 2002:adf:f308:: with SMTP id i8mr33988941wro.42.1578148836717; 
 Sat, 04 Jan 2020 06:40:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEXXn+HNAewzeJwiI0xgRp3U8woAvHQADyj1TTx3ybf32iwTsoT08e3xm3ymUcxtpq+0jgYg==
X-Received: by 2002:adf:f308:: with SMTP id i8mr33988894wro.42.1578148835950; 
 Sat, 04 Jan 2020 06:40:35 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id d10sm66266075wrw.64.2020.01.04.06.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2020 06:40:35 -0800 (PST)
Subject: Re: [PATCH v3 00/29] cputlb: Remove support for MMU_MODE*_SUFFIX
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191228231124.18307-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2928cb5d-f67f-4e70-b37b-4c0743cdd925@redhat.com>
Date: Sat, 4 Jan 2020 15:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 0wUax2_NNuCZTZRMNIplpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/29/19 12:10 AM, Richard Henderson wrote:
> This is part of a project to raise the limit on NB_MMU_MODES.
>=20
> One of those is in cpu_ldst.h, in support of MMU_MODE*_SUFFIX.
> While this could be extended, it's not the best interface for
> such things.  Better is a single interface that allows a variable
> mmu_idx.  The best exemplars of that is the usage in target/mips
> and target/ppc.
>=20
> In the process, I tried to clean up the implementation of these
> functions for softmmu and user-only.
>=20
> Aleksander asked about code size changes.  They vary between
> a minor size increase (e.g. for qemu-system-alpha, where there
> are in fact no uses of the functions, which are now present as
> out-of-line functions rather than eliminated inline functions),
> to a minor size decrease (e.g. -79k/-1.6% for qemu-system-i386).
> See below for details.
>=20
> Changes for v3:
>    * Add patch to avoid breaking build for --enable-plugins.
>    * Rebase on master and resolve conflicts.
>=20
> Changes for v2:
>    * Significantly revised docs/devel/loads-stores.rst.
>    * m68k and s390x dropped #defines and use *_mmuidx_ra directly.
>=20
> Patches lacking review:
> 0009-plugins-Include-trace-mem.h-in-api.c.patch
> 0010-cputlb-Move-body-of-cpu_ldst_template.h-out-of-li.patch
>=20
>=20
> r~
>=20
>=20
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
>=20
> Richard Henderson (29):
>    target/xtensa: Use probe_access for itlb_hit_test
>    cputlb: Use trace_mem_get_info instead of trace_mem_build_info
>    trace: Remove trace_mem_build_info_no_se_[bl]e
>    target/s390x: Include tcg.h in mem_helper.c
>    target/arm: Include tcg.h in sve_helper.c
>    accel/tcg: Include tcg.h in tcg-runtime.c
>    linux-user: Include tcg.h in syscall.c
>    linux-user: Include trace-root.h in syscall-trace.h
>    plugins: Include trace/mem.h in api.c
>    cputlb: Move body of cpu_ldst_template.h out of line
>    translator: Use cpu_ld*_code instead of open-coding
>    cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
>    cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
>    target/i386: Use cpu_*_mmuidx_ra instead of templates
>    cputlb: Expand cpu_ldst_useronly_template.h in user-exec.c
>    target/nios2: Remove MMU_MODE{0,1}_SUFFIX
>    target/alpha: Remove MMU_MODE{0,1}_SUFFIX
>    target/cris: Remove MMU_MODE{0,1}_SUFFIX
>    target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
>    target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
>    target/sh4: Remove MMU_MODE{0,1}_SUFFIX
>    target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
>    target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
>    target/m68k: Use cpu_*_mmuidx_ra instead of MMU_MODE{0,1}_SUFFIX
>    target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
>    target/s390x: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
>    target/ppc: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
>    cputlb: Remove support for MMU_MODE*_SUFFIX
>    cputlb: Expand cpu_ldst_template.h in cputlb.c

Series:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


