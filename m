Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91368C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5713420836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkaauq+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5713420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYtr-0007Id-Hp
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:52:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYt4-0005y5-7E
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUYsh-0004gw-7j
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:51:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:45098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYsg-0004gP-OS
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:51:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id u22so3818425plq.12
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mARvklzeUeMu/pTX9xunWoyb8aEjGx/kZ3Iw4AknXUo=;
 b=wkaauq+sK1Au9fAAcCEvHgfuOn5BHEh51C9MYeMAxLWX6kPKGsM5Ois8M5iTwdEcgv
 jLeSkEjEZ4KeY76qnvxi1pvPM6rdFpwzf6Zc6CrtqYR2i1r0jbe/aXMV9xqqfNl2fcKR
 qqn4YOTPdO3d+jIy98DiHT2e1poks0PbRYkNUN7oI/kAriaw3V8VmFy2gIOam7m+OsfU
 H5/PHOxOEVy28By2dZi9jSlcKJ/iKf20jJodLwxNRgw6w3rz7Oif+tVnhKNqb9MVfReK
 RH+DMHmjK/IJQyzmt9VhS3ZBmYBcdozhJ+5c/C1+3lJ2PjrrOfrJQ4YC9ZEOzgcKPxLG
 E0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mARvklzeUeMu/pTX9xunWoyb8aEjGx/kZ3Iw4AknXUo=;
 b=UH4Z2YuceELWe3Eb06M0FruIF5/Cvt54DHOcfBDqVz4M8EFFa4NL+OcTptFpCECUQC
 dZGKy3U88wwjYksq5luBw1eaCYFZd64reqg4tHIFfbMPRNH1+cSE+uLeQQnZOe+eeHvA
 9m8P6uMmPhJjoedLozEqbKklzxJkgi9QpqDiNuVgVdWnKxPImTx59sDqKa37alTtOSAK
 UwTDSg+NTK1tsM8SdTD109Wuosi6RVFiuCFdwLJDCFbfN+srstYFiTQB0a9BhD6dFsv7
 /5rf/BFMKrsglmLfU/2YwwmRtoMRa82Q4Q1rgiFIZ4hCjzHAffK2OFJsKvxwSSGHI+sL
 0uFg==
X-Gm-Message-State: AGi0PubC4E3pClTwPzAkOiOuF5lrw7b+miF3hlYADEKGJgEDrA1iebtJ
 EZTs2fp2eDNKilJqoXC5kGpg+Q==
X-Google-Smtp-Source: APiQypILHUwcK9kBzcPqlB88G/WRa8m7d151sdusr93eEkpbqJey49VuEKyfRi/f8ydnuZPqn2JSgA==
X-Received: by 2002:a17:90a:3450:: with SMTP id
 o74mr507690pjb.159.1588351877102; 
 Fri, 01 May 2020 09:51:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a142sm2686505pfa.6.2020.05.01.09.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 09:51:16 -0700 (PDT)
Subject: Re: About hardfloat in ppc
To: luoyonggang@gmail.com
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
 <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <FEA0FBA9-F5B7-4995-A2F3-5D8053637379@gmail.com>
 <CAE2XoE_N_oWJwwGVfh+9mOh3dYR6JXk5XJKzv8fr2A4iE9h1OA@mail.gmail.com>
 <alpine.BSF.2.22.395.2005011347390.29385@zero.eik.bme.hu>
 <CAE2XoE-0=SgjeXddZXDOYPeUC1xsD5V=A5xBoa1yHS8gL2=MQg@mail.gmail.com>
 <874kszkdhm.fsf@linaro.org> <d84e50f5-493e-7c8a-bf39-c94c18875171@linaro.org>
 <CAE2XoE-W=v5ifho_ze3Xg2Fx1v+VtQ_KvWSf7AuXns5ZYoRoTg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <851c309c-37f2-ea4a-b471-52bddde527c7@linaro.org>
Date: Fri, 1 May 2020 09:51:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-W=v5ifho_ze3Xg2Fx1v+VtQ_KvWSf7AuXns5ZYoRoTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::62b
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
Cc: Dino Papararo <skizzato73@msn.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 9:29 AM, 罗勇刚(Yonggang Luo) wrote:
> On Fri, May 1, 2020 at 10:18 PM Richard Henderson <richard.henderson@linaro.org
>     Step 1 is to rearrange the fp helpers to eliminate helper_reset_fpstatus().
>     I've mentioned this before, that it's possible to leave the steady-state of
>     env->fp_status.exception_flags == 0, so there's no need for a separate function
>     call.  I suspect this is worth a decent speedup by itself.
> 
> Hi Richard, what kinds of rearrange the fp need to be done? Can you give me a
> more detailed example? I am still not get the idea.

See target/openrisc, helper_update_fpcsr.

This is like target/ppc helper_float_check_status, in that it is called after
the primary fpu helper, after the fpu result is written back to the
architectural register, to process fpu exceptions.

Note that if get_float_exception_flags returns non-zero, we immediately reset
them to zero.  Thus the exception flags are only ever non-zero in between the
primary fpu operation and the update of the fpscr.

Thus, no need for a separate helper_reset_fpstatus.


r~

