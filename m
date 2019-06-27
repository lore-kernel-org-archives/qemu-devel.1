Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BA3C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E6D20659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLcRjBED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E6D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgYZv-00014h-7G
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgYYa-0007rQ-CW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgYYZ-00078u-C0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:51:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgYYZ-00078I-2b
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:51:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id g135so6568166wme.4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=xcVh1s1jnu/fUvR+0oHKUa0YMsd4tC+l3KSzixq5NwY=;
 b=tLcRjBEDegGzgRSvoJh3hgzjucPv7P38P7kI0tGEjSOdWl0GTu6STrSujArzoZefux
 OCfpa0TPz5tESNMxeSEj5YCxKmysLoisf5V2JcMi+iznAk3vEOuK0QN6eirGvYSSkgaN
 Z/2bLO7oNmbIVFJhLB+WiX5t18+JVfjtl76WCyEQtWRZNiVzdfJQ/rs86vZmqaRzNEKD
 TOWOpkKAt7lmhXXLvut1bz0LCs8Or5Xaxtgbzea0VTo/lu3Njw+JG8ZR/cQ1WpicwBAk
 e70vnhOnOyCBpXc0RCTsSDbDuPH3CwNtzyMS1zCaNziCQuf0106/H++sq748iTFbAoRw
 3r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=xcVh1s1jnu/fUvR+0oHKUa0YMsd4tC+l3KSzixq5NwY=;
 b=ExbOrWClUMd3c/t4v0rNslXLd2NVep6PWRCSkOQEuh2Tv0BELZUUt+WCO50xJgv4/z
 b3iZRyhskOTB2kjIfM7xNlPErK2G+keidMg814HpPQzz6Z8TKA3LEdDk8r4ZM6yCnYYf
 FNWUsVch7huoN3mmCaazTSjfixdDwrMZkRIWxt9IwRoPD9DMDpWsOvYIPFRU3gHOcDUx
 V1dNQBsc7JWhtJWAmCBeXJ6HJejed7DDaosplSna4FL5CF7D1s1jbO7M7ffkOLwMo2ww
 2ue71zS/KkcCxAsOV+mLzxliM6JnskOXmjmyLPYufNwYLqS4lBDN5qKIBZyd6ZLP7u2v
 c6LA==
X-Gm-Message-State: APjAAAVsaiE+out6HGCU10tpZNYeafIxEF9QF3yg8Unyzmk73zt6+4vj
 DdC9URtNedmf/8lK+/m/FkGKDg==
X-Google-Smtp-Source: APXvYqyuepjphURM0Zv3vDin/3PwFsQszCFWzwv5uNqZtFEXU/Pp1+vBxHOYpYpySl02BKESsh0S7w==
X-Received: by 2002:a05:600c:20c3:: with SMTP id
 y3mr4209388wmm.3.1561657893458; 
 Thu, 27 Jun 2019 10:51:33 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id q12sm3936588wrp.50.2019.06.27.10.51.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 10:51:32 -0700 (PDT)
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
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0d6d9b35-4c4a-a04d-76b5-eca089ade29c@linaro.org>
Date: Thu, 27 Jun 2019 19:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cd1a0635-5b5d-3c2d-dec3-4ceda8c789f9@ilande.co.uk>
Content-Type: multipart/mixed; boundary="------------2E56C0DDCE526B966A76E76C"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
--------------2E56C0DDCE526B966A76E76C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 6/27/19 7:24 PM, Mark Cave-Ayland wrote:
> For the TCG_TYPE_V128 case we have ret = TCG_REG_V2 but (ret & 31) masks
> off the top bit which converts this to TCG_REG_R2 and that's why
> tcg_out_mem_long() starts using r2 to calculate offsets.

Oh geez.  Ok, I see it now.

>      case TCG_TYPE_V128:
>          tcg_debug_assert(ret >= 32);
>          assert((offset & 15) == 0);
> -        tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset);
> +        tcg_out_mem_long(s, 0, LVX, TCG_REG_TMP1, base, offset);

No, here ret is the register into which we are loading.
Same for the rest.  The error is in tcg_out_mem_long in
trying to reuse the output register as a scratch.

> Presumably the reason this didn't break on your Power 9 box is because
> the 64-bit ABI doesn't mark r2 as reserved?

Correct.  That and the fact that V0 and V1 get reserved as temporaries, so I
didn't attempt to use r1 (i.e. sp) as a temporary.

Please try the following patch on top and if it works I'll split it back into
the patch set properly.


r~

--------------2E56C0DDCE526B966A76E76C
Content-Type: text/plain; charset=UTF-8;
 name="z"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="z"

ZGlmZiAtLWdpdCBhL3RhcmdldC9tNjhrL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L202OGsvdHJh
bnNsYXRlLmMKaW5kZXggMmFlNTM3NDYxZi4uYjYxYzdlYTBmMSAxMDA2NDQKLS0tIGEvdGFy
Z2V0L202OGsvdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L202OGsvdHJhbnNsYXRlLmMKQEAg
LTYxMjQsMjcgKzYxMjQsMzQgQEAgc3RhdGljIHZvaWQgbTY4a190cl90Yl9zdG9wKERpc2Fz
Q29udGV4dEJhc2UgKmRjYmFzZSwgQ1BVU3RhdGUgKmNwdSkKIHsKICAgICBEaXNhc0NvbnRl
eHQgKmRjID0gY29udGFpbmVyX29mKGRjYmFzZSwgRGlzYXNDb250ZXh0LCBiYXNlKTsKIAot
ICAgIGlmIChkYy0+YmFzZS5pc19qbXAgPT0gRElTQVNfTk9SRVRVUk4pIHsKLSAgICAgICAg
cmV0dXJuOwotICAgIH0KLSAgICBpZiAoZGMtPmJhc2Uuc2luZ2xlc3RlcF9lbmFibGVkKSB7
Ci0gICAgICAgIGdlbl9oZWxwZXJfcmFpc2VfZXhjZXB0aW9uKGNwdV9lbnYsIHRjZ19jb25z
dF9pMzIoRVhDUF9ERUJVRykpOwotICAgICAgICByZXR1cm47Ci0gICAgfQotCiAgICAgc3dp
dGNoIChkYy0+YmFzZS5pc19qbXApIHsKKyAgICBjYXNlIERJU0FTX05PUkVUVVJOOgorICAg
ICAgICBicmVhazsKICAgICBjYXNlIERJU0FTX1RPT19NQU5ZOgogICAgICAgICB1cGRhdGVf
Y2Nfb3AoZGMpOwotICAgICAgICBnZW5fam1wX3RiKGRjLCAwLCBkYy0+cGMpOworICAgICAg
ICBpZiAoZGMtPmJhc2Uuc2luZ2xlc3RlcF9lbmFibGVkKSB7CisgICAgICAgICAgICB0Y2df
Z2VuX21vdmlfaTMyKFFSRUdfUEMsIGRjLT5wYyk7CisgICAgICAgICAgICBnZW5faGVscGVy
X3JhaXNlX2V4Y2VwdGlvbihjcHVfZW52LCB0Y2dfY29uc3RfaTMyKEVYQ1BfREVCVUcpKTsK
KyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIGdlbl9qbXBfdGIoZGMsIDAsIGRjLT5w
Yyk7CisgICAgICAgIH0KICAgICAgICAgYnJlYWs7CiAgICAgY2FzZSBESVNBU19KVU1QOgog
ICAgICAgICAvKiBXZSB1cGRhdGVkIENDX09QIGFuZCBQQyBpbiBnZW5fam1wL2dlbl9qbXBf
aW0uICAqLwotICAgICAgICB0Y2dfZ2VuX2xvb2t1cF9hbmRfZ290b19wdHIoKTsKKyAgICAg
ICAgaWYgKGRjLT5iYXNlLnNpbmdsZXN0ZXBfZW5hYmxlZCkgeworICAgICAgICAgICAgZ2Vu
X2hlbHBlcl9yYWlzZV9leGNlcHRpb24oY3B1X2VudiwgdGNnX2NvbnN0X2kzMihFWENQX0RF
QlVHKSk7CisgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICB0Y2dfZ2VuX2xvb2t1cF9h
bmRfZ290b19wdHIoKTsKKyAgICAgICAgfQogICAgICAgICBicmVhazsKICAgICBjYXNlIERJ
U0FTX0VYSVQ6CiAgICAgICAgIC8qIFdlIHVwZGF0ZWQgQ0NfT1AgYW5kIFBDIGluIGdlbl9l
eGl0X3RiLCBidXQgYWxzbyBtb2RpZmllZAogICAgICAgICAgICBvdGhlciBzdGF0ZSB0aGF0
IG1heSByZXF1aXJlIHJldHVybmluZyB0byB0aGUgbWFpbiBsb29wLiAgKi8KLSAgICAgICAg
dGNnX2dlbl9leGl0X3RiKE5VTEwsIDApOworICAgICAgICBpZiAoZGMtPmJhc2Uuc2luZ2xl
c3RlcF9lbmFibGVkKSB7CisgICAgICAgICAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlv
bihjcHVfZW52LCB0Y2dfY29uc3RfaTMyKEVYQ1BfREVCVUcpKTsKKyAgICAgICAgfSBlbHNl
IHsKKyAgICAgICAgICAgIHRjZ19nZW5fZXhpdF90YihOVUxMLCAwKTsKKyAgICAgICAgfQog
ICAgICAgICBicmVhazsKICAgICBkZWZhdWx0OgogICAgICAgICBnX2Fzc2VydF9ub3RfcmVh
Y2hlZCgpOwo=
--------------2E56C0DDCE526B966A76E76C--

