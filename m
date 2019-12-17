Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255CCC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E357220733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsgEO1Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E357220733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHnI-0003BL-2x
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihHma-0002c5-KE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihHmY-0005Du-2s
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:41:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihHmX-0005Dg-U1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576608076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3sATrBClMlY9DL8gW1dd+a7IVwIb+RF5yx+AhagqTs=;
 b=YsgEO1MgAXonfVCEUUru68ldI2EbLEVwNuXKqqV1F5n3FUicXjSmi8L0hnp+OuaE4BFoFV
 lWPINtzjvxhd6TyQv+6gZIVt3uhNdfeNTDbWA3nS9v45K2n9SzvBJSSrSBbxAYmlB3GqpN
 5ns2GIAY9guLOkAqoddaPXtrtpMIEJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-GoRygTFgM5OTI9bt3GAYYg-1; Tue, 17 Dec 2019 13:41:12 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so5675455wrm.23
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f3sATrBClMlY9DL8gW1dd+a7IVwIb+RF5yx+AhagqTs=;
 b=TwJRK++Iv3Y2hyFkqSiJ4+HyZtwF4eKVzhqLeCyiNPM2qUM/osVzBTeUeBaPawz+Fj
 h4PsF8H66OSU178Bk7IjIsTVcauGvAMJG9q8F18FZTJD9SAcmURxvZxWpjSdE8wdBW3Y
 vokXq9M6Oa33sTzYHGas+oPes0it8WqmsUng7bp/MFAy1rICXcEOhuJLQ/llvDxM3XsH
 p3Zt+rXE7O2D+uKwPE+DIfJsNgkyo+GyFb3SHZ4BZquuqwYh9GxG11lXK85Lb4wXA2Eh
 +ITiNK8tuB+021jZuDy3At58+H3jf/BdO5SWc2Yge4D8wv4gjTwIRAHQQBaZf7M03tvW
 6VMg==
X-Gm-Message-State: APjAAAUasrDxDhtRtFiJ2niDIF37JAQVqi9FjBwsTaiw3jPfnia4CEdy
 wkbs3myZUJfZRmdMjnmezCdhuvEtyF2cod5rryLFSWPLCx4sheRelvG7ABaBXIh7EesVn4RF1Hj
 9Wyob3+jYkkY7UY4=
X-Received: by 2002:adf:8bde:: with SMTP id w30mr37713387wra.124.1576608071012; 
 Tue, 17 Dec 2019 10:41:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWQlkCrF0qLhfAE6wosHqnc7/G8Ve6lFUTxQfmPbzGJrhntByBLyTs6IRUbYvQBIHFO92LVQ==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr37713365wra.124.1576608070714; 
 Tue, 17 Dec 2019 10:41:10 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u14sm26933372wrm.51.2019.12.17.10.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 10:41:10 -0800 (PST)
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
To: Peter Maydell <peter.maydell@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87d0dw83uz.fsf@linaro.org>
 <BYAPR02MB48866E2D82D9C76ABBECA842DE760@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ffe58977-f251-df34-4bd0-62e32f78cc1a@linaro.org>
 <SN6PR02MB48953397AA553FA7456E7CFCDE700@SN6PR02MB4895.namprd02.prod.outlook.com>
 <BYAPR02MB488640DD7CC887E5FCC0F167DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAFEAcA-TpZfqbWjGX-tD0Osapt_K4yuTBg6+B=ZxU4MuVr7omg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ffdee96f-c9dc-0281-d4bc-da53e518e020@redhat.com>
Date: Tue, 17 Dec 2019 19:41:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-TpZfqbWjGX-tD0Osapt_K4yuTBg6+B=ZxU4MuVr7omg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: GoRygTFgM5OTI9bt3GAYYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Alessandro Di Federico <ale@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Niccol=c3=b2_Izzo?= <izzoniccolo@gmail.com>,
 "nizzo@rev.ng" <nizzo@rev.ng>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 7:21 PM, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 18:16, Taylor Simpson <tsimpson@quicinc.com> wrote:
>> Question 1:
>> I see this error from checkpatch.pl
>> ERROR: Macros with complex values should be enclosed in parenthesis
>> However, there are times when the code will not compile with parenthesis.  For example, we have a file that defined all the instruction attributes.  Each line has
>> DEF_ATTRIB(LOAD, "Loads from memory", "", "")
>> So, we create an enum of all the possible attributes as follows
>> enum {
>> #define DEF_ATTRIB(NAME, ...) A_##NAME,
>> #include "attribs_def.h"
>> #undef DEF_ATTRIB
>> };
> 
> checkpatch is often right, but also often wrong,
> especially for C macros which are in the general case
> impossible to parse. If the error makes no sense, you can
> ignore it.
> 
>> Question 2:
>> What is the best source of guidance on breaking down support for a new target into a patch series?
> 
> Look at how previous ports did it.

Recent ports were system (softmmu), this is a linux-user port. The last 
architecture merged is RISCV, they did that with commit, so I'm not sure 
this is our best example on breaking down:

$ git show --stat ea10325917c8
commit ea10325917c8a8f92611025c85950c00f826cb73
Author: Michael Clark <mjc@sifive.com>
Date:   Sat Mar 3 01:31:10 2018 +1300

     RISC-V Disassembler

     The RISC-V disassembler has no dependencies outside of the 'disas'
     directory so it can be applied independently. The majority of the
     disassembler is machine-generated from instruction set metadata:

     - https://github.com/michaeljclark/riscv-meta

     Expected checkpatch errors for consistency and brevity reasons:

     ERROR: line over 90 characters
     ERROR: trailing statements should be on next line
     ERROR: space prohibited between function name and open parenthesis '('

     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Signed-off-by: Michael Clark <mjc@sifive.com>

  include/disas/bfd.h |    2 +
  disas.c             |    2 +
  disas/riscv.c       | 3048 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  disas/Makefile.objs |    1 +
  4 files changed, 3053 insertions(+)

$ git show --stat 55c2a12cbcd3d
commit 55c2a12cbcd3d417de39ee82dfe1d26b22a07116
Author: Michael Clark <mjc@sifive.com>
Date:   Sat Mar 3 01:31:11 2018 +1300

     RISC-V TCG Code Generation

     TCG code generation for the RV32IMAFDC and RV64IMAFDC. The QEMU
     RISC-V code generator has complete coverage for the Base ISA v2.2,
     Privileged ISA v1.9.1 and Privileged ISA v1.10:

     - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
     - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
     - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10

     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
     Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
     Signed-off-by: Michael Clark <mjc@sifive.com>

  target/riscv/instmap.h   |  364 ++++++++++++++++++++++++++++++++++++++
  target/riscv/translate.c | 1978 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 2342 insertions(+)

$ git show --stat 47ae93cdfed
commit 47ae93cdfedc683c56e19113d516d7ce4971c8e6
Author: Michael Clark <mjc@sifive.com>
Date:   Sat Mar 3 01:31:11 2018 +1300

     RISC-V Linux User Emulation

     Implementation of linux user emulation for RISC-V.

     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
     Signed-off-by: Michael Clark <mjc@sifive.com>

  linux-user/riscv/syscall_nr.h     | 287 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  linux-user/riscv/target_cpu.h     |  18 +++++++++++++
  linux-user/riscv/target_elf.h     |  14 ++++++++++
  linux-user/riscv/target_signal.h  |  23 ++++++++++++++++
  linux-user/riscv/target_structs.h |  46 ++++++++++++++++++++++++++++++++
  linux-user/riscv/target_syscall.h |  56 
++++++++++++++++++++++++++++++++++++++
  linux-user/riscv/termbits.h       | 222 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  linux-user/syscall_defs.h         |  13 +++++----
  target/riscv/cpu_user.h           |  13 +++++++++
  linux-user/elfload.c              |  22 +++++++++++++++
  linux-user/main.c                 |  99 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  linux-user/signal.c               | 203 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
  linux-user/syscall.c              |   2 ++
  13 files changed, 1012 insertions(+), 6 deletions(-)


> Also I thought we'd
> had a subthread on how best to split things up, but maybe I'm
> misremembering.

I remember something too, I hope you are right :P

>>   I see avr being reviewed currently.  I have mostly new files: 12 in linux-user/hexagon, and ~50 in target/hexagon.  I also need to add test cases and a container for the toolchain.  Is it OK to break things down mostly at file boundaries?
> 
> No, file boundaries are generally a bad choice of breakdown.
> You want to split at conceptual boundaries, ie one chunk
> of functionality that can be comprehended in one go without
> having to refer forward to other patches.
> 
> thanks
> -- PMM
> 


