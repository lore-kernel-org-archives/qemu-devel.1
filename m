Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA60C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063E821739
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNLv8+QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063E821739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1yv6-0001wc-7G
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1yu4-0000zv-Dj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1yu2-0001kh-FP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:46:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1yu2-0001kN-C4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581540393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEdks3rQKrJTFqonrFevREq8Bri/rVuT/o9w6rSv3do=;
 b=hNLv8+QBy4dW3xqXVHoNO1H7e/fj2wdLGcW91ZQX7NCpalYbM0Ei+R1GH6T+VyPjcXVhcq
 /jXoM/CaTiaEdRWL9metKWV5VjyXUOAjuUKymmJfOjye8qUz5rrlOzIarLaIhyRH1sL8Qa
 fuQXdBWZb7p6MbVkiX2182ae87xRJMY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-VKoCgtJZPYiCo_Zcdr8F3A-1; Wed, 12 Feb 2020 15:46:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id p8so1330233wrw.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2LNZd6DCpH/KhHmzWPs1lUFa5pUuo/VgbkG162WMYOg=;
 b=m4cffR1R82wWCgtYmfVcaKBXd5pUP0DqOuUjD3vg/iMtaS3yu8SKKWtjLonSHRpLZN
 2Y7qpJxvuueGIIAEz+6tTdtR2mjF2owdv6wmoRy/aUXPvGf8ozFhDEt0V5rZR0bYOkvH
 wvxpV7br3ylNuZ73o9zGZtFM9RtHR6aC3/MAt1HlQ4oICvRBRaoQgCaghuVCgOuMpvUK
 9ToMUAAYDIavNlFWr/F3EJTsEh0P3LbETAGFurURNQzPARyo2HIGdhjoup71it7rD3yr
 DxpSiivZ2/FFrh6U4S/lFvg+REi4mJ7OpT3BBceTiiApqVos1Y43YCxLsNJp8mqpcMx9
 ErTA==
X-Gm-Message-State: APjAAAVzrpUwz8ElvrvZRzca8TfJdAcrL5Tl5JOFB8LbLiHRxQetn9+I
 1A1m51WWSpquaCjn7JM0HCNKX2uzjxrcFrc+kOjnAuKVTHpOT4r+x1jUZSXnBlRBj7Tj0V3oQKv
 JOpaTrmN5nQNU/7A=
X-Received: by 2002:adf:f54d:: with SMTP id j13mr17050211wrp.19.1581540388210; 
 Wed, 12 Feb 2020 12:46:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfD+7U13uqs5XUaJznR4QLmuoRWHsDvJ7rkEMlbkXiUM+CZPFxDG9nmOUZTMrInXXgyBvJKA==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr17050186wrp.19.1581540387970; 
 Wed, 12 Feb 2020 12:46:27 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id e16sm2092922wrs.73.2020.02.12.12.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 12:46:27 -0800 (PST)
Subject: Re: [PATCH v1 2/5] tests/rcutorture: update usage hint
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200207113939.9247-1-alex.bennee@linaro.org>
 <20200207113939.9247-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0bf5f39b-14ea-8dc0-c787-d92fdc944448@redhat.com>
Date: Wed, 12 Feb 2020 21:46:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207113939.9247-3-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: VKoCgtJZPYiCo_Zcdr8F3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 12:39 PM, Alex Benn=C3=A9e wrote:
> Although documented in the comments we don't display all the various
> invocations we can in the usage.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/rcutorture.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/rcutorture.c b/tests/rcutorture.c
> index 49311c82ea4..e8b2169e7dd 100644
> --- a/tests/rcutorture.c
> +++ b/tests/rcutorture.c
> @@ -413,7 +413,8 @@ static void gtest_stress_10_5(void)
>  =20
>   static void usage(int argc, char *argv[])
>   {
> -    fprintf(stderr, "Usage: %s [nreaders [ perf | stress ] ]\n", argv[0]=
);
> +    fprintf(stderr, "Usage: %s [nreaders [ [r|u]perf | stress [duration]=
]\n",
> +            argv[0]);
>       exit(-1);
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


