Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040BC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D347C20644
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8KHva8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO6v1-00044N-17
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 17:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6u2-0003Zz-6a
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6u1-0004gS-2W
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:46:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6u0-0004gK-QP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:46:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so4654512wrx.4
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QFkOox9aW5Gz1w1lC/2hfijexeJeZQvw0fwqEQekOIY=;
 b=c8KHva8AwDSmTJ1OpcDc71xNHp7Uq64RwYjjQvp++dP+GMvIPfydmUyarjYagVX53/
 uHpoNv/OmAJwKKcVAuBZIPPpjuX2TI0ijXooU/4NBvx4wWhh9c14tphOfnLvKkcZwql/
 PvJV44MNfAMgNI7EgMYySqdX+GhkTbqeUZOyS1N+viJcyVrAfKXnSN31HvJmWncznlHm
 aHHKDxQdgnz3ZeJM81dt+dJEg5XljLny13zWEr8eEePM8sy+0vwuHyGGRkH7jAyaEu4j
 sTkIcPoCsRxg2EcAOi2tt5WFbDIKvGS8r+reySh2Lsmgdv3GsEjtAW3pLBCH5XzDrx6V
 Zrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QFkOox9aW5Gz1w1lC/2hfijexeJeZQvw0fwqEQekOIY=;
 b=GgJcoru4UuexDFeqrI/9TrO3sSSA/8m/dt0KbWUn2gH7yiCTAN3au04a6x/qUQGshm
 V56nPsWQqh4tzkp3lPwkvO1BybpzyvKeFrAqYCeksk0bFiBAhCexrJMlWL7QqLlP1Nzn
 vg+novT4X4hbwPrSSFo8vvGHl3QLExxX88CwdW5cI+VTq1h9dErCsO9qEgQE/wLrxzQS
 oRbu8Dse3ALzoJ0TZchaRnwiFKmyjcYNQ4S3DTeGtkRv53DiCTZKAoZrmp8EOkmzm1yq
 2L2CWFRQMrqPJfhtwjClqJzY2cPhpAUSOAU9G6TXZ1kOvzUFcjue93zVr0dopHT0LLRV
 xU0A==
X-Gm-Message-State: AGi0PuYMs12w5ZUD8ljJ2BOwrrYSbd6Njat0gdpXiJPbLgb60Kzgbas8
 DAQIMn3ovVdpZpetXCHtpsHn3pVeTzRD5g==
X-Google-Smtp-Source: APiQypIwUDgoXS1X6ufpFZuuGP3SHG1DKehdl0isvamfRZ6edCGlbzwnvCbCp3MQyiWqAtZRARREnw==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr11951186wrs.12.1586814359330; 
 Mon, 13 Apr 2020 14:45:59 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 19sm8490025wmo.3.2020.04.13.14.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2020 14:45:58 -0700 (PDT)
Subject: Re: [PATCH] .gitignore: include common build sub-directories
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200413162902.7985-1-alex.bennee@linaro.org>
 <2c489489-f459-f029-029e-74bfbfc70e49@redhat.com> <87imi38433.fsf@linaro.org>
 <d97c8034-2a9f-fe26-c70b-49b4d19f800d@redhat.com>
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
Message-ID: <9bebc7e2-77f7-2b06-9ed2-7dd26673078b@amsat.org>
Date: Mon, 13 Apr 2020 23:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d97c8034-2a9f-fe26-c70b-49b4d19f800d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 11:42 PM, Eric Blake wrote:
> On 4/13/20 4:32 PM, Alex Bennée wrote:
>>
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 4/13/20 11:29 AM, Alex Bennée wrote:
>>>> As out-of-tree builds become more common (or rather building in a
>>>> subdir) we can add a lot of load to "git ls-files" as it hunts down
>>>> sub-directories that are irrelevant to the source tree. This is
>>>> especially annoying if you have a prompt that attempts to summarise
>>>> the current git status on command completion.
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>    .gitignore | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>> diff --git a/.gitignore b/.gitignore
>>>> index 0c5af83aa74..7757dc08a08 100644
>>>> --- a/.gitignore
>>>> +++ b/.gitignore
>>>> @@ -141,6 +141,8 @@ cscope.*
>>>>    tags
>>>>    TAGS
>>>>    docker-src.*
>>>> +build
>>>> +builds
>>>
>>> Would 'build-*' be worth adding as well?
>>
>> Sure - I'll add it to v2.
> 
> Or even consolidate it into a single pattern: build* (which would allow
> 'build', 'builds', 'build1', 'build23', 'build-fedora', 'build-bug1234',
> ...)

Using 'build*':
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

