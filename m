Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A2CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4165C20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccomMQYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4165C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbtn-0007Y6-1e
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNall-0005s4-UU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNalk-0001sd-Es
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:55:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNalk-0001rt-5Z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:55:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id n15so14748054wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ooMnS0LiPSQoZLGSo+BzkAeumpBfuLiUsvNynH34FnY=;
 b=ccomMQYAOSm8l1lLMd2EqP92RmWWEara7WJH+4A2UAHdA4FQY/31xdvwbf07joEMN9
 XswSz6Lvw7HcUzrbxoFxQzZYWYTOUACIJQggeYdTY0o8gtreAnVP+E2c1fZw2guI/wxz
 TJktbmL3k7Qpk/0K9IlfyffKhT3Na9QdsXyGhG5mGFdz5uFrf6Q65wftFr/yTWcgvbfN
 lmDT3WRyHLOmBngVLZTOz8n4h0t0kH/GjSTwwQ1ySnf66ekW8ujvolKpR4IlMP5q+bI8
 nAT1z3wd9b3wTvb4IGVWSCQje+DcJZU9f6HATlUZw1YGlqGqoknYS0+R4GtNNb5QD/Xm
 AxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ooMnS0LiPSQoZLGSo+BzkAeumpBfuLiUsvNynH34FnY=;
 b=Cj/n5p1+37T2ja4SBmvB6A0akUxpz/si4UANpqsXCXoswBw6AkkoceycSK1wBQwpLJ
 B8DP7ULcfaXmdjeBUP0AokqoP27dYms+M18W2MhMkQYb5FfVt9lm+qGinwh5sWVJ8I9c
 yycKTUpzC0XEo7X1CdjWDoA850O/Dl1MhhXnyUZ57ZU4XpKZ+m55V/NnOAP5owIOgPQm
 iS+0ZgI5kr4KPGntXhUUmiOL9GXJ26tAtrB2L0kDNUbwPpISQcGoQXM/ho/Nd/v/LT3j
 MvMIhwkhrZoE1FSmT+7ZK91vuF7mp4xqk/uVnXUTb7wTTGg6gxQo0s4LX+yIrpfNPYH6
 xtTw==
X-Gm-Message-State: APjAAAUhFUas0aIJijQZRV3667l51hk+IU1rNz3rYKA2pRQvlsABYrbH
 SaAHuG/S7D/Acyk51kCz7xEFSA==
X-Google-Smtp-Source: APXvYqwk+aY7LBKL7MsN0ILG7pWrZEzxLRXyzI7Wj4jCmYVAWg6w47eAtj9qlxGF6btnjzmR8u/gzw==
X-Received: by 2002:a05:6000:10d:: with SMTP id
 o13mr3147233wrx.321.1571914502112; 
 Thu, 24 Oct 2019 03:55:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h10sm22224040wrq.95.2019.10.24.03.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:55:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 676211FF87;
 Thu, 24 Oct 2019 11:54:59 +0100 (BST)
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-8-alex.bennee@linaro.org>
 <CAFEAcA9jeb_KBy9jMrFoY9=fp0+7YqNU8WrhRr7zxAk308MFXQ@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 07/19] cirrus.yml: reduce scope of MacOS build
In-reply-to: <CAFEAcA9jeb_KBy9jMrFoY9=fp0+7YqNU8WrhRr7zxAk308MFXQ@mail.gmail.com>
Date: Thu, 24 Oct 2019 11:54:59 +0100
Message-ID: <87imoemn0c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 22 Oct 2019 at 20:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The MacOS build can time out on Cirrus running to almost an hour.
>> Reduce the scope to the historical MacOS architectures much the same
>> way we do on Travis.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .cirrus.yml | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.cirrus.yml b/.cirrus.yml
>> index 8326a3a4b16..4b042c0e12c 100644
>> --- a/.cirrus.yml
>> +++ b/.cirrus.yml
>> @@ -1,5 +1,6 @@
>>  env:
>>    CIRRUS_CLONE_DEPTH: 1
>> +  MACOS_ARCHES: i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86=
_64-softmmu
>
> I don't know whether Cirrus is our long-term plan for doing
> CI of OSX (maybe we'll be using Gitlab and some runner on an
> OSX platform??), but as a general point: since OSX is one of
> the non-Linux hosts it's therefore worth making sure our
> compile-coverage is as wide as possible, not narrow. It's
> safe(r) to have narrow coverage of x86-Linux because people
> catch issues with that anyway, but it's exactly the less
> common platforms like OSX, the BSDs, odd architectures that
> we want to be compile/make-check testing as much of our code
> as possible.

OK I can drop the patch. It seems the long builds are just a random
pause that occasionally happens on their MacOS host.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

