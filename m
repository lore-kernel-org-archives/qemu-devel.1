Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A630DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7036A2070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSfvIAIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7036A2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jxv-0003yG-Lb
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Jww-0003Vm-LK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Jwv-0004EM-32
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:31:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6Jwu-0004DV-R7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:31:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id t17so7621937wmi.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4SsIC9L9hhwDmbpA9fN0dmF4lf9/FJI7d/JyJxbweU8=;
 b=zSfvIAIbCNiU9P1+UTUHnCkX6xZ19iA4oF0vDBWg863wN2NmVPH5NOZRlvpTluFPt+
 nQS/s8wJYkvyRNduAtrSqpLgem7nhueo2P+mCaVnBzxCIjtWZvOunt3GvN+fCk5SoJH4
 SwcRzbik8M+ICkjNPKYeFSAKGTYbdBOTxL1jeAu/0m5YHKDFeU5Bg+FdKLnsXueuLq7j
 HKcxSkUccNnTHM+nDO/K6Q0Gwzy0DwGj2foMZSq5rFQCYkbKLqGjSj/WiIPd7F85VpUc
 yigIyj3cycW+wP07BMqHtu2/Ycdlci6NBF+LuMSwQURSMwPQhQoCjtSRSR6BqyOw1faz
 1Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4SsIC9L9hhwDmbpA9fN0dmF4lf9/FJI7d/JyJxbweU8=;
 b=bE3YplYJL025+309skM94jBdbHN1FkGPo9bv5mDerOPT0eSqEJi6iwQicYWwGZ+z5y
 RUm4Ryn6PdSu6+Lf2WT35dTF2i0S8waAEjxA/+hAiOilDcI5UhJ1YO0WKcoQnPirRQyt
 d1A3DMzCTPvuUWGiHchxeMBLtniuiiXSu2dw6O2geL46vAof+BevdZQILdOxanaCVobW
 YyrV92nqWpaLfZbWdslJDjcknYaM5/5kqQAllWCpahHUjerLDFOjbScP0keiTt5LVk1a
 KLZpEkMXkrVd/USzVcnwzVDYh3wuxZIynngu2bj4x/7WhzWdbfBXhn0HNx/3UTwCgIim
 4pWg==
X-Gm-Message-State: APjAAAWz1hBu7qMtfB2s5egnzU0YrWgH1rYf8S1rppxa5/MO/yMYQZdA
 l6sXYf12VEJpyG6PE2DVDFzGAw==
X-Google-Smtp-Source: APXvYqx2fkdK/kzbvAVVQzmkRPstr8Wj0+ikATw7StcQk6JN9EjHJU1UrxtJRjZtaTPaMlTz8bTCyQ==
X-Received: by 2002:a1c:7a14:: with SMTP id v20mr9383069wmc.75.1567798271309; 
 Fri, 06 Sep 2019 12:31:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm5859061wrd.39.2019.09.06.12.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 12:31:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E439B1FF87;
 Fri,  6 Sep 2019 20:31:09 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-14-alex.bennee@linaro.org>
 <20190802182541.GO5034@quinoa.localdomain>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
In-reply-to: <20190802182541.GO5034@quinoa.localdomain>
Date: Fri, 06 Sep 2019 20:31:09 +0100
Message-ID: <877e6lz0g2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH  v4 13/54] plugin: add user-facing API
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
Cc: "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> One thing I would find useful is the ability to access register values
> during an execution-time callback. I think the easiest way to do that
> generically would be to expose them via the gdb functionality (like
> Pavel's earlier patchset did [1]), though that (currently) limits you to
> the general-purpose registers. Ideally it would be nice be able to
> access other registers (i.e. floating-point, or maybe even system
> registers), though those are more difficult to do generically.

ARM already has system register support via the gdbstub XML interface so
it's certainly doable. The trick is how we do that in a probable way
without leaking the gdb remote protocol into plugins (which is just very
ugly).

> Perhaps if we added some sort of architectural-support checking for
> individual plugins like I mentioned in another response to this
> patchset, we could allow some limited architecture-specific
> functionality in this vein? I confess I haven't thought through all the
> ramifications of that yet, though.

I was wondering if exposing the Elf Type would be enough? It's portable
enough that plugins should be able to work with it without defining our
own architecture enumeration.

>
> -Aaron
>
> [1] - See qemulib_read_register() at
>       https://patchwork.ozlabs.org/patch/925393/


--
Alex Benn=C3=A9e

