Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79FC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30033218C9
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFLiEkUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30033218C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOT8-0006Di-Dt
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjORU-0005GM-Bx
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjORR-0003Rb-Bt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:39:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjORR-0003Am-5X
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:39:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so9408968wmj.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LO3A3nCigJiZHxNec/TR7At9owXXE9RfFXRpvh7ttVI=;
 b=JFLiEkUoMZJBvrJ5LCTmr+XFDxpjXjIYpUs3idDEy2136XHzQTa89hXqRPYUK/gcCh
 ULsC0qzX5n6OZ5d2wnPGQdtFu2jB9lyr8QJEaGCP4ewda7yJRQXU2EOSfcyo11q+3ucx
 TfnNeRFYgFmbK4UnexFMcN41/VVLkLozK7Eqk63xRTi29bgjMuu6NW08Z1hfqCzdpXuI
 glb/pQXwlMmy55QkJNISlQ88LgURq/yDRKQAJoBGvYhTmchYCyD7R2SzEFLShI/8XOh8
 YgsWtcZw/VBLzgv0srSA9KkHyuxPmH2Ihg1FO2YIcKZtPuN2YMUApoIBLDxxySSZI63D
 SyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LO3A3nCigJiZHxNec/TR7At9owXXE9RfFXRpvh7ttVI=;
 b=YM/DurXqv31s082sHZLLeJtNcCVaXYbMJ4/0atUsSTrxFi/oJjj7Qkj2vUt8n2upSA
 xx25ABe85dTAxeivctbbPUgNf8x6TvkdzfcCDYWenKc6rlLlpnICgpkF90+pibX4lMTb
 GdygWxwlGfqYIBr6bKYMwEgeu16vY7WdJnSm6utyVTuty5EJBEm74sBUI6LSQ2Nm6Id0
 8PDA594s06ltn9FJ+mNTZoAJMQMnocRkMumDoCzwKvBJMGsfXF+1Y8YZ6bzhoy+meJSD
 0IrmQpFWdkd3toAg7h3YVLxG5P5s32o1UFvq1qwoB6lGuGuA3JSSJ00NJHxw6nCY+axM
 l7lw==
X-Gm-Message-State: APjAAAXouiMyBoPomjxkNmnZpouIrsyEAZPdBYt1Tentla45TswWP7Ap
 D4mWdOAYaEsX8YHfvx/gtFfjIQ==
X-Google-Smtp-Source: APXvYqzXSUOE11MAQQmVwS/dmeav2UTQ9afvS8nnRGUs7i6Ie+Iuo45co5iE6wLqO8gyDEQIaNl12Q==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr3562288wmg.65.1562333993563;
 Fri, 05 Jul 2019 06:39:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b8sm9780162wmh.46.2019.07.05.06.39.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 06:39:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A1DD51FF87;
 Fri,  5 Jul 2019 14:39:52 +0100 (BST)
References: <20190705124318.1075-1-philmd@redhat.com>
 <db75031d-e9af-c349-903f-276ec92f850d@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <db75031d-e9af-c349-903f-276ec92f850d@redhat.com>
Date: Fri, 05 Jul 2019 14:39:52 +0100
Message-ID: <87v9wgvbvb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] target/arm/vfp_helper: Call
 set_fpscr_to_host before updating to FPSCR
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Correct subject: "Call set_fpscr_to_host before updating FPSCR reg"
> (or without "reg").

Queued to testing/next, thanks.

>
> On 7/5/19 2:43 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> In commit e9d652824b0 we extracted the vfp_set_fpscr_to_host()
>> function but failed at calling it in the correct place, we call
>> it after xregs[ARM_VFP_FPSCR] is modified.
>>
>> Fix by calling this function before we update FPSCR.
>>
>> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  target/arm/vfp_helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
>> index 46041e3294..9710ef1c3e 100644
>> --- a/target/arm/vfp_helper.c
>> +++ b/target/arm/vfp_helper.c
>> @@ -197,6 +197,8 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_=
t val)
>>          val &=3D 0xf7c0009f;
>>      }
>>
>> +    vfp_set_fpscr_to_host(env, val);
>> +
>>      /*
>>       * We don't implement trapped exception handling, so the
>>       * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RE=
S0!)
>> @@ -217,8 +219,6 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_=
t val)
>>      env->vfp.qc[1] =3D 0;
>>      env->vfp.qc[2] =3D 0;
>>      env->vfp.qc[3] =3D 0;
>> -
>> -    vfp_set_fpscr_to_host(env, val);
>>  }
>>
>>  void vfp_set_fpscr(CPUARMState *env, uint32_t val)
>>


--
Alex Benn=C3=A9e

