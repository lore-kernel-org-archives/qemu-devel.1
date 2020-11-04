Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12AD206FA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osQFm1jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12AD206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaM4q-00078f-U7
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaM3m-0005xu-BR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:54:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaM3k-0003uk-FE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:54:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id 23so2266751wmg.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4jjWpn4bcwLC7eZjYcSUVSK/OwVcFjwCXKimzrpEA18=;
 b=osQFm1jSPAgDnLwh/kW/r8CpAJdDTvPMUvweMlat8bmDz4AS0gR7n/zO/DCXS6h49x
 Ai4J45OlWEz5KClmmiorY7ixpxixy6fhNrsSkyE2PLmWdhhBWuoq/Z/DY8QVjK9rtAdr
 c9ysG/C4xXLwJCSHitsgKEWcjn2zDPF2XT6o4LamikLZ8+MuOS0nWbW/c+EH4gkMAYEe
 ayHAaGS9LK9qPDt77/g+Txh464ZW/L25r0lZ9KHNr2KrYOiYgYJuQ7KOMHTNj6AVjhdy
 EUifoyo2hvBIef8RX3+1AUWw3QyqkBHGv9ecKv4yF5u4mVzhu2rpxXYDuRAh9nySb4dq
 yX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4jjWpn4bcwLC7eZjYcSUVSK/OwVcFjwCXKimzrpEA18=;
 b=igxPZe4gxFc2N2DeGmiIkZ5tG/oON2MM2LYT/aII1/tid2t2pYWPdsrCIeMWeFPWe6
 l+feWwz9ysjtKQiQK8HNEw9WEPe550ORfpcJ/ODGyIwwCuaOieB/XwNjM3Tz1KrJh5/0
 qwhO55eNXG/TjGbzB00uJ5XIpL+UkGTSFwxgrC9btj7NMcS/ap5KhS6Iw2ufTdwYLulX
 tqQfn8ic7n+TZgxY8s1D0sc03JAdaTOoph+h4KMq5TBiMH6r2O094SqLGLMuwHCVC3lW
 GKho8eVjYnuJn76rGYxFu/Mfg+JNlfxPusxgDSwtPtzxj51dAqmBOEXsWqIc4pj7k3wZ
 QV5A==
X-Gm-Message-State: AOAM530WHx3LJDZZG7hkUVrbEsSw9oicroFmnNJ5DXEfCAyYEeT7/LHA
 5LyIeGu1tfnTwS+a9GBse5EK5Q==
X-Google-Smtp-Source: ABdhPJynb/uN3jJeod19WJJBzTzFlb9xcseIOuZihTTv0r+4OmJ6ZlLxTCQVXDpCjP/V6uNM9C6QPg==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr5442154wmc.24.1604508895023; 
 Wed, 04 Nov 2020 08:54:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z2sm3009676wmf.45.2020.11.04.08.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 08:54:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F0551FF7E;
 Wed,  4 Nov 2020 16:54:53 +0000 (GMT)
References: <20201103104710.27150-1-alex.bennee@linaro.org>
 <20201103112339.GP1664@vanye>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Leif Lindholm <leif@nuviainc.com>
Subject: Re: [RFC PATCH] docs: add some notes on the sbsa-ref machine
In-reply-to: <20201103112339.GP1664@vanye>
Date: Wed, 04 Nov 2020 16:54:53 +0000
Message-ID: <87sg9pawpu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Hongbo Zhang <hongbo.zhang@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Leif Lindholm <leif@nuviainc.com> writes:

> On Tue, Nov 03, 2020 at 10:47:10 +0000, Alex Benn=C3=A9e wrote:
>> We should at least document what this machine is about.
>
> Thanks!
> (comments below)
>
>> Cc: Graeme Gregory <graeme@nuviainc.com>
>> Cc: Leif Lindholm <leif@nuviainc.com>
>> Cc: Hongbo Zhang <hongbo.zhang@linaro.org>
>> Cc: Shashi Mallela <shashi.mallela@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  docs/system/arm/sbsa.rst   | 30 ++++++++++++++++++++++++++++++
>>  docs/system/target-arm.rst |  1 +
>>  2 files changed, 31 insertions(+)
>>  create mode 100644 docs/system/arm/sbsa.rst
>>=20
>> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
>> new file mode 100644
>> index 0000000000..a47c9360de
>> --- /dev/null
>> +++ b/docs/system/arm/sbsa.rst
>> @@ -0,0 +1,30 @@
>> +Arm Server Base System Architecture Reference board (``sbsa-ref``)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +While the `virt` board is a generic board platform that doesn't match
>> +any real hardware the `sbsa-ref` board intends to look like real
>> +hardware. The `Server Base System Architecture
>> +<https://developer.arm.com/documentation/den0029/latest>` defines a
>> +minimum base line of hardware support and importantly how the firmware
>> +reports that to any operating system. It is a static system that
>> +reports a very minimal DT to the firmware for command line input to
>> +the firmware.
>
> I think you mean the right thing, but ...
> "a very minimal DT to the firmware for non-discoverable information
>  about components affected by the qemu command line"
>  (i.e. cpus and memory)
>
>> As a result it must have a firmware specifically built
>> +to expect a certain hardware layout (as you would in a real machine).
>> +
>> +It is intended to be a machine for developing firmware and testing
>> +standards compliance with operating systems.
>> +
>> +Supported devices
>> +"""""""""""""""""
>> +
>> +The sbsa-ref board supports:
>> +
>> +  - A configurable number of Cortex-A57 cpus
>> +  - GIC version 3
>
> The intent was always for sbsa-ref to be tracking SBSA development, so
> I wonder whether we should be documenting specific versions of cpu and
> gic (and then keep remembering to update the docs).
> My short-term plan was to swap the a57 for "max", but
> documentation-wise, could we just say "number of aarch64 cpus"?
> Could we refer to the gic as "latest supported emulated"?

I'm not sure we want a movable feast... shouldn't we at least provide
compatibility for older variations? -cpu max is useful but you can get
new features coming out of the blue.

--=20
Alex Benn=C3=A9e

