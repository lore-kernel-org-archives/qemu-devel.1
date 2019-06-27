Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE235C48BE7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F1120659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIYq9laJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F1120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgYcJ-0003BU-S5
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgYbV-0002eP-OI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgYbU-0000te-Dd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:54:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgYbU-0000t6-4y
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:54:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so3557765wrs.5
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=DFthjlSbcZ9cCF0gVyYSQXcYtS7vlaXY7Zk15FDNZ+E=;
 b=wIYq9laJKzzf/wsAz78gPNdzaisfwebrDBlgg9PR9/O/VHkn6AaFHky4YoRejwaY4O
 7xTZuHHT8Tn62+lL5Ao/Y40LMz7+94fhI9msxHFcQJJJqPFBuzL9z0r2kUeDBIWFLMqy
 BBU42xxYokd07pSh9EUEuanLquCnBIdt7T5VC6AiJ7M0YVgY2RLBfIMX8LU58uG9TH6I
 lO3u2rHh1l2F8gxDxblS8v94cmZQSzLnKDnSVUfvFnI0m8rNXYkBkDh+6Zt4KJeB9/Ir
 //wL/uSm/wcjHk2n4jD4eXVY0p25ymGk24R8XWGookdYXwfYCwdJOYTU/ScEjjsRvTJO
 iW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=DFthjlSbcZ9cCF0gVyYSQXcYtS7vlaXY7Zk15FDNZ+E=;
 b=HhE1Y0BXPMCdVWhxzUSKd7J13dEx7uLji/4gW3i+hmXuKvUas3QNE+KVFfMvBRLbL3
 wsWMec12UZQ6EJfunc6VBCkiVfVDbFPMpBGljlgvRuuTB2L+zN7+c9Yj7VWbG343Bl9Z
 9AgQ1HI2jTdKRSv3/DOBIuw2kpq8oqmc5xVH+Ncj8YogPfeq82/M6VFRVwXJEHxYrCpr
 y8ejeN5dAg7A4k/s43Dx/Og53u7yo2XZszsYu0TdyJV6oSGu7z6pbdxDb0FFTbhT/nsa
 3/DseJthEYgWg8iC4kpiQqrRaGQHPDPSELJUjq5h/nWdBCktpjp+pKoBUJMVJwPYeljj
 QMFg==
X-Gm-Message-State: APjAAAVZ9D1mDbY8X87aYP0yvGwgp2//XW2n39lR/0myEym7gCHq/pH2
 6Ppbyu31gjusaZleulyNhEiF6g==
X-Google-Smtp-Source: APXvYqyCoxcjpJf2KT9AdqMUuFatCwGKDYmZjTKFgoCdr9JV+2r628YQIL6iKT+qOYapJkeLd3NTcw==
X-Received: by 2002:a5d:430c:: with SMTP id h12mr4289026wrq.163.1561658074241; 
 Thu, 27 Jun 2019 10:54:34 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id g8sm5291344wmf.17.2019.06.27.10.54.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 10:54:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
 <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
 <d2c1f979-7ff2-946e-4863-c1be19c5f003@ilande.co.uk>
 <16f26b7f-2435-aa05-66a3-073e8310d5c8@linaro.org>
 <0ceec012-fcdc-ccde-291a-121a4e475f86@ilande.co.uk>
 <7b1699e1-28ca-a58f-787e-c0ca11666b90@linaro.org>
 <9502af13-22b9-031e-2ba9-ec4ff75ccd0e@ilande.co.uk>
 <cd1a0635-5b5d-3c2d-dec3-4ceda8c789f9@ilande.co.uk>
 <0d6d9b35-4c4a-a04d-76b5-eca089ade29c@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2903e103-bb1f-cc68-3a1f-cebef2590684@linaro.org>
Date: Thu, 27 Jun 2019 19:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0d6d9b35-4c4a-a04d-76b5-eca089ade29c@linaro.org>
Content-Type: multipart/mixed; boundary="------------4136C17C2991C11D935B237C"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------4136C17C2991C11D935B237C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 6/27/19 7:51 PM, Richard Henderson wrote:
> Please try the following patch on top and if it works I'll split it back into
> the patch set properly.

Dangit.  I generated the patch on the wrong machine.
Let's try that again.


r~

--------------4136C17C2991C11D935B237C
Content-Type: text/plain; charset=UTF-8;
 name="z"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="z"

ZGlmZiAtLWdpdCBhL3RjZy9wcGMvdGNnLXRhcmdldC5pbmMuYyBiL3RjZy9wcGMvdGNnLXRh
cmdldC5pbmMuYwppbmRleCA2Y2M1NmNmLi5lOTI5ZGYzIDEwMDY0NAotLS0gYS90Y2cvcHBj
L3RjZy10YXJnZXQuaW5jLmMKKysrIGIvdGNnL3BwYy90Y2ctdGFyZ2V0LmluYy5jCkBAIC0x
MTMyLDcgKzExMzIsNyBAQCBzdGF0aWMgdm9pZCB0Y2dfb3V0X21lbV9sb25nKFRDR0NvbnRl
eHQgKnMsIGludCBvcGksIGludCBvcHgsIFRDR1JlZyBydCwKICAgICAgICAgYWxpZ24gPSAz
OwogICAgICAgICAvKiBGQUxMVEhSVSAqLwogICAgIGRlZmF1bHQ6Ci0gICAgICAgIGlmIChy
dCAhPSBUQ0dfUkVHX1IwKSB7CisgICAgICAgIGlmIChydCA+IFRDR19SRUdfUjAgJiYgcnQg
PCAzMikgewogICAgICAgICAgICAgcnMgPSBydDsKICAgICAgICAgICAgIGJyZWFrOwogICAg
ICAgICB9CkBAIC0xMTYxLDcgKzExNjEsNyBAQCBzdGF0aWMgdm9pZCB0Y2dfb3V0X21lbV9s
b25nKFRDR0NvbnRleHQgKnMsIGludCBvcGksIGludCBvcHgsIFRDR1JlZyBydCwKICAgICAg
ICAgfQogICAgICAgICB0Y2dfZGVidWdfYXNzZXJ0KCFpc19pbnRfc3RvcmUgfHwgcnMgIT0g
cnQpOwogICAgICAgICB0Y2dfb3V0X21vdmkocywgVENHX1RZUEVfUFRSLCBycywgb3JpZyk7
Ci0gICAgICAgIHRjZ19vdXQzMihzLCBvcHggfCBUQUIocnQsIGJhc2UsIHJzKSk7CisgICAg
ICAgIHRjZ19vdXQzMihzLCBvcHggfCBUQUIocnQgJiAzMSwgYmFzZSwgcnMpKTsKICAgICAg
ICAgcmV0dXJuOwogICAgIH0KIApAQCAtMTE4Miw3ICsxMTgyLDcgQEAgc3RhdGljIHZvaWQg
dGNnX291dF9tZW1fbG9uZyhUQ0dDb250ZXh0ICpzLCBpbnQgb3BpLCBpbnQgb3B4LCBUQ0dS
ZWcgcnQsCiAgICAgICAgIGJhc2UgPSByczsKICAgICB9CiAgICAgaWYgKG9waSAhPSBBRERJ
IHx8IGJhc2UgIT0gcnQgfHwgbDAgIT0gMCkgewotICAgICAgICB0Y2dfb3V0MzIocywgb3Bp
IHwgVEFJKHJ0LCBiYXNlLCBsMCkpOworICAgICAgICB0Y2dfb3V0MzIocywgb3BpIHwgVEFJ
KHJ0ICYgMzEsIGJhc2UsIGwwKSk7CiAgICAgfQogfQogCkBAIC0xMjA0LDExICsxMjA0LDEx
IEBAIHN0YXRpYyB2b2lkIHRjZ19vdXRfbGQoVENHQ29udGV4dCAqcywgVENHVHlwZSB0eXBl
LCBUQ0dSZWcgcmV0LAogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIH0KICAgICAgICAg
aWYgKGhhdmVfaXNhXzJfMDdfdnN4KSB7Ci0gICAgICAgICAgICB0Y2dfb3V0X21lbV9sb25n
KHMsIDAsIExYU0lXWlggfCAxLCByZXQgJiAzMSwgYmFzZSwgb2Zmc2V0KTsKKyAgICAgICAg
ICAgIHRjZ19vdXRfbWVtX2xvbmcocywgMCwgTFhTSVdaWCB8IDEsIHJldCwgYmFzZSwgb2Zm
c2V0KTsKICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICB9CiAgICAgICAgIGFzc2VydCgo
b2Zmc2V0ICYgMykgPT0gMCk7Ci0gICAgICAgIHRjZ19vdXRfbWVtX2xvbmcocywgMCwgTFZF
V1gsIHJldCAmIDMxLCBiYXNlLCBvZmZzZXQpOworICAgICAgICB0Y2dfb3V0X21lbV9sb25n
KHMsIDAsIExWRVdYLCByZXQsIGJhc2UsIG9mZnNldCk7CiAgICAgICAgIHNoaWZ0ID0gKG9m
ZnNldCAtIDQpICYgMHhjOwogICAgICAgICBpZiAoc2hpZnQpIHsKICAgICAgICAgICAgIHRj
Z19vdXRfdnNsZG9pKHMsIHJldCwgcmV0LCByZXQsIHNoaWZ0KTsKQEAgLTEyMjQsMTEgKzEy
MjQsMTEgQEAgc3RhdGljIHZvaWQgdGNnX291dF9sZChUQ0dDb250ZXh0ICpzLCBUQ0dUeXBl
IHR5cGUsIFRDR1JlZyByZXQsCiAgICAgICAgIHRjZ19kZWJ1Z19hc3NlcnQocmV0ID49IDMy
KTsKICAgICAgICAgaWYgKGhhdmVfaXNhXzJfMDZfdnN4KSB7CiAgICAgICAgICAgICB0Y2df
b3V0X21lbV9sb25nKHMsIGhhdmVfaXNhXzNfMDBfdnN4ID8gTFhTRCA6IDAsIExYU0RYIHwg
MSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ICYgMzEsIGJhc2UsIG9mZnNl
dCk7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCwgYmFzZSwgb2Zmc2V0KTsK
ICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICB9CiAgICAgICAgIGFzc2VydCgob2Zmc2V0
ICYgNykgPT0gMCk7Ci0gICAgICAgIHRjZ19vdXRfbWVtX2xvbmcocywgMCwgTFZYLCByZXQg
JiAzMSwgYmFzZSwgb2Zmc2V0ICYgLTE2KTsKKyAgICAgICAgdGNnX291dF9tZW1fbG9uZyhz
LCAwLCBMVlgsIHJldCwgYmFzZSwgb2Zmc2V0ICYgLTE2KTsKICAgICAgICAgaWYgKG9mZnNl
dCAmIDgpIHsKICAgICAgICAgICAgIHRjZ19vdXRfdnNsZG9pKHMsIHJldCwgcmV0LCByZXQs
IDgpOwogICAgICAgICB9CkBAIC0xMjM3LDcgKzEyMzcsNyBAQCBzdGF0aWMgdm9pZCB0Y2df
b3V0X2xkKFRDR0NvbnRleHQgKnMsIFRDR1R5cGUgdHlwZSwgVENHUmVnIHJldCwKICAgICAg
ICAgdGNnX2RlYnVnX2Fzc2VydChyZXQgPj0gMzIpOwogICAgICAgICBhc3NlcnQoKG9mZnNl
dCAmIDE1KSA9PSAwKTsKICAgICAgICAgdGNnX291dF9tZW1fbG9uZyhzLCBoYXZlX2lzYV8z
XzAwX3ZzeCA/IExYViB8IDggOiAwLCBMVlgsCi0gICAgICAgICAgICAgICAgICAgICAgICAg
cmV0ICYgMzEsIGJhc2UsIG9mZnNldCk7CisgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
LCBiYXNlLCBvZmZzZXQpOwogICAgICAgICBicmVhazsKICAgICBkZWZhdWx0OgogICAgICAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwpAQCAtMTI1Niw3ICsxMjU2LDcgQEAgc3RhdGlj
IHZvaWQgdGNnX291dF9zdChUQ0dDb250ZXh0ICpzLCBUQ0dUeXBlIHR5cGUsIFRDR1JlZyBh
cmcsCiAgICAgICAgICAgICBicmVhazsKICAgICAgICAgfQogICAgICAgICBpZiAoaGF2ZV9p
c2FfMl8wN192c3gpIHsKLSAgICAgICAgICAgIHRjZ19vdXRfbWVtX2xvbmcocywgMCwgU1RY
U0lXWCB8IDEsIGFyZyAmIDMxLCBiYXNlLCBvZmZzZXQpOworICAgICAgICAgICAgdGNnX291
dF9tZW1fbG9uZyhzLCAwLCBTVFhTSVdYIHwgMSwgYXJnLCBiYXNlLCBvZmZzZXQpOwogICAg
ICAgICAgICAgYnJlYWs7CiAgICAgICAgIH0KICAgICAgICAgYXNzZXJ0KChvZmZzZXQgJiAz
KSA9PSAwKTsKQEAgLTEyNjUsNyArMTI2NSw3IEBAIHN0YXRpYyB2b2lkIHRjZ19vdXRfc3Qo
VENHQ29udGV4dCAqcywgVENHVHlwZSB0eXBlLCBUQ0dSZWcgYXJnLAogICAgICAgICAgICAg
dGNnX291dF92c2xkb2kocywgVENHX1ZFQ19UTVAxLCBhcmcsIGFyZywgc2hpZnQpOwogICAg
ICAgICAgICAgYXJnID0gVENHX1ZFQ19UTVAxOwogICAgICAgICB9Ci0gICAgICAgIHRjZ19v
dXRfbWVtX2xvbmcocywgMCwgU1RWRVdYLCBhcmcgJiAzMSwgYmFzZSwgb2Zmc2V0KTsKKyAg
ICAgICAgdGNnX291dF9tZW1fbG9uZyhzLCAwLCBTVFZFV1gsIGFyZywgYmFzZSwgb2Zmc2V0
KTsKICAgICAgICAgYnJlYWs7CiAgICAgY2FzZSBUQ0dfVFlQRV9JNjQ6CiAgICAgICAgIGlm
IChhcmcgPCAzMikgewpAQCAtMTI3Nyw3ICsxMjc3LDcgQEAgc3RhdGljIHZvaWQgdGNnX291
dF9zdChUQ0dDb250ZXh0ICpzLCBUQ0dUeXBlIHR5cGUsIFRDR1JlZyBhcmcsCiAgICAgICAg
IHRjZ19kZWJ1Z19hc3NlcnQoYXJnID49IDMyKTsKICAgICAgICAgaWYgKGhhdmVfaXNhXzJf
MDZfdnN4KSB7CiAgICAgICAgICAgICB0Y2dfb3V0X21lbV9sb25nKHMsIGhhdmVfaXNhXzNf
MDBfdnN4ID8gU1RYU0QgOiAwLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTVFhT
RFggfCAxLCBhcmcgJiAzMSwgYmFzZSwgb2Zmc2V0KTsKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU1RYU0RYIHwgMSwgYXJnLCBiYXNlLCBvZmZzZXQpOwogICAgICAgICAgICAg
YnJlYWs7CiAgICAgICAgIH0KICAgICAgICAgYXNzZXJ0KChvZmZzZXQgJiA3KSA9PSAwKTsK
QEAgLTEyODUsMTMgKzEyODUsMTMgQEAgc3RhdGljIHZvaWQgdGNnX291dF9zdChUQ0dDb250
ZXh0ICpzLCBUQ0dUeXBlIHR5cGUsIFRDR1JlZyBhcmcsCiAgICAgICAgICAgICB0Y2dfb3V0
X3ZzbGRvaShzLCBUQ0dfVkVDX1RNUDEsIGFyZywgYXJnLCA4KTsKICAgICAgICAgICAgIGFy
ZyA9IFRDR19WRUNfVE1QMTsKICAgICAgICAgfQotICAgICAgICB0Y2dfb3V0X21lbV9sb25n
KHMsIDAsIFNUVkVXWCwgYXJnICYgMzEsIGJhc2UsIG9mZnNldCk7Ci0gICAgICAgIHRjZ19v
dXRfbWVtX2xvbmcocywgMCwgU1RWRVdYLCBhcmcgJiAzMSwgYmFzZSwgb2Zmc2V0ICsgNCk7
CisgICAgICAgIHRjZ19vdXRfbWVtX2xvbmcocywgMCwgU1RWRVdYLCBhcmcsIGJhc2UsIG9m
ZnNldCk7CisgICAgICAgIHRjZ19vdXRfbWVtX2xvbmcocywgMCwgU1RWRVdYLCBhcmcsIGJh
c2UsIG9mZnNldCArIDQpOwogICAgICAgICBicmVhazsKICAgICBjYXNlIFRDR19UWVBFX1Yx
Mjg6CiAgICAgICAgIHRjZ19kZWJ1Z19hc3NlcnQoYXJnID49IDMyKTsKICAgICAgICAgdGNn
X291dF9tZW1fbG9uZyhzLCBoYXZlX2lzYV8zXzAwX3ZzeCA/IFNUWFYgfCA4IDogMCwgU1RW
WCwKLSAgICAgICAgICAgICAgICAgICAgICAgICBhcmcgJiAzMSwgYmFzZSwgb2Zmc2V0KTsK
KyAgICAgICAgICAgICAgICAgICAgICAgICBhcmcsIGJhc2UsIG9mZnNldCk7CiAgICAgICAg
IGJyZWFrOwogICAgIGRlZmF1bHQ6CiAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7
CkBAIC0zMDc1LDcgKzMwNzUsNiBAQCBzdGF0aWMgYm9vbCB0Y2dfb3V0X2R1cG1fdmVjKFRD
R0NvbnRleHQgKnMsIFRDR1R5cGUgdHlwZSwgdW5zaWduZWQgdmVjZSwKICAgICBpbnQgZWx0
OwogCiAgICAgdGNnX2RlYnVnX2Fzc2VydChvdXQgPj0gMzIpOwotICAgIG91dCAmPSAzMTsK
ICAgICBzd2l0Y2ggKHZlY2UpIHsKICAgICBjYXNlIE1PXzg6CiAgICAgICAgIGlmIChoYXZl
X2lzYV8zXzAwX3ZzeCkgewo=
--------------4136C17C2991C11D935B237C--

