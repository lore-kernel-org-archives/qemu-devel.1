Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2738C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5E12070B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oR61h/5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5E12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQY2M-000597-WD
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56228 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQY1k-0004ic-1V
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:08:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQY1j-0001LU-68
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:08:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46013)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQY1i-0001Ha-M2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:08:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id t14so12568261wrw.12
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qST+qcs+d4E/V6Rj8sWonfhASUPThGb82ThTl3fQeX4=;
 b=oR61h/5qJfuW5L6zhY6RqliwtbeCF6HqBNEjGZ39DWH4TlfXt/un37dYKCv5aakwC4
 xIJ+D5V1zl33T60lhNhObcHPcIG5K7k7toA1nAzGG05Tf11g5STHct8da9bzdDZc8wXo
 mXsbG6PkYvtHq/MIRAUTDPlieHoNZGYJRPjqg+aBXA8vPsMgpiEpPRLR+7yZWmiwUmfl
 jKzDmCY9WX56sKQO7qSxAatV74HF+h1HR4XioeD/Bk88fgwhH9O7OtzXpzHphvtrX1z1
 K3160syDCP1PTRVjODzwlr/BSQIsIbVD++covzQUdo6T6eOVxojLoAt3/hHMTphpyoeG
 w0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qST+qcs+d4E/V6Rj8sWonfhASUPThGb82ThTl3fQeX4=;
 b=c22cT0NIDMjEjZruwut+a6WwJIrJ0r8tz1ojwDdzzlR2YXGHubEAGIlpkYyx328EJu
 kKAiCDLtQlXeL3eq2h7nIwiLEZdFuX/7K3gCw1TdJwoUehYAIIK5rUMcLyoMdFLa0qxy
 zLxkJHHUzgYp/7sPvXNqj1D+P5hsve9ejKt4wWWnw6tQwdR8JnPMVBZZwN9SsuGax43c
 OCVey+K9fSKJEJ/u89hL2972BCSpa4UnXq9YCdirQlEzRvDBNiVHyEpRTPWqWIGitr+S
 2l8rJllpqO0JC9u/G7Kl8wXG5YZvFwnFvcR3XyGiA/mesGO2fz+a1MDZMBSsAJwfUW1u
 QV1w==
X-Gm-Message-State: AGi0PuZrB0paQ6wQvbWQ7RraaJF9wrxVnRuJEdSuDRY1mpxCWwQoqiyD
 p7vxM2GrNKa5Q/LmMsnmtIijgA==
X-Google-Smtp-Source: APiQypJmLSv74KBcg9K45wFB426kn9vymGJnDICyVwOb9X5naSZ9PQ4SzX5QeoGv5tfWIyf8vUaVqQ==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr19685344wro.317.1587395280419; 
 Mon, 20 Apr 2020 08:08:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v10sm1618930wrq.45.2020.04.20.08.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 08:07:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 52B371FF7E;
 Mon, 20 Apr 2020 16:07:58 +0100 (BST)
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <CAFEAcA9Yk53oK5YstN7DpCCq344+tbyjvDA6RaWcJCrL9QSjMw@mail.gmail.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
In-reply-to: <CAFEAcA9Yk53oK5YstN7DpCCq344+tbyjvDA6RaWcJCrL9QSjMw@mail.gmail.com>
Date: Mon, 20 Apr 2020 16:07:58 +0100
Message-ID: <87lfmqdwkx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 20 Apr 2020 at 10:16, Nikolay Igotti <igotti@gmail.com> wrote:
>>
>> In linux-user multithreaded scenarious CPU could be inited many times wi=
th the same id,
>>
>> so avoid assertions on already present hashtable entry.
>>
>>
>> Signed-off-by: Nikolay Igotti <igotti@gmail.com>
>
> Wouldn't it be better to make sure we remove the entry from
> the hashtable when the old thread that was using that CPU
> ID exits, or is that not feasible ?

I'm fairly sure that is exactly what should be happening via
qemu_plugin_vcpu_exit_hook(cpu) which should be a result of the
object_unref(OBJECT(cpu)) in thread exit.

Is there a test vase?

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

