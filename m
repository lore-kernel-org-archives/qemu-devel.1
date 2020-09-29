Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9722AC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2412D23B28
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG3YAhYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2412D23B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDtL-00063f-BZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNDrH-0004kt-5j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:31:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNDrF-0006rQ-Du
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:31:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id e17so4259599wme.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q2SQy4mHgOjFf0lIv3zdyqk0dWnM2cTHovCUiI5p1rM=;
 b=JG3YAhYSVmpdOM3PjE5Ie/wlT3UBMV/9TNWnG0enINjvrfXZFz4GW+QQVwuBS8+kJC
 C9VsiLcWxLsvKyHIYa9ArZiJMVAXRz9q8d2vVDBxHzjVWZH9ITQH3wsUCGcoOR7omwxW
 m3G9IQIDzUj+uyLRD6fAhZblGmhDOUbfSogZlW3x1o783v8m8vgiQuWeLNyjrGbYWJK7
 a1vJPmgJApM2G15O9BF3Y/fM5pJNQz3uYkcgg55rp5nMU52NmcIoG8GY5BZWPw+pwEhd
 d5wJnmgSIVkR7KcZmxdJdVbwT1T1COdVzZzEfjJeA5P5G3jK4Aa2Jocfu7xjbt2RB0iM
 dH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q2SQy4mHgOjFf0lIv3zdyqk0dWnM2cTHovCUiI5p1rM=;
 b=HKBMTBdVmHv1y4YtS8NdL2i3RctsCN/czb4nAE6Lzl/YICg67CJOV98Kk4hKZ2aXd2
 uSBU4RlEtC3NkRFTCLazaZ4ykcr5RETNMd1hlTqafYizAhHrUHO5C/SrZ6u+SMwcr4nT
 rw4F7pR5dmD8NVd98WNJ99yAvMh9Uv60KTjvzToNdu+oYHXcZNGTCwBOIzxl3rTwSfP1
 ILtDykFlnwG/cOyRVMhtQKtReAVPqCYayPVlsUepNNu5ad1Lu5zBUAlwSg7LnpIW20y4
 MItX6M7suv2wkNpUIkAx9d2dnptA0c9thLNBXQt08zTgE7Z+LsruZpj0piEGwLu8f4w/
 UnfA==
X-Gm-Message-State: AOAM532/3OPtm/lyuVnWA/1LcuXOpM/OpPkHbnpewx+LHED+Op6bCdVI
 9lfZQjdd/vU/pGhL06kybgU=
X-Google-Smtp-Source: ABdhPJyaIQh3HkkzytsVOUWVXnPgbvAJt58IbN2n1guHi8o1WSbqofzatiM0UPNlgwyYTpPNRhI53g==
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr4257632wmm.102.1601379103671; 
 Tue, 29 Sep 2020 04:31:43 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b188sm10880879wmb.2.2020.09.29.04.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 04:31:43 -0700 (PDT)
Subject: Re: [RFC PATCH v4 17/29] Hexagon (target/hexagon) generator phase 1 -
 C preprocessor for semantics
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-18-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4dc60a7a-99fd-9649-b8ae-8ce2f719ec47@amsat.org>
Date: Tue, 29 Sep 2020 13:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601314138-9930-18-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:28 PM, Taylor Simpson wrote:
> Run the C preprocessor across the instruction definition files and macro
> definitoin file to expand macros and prepare the semantics_generated.pyinc

Typo "definition".

> file.  The resulting file contains one entry with the semantics for each
> instruction and one line with the instruction attributes associated with
> each macro.
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/gen_semantics.c | 88 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 target/hexagon/gen_semantics.c
> 
> diff --git a/target/hexagon/gen_semantics.c b/target/hexagon/gen_semantics.c
> new file mode 100644
> index 0000000..1b198cb
> --- /dev/null
> +++ b/target/hexagon/gen_semantics.c
> @@ -0,0 +1,88 @@
> +/*
> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
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
> +/*
> + * This program generates the semantics file that is processed by
> + * the do_qemu.py script.  We use the C preporcessor to manipulate the
> + * files imported from the Hexagon architecture library.
> + */
> +
> +#include <stdio.h>
> +#define STRINGIZE(X) #X
> +
> +int main(int argc, char *argv[])
> +{
> +    FILE *outfile;
> +
> +    if (argc != 2) {
> +        fprintf(stderr, "Usage: gen_semantics ouptputfile\n");
> +        return -1;

Exit code is in [0-255] range. What about returning 1 instead?

> +    }
> +    outfile = fopen(argv[1], "w");
> +    if (outfile == NULL) {
> +        fprintf(stderr, "Cannot open %s for writing\n", argv[1]);
> +        return -1;

Ditto.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    }
> +
> +/*
> + * Process the instruction definitions
> + *     Scalar core instructions have the following form
> + *         Q6INSN(A2_add,"Rd32=add(Rs32,Rt32)",ATTRIBS(),
> + *         "Add 32-bit registers",
> + *         { RdV=RsV+RtV;})
> + */
> +#define Q6INSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
> +    do { \
> +        fprintf(outfile, "SEMANTICS( \\\n" \
> +                         "    \"%s\", \\\n" \
> +                         "    %s, \\\n" \
> +                         "    \"\"\"%s\"\"\" \\\n" \
> +                         ")\n", \
> +                #TAG, STRINGIZE(BEH), STRINGIZE(SEM)); \
> +        fprintf(outfile, "ATTRIBUTES( \\\n" \
> +                         "    \"%s\", \\\n" \
> +                         "    \"%s\" \\\n" \
> +                         ")\n", \
> +                #TAG, STRINGIZE(ATTRIBS)); \
> +    } while (0);
> +#include "imported/allidefs.def"
> +#undef Q6INSN
> +
> +/*
> + * Process the macro definitions
> + *     Macros definitions have the following form
> + *         DEF_MACRO(
> + *             fLSBNEW0,
> + *             predlog_read(thread,0),
> + *             ()
> + *         )
> + * The important part here is the attributes.  Whenever an instruction
> + * invokes a macro, we add the macro's attributes to the instruction.
> + */
> +#define DEF_MACRO(MNAME, BEH, ATTRS) \
> +    fprintf(outfile, "MACROATTRIB( \\\n" \
> +                     "    \"%s\", \\\n" \
> +                     "    \"\"\"%s\"\"\", \\\n" \
> +                     "    \"%s\" \\\n" \
> +                     ")\n", \
> +            #MNAME, STRINGIZE(BEH), STRINGIZE(ATTRS));
> +#include "imported/macros.def"
> +#undef DEF_MACRO
> +
> +    fclose(outfile);
> +    return 0;
> +}
> 


