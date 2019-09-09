Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F9BC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAD2207FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu2QaNOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAD2207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KED-000324-IW
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7KDS-0002Se-1O
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7KDN-0001dV-7X
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:00:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7KDN-0001ch-1r
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:00:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id u16so14013574wrr.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fMfXWMcLnBG1BaWqMzbahQ8ZxJtVXJSKVHCWC7YPN0U=;
 b=Eu2QaNOdv+51szB3lCVnb//DiNxgl72gq5dtGBYccWRfHfGtIc/L2elwlelcjKQ3ry
 g7LoFpm36A6IBtBUh70IpigOqNGxZS6giiKFCYlLcgwKKlLCkuhDan7eN857DYPSQU2a
 85fbRZKPYnon3QeBS5+QT8V2kMqTEBf7qLVJWCPpi/P6XIrg2hlSVAAjfLf1gAaruCIb
 HsmS55PoRa7Nb0tbGpCkyIYKZqDYEHfRv4z877uWmMK4tci+hOyoQPJRnVhSUajeDBLr
 bIYwyit9F6yfLFVMSga1oZjBoep1ouIov8OuUTxQawgx1dd2WAW9wM+YQzGZ0Sl/KZkk
 DV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fMfXWMcLnBG1BaWqMzbahQ8ZxJtVXJSKVHCWC7YPN0U=;
 b=NiM1hbmugXwcF8ZBOu7J49ufSZ6tB811zvMpMrh2YlZqOnJuORa343maHxHfJSbwwY
 EKAPZdUFkZJI0dfQP4oKSj/mK8n2LdVaAk1OUJwYtjGLnE1CvXfdAyIMKlHdGl7hAiJE
 rXK2AdU8p62P02wHptCQ1/nz1z9/MESiiTSUUrLwdF+aBOh8ZkJFZ7km70nadUhGK+mp
 kLasqhtokxUbQOz9/sUzLCmucA0CTeUAhC/yNbcR3+GORrO663u2OpChh5DB/ymfirpN
 gDgRmnWUjUBL1om6EMsC+Zd/h9q6Fyct+AJiTtrsIQq1Z5kAUHt8AhCEnN3RM9GoJ82z
 /LEA==
X-Gm-Message-State: APjAAAUc12+SvXBnQrV8pD+uS0vQQ9eA7GOGI2GkYk37oEHCnOE2fKgz
 QWmPfVAMq9TzXYR93hbLOS/C2w==
X-Google-Smtp-Source: APXvYqzmhPXGo+Sq4SaLmCLh/zakqDM54MZ9hx0f3gPUamBgGRKvguRhaAfPkeP5mE+BVVoJQgA0GA==
X-Received: by 2002:a05:6000:188:: with SMTP id
 p8mr19032533wrx.220.1568037619663; 
 Mon, 09 Sep 2019 07:00:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e30sm26383116wra.48.2019.09.09.07.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 07:00:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66F3E1FF87;
 Mon,  9 Sep 2019 15:00:18 +0100 (BST)
References: <20190830143648.2967-1-alex.bennee@linaro.org>
 <c8340803-34a7-ab53-7791-efdcb734db41@vivier.eu>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
In-reply-to: <c8340803-34a7-ab53-7791-efdcb734db41@vivier.eu>
Date: Mon, 09 Sep 2019 15:00:18 +0100
Message-ID: <87sgp51sel.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] linux-user: fail and report on bad dfilter
 specs
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 30/08/2019 =C3=A0 16:36, Alex Benn=C3=A9e a =C3=A9crit :
>> Just passing NULL means we end up ignoring the bad dfilter spec
>> instead of reporting it and exiting as we should.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/main.c b/linux-user/main.c
>> index 47917bbb20f..50a031520ca 100644
>> --- a/linux-user/main.c
>> +++ b/linux-user/main.c
>> @@ -236,7 +236,7 @@ static void handle_arg_log(const char *arg)
>>
>>  static void handle_arg_dfilter(const char *arg)
>>  {
>> -    qemu_set_dfilter_ranges(arg, NULL);
>> +    qemu_set_dfilter_ranges(arg, &error_fatal);
>>  }
>>
>>  static void handle_arg_log_filename(const char *arg)
>>
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Did you queue this or do you want me to resend?


--
Alex Benn=C3=A9e

