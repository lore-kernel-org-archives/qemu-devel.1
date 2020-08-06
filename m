Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81479C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB9123128
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpqQGr+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB9123128
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gIk-00084f-HQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3gHz-0007Ep-Jv; Thu, 06 Aug 2020 09:50:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3gHx-0004Xp-Q3; Thu, 06 Aug 2020 09:50:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id p14so8914167wmg.1;
 Thu, 06 Aug 2020 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LjB1ffki1ZRnWjsIwS0CS222qFqaOro+d2rusU7hmhA=;
 b=KpqQGr+nFCi3kPPJH6uDQhpqdRx8FbBb71DJ4yeHYo/BEJLy4WXJRy9e6HqhaC/Co4
 DuXdhtPFR7+sVuljIc9LytDOixPDBW0exeM7MIaax2sFhhlxYnABvZ4QLftBd7TVKZZQ
 9JXzn4bGIX/2xJGGMw0sFi+W4YRsidcJwj1qP0eS8bknVfhwPI/rX6v94SPAzacOLMwh
 BEoxFc4rLCDr1rvPFQfADyO69NiEcg8ChEwACgt7trvnPWe/ZC/v3KzObYRAf2HmBt2d
 3mNg28F4mfmG93P4JITPSqTqfZZ8QsE5LeLIM83Q8wg4+clqYDKYOl+wQUtrVIWmzGEn
 hthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LjB1ffki1ZRnWjsIwS0CS222qFqaOro+d2rusU7hmhA=;
 b=X8Uu0ylVTlRprpgNKX0FMQG/Pg1enJhwAI2ujrc6YMykrqtj/77DH5wnYc4CZw99pB
 Lb+OmfJsZI9hsy4L9JaY7LC0GLajLa6WeZx4IgR9CvcYIuUjh0Rj4SC9y/LKpXTLqA3q
 dfKXG90nCePM59+AENSq9KsCxqmEyXa1KXFomZ6kMRHwFQlH4GUFFWjbefW2ot+fuIBs
 lv9C9hKZ5DI+KFe+7iHNhVUqrn5B3+bpAnQ0EwG+HxDxQJ+MpC5sphHd/rKkyBmaM1og
 iBmTSqm0Hjjg28oSHtzUZfSpGz2sbwXT8eoWznp6zg1YJU2UvwtvXGHvFRv8EhdMr1++
 4AvA==
X-Gm-Message-State: AOAM530brERnbGGf/DKmnYqBoTbzCf7FJZv9sDFQH/SZyNNIgR3V+6X1
 WDGcbPRNRaG5rRZI+8LDeYk=
X-Google-Smtp-Source: ABdhPJw1h1CD8ZIQbMM0VBgdLyJuJBZFykWuzLyyp1bIkMZvKSIkoluvh0xoHL9y8w3WPbpUkLaS4Q==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr8198237wmf.160.1596721831581; 
 Thu, 06 Aug 2020 06:50:31 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w1sm6712094wmc.18.2020.08.06.06.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 06:50:30 -0700 (PDT)
Subject: Re: [PATCH v2] .mailmap: Update Paul Burton email address
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
References: <20200707022544.24925-1-f4bug@amsat.org>
 <19b2c623-7c8e-fd93-290f-86498b85caf5@amsat.org>
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
Message-ID: <932a272b-bc80-f6e4-d51e-32e2222f540c@amsat.org>
Date: Thu, 6 Aug 2020 15:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <19b2c623-7c8e-fd93-290f-86498b85caf5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping, as I'm still receiving "The recipient email address is
incorrect or does not exist in this domain." from wavecomp.com...

On 7/16/20 8:56 AM, Philippe Mathieu-Daudé wrote:
> Hi Paul,
> 
> Do you mind Acking this patch? QEMU's get_maintainer.pl
> still selects pburton@wavecomp.com for various of your
> contributions and wavesemi.com (where wavecomp.com seems
> redirected) keeps sending "The recipient email address is
> incorrect or does not exist in this domain."
> 
> In case you don't want to receive any more emails from the
> QEMU mailing list, you can Nack this patch, so I'll have a
> good reason to insist with the alternative to have a
> 'ignore .mailmap', suggested here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg717757.html
> 
> On 7/7/20 4:25 AM, Philippe Mathieu-Daudé wrote:
>> Following the Linux kernel equivalent patch posted on
>> linux-mips@vger.kernel.org [*], update Paul Burton email
>> address to avoid emails bouncing.
>>
>> [*] 'MAINTAINERS: Use @kernel.org address for Paul Burton'
>> https://lore.kernel.org/patchwork/patch/1140341/
>>
>> Cc: Paul Burton <paulburton@kernel.org>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .mailmap | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 926cac6bb8..fe4c561338 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -49,9 +49,10 @@ Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
>>  Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
>>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>>  Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
>> -Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>> -Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>> -Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
>> +Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
>> +Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
>> +Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
>> +Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
>>  Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
>>  Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
>>  Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>>
> 

