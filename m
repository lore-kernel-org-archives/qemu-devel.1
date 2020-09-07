Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EFEC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533002078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQL/Mpck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533002078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDCO-0001ah-FP
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFDBq-0000xh-Kv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:11:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFDBo-0001xD-RJ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:11:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id m6so15010195wrn.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r3yL4F/BREaE/irOx7QyIAYifrGcKLqErgVN72uinxc=;
 b=TQL/Mpck5+11R0ZBGEu2V/9bsOGEfVfUnhQUEavfbBOnqBNdKFGj5uYR8Jr3cuFvwE
 cM1pvWMVvRSdBvc4fZTNWdr41mJmFQgUxtG1sx6cuUOCyRuNdbJm296FCs3r/GvSCRFQ
 YP4ebXwVPZZBtqez3662iE0KjxqpqUCLZ/BDyf1XRODaQj1bEQY0mTlIn3sWPmrfocsb
 gwUsgL8sGzb7I2oncpUh32Mc4MnL/co2nISqPV8PJZXOsT+ttpTCrhFOpCQ6hxdfKZLl
 dG7UXDpvVwtQkqNcoEn1DLYrtMRu6S7/dkWiSyJLBYrRQaJD7ubPinFg5MH7Flf8SfVr
 d1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r3yL4F/BREaE/irOx7QyIAYifrGcKLqErgVN72uinxc=;
 b=UoENv8D0k2fBO8YnjuLC291/blW+nlpF4RXAEVsplGUoQ40eUkGbaHyCy9EOo0nqJa
 ZpHIK9QVzWxo23tEgmO48LfRbA9IxKT4kMH9keXYtiKWqIZ7omt2Mf6v9WDhAlXDaV6V
 jU3QI4T7lQHcB744dCMcqQ8AFT4ckSwPrlLHmzEIJ7NMZaK79ZSQ4VxJK7SoRu25YRs+
 rY9pnMruJ3OvKb1fRNjdLePiBv4xUTQMXqz4ZSRkVWeeRS/GY/P+ZTFXrYkrxrdD9fUm
 jJSTTud7a+QbxhMM8SFdONfdOqr9/7qxmNyiuFkIVq3joG2gnvvz0c63o0vBE8HDH8I8
 LDEw==
X-Gm-Message-State: AOAM533Q/2EEYbkDV5lcxPj8bcGCO1M0p8BLHD7AT2+nkA1lH7byM9Um
 pPua26tRYvjBrVF8oZ7LZXViMA==
X-Google-Smtp-Source: ABdhPJz0Y0zuFqjfaAOb3nqtirWHg2p4eipJBYBYbzWL3ifhaI8WE/7Cu9c9+BqqOYHM6R9Yxgb1YQ==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr19808553wrt.32.1599469911424; 
 Mon, 07 Sep 2020 02:11:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c205sm26164349wmd.33.2020.09.07.02.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 02:11:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 667D91FF7E;
 Mon,  7 Sep 2020 10:11:49 +0100 (BST)
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-7-alex.bennee@linaro.org>
 <CABgObfZ_Xdd-pnRjpWO=8NjEznZhz84DTq95OzCdjL_rxnw=XQ@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 6/8] tests/meson.build: fp tests don't need CONFIG_TCG
In-reply-to: <CABgObfZ_Xdd-pnRjpWO=8NjEznZhz84DTq95OzCdjL_rxnw=XQ@mail.gmail.com>
Date: Mon, 07 Sep 2020 10:11:49 +0100
Message-ID: <87a6y2rlwq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 f4bug@amsat.org, "Emilio G. Cota" <cota@braap.org>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Il gio 3 set 2020, 13:21 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scr=
itto:
>
>> As the tests build only softfloat.c no actual TCG machinary is neede
>> to test them (as is evidenced by GCC check-softfloat). Might as well
>> fix the wording on Travis while at it.
>>
>
> The reason is that softfloat is not built at all into QEMU if !CONFIG_TCG.
> We similarly skip block layer tests if !CONFIG_SOFTMMU &&
> !CONFIG_TOOLS.

It's not built anyway if you don't call the test. Are you saying a
--disable-system and --disable-user build is invalid for running unit
tests? That is what check-softfloat is doing as it doesn't involve
softfloat built into any qemu binary.

>
> Paolo
>
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml       | 2 +-
>>  tests/meson.build | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 1d0ade0a133..65341634d02 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -138,7 +138,7 @@ jobs:
>>
>>
>>      # Just build tools and run minimal unit and softfloat checks
>> -    - name: "GCC check-softfloat (user)"
>> +    - name: "GCC check-unit and check-softfloat"
>>        env:
>>          - BASE_CONFIG=3D"--enable-tools"
>>          - CONFIG=3D"--disable-user --disable-system"
>> diff --git a/tests/meson.build b/tests/meson.build
>> index fe2c6d8e6b6..bdcc5d75293 100644
>> --- a/tests/meson.build
>> +++ b/tests/meson.build
>> @@ -7,8 +7,9 @@ test('decodetree', sh,
>>       workdir: meson.current_source_dir() / 'decode',
>>       suite: 'decodetree')
>>
>> +subdir('fp')
>> +
>>  if 'CONFIG_TCG' in config_host
>> -  subdir('fp')
>>    if 'CONFIG_PLUGIN' in config_host
>>      subdir('plugin')
>>    endif
>> --
>> 2.20.1
>>
>>


--=20
Alex Benn=C3=A9e

