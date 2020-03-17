Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFF4C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E53206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKmmba/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E53206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECjj-0002Rd-T6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jECir-0001vX-MX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jECip-0006Kc-Ag
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:57:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jECio-0006GV-0b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:57:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so25817526wrd.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SWpFu5k+3xxOIq1pztcGURGIotm+HV+AkUgWti6Vq0A=;
 b=wKmmba/mONMshQwvBUuo3cZyqh3849IZ1lQgAQnCpCHYXy2cogCBkEKWO8i2BPJKtw
 mHIegzI7k3zp3uHqRpr0MZj9sa2jYfebDozJMowKUXEBBXqC65ZERRDBhgKwBrXUsg4g
 +/tYabGQhI+94CxjBzKXMlj0fyq7TLVlbeKPQQzj5X/Px5+0+0hspyDst7wK8vM01FM6
 f1pmKQOFVVCnK5N+FOtglNw7aUqQM+VjIA88+Pqmv7pw/B+NX+JpAFRnDXj3rUICCKCC
 JvXOfurpEwJw6pdFon1pME5YCwuuqOgRh49tau+SHpRb8k9ztuOMDAw4RcRMVsFUBFjO
 gKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SWpFu5k+3xxOIq1pztcGURGIotm+HV+AkUgWti6Vq0A=;
 b=ibd1/GxxfLihi0BX5rYbJxoNEkrUVsxdoytyRZATtTRJsI3zhhJ8IzqjMZt44rpMRV
 WkEEMHFzM59+mHRD8YRnH2uJjH0wiikazRz/PblTkILaPEET7bn4YT0DHMKzvTtVrz+A
 Ox79iaIgW+pWF7fKeW17Dd3/wn/4bCgsi7+ulyAXoeOJdxb92A2GOFKtleyRMFcBMZkk
 jLhSPeo2yHic+z0Xc70CNmGOLjqrisAccX5Tmuxtd99SfnaWLCHWCdMzCjFihsQF8R4k
 t8k+W+Jkj+nMZ0NVkzfqVvp7Y74KEU525LVJ0l55PMb798MD1WOddHIYwcVrRpiUtEAB
 xqMw==
X-Gm-Message-State: ANhLgQ3zsoUAWwNMqzAn3LLUz2bPlWTL/GKQZUf89MIokrOXh6uon5B4
 ZQiYz8tYl3DXgbvqpdeY5C8Ytw==
X-Google-Smtp-Source: ADFU+vujfYcMRmKEntFNzR9d3cQbkspo1F7ANk+PuabLLTyRFmnxx51f7LhKKG5T82dWFnW6ukZaag==
X-Received: by 2002:adf:9c8d:: with SMTP id d13mr6304069wre.6.1584453447211;
 Tue, 17 Mar 2020 06:57:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f12sm4070716wmh.4.2020.03.17.06.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 06:57:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 03B041FF7E;
 Tue, 17 Mar 2020 13:57:25 +0000 (GMT)
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-25-alex.bennee@linaro.org>
 <3d01f357-eeb6-7fd7-1895-feae05beca99@redhat.com>
 <CAHiYmc5CtAH-zs38YmyLkrrp2DnxzLUWNKBTcL+oyFNEiCsV8A@mail.gmail.com>
 <CAFEAcA8FSwVeOVDWT8qRO_EL2OncxdgGZbNHH8VhaaoKuwS7_w@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 24/28] tests/tcg/aarch64: add SVE iotcl test
In-reply-to: <CAFEAcA8FSwVeOVDWT8qRO_EL2OncxdgGZbNHH8VhaaoKuwS7_w@mail.gmail.com>
Date: Tue, 17 Mar 2020 13:57:24 +0000
Message-ID: <87imj3jd8b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 17 Mar 2020 at 10:45, Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>> I think it is also a little problematic that tests like this reside
>> and belong in tests/tcg - since they deal more with elements
>> of kernel interface (system call prctl()), rather than TCG.
>> Still, I see there are many other similar cases in tests/tcg,
>> so probably (at this moment) one should't bother about it in
>> the context of this patch. However, in general, the location
>> /tests/tcg for all these cases seems wrong to me.
>
> Well, the only reason we have the test at all is for testing
> our TCG emulation. Generic tests of syscalls don't live
> in QEMU at all, the best place for those would be the
> Linux Test Project's test suite.

Yeah it's all for exercising the TCG. I have run tests/tcg/aaarch64
binaries on real hardware from time to time but it's not the focus of
anything in that directory.

--=20
Alex Benn=C3=A9e

