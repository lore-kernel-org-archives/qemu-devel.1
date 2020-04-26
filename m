Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36802C55191
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 07:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0292E2064C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 07:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emb25PzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0292E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jScBZ-0001Ye-2N
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 03:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jScB0-0000zo-E2
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jScAz-0006XK-Im
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:58:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jScAy-0006S1-VJ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:58:09 -0400
Received: by mail-ot1-x343.google.com with SMTP id g14so20581592otg.10
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2020 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rHIlVD+qrWh/IzarsCqKhEK3hUcc6U/EmckMA/HJQek=;
 b=emb25PzRSQ2wB96i7UlCeMgxjQEak24W7Uz4xq1l13+c8HYHo9HHRf3e2iO11FGfJ6
 Uv9NtRm2AHgCALlzn4Sp1B3viXdvCgU4jp24Rihj3xfGCf7+BBDk1JXWvrL3l70t4g1Z
 NoliZ6XdOolmKpIYlJI1Kmpfd1k3u7392b5brFhmXyztpLzyP5DYBp7IQ18VnN3bDPZk
 vAQj6PBTtxdLpzlhj0ZtC+BvcWEfpABhdO/lDugjTF+oQ9HMMw5i3H8Np64zvAa5mNsE
 8n/j7EUpxKHDBn5KanD/PUQhduBZJdV7dUJvglyN5W9Xv60D+ZSw7l3EdKoaMIz9wVfH
 n1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rHIlVD+qrWh/IzarsCqKhEK3hUcc6U/EmckMA/HJQek=;
 b=BzxmlBpQZOapMiJGZseb0jl7kPK9zSqsnK1M8k/6UuIH7bjihd+h/ZQ/JB1l/Tm2nL
 AO0B2fqmmVr60VnLhddwCQcckvL5BZ/09y+NWzJ2HeGoBmrEvK0I/mmeSC2P6pBnzcuO
 Vrjadf2NTEA/f+KjjsefZpFKm+1en60ZVC/Y71f8iv0jUT1nojYHeyChoYMGY+Hbgm9k
 k3zfHV+kbew8+yrj25mF614M0buHu8iXrzyonfdOj7v5Okvelm3gFbOrzKXKR5ydoeXR
 GWekK5EmMckkZ9VCXIKtkN4NScM1/CAVaDPx/zzaW4JSeUicBJQQ5vvg4Mb1nUmbAFj0
 Yg9w==
X-Gm-Message-State: AGi0PuazrRZGEHBmNhMLPXjRKGRDGylHrqzIjJC4TceLUGvhLu/9dUWN
 sh0nQbnoh3/ay0TyYK0U4oOGspUdrf2r4iqZoDJDPg==
X-Google-Smtp-Source: APiQypKmZ+cIDSAUt5oE6YYYdOZviBObp497XWVk0AuXaewLacTKa7gh8y0L3cPnSE6Tk89RnEoViC9RzPgYgqd6hqY=
X-Received: by 2002:aca:c751:: with SMTP id x78mr12503815oif.163.1587887887324; 
 Sun, 26 Apr 2020 00:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200423231644.15786-1-f4bug@amsat.org>
 <20200424152722.GA14573@ls3530.fritz.box>
 <1f04b513-eece-baa7-5556-4665afe1f637@redhat.com>
In-Reply-To: <1f04b513-eece-baa7-5556-4665afe1f637@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Apr 2020 08:57:56 +0100
Message-ID: <CAFEAcA-vJXRcjNPnyB5t4UOrmH5wnUoZsx-JAwDYNavQ_L64XQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] hw/net/tulip: Fix LP#1874539
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 26 Apr 2020 at 03:50, Jason Wang <jasowang@redhat.com> wrote:

> Looks good to me.
>
> Would you please send a formal patch and cc Peter.
>
> Consider we are about to release 5.0, it's better for him to apply the
> patch directly.

I am not applying any further patches for 5.0 unless they come
with an attached rock-solid justification for why we should
delay the release again for them.

thanks
-- PMM

