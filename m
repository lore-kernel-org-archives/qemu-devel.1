Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B75EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221B120663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZt4UZ0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221B120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7E7-00027T-CH
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO7DX-0001ht-3v
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO7DV-0002Ll-1N
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:06:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO7DU-0002Lc-PW
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:06:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id d17so5032882wrg.11
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9bfTY167sjqKg0j7diQOa4rjBTWcdaFc9b+SRgfV2hU=;
 b=aZt4UZ0t1AVfMlIDatV5vi1aCOl5hqdvSlO1cm+3X6HEHiZmtaX5MZ7WaRDPUXJNXh
 tEtnFdvHN7sYoqoo/WhdG1o0r9K7SrLxSIQchuSkgkk7uW7nZf595VVG7kxp8p4nIOXz
 cvK2QH6lh7WTBzik/WK4h9WPUFZDuHYPViBpK8HDYG0NQCaOP3e3H3G+iVz3MbEIIIrq
 JxFDxiH+EAUKTkBoqZrCcLX8fw81SIHnzIfpYD/HZpn673N6SZ/e7xoxoAcNSCzO6Lgz
 OOGxfcIw4C4qaACgGOhF8+nkKtZS7k7uWhfHs/xu8sSwFyww4RIjfb1a0NXbi2yw7AkE
 +f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9bfTY167sjqKg0j7diQOa4rjBTWcdaFc9b+SRgfV2hU=;
 b=O1I2DtSvex2jN93m7KU+2AsTp8sUyAWzM4dhhWtlsuzOiZEDQcKu9+c8lgO9FaGMs5
 VLrXJmjt10mNqErM8k3TqgQgUeOWMq0u5FSGvEBvD7gkMx1xS0Svz+XABTDo+LkctVN7
 EtcN4vzfuZg4F3MmBB23vR23+aHSldax0bYuhcRiE/SCmzlmCqeL6HavW0OmJtM52DqW
 DGz/2IlZ6k4nIMJ58YFj79HNlxuy8vHoB6s4PUQCr8imLFmV3r6zsLo7RLdYX+g1tGEj
 +tepYq0E77VImuMqIiP9je21Khl+haCjqp7EpEF8a2LyZBo2bRToG+BIrf/8z3QFQRGS
 UYCA==
X-Gm-Message-State: AGi0PuY3RTXLrpYZgMqRBYHNRjrVIhHEiaJxzfOCIWIqDndI7HMBJJs0
 zFHn0AZbGvcBye5rrkfAXFg=
X-Google-Smtp-Source: APiQypKNCjM8knpi+73akKW+WqsoXHXA+wU4vlxlt9kqSImXkRtt9gIOnbYHvtiyMuRH52c9+Nn24g==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr22158368wrs.302.1586815567546; 
 Mon, 13 Apr 2020 15:06:07 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v16sm16185569wml.30.2020.04.13.15.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2020 15:06:06 -0700 (PDT)
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as fulong2e co-maintainer
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-3-git-send-email-chenhc@lemote.com>
 <CAHiYmc61GZSvvwhCaC0B5q0GrEUN3CevDvNTEEWLE9PCJqVbvw@mail.gmail.com>
 <CAAhV-H5moZ8kD5WAM1GvLRmg9spO7m=2DZZL+uUXAoo4iWZyVg@mail.gmail.com>
 <20200409103844.1591548c@flygoat-x1e>
 <CAHiYmc71dZK9bYOWCQ4aA4_wTnicrpCGkuNp+h5umOwP6Q1xiA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <21fee195-29d6-706e-144d-d06ad76a0869@amsat.org>
Date: Tue, 14 Apr 2020 00:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc71dZK9bYOWCQ4aA4_wTnicrpCGkuNp+h5umOwP6Q1xiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Huacai Chen <chenhc@lemote.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 4:37 PM, Aleksandar Markovic wrote:
> 04:39 Čet, 09.04.2020. Jiaxun Yang <jiaxun.yang@flygoat.com
> <mailto:jiaxun.yang@flygoat.com>> је написао/ла:
>>
>> On Thu, 9 Apr 2020 10:17:46 +0800
>> Huacai Chen <chenhc@lemote.com <mailto:chenhc@lemote.com>> wrote:
>>
>> > Hi, Aleksandar,
>> >
>> > On Wed, Apr 8, 2020 at 11:30 PM Aleksandar Markovic
>> > <aleksandar.qemu.devel@gmail.com
> <mailto:aleksandar.qemu.devel@gmail.com>> wrote:
>> > >
>> > > 11:08 Sre, 08.04.2020. Huacai Chen <chenhc@lemote.com
> <mailto:chenhc@lemote.com>> је
>> > > написао/ла: 
>> > > >
>> > > > I submitted the MIPS/fulong2e support about ten years ago, and
>> > > > after that I became a MIPS kernel developer. Last year, Philippe
>> > > > Mathieu- Daudé asked me that whether I can be a reviewer of
>> > > > MIPS/fulong2e, and I promised that I will do some QEMU work in
>> > > > the next year (i.e., 2020 and later). I think now (and also in
>> > > > future) I can have some spare time, so I can finally do some real
>> > > > work on QEMU/MIPS. And if possible, I hope I can be a
>> > > > co-maintainer of MIPS/fulong2e.
>> > > >
>> > > > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com
> <mailto:jiaxun.yang@flygoat.com>>
>> > > > Signed-off-by: Huacai Chen <chenhc@lemote.com
> <mailto:chenhc@lemote.com>>
>> > > > ---
>> > > >  MAINTAINERS | 1 +
>> > > >  1 file changed, 1 insertion(+)
>> > > >
>> > > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > > index 642c8e0..3281ff2 100644
>> > > > --- a/MAINTAINERS
>> > > > +++ b/MAINTAINERS
>> > > > @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c
>> > > >  Fulong 2E
>> > > >  M: Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>>
>> > > >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com
> <mailto:aleksandar.qemu.devel@gmail.com>>
>> > > > +M: Huacai Chen <chenhc@lemote.com <mailto:chenhc@lemote.com>>
>> > > >  S: Odd Fixes
>> > > >  F: hw/mips/mips_fulong2e.c
>> > > >  F: hw/isa/vt82c686.c
>> > > > --
>> > > > 2.7.0
>> > > > 
>> > >
>> > > First of all, I want to express great pleasure and delight seing
>> > > your series, and this patch in particular.
>> > >
>> > > A warm welcome to QEMU developers communities!
>> > >
>> > > We are currenyly very busy preparing QEMU 5.0 release, and
>> > > additionaly, Easter holidays are in next few days or week
>> > > (different parts od Christian world have different calendars), so,
>> > > fot thay and other reasons, don't expect promot replies from us.
>> > >
>> > > I would also like to see Jiaxng at least having official reviewer
>> > > status, but, of course, only if he wants that. 
>> > Thank you for your best wishes, I'm also very glad to see Jiaxun be
>> > an reviewer.
>>
>> Thanks, but I was a primary school student at Loongson-2E's era, so I
>> can do nothing with 2E.
>>
>> My experience with Loongson starts from 2F. And I'm more familiar with
>> 2K and 3A.

Thank you both of you, your help is very welcome :)

I have a simple series renaming "fulo[o]ng" I plan to send when the 5.1
development window opens, I'll include your patch.

>>
> 
> OK, it makes sense. But, if you ever become wanting to be a reviewer for
> Foolong 2e, just give me an email.
> 
>> I'm happy to contribute QEMU support for these platforms.
>>
> 
> I am happy as well.
> 
> Best wishes and best health to you, people from China, and the whole
> region!!
> 
> Yours,
> Aleksandar
> 
>> Thanks.
>>
>> >
>> > Regards,
>> > Huacai
>> > >
>> > > Yours,
>> > > and wishing you and all people from China best health!
>> > >
>> > > Aleksandar 
>>
>> --
>> Jiaxun Yang
> 

