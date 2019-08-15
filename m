Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED2CC31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0D821855
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqkdqm6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0D821855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyCUW-0007Cp-Lx
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hyCTj-0006Kg-8v
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hyCTi-0001rk-5i
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hyCTh-0001qc-VD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so784327wmj.5
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GTCBA1nemiW0D/ETX2R5+GasjrENeLfDdirLiRnqDMk=;
 b=aqkdqm6JH9UJ+w7Uuz33NecPhjxvukQjJ5O4b/M5mSUM6zIWCIC42X/T7scj9DJ8U0
 15zCYtAgnpgca/RcmcCHK8VGRBbsR7P81m17WXdBFXUiJhfP7A3LanycFfcOh/DPoP/7
 FSBE/ERG3Ohe0PXtfR93xdZpe5/PYLCMZeyGaVBX0Cdq2OBivvDjzufdLnecwFr7zgyN
 7ba/otVRrlJdm244nD4k3+oIQ5ou5lUkXkvsAVQfmvdaCfJ2mS3gWtfx5os7RhgCMnIM
 ADxnPCn0Too5NdMEkzcc/IIilw0wJDfASgp4Zc7YVtqha2lcr8oe44cuOs1IQK5IaChw
 jN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GTCBA1nemiW0D/ETX2R5+GasjrENeLfDdirLiRnqDMk=;
 b=Xk8w/mTcw/4TgA+DGs+JdQVbFDzf0pQzO0eL6gNPcvhfi8sq+3xvMsN1CC+k6Quata
 /OnVLrV77tFbMrqc0q3RfgfgqjkFczWNrgNQPCDkVq1UOAo4yf5DXWRqlM5homtmrYJB
 rUJ5yY7QnFNCgRwzywpCq8Ka89Cyft94yvqK5nKsxMLSdLsFi+pS0sqUoHouKXNV2qJh
 nxMW2rCOEPzR4Ro/ZyuHE+g6ERA2Hx12EVWHCeual9bTjnW27IG5FLk4y8PQnwPJXtGz
 6oNUw7s9ViRGIcAbOFzQjg3XVIqgvgLoeQLtyqb8Gd9c1qW8xlP2+YZvObz6dXy+7Drp
 BURA==
X-Gm-Message-State: APjAAAVtMlbiDGVoJAOaaIz8xNwIsIysgejZ0kaX/L1PFL1POG/Ujv2A
 7FoIgr7qanAE3ST9wx7EsOcR2+BYw7kjKA==
X-Google-Smtp-Source: APXvYqxhUXFG3n/EoY2kmU4SjpPOSfjrJxEyBSoaBHQ3VzuzdC4J1tdgSM0p6avks132SPq2XTvhAA==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr1908038wmc.117.1565862928766; 
 Thu, 15 Aug 2019 02:55:28 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id b3sm3394360wrm.72.2019.08.15.02.55.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Aug 2019 02:55:28 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Jan Bobek <jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-3-jan.bobek@gmail.com>
 <CAL1e-=j9eDuFSspcUx3oac3UFvY7-N4rYOwVvQ2eSvc9DnbC=A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8a3988c7-5cca-d6b9-2be9-84cfe4b59f9f@linaro.org>
Date: Thu, 15 Aug 2019 10:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=j9eDuFSspcUx3oac3UFvY7-N4rYOwVvQ2eSvc9DnbC=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH v3 02/46] target/i386: Push rex_w into
 DisasContext
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
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/15/19 8:30 AM, Aleksandar Markovic wrote:
> 
> 15.08.2019. 04.13, "Jan Bobek" <jan.bobek@gmail.com
> <mailto:jan.bobek@gmail.com>> је написао/ла:
>>
>> From: Richard Henderson <rth@twiddle.net <mailto:rth@twiddle.net>>
>>
>> Treat this the same as we already do for other rex bits.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net <mailto:rth@twiddle.net>>
>> ---
>>  target/i386/translate.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index d74dbfd585..c0866c2797 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -44,11 +44,13 @@
>>  #define REX_X(s) ((s)->rex_x)
>>  #define REX_B(s) ((s)->rex_b)
>>  #define REX_R(s) ((s)->rex_r)
>> +#define REX_W(s) ((s)->rex_w)
>>  #else
>>  #define CODE64(s) 0
>>  #define REX_X(s) 0
>>  #define REX_B(s) 0
>>  #define REX_R(s) 0
>> +#define REX_W(s) -1
> 
> The commit message says "treat rex_w the same as other rex bits". Why is then
> REX_W() treated differently here?

"Treated the same" in terms of being referenced by a macro instead of a local
variable.  As for the -1, if you look at the rest of the patch you can clearly
see it preserves existing behaviour.

>> @@ -4503,6 +4504,7 @@ static target_ulong disas_insn(DisasContext *s,
> CPUState *cpu)
>>      s->rex_x = 0;
>>      s->rex_b = 0;
>>      s->rex_r = 0;
>> +    s->rex_w = -1;
>>      s->x86_64_hregs = false;
>>  #endif
>>      s->rip_offset = 0; /* for relative ip address */
>> @@ -4514,7 +4516,6 @@ static target_ulong disas_insn(DisasContext *s,
> CPUState *cpu)
>>      }
>>
>>      prefixes = 0;
>> -    rex_w = -1;


r~

