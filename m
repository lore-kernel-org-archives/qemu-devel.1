Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C4C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8D320663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGr+V10e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8D320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZ3p-0004R6-TY
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixYAP-0004ar-A0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixYAM-00082v-T8
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:25:09 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixYAM-00080P-Lq
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:25:06 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so8312648wmb.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9z1qTwT+bFUvhY2Fz0CUfsHxHUrXDCl+ExjRUUP10Jg=;
 b=bGr+V10eFQToXptdj420lY3oBduugQFv4Fp3ARYzYk/YqjJlcyfyK3vi9wPcuIXpXo
 R7pKGbxa1R90eIsi2VvoSuYTXEKfXiFZoTTZu1l7Jv3GE67KHGER5ZFBFzQj0xArpXlU
 ET/4lvMLWrrBKVIDBshz1FDJ++3RMTb7xRSnAUPKnH7aurx6gybYrNs3W/iCGui2i9r0
 bDZMnN2S0dJa67Pxti4QYzEyVl6EtMAMrqImG5bhbno1XwzDKHXP/ETP0Gu5P9/9Qoq0
 oVGAH+40Hq3H4KaxMo0mw5XLdmuR+JW8D/zvc481tBAf5uaYox59uhkj/HWi9RkikSzR
 jplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9z1qTwT+bFUvhY2Fz0CUfsHxHUrXDCl+ExjRUUP10Jg=;
 b=adiUwy7zLApx5eKsSvzmhoi/5qZlU1CX+xxWIuF/XO2gQip4tsfPyvoL+RD6wC8shJ
 1r4FgcRATaU1dUhbuvY1KtyMLzqHTBrc3ygti047T4HfmPsYkW/wu7GwNja3NqtpI7pV
 7Asaggusyoc6+YCa52MLZaROQAiliEqHW2Nn2AZCstd2n0KO2VHuWwDUIjb0GoFQAgy1
 ywQGyMZsOrsJJHJjJ7TGihFLRQq2aJZZ8dUW+yFyV8KyVXofcT5ch2XnJj1kESn9OoNK
 qHV9m6vypAj/uxcd3lXIoq7ei8lJW/w0erVu6QhcULYAQ/DUYIaHY6dPJ0TYy90p5ItE
 fUCg==
X-Gm-Message-State: APjAAAVB8tXgj36G03bM/7qUhcHadUTg3Y+WlMlD2LDp8UlL8r7mts5x
 XnM/kJ8k5Vx59GECbgnj8SQMxQ==
X-Google-Smtp-Source: APXvYqzuU6jt3vq3gd3JrLwRe0uLeU9R7qnEXoYQiTtSlGxrlGYnNttGLHb714DQZR6H5sZbCJnLKA==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr12785769wme.25.1580484305154; 
 Fri, 31 Jan 2020 07:25:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c13sm2744049wrn.46.2020.01.31.07.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 07:25:03 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2199A1FF87;
 Fri, 31 Jan 2020 15:25:03 +0000 (GMT)
References: <20200130213814.334195-1-stefanha@redhat.com>
 <CAFEAcA_=_8ZFC=DF3UkqvWqvjQsCHjc=_fYcMmbXs=iLp7JrcQ@mail.gmail.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/5] Tracing patches
In-reply-to: <CAFEAcA_=_8ZFC=DF3UkqvWqvjQsCHjc=_fYcMmbXs=iLp7JrcQ@mail.gmail.com>
Date: Fri, 31 Jan 2020 15:25:03 +0000
Message-ID: <875zgr8x80.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 30 Jan 2020 at 21:38, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f=
57d:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20=
200130' into staging (2020-01-30 16:19:04 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>>
>> for you to fetch changes up to e144a605a614d22165000c69e8e1dc6986d45cd8:
>>
>>   qemu_set_log_filename: filename argument may be NULL (2020-01-30 21:33=
:50 +0000)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> ----------------------------------------------------------------
>>
>> Peter Maydell (3):
>>   docs/devel/tracing.txt: Recommend only
>>     trace_event_get_state_backends()
>>   memory.c: Use trace_event_get_state_backends()
>>   hw/display/qxl.c: Use trace_event_get_state_backends()
>>
>> Philippe Mathieu-Daud=C3=A9 (1):
>>   Makefile: Keep trace-events-subdirs ordered
>>
>> Salvador Fandino (1):
>>   qemu_set_log_filename: filename argument may be NULL
>
> Here's a weird one -- with this pullreq applied I
> see a new warning running check-tcg on the linux-user
> static config build:
>
>   TEST    linux-test on aarch64
>   TEST    testthread on aarch64
>   TEST    float_madds on aarch64
>   DIFF    float_madds.out with
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/float_ma
> dds.ref
>   TEST    fcvt on aarch64
> warning: TCG temporary leaks before 0000000000400a0c
>   DIFF    fcvt.out with
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/fcvt.ref
>   TEST    pauth-1 on aarch64
>   TEST    pauth-2 on aarch64
>
> but I'm not sure why any of the patches here would have
> provoked that, unless they're now causing a log message
> that would previously have been suppressed or directed
> somewhere else to be emitted.

That must be it - before hand we wouldn't have called
qemu_set_log_filename which in turn doesn't call qemu_set_log.

Anyway I have replicated the warning.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

