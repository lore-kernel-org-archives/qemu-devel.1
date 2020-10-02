Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D1C47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F53206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c07kYgTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F53206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJE8-0001Oy-5Q
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJDI-0000yp-RP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:27:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJDG-0006Pq-OZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:27:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5so1403951wrp.8
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=i/ksm3Ie/Wc8//BxET3C6kWMb+bPMCUaGWqDezXjCqw=;
 b=c07kYgTcf/nLsTE7xpL8Mpf2eAlCEFw/yH6TfQKVaZ+eHka6tm+TjBClXQIdt7qLHh
 sLyY0hE42sijK+frIW7ABIJYMljCDdeomqV9Z8RPr06q3pmvVumlpfvqb7y+rjgzfaPy
 0H4qONRKmmnvqbJC23XwrCL7MsXjDsFFcs3VrksxOhpXqlFhRy++ZRlR4VIYYdEAW3JG
 Y7kmPCAzkgbrb0ictJi5IkWWa6W1ZzFNccHy8yWZrrp8u5dHKL1XsC0hhgCSzR4cFJ1I
 SzUxNObx/9IgfS/AE6Ibnm7ukhwTkYW4XjlLFzLxFJXzAx48pXiEmewrm8W754YpbaqF
 TnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=i/ksm3Ie/Wc8//BxET3C6kWMb+bPMCUaGWqDezXjCqw=;
 b=mxnPULY+Gejl7UwIJxqyE2SxLB5R8LsW/ulPXfLdEOoOj/6dmnpw9kzsBClm3xIKHE
 DngShzLWFiXjJX02sqgiWVF1TXeRqCeCc9yAdkRB5hxw7+QH31UwkaDkqvaPNEgC/n2o
 UWSOdiEzKXt8UmiQorBpkGXmaEA5N0foQPgBRFivud79aWQAydAdZkw1AiBXzP+egL1h
 qVaQZKrvwDXDIJdi3UM+SUEONpxEB5OIKIYF0FHxWrAfC4fkBHNRmKhtCdQOecInsaG5
 lwWeA9Vr7UjwKv9dOEOMTWPPNzrEUonRkrM7vgZ0F6cRwNj+7QorxdYnZbt/poXYUJbf
 djQg==
X-Gm-Message-State: AOAM531SMlSMY/Q+QkfilbTvZ1WmdZ54By3LuMrB2idZ17H8nEKDDsEB
 2ksfgmh4++5u6ODruCj/j1cpvvmPIEV1KQ==
X-Google-Smtp-Source: ABdhPJwTDCj8emfBxHpYBnkXJOFgTkME9JmyVoBHnOUO2KPEsj3OWo/Uv5PQuTE0Nszr/C7rr8JO1A==
X-Received: by 2002:adf:9e41:: with SMTP id v1mr2743504wre.60.1601638016130;
 Fri, 02 Oct 2020 04:26:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm1408913wme.26.2020.10.02.04.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:26:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B3DF1FF7E;
 Fri,  2 Oct 2020 12:26:54 +0100 (BST)
References: <20201002091538.3017-1-alex.bennee@linaro.org>
 <d5799eff-7760-b74f-9f43-167201d90460@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab: split deprecated job into build/check stages
In-reply-to: <d5799eff-7760-b74f-9f43-167201d90460@redhat.com>
Date: Fri, 02 Oct 2020 12:26:54 +0100
Message-ID: <874kncoold.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 02/10/2020 11.15, Alex Benn=C3=A9e wrote:
>> While the job is pretty fast for only a few targets we still want to
>> catch breakage of the build. By splitting the test step we can
>> allow_failures for that while still ensuring we don't miss the build
>> breaking.
>
> Is there already something broken?
>
> Otherwise, I'd rather simply remove the "allow_failure: true" tag
> instead ... these jobs otherwise tend to get ignored.

Yeah I got a recurring ppc64abi32-linux-user failure as I was testing
the PR.

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .gitlab-ci.yml | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 346f23acf7..a51c89554f 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -270,9 +270,24 @@ build-deprecated:
>>    variables:
>>      IMAGE: debian-all-test-cross
>>      CONFIGURE_ARGS: --disable-docs --disable-tools
>> -    MAKE_CHECK_ARGS: check-tcg
>> +    MAKE_CHECK_ARGS: build-tcg
>>      TARGETS: ppc64abi32-linux-user tilegx-linux-user lm32-softmmu
>>        unicore32-softmmu
>> +  artifacts:
>> +    expire_in: 2 days
>> +    paths:
>> +      - build
>> +
>> +# We split the check-tcg step as test failures are expected but we still
>> +# want to catch the build breaking.
>> +check-deprecated:
>> +  <<: *native_test_job_definition
>> +  needs:
>> +    - job: build-deprecated
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: debian-all-test-cross
>> +    MAKE_CHECK_ARGS: check-tcg
>
> Anyway, that's better than before, so:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>


--=20
Alex Benn=C3=A9e

