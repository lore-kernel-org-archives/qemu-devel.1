Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE77C5518A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 03:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE14220706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 03:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOLI3qKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE14220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRpM2-0007EU-Q3
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 23:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRpLL-0006X6-FZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 23:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRpLK-0002Vk-OD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 23:49:35 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRpLK-0002VZ-7f
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 23:49:34 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a32so3404857pje.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 20:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eogVWK7272/2Frm2zUz2eXygQVICQqW5fWjO/b5QYG8=;
 b=BOLI3qKKeXiSp0ucO1yP7cymCQCoGTdxokx3wr5wJe9fzzP2NUaAAywlxiKMOmJ00G
 /QSEg7yJhlGYmJZpHQ4nJV+biNZgj+lBvZYdt9Bseo8Ao1MZwgztOH3OynTIzuk059AC
 96qti0ELh0E9gb7qSxfAGzn5R5d+76IyxZQ3DVcpW53KH7m2jY4pz91HjQYZkWOPj+yO
 B/cor9uFUB9kv6wzRwDP5/dQ70/oDPZF3odYkbbYVZUUrcY3Noo8yh2Bl5fmP0nLEDdX
 MSFmbhANr2IjeYrRX2d+7No1fBx+JafV0FVKhKSq4/88RH1gbmaVEg50IvOxPdEBRP7e
 fjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eogVWK7272/2Frm2zUz2eXygQVICQqW5fWjO/b5QYG8=;
 b=Dmhcy38lbkvTXNjzicJszH4TaULYyBy115lEKnDY8D8umCy6JKyrMEKM4F8Iar6/8j
 LWJBIdD5FIvoncVXDwVZq6ANkhNwNwvJH6LY7uproeokoiRhWSepvtSCmxB82GSRJWED
 lpsjG8D5l6gNFfdBev5oeRPVe09+g0cpD/GFOsbHXb8ooSxN92hgko7B45Tuxb52LzW4
 PrPZuGyFekNUT6+EGtX7FR1ne/Xsij49ZSMf/a64qPakvzvUTrwRdBbC57EF4WKI0OVf
 dNb7LKOfoBGJJbWjKD5jdxqXZTPjIK3ZmiwXgpdnycFEMXol/7fMDqHPUfAQNGxbwsEW
 D/sQ==
X-Gm-Message-State: AGi0PuYQkP4vO3bkgEbb7UP4OU5nnu+3gxSXvK+Dg86UGxksUG/ebFwc
 oYqxo+1joUz/puuKQOuONQUlrA==
X-Google-Smtp-Source: APiQypI9pvP1JChQtc/kX9r7LsACErZSe7yI2/spdraAPl3wggQ+ZISEF6Kcel7H4nURjOpiGzFWnw==
X-Received: by 2002:a17:902:c382:: with SMTP id
 g2mr4927359plg.290.1587700172190; 
 Thu, 23 Apr 2020 20:49:32 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 140sm1611549pfw.96.2020.04.23.20.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 20:49:31 -0700 (PDT)
Subject: Re: [PATCH 0/7] chardev: Reduce system emulation specific code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200423202112.644-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aefe2b6e-71b3-11a9-38a2-9627d0edb0bd@linaro.org>
Date: Thu, 23 Apr 2020 20:49:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423202112.644-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 1:21 PM, Philippe Mathieu-Daudé wrote:
> chardev cleanup while reviewing 'Refactor machine_init and exit
> notifiers' from the multi-process series:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg697510.html
> 
> Elena Ufimtseva (1):
>   multi-process: Refactor machine_init and exit notifiers
> 
> Philippe Mathieu-Daudé (6):
>   monitor/misc: Remove unused "chardev/char-mux.h" include
>   tests/test-char: Remove unused "chardev/char-mux.h" include
>   chardev: Restrict msmouse / wctablet / testdev to system emulation
>   chardev: Reduce "char-mux.h" scope, rename it "chardev-internal.h"
>   chardev: Extract system emulation specific code
>   stubs: Split machine-init-done as machine-init and machine-notify

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

