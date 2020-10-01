Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4117BC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CBA20780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 19:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2fTmqT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CBA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO4g4-0006Jw-FF
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 15:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO4ee-0005lG-5l
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 15:54:16 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO4eY-0005rG-L2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 15:54:14 -0400
Received: by mail-oi1-x243.google.com with SMTP id 185so6890513oie.11
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FIiMlwa+CEKj+QiLXG4kK4OYHDirOmqDxqyURsN9uFg=;
 b=u2fTmqT4PAww9FFcg7gGnENNXmXSkuI/NU39vDYDjWKU9f75kGbmlOBWxBmUJtoFfc
 unLREX1rz0yLS7zDO07Tw3Gail7pvuMogCamGakQLlgg/iMqsBoSaDMjEP79f1UTW3DS
 r4fq0Ln9Fsaeq+Cu1QTi5m6mnV1cOShmyqkA5NXzHDc6uvMTTEdPR9XXj5L6KhKFSp+6
 w2RD2CdOq1MTMsrq0+lez1UpN/I5JRP9fXncXIyuG1w0UeZW68t2uaLpekHHGcutKdzJ
 6YrJ5AC0mOhx4buyiQH1u+4cwRMqYNkrEc1SY8s21UlshR87ZrAKVzyzY9UksT5G2NRM
 TaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FIiMlwa+CEKj+QiLXG4kK4OYHDirOmqDxqyURsN9uFg=;
 b=hbZtLr+4tnb+6IfEB4aVMbYPX2N279ZJFnaJAN8A/H+LVTU/pUGcp6yJ9bVWy9mTO4
 INFfd4EHJuX53FtQckUakdmkm+mBYHGO1qFIDlmm2naSoeDgBm1klOH786R12XawAKFc
 aQB6WXBSGSG/LJrKOAF9lib65N6r9dVyzBOCyjmBxJcVm0bQChPD/SGKoeq9pfB6Dr9S
 h3aFZ0yH9aByY6B/y1mdEhqR6fEbHVAwGTrpUZMBEq+t6vJSPrxnPs3ORPR0SUF7Lufg
 sxWQI1U3tzFdTocZ+iwdSLvihfCxv0f9KKV5BylS6pWc5cpJ4oyEr0AQmJeqPXRV1qAt
 tizQ==
X-Gm-Message-State: AOAM533vAzMIFi/5glOGEaVMc0CwddC9l0frTaJrCJEHTsRFJ6cRVnWR
 +YmNDpv4Sk+hzpFKLM+1rjM4Tw==
X-Google-Smtp-Source: ABdhPJxl6QxvoO5Z960qMeldoGeRh41xTbQ5c4EXNhrlWNs2tZyi2JT2wRS93Zdj40bI7lh8kdRJeA==
X-Received: by 2002:aca:d409:: with SMTP id l9mr979417oig.70.1601582043828;
 Thu, 01 Oct 2020 12:54:03 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id m12sm1473004otq.8.2020.10.01.12.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 12:54:02 -0700 (PDT)
Subject: Re: [RFC PATCH v4 19/29] Hexagon (target/hexagon) generator phase 3 -
 C preprocessor for decode tree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-20-git-send-email-tsimpson@quicinc.com>
 <a4da7010-474f-6df3-a74a-2966c44df931@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5502293e-face-7b06-3077-9c446ac6b0b9@linaro.org>
Date: Thu, 1 Oct 2020 14:54:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4da7010-474f-6df3-a74a-2966c44df931@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 6:37 AM, Philippe Mathieu-Daudé wrote:
> On 9/28/20 7:28 PM, Taylor Simpson wrote:
>> Run the C preprocessor across the instruction definition and encoding
>> files to expand macros and prepare the iset.py file.  The resulting
>> fill contains python data structures used to build the decode tree.
>>
>> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
>> ---
>>  target/hexagon/gen_dectree_import.c | 191 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 191 insertions(+)
>>  create mode 100644 target/hexagon/gen_dectree_import.c
>>
>> diff --git a/target/hexagon/gen_dectree_import.c b/target/hexagon/gen_dectree_import.c
>> new file mode 100644
>> index 0000000..237726e
>> --- /dev/null
>> +++ b/target/hexagon/gen_dectree_import.c
>> @@ -0,0 +1,191 @@
>> +/*
>> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +/*
>> + * This program generates the encodings file that is processed by
>> + * the dectree.py script to produce the decoding tree.  We use the C
>> + * preprocessor to manipulate the files imported from the Hexagon
>> + * architecture library.
>> + */
>> +#include "qemu/osdep.h"
>> +#include "opcodes.h"
>> +
>> +#define STRINGIZE(X)    #X
>> +
>> +const char *opcode_names[] = {
> 
> Richard will probably ask to use "const char *const opcode_names[]".

It is good practice, even if this is a generator and so doesn't actually impact
the qemu executable itself.  ;-)


>> +const char *opcode_syntax[XX_LAST_OPCODE];
>> +
>> +/*
>> + * Process the instruction definitions
>> + *     Scalar core instructions have the following form
>> + *         Q6INSN(A2_add,"Rd32=add(Rs32,Rt32)",ATTRIBS(),
>> + *         "Add 32-bit registers",
>> + *         { RdV=RsV+RtV;})
>> + */
>> +void opcode_init(void)
>> +{
>> +#define Q6INSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
>> +   opcode_syntax[TAG] = BEH;
>> +#define EXTINSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
>> +   opcode_syntax[TAG] = BEH;
>> +#include "imported/allidefs.def"
>> +#undef Q6INSN
>> +#undef EXTINSN
>> +}

What is it that about this case that can't be initialized at compile time?


r~

