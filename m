Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F492C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A15422CF8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJGEwP52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A15422CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Xjx-0003j0-0e
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2XjB-0003Eb-Pi
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2XjA-0004gf-Gg
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:25:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2XjA-0004dz-4w
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:25:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id p74so2282555wme.4
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QrRpDfhnbpm3wqjOmkPhUCBCrFOn79sXfdbH8pLgtR8=;
 b=bJGEwP52d919ypL4EkxaT7c+pNl/ifqMllRhib625NDsKKeCa80Pro5/ig+g/lNcwt
 56j4IDH30y8NZ6LzOs1Z5dRb0kISUtQKnsbA/RESbbq3EthyH4LjwINeLP1bSUrY+VZD
 iBqMayzwYsk8TGErtV7vgRLU/ZCEfyXlFb/51U2SrIV/Hd/XLTdVCKPoA/CO1udOASlm
 dDA9xAIXXBPcOsPYqKFIVesiYNT9yCyXLYwG0Yf2oJHyeFKjZdNqv9B3RRzUEhEcIlE7
 OxaSlDQ4i+jGAREXQi24L/Z7mrYy8BKbaZf7eyamhY5SUK/aj6zLYqMy3RkqETDdpLA/
 tk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QrRpDfhnbpm3wqjOmkPhUCBCrFOn79sXfdbH8pLgtR8=;
 b=ZiqeeTDJ2SY1B9oKOtRn00DPhdDnHTW9IiRK0/HJZ7dsWrNt/NOsZTUBdYoh1B1h2t
 vUOl7l5lHxm3I/9ZloTB8MbvvGs+Txg1ObDb4vBbh6+swjNEsCJvQHhEirQDGsE125fQ
 1iu+9v6ABGsXAwyBAqHVu4Byp8Y96hOM7a0S/oe387gHyL5cLZneaXCj+cMdTjPDLrPK
 LPPl/+ylcjRCg4iSkWjKvo5VS7AzRIb+a8Q681DCqSJngyZJjgr9E2MKVsB79ckraV2e
 V/QHgiKPA5BuVjEanBLty7DkW7HH+iMZiEhse6O86hlmRi40wzhzMtR/Cx+IjP0gvlXW
 e2Qg==
X-Gm-Message-State: APjAAAXTXjJ7BlDRaAGrVeFSvv1auMBHRtweBYY8a6eLwHuvUoejdqQT
 Xii0t10YyhYtqO7mdmImrpF6Mw==
X-Google-Smtp-Source: APXvYqyQ0xvhwydyom7doeLRNr9AT4XO/x4ZhU053jDBJCeBD2PBn57uX3r1u8HSJfZNxqBXyJOPng==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr26343447wmh.69.1566897921941; 
 Tue, 27 Aug 2019 02:25:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x9sm2714327wmi.10.2019.08.27.02.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 02:25:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93A6F1FF87;
 Tue, 27 Aug 2019 10:25:20 +0100 (BST)
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-9-mrolnik@gmail.com> <87mufwz3e0.fsf@linaro.org>
 <6c7f5897-e7ed-b5f3-f167-78073a9e5b67@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <6c7f5897-e7ed-b5f3-f167-78073a9e5b67@linaro.org>
Date: Tue, 27 Aug 2019 10:25:20 +0100
Message-ID: <87r25755a7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v29 8/8] target/avr: Add tests
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 imammedo@redhat.com, dovgaluk@ispras.ru, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/26/19 2:23 AM, Alex Benn=C3=A9e wrote:
>> Are there any compilers available so we can add the multiarch tests to "=
check-tcg"?
>
> Debian has a gcc-avr package.

Looking at the bios "bytes" it should be easy enough to do a simple
serial based test. We can add it after it's merged though... is it ready
to go yet?

--
Alex Benn=C3=A9e

