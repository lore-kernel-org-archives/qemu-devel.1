Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7041CC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 20:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404172072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 20:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BjPltzXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404172072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isXo2-000376-1z
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 15:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1isXkL-000297-Ve
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1isXkI-0003PM-HH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:57:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:40335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1isXkI-0003Of-4E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1579291044;
 bh=w6DxTm3IwxU1n4gof+PtInGTwdVNLKKuqOfhddmiqp4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=BjPltzXZxYRs/4XjiHQOs/zL02lbwa2SG4eG2fzkEZiSP359ORM4D+Kk1bE+/+Q70
 gOJXzYCHibCdIbw4C6btrF+hUoF2gRbenq2dtRildNUPUNP/sQ6cAuVGE3uic3TfiH
 yYIK4uaQy9avFCy10gzbAvivAJ+oMoRKMR2NJ+oo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.147.128]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1jfzf90q4l-016957; Fri, 17
 Jan 2020 20:57:24 +0100
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <CAP+75-WqE4j7kRkSae+fQHn9N0=L+OTZz5xUziZkn9Z-1uAs9Q@mail.gmail.com>
 <ae03e9e6-af60-1b32-751f-68c08d0b3d51@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <560a7f65-68f6-bfae-7757-3c544005c20e@gmx.de>
Date: Fri, 17 Jan 2020 20:57:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ae03e9e6-af60-1b32-751f-68c08d0b3d51@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:scgjtsiztJDmHfrxy24IqIvWL4s9BBQGr9oRo0PeOplXRXGsvj3
 P6HokfiwZzuN8C5099ze2JWDYbN2TxLPfjoC0He2KSGadXNbwrtjpXACu45zQE7+bLlLhA/
 BafFyZYD42zLN7lLKTr0K9E5VHx+v9hJZ51JZPT2/cv4a3mFhdlYIhYvhrpQaihsKmOaZuV
 +AUmmBSwMv7rZ2o0rYbCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rRkVcvlQ3BE=:brEJwp/45Y8rhG9poaRZZ5
 8q8GkvOFTIpvZwZ1wkYQ/5egnMzQYf/P9Oeje9XVlaIknB+y4DrciOXfreOOAl/xE/mdoQMEC
 YzDeLNVmGkdBzhIxgAD9TWPiEOPumB3S/uNgzVzPvmA+H31y/+XI86e9rA8/Rly7qzxaV0N/M
 eIEgjWbib/csPL8QgJZMzE2OA7w3fWqNZTDdX4JTkAM/JiUPMy03QT5P0NGFIgm8i5J1ujUjx
 vvR1IjasQgTyl0wqa+e6k1L5TtAVEF9btSe6iTOmW0khVsTGNze2+9aqRM0oCutkRT1y6Qn7e
 f3Kz593HHSvuz5RPuo7TN2dOMBWMDVkTbI6Q2vVhuqrTOlbj6FxHH4nfXqUzL5iihVplYUKB8
 vN35EwaETSBjoPySClFBZyZ16tzKIXQMz2yZSn0qF1q3GOMYBdJloq45mCtE3JVa9XAwtQ7/o
 xknFtB08q4SQdlAOhnQmbKxjDf/ZBYDFrJtPnwFCPmbvvn9qOaT+cCuSnQy7qunxffBw4WOaL
 V0crW3UmqTPPgBSi4xSulotDFUNAt7PiX0BwgY77+gGIDN0qPNw46SoXPbfBArAzsG+CZKbCI
 uQgeIrhRqFJAKten4cZ3RVWBTDps7LGGsZwVYjqIcl3X00QrMMtB/2ULXwUAUkI6BxHULb+Vm
 sW/x/p+i7BLyhc44zOWoXvI1gKwAQnZrZDMX4bDIBCAIc09IRgK/blbRwqD2+6B1oLzclnhZ6
 VyqDnELQ8tEoAzQW9YzS22Vshxw5Im00hFIfI3OtoGORbSk6+No/hT9Ck5/Y6f9+9LMBHwSur
 RCcRqIz/auIJcFhSi0fE9rBrLIaTd2EauL/bELj83vcZnKJXgtBMm9GSxbnt3WfUwVOaQOUO7
 ugtnGJyQmL3kSG38DRvFv0/GfIMRYWF1RXKR2e3eA9O4BMl6gIazVDantHrcEsnD6kv6BEv7u
 gPG/m7JIedz1cpN4/FWnEccVSwBYAnlYgWjTbEJ5vTuEkhcee8w+J40e2vAuV9WA0GS7efZIp
 /0vAryeOhsqlDAcM4ckLamYOKLUd5ePoEtRlKNunWJu3WojKFE/qRNeHwh2T55LyhxU5N0zs5
 gGFaRTng9mrCh/abHfQACbXRg7ihY/NTsJGdNnAWzInQXuo//eTFon8BxMmGSW/bxxhPJN/Oh
 X3P1nMw1eb371IKHUKQc6FQMx60hlm4Ll1k4MxGK+sC/yNT5UDdMO+2kHpRkCcEQ2IQzkjS3B
 CZmMak4Mbc6u7eiiTxBWbWoLHh+rlXy9opkqCDQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.15
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
Cc: dave.anglin@bell.net, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.01.20 20:23, Richard Henderson wrote:
> On 1/17/20 8:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On Fri, Jan 17, 2020 at 2:53 AM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
>>> or the operation is undefined.  However, real hardware only generates
>>> an unaligned access trap for unaligned mod 4.
>>
>> This Linux kernel commit seems relevant:
>>
>> https://github.com/torvalds/linux/commit/14e256c107304#diff-e85862c7227=
599cb24e36494f75948d5R159-R164
>>
>>   /* From: "Jim Hull" <jim.hull of hp.com>
>>   I've attached a summary of the change, but basically, for PA 2.0, as
>>   long as the ",CO" (coherent operation) completer is specified, then t=
he
>>   16-byte alignment requirement for ldcw and ldcd is relaxed, and inste=
ad
>>   they only require "natural" alignment (4-byte for ldcw, 8-byte for
>>   ldcd). */
>
> It isn't completely relevant.  We don't implement hppa 2.0.
>
> I added a TODO comment for HPPA64, as I said in reply to Dave Anglin els=
ewhere
> in this thread.

I agree. A TODO comment should be sufficient for now.

Thanks!
Helge

