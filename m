Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A14C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC880206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RrFxkAd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC880206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTad-0007mI-VW
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTYx-0007Af-17
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTYv-0007Eh-Jh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:00:34 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:44710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHTYv-0007ES-B6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:00:33 -0400
Received: by mail-yw1-xc41.google.com with SMTP id m13so5127748ywa.11
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2uUlaVvMd9oVjeYdl0v66vOxdwVdVbtYNrL3LrGajtA=;
 b=RrFxkAd2Htozl9oB4k4R7CZDpuW1KZ24h2KH/rZwLVSknqTWkPnevSCyv2Jv6BVe01
 QkJCRnkXYS/uFlmd0EHk64iFzgwex7Mi9v2XRoKvbNLRnSuUihbaERp3vY1RIKh+1BA7
 Mgcv7ZKxgekXlEEkb1LtNQQ3kZ2U3jPpzfz2hzRw9wlhpGpvpPjIwcydCfg46tvw3Ci8
 g/76hhC6x1Khm+pWmU2nkLYZIpnocruHWukPK4Q/1B5jBPczJARAk0uZVi+kj1u5nhQK
 wWTZ2g7SWjklqdf4dsV/JOu/VrSVdT0ZsXPUlEGJ+UVUsmeHNplk60H1tEm5D81odlI5
 cHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2uUlaVvMd9oVjeYdl0v66vOxdwVdVbtYNrL3LrGajtA=;
 b=kHSwwYoR8FTgQIN0nWBMXH8Wgzxn4eWDecc++kG03nOTVVdNwLRX+sunXEA/vDLZVx
 miS54Y6yicujJWHPKlnuB4edjYLP++VsIxDvHPdjSM4iXqpq/J7VRLZJh1v0Z6koWU65
 DtPLvqxqlxuRGej+DT/7XE7v6agR4t/gBPxX13Aoeseo5976e/VU/g/FJj/jve6SSwHb
 F6QwX6+xeVjQnAs9V38WWWt4WzY3dDDYCBU/bf/quUVu6aOeORQdpfpgj6khh9ml8x2g
 iQRsoRNqjUWBlC/HZqx5sAlgpB3wfXcsbIKvAmSOnt+k/VT3qGozRgFgZ2yjtjug6aCE
 lIvw==
X-Gm-Message-State: APjAAAVopJX1SnzOSIVg42u4FFiI2YWpspRvnzEFzX0qeFU/WS7TQqZQ
 /jjeTikx4pP2f7I2YSQpiAUW1Q==
X-Google-Smtp-Source: APXvYqwnCv5wmLbrh9nxKJMLgWIpxk8L1iCel7clZZ6yKCT8Wl3k0e7ruXJtN0VSdifgyv3EckXTkA==
X-Received: by 2002:a81:5f41:: with SMTP id t62mr20189961ywb.161.1570456832141; 
 Mon, 07 Oct 2019 07:00:32 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id t82sm3871469ywc.26.2019.10.07.07.00.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 07:00:31 -0700 (PDT)
Subject: Re: [PATCH] cpus: kick all vCPUs when running thread=single
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20191001160426.26644-1-alex.bennee@linaro.org>
 <5582c91e-ac0e-9f74-a3de-82f7fe25fadd@redhat.com> <874l0sl5z6.fsf@linaro.org>
 <d25121c7-e499-95e4-840e-4de53a4469f2@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a475e640-1739-24df-f873-d54abb891c35@linaro.org>
Date: Mon, 7 Oct 2019 10:00:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d25121c7-e499-95e4-840e-4de53a4469f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/19 9:05 AM, Paolo Bonzini wrote:
> On 01/10/19 19:40, Alex Bennée wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 01/10/19 18:04, Alex Bennée wrote:
>>>> qemu_cpu_kick is used for a number of reasons including to indicate
>>>> there is work to be done. However when thread=single the old
>>>> qemu_cpu_kick_rr_cpu only advanced the vCPU to the next executing one
>>>> which can lead to a hang in the case that:
>>>>
>>>>   a) the kick is from outside the vCPUs (e.g. iothread)
>>>>   b) the timers are paused (i.e. iothread calling run_on_cpu)
>>>>
>>>> To avoid this lets split qemu_cpu_kick_rr into two functions. One for
>>>> the timer which continues to advance to the next timeslice and another
>>>> for all other kicks.
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Cc: Doug Gale <doug16k@gmail.com>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>  cpus.c | 24 ++++++++++++++++++------
>>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>>
>>> Looks good to me.  Single-threaded TCG is not going to have high vCPU
>>> counts anyway.
>>
>> Are you going to take this via your queue?
> 
> I wasn't, since we have had a proper TCG maintainer for a while. :)

Hah.  Point taken, and queued.  Would you care to go on the record with
something more than a LGTM?


r~

