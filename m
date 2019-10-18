Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C574CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006DE20640
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSTT44Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006DE20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXQk-0005eg-V8
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXMp-000272-Uk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXMn-0004gr-F2
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:51 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLXMn-0004g4-5G
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:52:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id y72so4402317pfb.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oTQ4y+ThlrWd/7Ox/7y1BuZvuF3RUt7kNzxcufjgRik=;
 b=OSTT44YuMhNovw+OCnXgKf1Qw859Pf2kp9oCs+g6h6sIXn4hZ2Rzqch1fbhunV8uub
 uptxTEgpZ+v/Uj6cxCvV8Kd6X41p3nwo7agIsJFWT8UCwaMhpcnaAZcrYEk0UUwdI76H
 wTRSprfh2H+SHBJr+6hamj9v4JZtyCu75KAJ1Xuy5zSa8r3UbDZRhj5ge6OBSxgSE1VS
 J3S/VVV+jWg62Or4Y1HnR5BYGwE2kTzUopX81le29X0iKMkSzuqGdimrXotYXhfHQuPx
 ZYIvO7djkUD1+IaEv21kfLZq6YyuXKYmyT6DX699Zwsq3GXkAzSiWEmiNt30Cy8lCLz+
 1xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oTQ4y+ThlrWd/7Ox/7y1BuZvuF3RUt7kNzxcufjgRik=;
 b=eq8GZaHzccQzaUapH/CWIe/Lc3McXY65MIPt4/D2+Sa8OvhkFZVZDt6NDy1t9sFFsV
 t4Dw9pfFv2lGe0AksU3IXx+tvsuBEbG9EToOLNYTiib5whzrFFN2UhH3tU8crDO7RiC0
 xSf498PTM0DmK1CdvsgBUe3USjJW74apOXE4ykpXBYeWXqivOy+oqM6HnEj58t7NMUO4
 jDS3D88kP4/TBhujQsT72b1cEqR42Qr1xoVgo4Jj0F+MJ1phgQvapC1ptxFW+Woowk7/
 NlkceZO+bmwp+tDCMIiLnVpj0bPSjIxcD29rgYGgZCFYpbyuhF/Km2BpAu0qTz5DsdI2
 wnlw==
X-Gm-Message-State: APjAAAUBnkb3vTmuMtUZC2lK8kFw+TziF7FU3LOiUtJuhsz/Mrh9FFpG
 vRD6sUTlJ6YDHL4pzntM19A9Sg==
X-Google-Smtp-Source: APXvYqy0rFeVJkwis3E7hUBf/TBBL/VOAsaHcqJaWwDK4p5u1igHjcVwCmg3nu/sInkhaEDsVCHiTA==
X-Received: by 2002:a62:38d5:: with SMTP id f204mr8564645pfa.100.1571424766913; 
 Fri, 18 Oct 2019 11:52:46 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c11sm9674085pfj.114.2019.10.18.11.52.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 11:52:46 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] s390x/tcg: Fix VECTOR SUBTRACT COMPUTE BORROW
 INDICATION
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-5-david@redhat.com>
 <d12a5c30-1953-7586-97d4-883131ac0b40@redhat.com>
 <be613a08-a62e-c10d-5c5d-8b334e8f0985@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <567b4675-6d94-8255-d3f7-0edf1e4928f9@linaro.org>
Date: Fri, 18 Oct 2019 11:52:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <be613a08-a62e-c10d-5c5d-8b334e8f0985@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 11:18 AM, David Hildenbrand wrote:
> On 18.10.19 19:41, David Hildenbrand wrote:
>> On 18.10.19 18:10, David Hildenbrand wrote:
>>> Looks like my idea of what a "borrow" is was wrong. We are dealing with
>>> unsigned numbers. A subtraction is simply an addition with the bitwise
>>> complement. If we get a carry during the addition, that's the borrow.
>>> "The operands are treated as unsigned binary integers."
>>>
>>> This is nice, as we can reuse the VECTOR ADD COMPUTE CARRY functions
>>> and avoid helpers, all we have to do is compute the bitwise complement.
>>>
>>> Fixes: 1ee2d7ba72f6 ("s390x/tcg: Implement VECTOR SUBTRACT COMPUTE BORROW
>>> INDICATION")
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    target/s390x/helper.h           |  2 --
>>>    target/s390x/translate_vx.inc.c | 45 ++++++++++++++++++++++++---------
>>>    target/s390x/vec_int_helper.c   | 16 ------------
>>>    3 files changed, 33 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>>> index 56e8149866..ca1e08100a 100644
>>> --- a/target/s390x/helper.h
>>> +++ b/target/s390x/helper.h
>>> @@ -207,8 +207,6 @@ DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void,
>>> ptr, cptr, cptr, i32)
>>>    DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>>>    DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>>>    DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>>> -DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>>> -DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>>>    DEF_HELPER_4(gvec_vtm, void, ptr, cptr, env, i32)
>>>       /* === Vector String Instructions === */
>>> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
>>> index 5ce7bfb0af..40bcc1604e 100644
>>> --- a/target/s390x/translate_vx.inc.c
>>> +++ b/target/s390x/translate_vx.inc.c
>>> @@ -2130,14 +2130,40 @@ static DisasJumpType op_vs(DisasContext *s, DisasOps
>>> *o)
>>>        return DISAS_NEXT;
>>>    }
>>>    +static void gen_scbi8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
>>> +{
>>> +    TCGv_i64 t = tcg_temp_new_i64();
>>> +
>>> +    tcg_gen_not_i64(t, b);
>>> +    gen_acc(d, a, t, ES_8);
>>> +    tcg_temp_free_i64(t);
>>> +}
>>
>> BTW, I would have thought that we need the 2nd complement in all these
>> cases. However, the description of the other functions confused me
>> (VECTOR SUBTRACT WITH BORROW INDICATION) - add bitwise complement and
>> add the borrow.
>>
>> This passes my test cases (that are verified against real HW), but I am
>> not sure if I check all the corner cases.
>>
>> @Richard, do you have any idea how to do it the right way for this
>> instruction?
>>
> 
> My impression was right. A simple "0-0" test makes this visible. The other two
> fixes seem to be correct, though.

Your description seems to indicate that you want carry output, which is
!borrow.  ARM represents things this way, but I didn't recall it for S390.

If you want to implement sub r,x,y with add r,x,~y, you also have to add one --
often times with the carry-in.  But since we don't have a carry-in here, I
wonder if it isn't easier to invert your result:

     tcg_gen_sub2_i64(tl, th, al, zero, bl, zero);
     tcg_gen_andi_i64(th, th, 1);
     tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
     tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
-    tcg_gen_andi_i64(dl, th, 1);
+    /* "invert" the result: -1 -> 0; 0 -> 1 */
+    tcg_gen_addi_i64(dl, th, 1);


r~

