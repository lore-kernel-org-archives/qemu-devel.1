Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80C3C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F0B207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYzMOHii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F0B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih9jO-0003xr-Op
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 05:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ih9iY-000318-Ls
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ih9iX-0006EY-ID
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:04:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ih9iX-0006EU-EP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576577077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loAK4kVwopibUcm9RXYBoS7F17AJtpqG86ZIEZJUItE=;
 b=EYzMOHii4hYjKZmVmwsEU53avx8e53dyuhrXTujWJ5OEJhIEE85MScDR0ep0SXIWR5ECu7
 AkX/6yI+YNn6KDW45nizX9yHsOHYUX8yTygp8dzxedsDisJiwYxWEh+X9lMPpmaZIGQ3e3
 4nXax4TvxPowOpf3lm3AqzRXfXx77P8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-ivCw0fHBM_mJoO3j6QE0uw-1; Tue, 17 Dec 2019 05:04:35 -0500
Received: by mail-wm1-f69.google.com with SMTP id q21so179688wmc.7
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 02:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D6qcer7pEfC9pWYO7pBi1lXIWSygHQ8u1k+W/Teuk1I=;
 b=FB51Jq9b/s9A3KZ6LUjM/j4zjqnrT/VheW+HnYnHTcT155k5SYl6FlaOn+Gz4ExP3g
 dnksA2eyJGCYV+HYwmjjZTAIOCAU2tCvCjRioFO9nClgA74kKMm5I6AXFutNgRuso5yp
 VQc48+ruOgxGoPs0tKU3FEokTCkjrOhP6Cj86q9PQhAci8R3UZJSh+vUGr0XJU4wer5M
 bxs1rp0dcwM4PWtFhcE2aUkfRRwmiahk39HTWrM2A6sN5DrcLkXpo8EmHbGMjK+XpXK5
 dncVG20tgT63Rbwhn74cwaKpdfZmdFM4oQJC5jYLYqGx397cN7LxyN2eciqnPclIuyAQ
 Bj4g==
X-Gm-Message-State: APjAAAW5plVxsyWItZ/9V5j5OG2BEqXevQpqzu+RwcVs5ySHUt/a0gd9
 e9I8SRHQgW6GofIh+TwIgtKVy8UxoH6yfbDGgchqiQEyAEF4G+P/qzLJJJwr27BfJ9DR8izjrtV
 R2PAn0AeGa7goA2Y=
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr4646939wma.89.1576577073987; 
 Tue, 17 Dec 2019 02:04:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjBawQMNs9dzsP9xZl/9p00EI/6jhUNWsR0TLx5Mmfp3lKCVP1M4gP5if+xKyTno73Wi6ryQ==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr4646911wma.89.1576577073720; 
 Tue, 17 Dec 2019 02:04:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id v83sm2480731wmg.16.2019.12.17.02.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 02:04:33 -0800 (PST)
Subject: Re: [PATCH] Semihost SYS_READC implementation (v6)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <87h83w4dod.fsf@keithp.com>
 <20191104204230.12249-1-keithp@keithp.com> <87h81zwdmw.fsf@linaro.org>
 <5a3b1155-4242-831c-8ae4-e9fb07f1cdb2@redhat.com> <87eex3wa9a.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
Date: Tue, 17 Dec 2019 11:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87eex3wa9a.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: ivCw0fHBM_mJoO3j6QE0uw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Keith Packard <keithp@keithp.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 10:51, Alex Benn=C3=A9e wrote:
>>> Secondly if the vCPU is paused (via console or gdbstub) we need to
>>> unwind from our blocking position and be in a position to restart
>>> cleanly.
>> Perhaps if fifo8_is_empty(&c->fifo) the CPU could update the PC back to
>> the SVC instruction and enter a halted state?  Perhaps with a new
>> CPU_INTERRUPT_* flag that would be checked in arm_cpu_has_work.
> I don't think the PC has been updated at this point - but we don't want
> that logic in the common semihosting code. If we cpu_loop_exit the
> exception is still in effect and will re-run when we start again.

So that would work?  cpu_loop_exit if the FIFO is empty, reentering via
cpu_interrupt and clearing the interrupt signal in do_arm_semihosting.

> What we really want to do is fall back to the same halting semantics
> that leave us in qemu_wait_io_event until there is something to process.
> Is there any particular reason a blocking semihosting event isn't like
> any other IO event?

The "io" in wait_io_event really stands for "iothread".  Usually in
system emulation "waiting for I/O events" means "waiting for an
interrupt" with a halt instruction (for ARM, WFE/WFI), hence my suggestion.

Thanks,

Paolo


