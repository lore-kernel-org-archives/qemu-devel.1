Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB2DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587B620848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqD/ilEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587B620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABW2-0007Sb-HY
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jABVT-00071N-49
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jABVR-0006l6-RL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:51:06 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jABVR-0006kR-IZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:51:05 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so2002566wrn.6
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IzWAOuUZuk3+qrPCYpt5N4XDCb784IMTeW0/XwQlziY=;
 b=hqD/ilEGCUQFBbFkxZvNorYg/DFQ0IaUBYvKZbPC80jsAbs9JfEL0FsQlagZ9wDjuY
 R57oUA3ch/n0VAZl+m99RVTd4JIsc78fa4caIEFUlaw7J/ELZ/DnT/O7CQ4lqs8p6cfE
 x3POw9YtiDBSAQKzJ6PCGJOetME4Krfa8IDeJKXnyLtxHn7TDVJNw9S2w9M42UR4k3Pb
 3Ck9VBFlJX0fndRY2Hn4x5y1Y0zhxacRBDRXJkmc76ZRmt4SUbTEaUkaQEz9UbMC22FT
 AkrwQUTDbeY3Drzzg36q3E805dAoj3yhMY4TwO7dOXek7iSRlwqWbsR5MVgTwC8W7Dgc
 VS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IzWAOuUZuk3+qrPCYpt5N4XDCb784IMTeW0/XwQlziY=;
 b=dFeSpKXCxN3LI7XY0SQglkPfgo5zKZbPRt+7dIKofzA27y8/D6s5a8hRb8ZP7eHYtd
 MxpKHhFDah4GRfkLLV0xzansvRAAenZg5KuVbTNsKDARkCUQx1N5fBUOrEStgOvAHr91
 Vx4gEqTzoOWwlz6qIIH7Cyj1EL3mLTBQt+DTZAJbzc2GDu3/zNU0MOUymARzSO1nyRU8
 OZsfBAeEe1xWWNpuY9hZ4ww4bBq2MrFPcRroRMGLS4uaqErwWQC4ZnckahAt1IRsXQs6
 +f9+sABdpin73/cST4yp5loc7JPcduRmuNMutVSLFE/qOS7xgQpZ0mPWmYu7Rea6Mp+r
 paAQ==
X-Gm-Message-State: ANhLgQ13dn6JRKgP6Nvycpg5F1hejj0pBHAl5sZcjmJJFlqMzjCBvNz7
 C5IBVJpW8plUexryZUjJ+S+LBQ==
X-Google-Smtp-Source: ADFU+vt3Rbm4mw2+xk0H9WbyxMiithM7TkwjVbzf7BFBxGHAwHSEaPnrYavwvGAGt/qnpuTiKMy2PA==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr3699051wru.421.1583495464082; 
 Fri, 06 Mar 2020 03:51:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f8sm5929376wmf.20.2020.03.06.03.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:51:02 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 44D7F1FF87;
 Fri,  6 Mar 2020 11:51:02 +0000 (GMT)
References: <20200212202738.12986-1-philmd@redhat.com>
 <4481651f-1c10-ca86-dc57-02aaff7d2a1a@redhat.com>
 <030679b1-2fb7-0687-9ac7-f2cfe4ed8b02@redhat.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/docker: Install tools to cross-debug and build
 Linux kernels
In-reply-to: <030679b1-2fb7-0687-9ac7-f2cfe4ed8b02@redhat.com>
Date: Fri, 06 Mar 2020 11:51:02 +0000
Message-ID: <87a74t66s9.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> ping ping?

Queued to testing/next, thanks. Sorry for the delay.

>
> On 2/24/20 1:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/12/20 9:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>>> We often run Linux kernels to test QEMU. We sometimes need
>>> to build them manually to use non-default features. We only
>>> miss the tiny 'bc' tool.
>>>
>>> The ncurses library is helpful to run 'make menuconfig'.
>>>
>>> Finally, gdb-multiarch allow us to debug a TCG guest when its
>>> architecture is different than the host.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>   tests/docker/dockerfiles/debian10.docker | 3 +++
>>>   tests/docker/dockerfiles/debian9.docker  | 3 +++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian10.docker
>>> b/tests/docker/dockerfiles/debian10.docker
>>> index 5de79ae552..2fcdc406e8 100644
>>> --- a/tests/docker/dockerfiles/debian10.docker
>>> +++ b/tests/docker/dockerfiles/debian10.docker
>>> @@ -17,14 +17,17 @@ RUN apt update && \
>>>       DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>>>       DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>>       apt install -y --no-install-recommends \
>>> +        bc \
>>>           bison \
>>>           build-essential \
>>>           ca-certificates \
>>>           clang \
>>>           dbus \
>>>           flex \
>>> +        gdb-multiarch \
>>>           gettext \
>>>           git \
>>> +        libncurses5-dev \
>>>           pkg-config \
>>>           psmisc \
>>>           python3 \
>>> diff --git a/tests/docker/dockerfiles/debian9.docker
>>> b/tests/docker/dockerfiles/debian9.docker
>>> index 8cbd742bb5..92edbbf0f4 100644
>>> --- a/tests/docker/dockerfiles/debian9.docker
>>> +++ b/tests/docker/dockerfiles/debian9.docker
>>> @@ -17,13 +17,16 @@ RUN apt update && \
>>>       DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>>>       DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>>       apt install -y --no-install-recommends \
>>> +        bc \
>>>           bison \
>>>           build-essential \
>>>           ca-certificates \
>>>           clang \
>>>           flex \
>>> +        gdb-multiarch \
>>>           gettext \
>>>           git \
>>> +        libncurses5-dev \
>>>           pkg-config \
>>>           psmisc \
>>>           python3 \
>>>
>> ping?


--=20
Alex Benn=C3=A9e

