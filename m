Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBE4C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4450920868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qN1iIgI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4450920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmyB-0000JX-L3
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:37:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTmvL-0006l8-O3
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTmvK-00088v-HA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:34:19 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:39090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTmvK-000872-Bk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:34:18 -0400
Received: by mail-yw1-xc44.google.com with SMTP id w21so2190730ywd.6
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=r0PfXHyRkf4cFZJ3uttHehzVtAcxUwDcDEweCp+N9lw=;
	b=qN1iIgI+50tP7QSZbS3EtZQAWvI5QUGJcQSu1tZa4T5cOxSYim6sJkcqsQISLse6mM
	2eOv4tzAVIG7VFUgamm3BH8tGF4HQx4PrBGe/p8pZXKfgxqhjVWMKwQNWYWh8fmGI4BL
	keY807n/7mXJZ8h1POPu1VRWTMrQVkKM0uaqVHXCDjbj+vprg5xSlwj7jXTvKhYk7yQw
	PZD1kOnkP0EgcFA2wgbKgz5HICFuzSwNsI7pxEw/vovzNZ4/jfNBvQ1P5W3juOeKr7N7
	WbdzOXx6A9aFbTYeBoEObmIa31tL1ySmm9cFPdHz37bY+IksTbAy/SpO4tcR76t5i2Dd
	8jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=r0PfXHyRkf4cFZJ3uttHehzVtAcxUwDcDEweCp+N9lw=;
	b=lsqI3fIMb/kjge53vQsB2Appzg7J6dHhDyEcJ3rN2tO5SDcEeemd0GFx/JtbXUOYam
	Pl2yFMKg6x2HwoSyBCiOKlEvt7wQuGUJaYcBCEcd/Ks3whZnliOeC7JRkfGcUbYmBg1p
	1Lb3rfxao4FJgXbSPEMKdn2NjbUPSNlykrvjRpMhDbJO3oXlQGD50p9pmii1ZfGfZ9Pp
	IjkrcQ8gaLJHYX0p6jip0H82n/JFj6lX0F4X0LYfCA8mJxDsMBD5D+0jhSgSIttoKkBm
	KHxM2jgzf9sybwGzItE5Fg6UqBeJFB6dfM5Wz+IPS51YegIIWhXsIyINPhlUPESripzl
	4/MA==
X-Gm-Message-State: APjAAAWp4XQk9vq5sF+pvl52XaXNvzRbJ6IFwDzC+ua2KepiunDY8faI
	uhULGT2PnDW2yp2IbOHmixY7Ng==
X-Google-Smtp-Source: APXvYqzAPk5Rf01sqFIj2GO0odO///5pRUzYrR0EUr89J4lXDJd0p2bbZjsSOUeDQtyFpi3oPJte+w==
X-Received: by 2002:a81:128f:: with SMTP id 137mr46678078yws.164.1558614856168;
	Thu, 23 May 2019 05:34:16 -0700 (PDT)
Received: from [10.240.8.143] ([71.46.56.63]) by smtp.gmail.com with ESMTPSA id
	f206sm7611995ywf.77.2019.05.23.05.34.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 05:34:15 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-4-richard.henderson@linaro.org>
	<aa0fbb17-ca7e-b9d7-fe3b-b6ae27edd35f@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e300db92-9121-b8c7-1223-e2a2d61c1d15@linaro.org>
Date: Thu, 23 May 2019 08:34:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aa0fbb17-ca7e-b9d7-fe3b-b6ae27edd35f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: Re: [Qemu-devel] [PATCH 3/3] capstone: Enable disassembly for s390x
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 4:27 AM, David Hildenbrand wrote:
> On 23.05.19 04:42, Richard Henderson wrote:
>> Enable s390x, aka SYSZ, in the git submodule build.
>> Set the capstone parameters for both s390x host and guest.
>> Install a skipdata hook to keep capstone in sync with the
>> instruction stream for unknown opcodes.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  Makefile           |  1 +
>>  disas.c            | 40 ++++++++++++++++++++++++++++++++++++++++
>>  target/s390x/cpu.c |  4 ++++
>>  3 files changed, 45 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 155f066a20..a37e872825 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -477,6 +477,7 @@ CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
>>  CAP_CFLAGS += -DCAPSTONE_HAS_ARM
>>  CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
>>  CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
>> +CAP_CFLAGS += -DCAPSTONE_HAS_SYSZ
>>  CAP_CFLAGS += -DCAPSTONE_HAS_X86
>>  
>>  subdir-capstone: .git-submodule-status
>> diff --git a/disas.c b/disas.c
>> index 41ad0102e2..c1ecd2d769 100644
>> --- a/disas.c
>> +++ b/disas.c
>> @@ -179,6 +179,39 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
>>     to share this across calls and across host vs target disassembly.  */
>>  static __thread cs_insn *cap_insn;
>>  
>> +/*
>> + * The capstone library always skips 2 bytes for S390X.
>> + * This is less than ideal, since we can tell from the first two bits
>> + * the size of the insn and thus stay in sync with the insn stream.
>> + */
>> +static size_t CAPSTONE_API
>> +cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
>> +                      size_t offset, void *user_data)
>> +{
>> +    size_t ilen;
>> +
>> +    /* See get_ilen() in target/s390x/internal.h.  */
>> +    switch (code[offset] >> 6) {
>> +    case 0:
>> +        ilen = 2;
>> +        break;
>> +    case 1:
>> +    case 2:
>> +        ilen = 4;
>> +        break;
>> +    default:
>> +        ilen = 6;
>> +        break;
>> +    }
>> +
>> +    return ilen;
> 
> return (code[offset] >> 6) << 1; ?

Doesn't work for 1.  Anyway, with the comment I wanted to match get_ilen() exactly.


r~

