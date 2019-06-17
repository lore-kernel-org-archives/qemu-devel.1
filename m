Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C3C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 08:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B03421E6D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoqwtULV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B03421E6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcmuw-0000cS-Lb
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 04:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcmuF-0008Tj-2D
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 04:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcmuC-0000O1-8n
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 04:22:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcmuB-0000Kw-W7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 04:22:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so8046826wma.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1HXHVlAUSd+oFH5mgtGl6yrk2mxboJI2fJGSvkh2TqM=;
 b=QoqwtULVWutbYKq7GXbYoselRCphlIq84YhWR6c+uy1PZj3drscVJrk6zJPPR6ThZN
 qNGd52DodR7MJXDMx59iruNnywxfvorOE932SLB6vhu+bdPhFhLYnkQ1ISGCb4PyTMc5
 MdRPdmu+GhmxZuxvk5pw/OW2fng3kPd1A05jz/0YtpR7xq50zZNHggnbMgDGycnepDye
 1j3T6vLfD9PXPIFJyVxuDRhEopeDUVX+MuG4bt/U1ma32Tp+0NdpnVYXH6DB9kpBBfeQ
 +vxjUbQF2gKwOM+eVNDLs9Hz4vj6W5VTSwNzqNxSB4U533fK145WQuFrBq3ABXwH3Zaa
 bs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1HXHVlAUSd+oFH5mgtGl6yrk2mxboJI2fJGSvkh2TqM=;
 b=RGeJwyD90N7R4/2NMXwzyrfpzHmQEYyHn0UaEhrR2AUzLpwlURoXjLDBX/0Yzd3dOr
 C/D2wCSUyyyS+0zTQQFAzi75RbPXVOZzUzXj1UR7byayNiY7TK4ssnqhwcdVOg5vztwc
 KbhUvQ6pwXQjTV7WYBLDcKcrR12Q33llG4dn3YX403NK4VHMcrO9tut/jtCm5b6z8TjH
 HwGOsroJMAzJ5LlwGmEBgL1MoVHrCIEN/4hrcDF5zjlfSMf5Q1qBauedy43Q827oeX5Y
 tiIRpIQt55zipe3mIUG/cXHh8MpQ157p16xXQSWJnTTT6hwreNTKrTUFEWzWfujE1RUl
 nTZw==
X-Gm-Message-State: APjAAAVhmV5XjUltw1pP+aqiXYtea50MXsJCMDvBjqcYMiNv/RUB5QMz
 8qhtXNjQjkOnlwRZzv4UlGybNw==
X-Google-Smtp-Source: APXvYqw4mrzl/ZeeKWnAFHzurQGJTQF3PAZLzGgh3+CX05Hp7kgIUDqZ5qvOB9M1H6o0dhCIV/Tg3w==
X-Received: by 2002:a1c:e0c4:: with SMTP id
 x187mr16749632wmg.177.1560759737286; 
 Mon, 17 Jun 2019 01:22:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a84sm1612357wmf.29.2019.06.17.01.22.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 01:22:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 342991FF87;
 Mon, 17 Jun 2019 09:22:16 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-2-alex.bennee@linaro.org>
 <68f400ee-9186-f1f7-687d-9c96bde89c7d@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <68f400ee-9186-f1f7-687d-9c96bde89c7d@linaro.org>
Date: Mon, 17 Jun 2019 09:22:16 +0100
Message-ID: <87y320wrif.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 01/50] trace: expand mem_info:size_shift
 to 3 bits
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/14/19 10:11 AM, Alex Benn=C3=A9e wrote:
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> This will allow us to trace 16B-long memory accesses.
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> ---
>>  trace-events | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/trace-events b/trace-events
>> index 844ee58dd9..037169aab3 100644
>> --- a/trace-events
>> +++ b/trace-events
>> @@ -159,7 +159,7 @@ vcpu guest_cpu_reset(void)
>>  # Access information can be parsed as:
>>  #
>>  # struct mem_info {
>> -#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes=
 */
>> +#     uint8_t size_shift : 3; /* interpreted as "1 << size_shift" bytes=
 */
>>  #     bool    sign_extend: 1; /* sign-extended */
>>  #     uint8_t endianness : 1; /* 0: little, 1: big */
>>  #     bool    store      : 1; /* wheter it's a store operation */
>>
>
> Well, 128B-long memory accesses.  But SVE supports 256B memory accesses
> already.  So why not add one more bit now.

Good point.

Do we have any architectures that do load/stores that are not power of
2? I guess the SVE non-faulting accesses are treated as a series of elem
size accesses.

>
>
> r~


--
Alex Benn=C3=A9e

