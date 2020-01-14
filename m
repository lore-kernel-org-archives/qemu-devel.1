Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6474C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBF32084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OblAiHGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBF32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irVjR-0002gh-HE
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 18:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1irVim-0001wH-Tl
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1irVii-0006wo-V9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:35:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1irVii-0006uw-MB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579044935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCL+UTDyFHk1FkAY0CukkmHnR472fs1W8gsmYZn0wlA=;
 b=OblAiHGxM5aUHLv6Cto3QeZA0C9hr+RVpDEKjMrYoSBDEeH4Xu+qxU53+VoQ1gpLTJz+9M
 J5JSWuCAmzAEot7AWa7F9O2z7nZpR56c5JOGpRyPXiZncCRXC6IdPpYrjtshrn7sEUJrOm
 ST5Z0AjI6YLJNSwWj606/CCRm6QTbW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-ak3kZZslOeupKUc6rao9Mg-1; Tue, 14 Jan 2020 18:35:34 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so7160017wrn.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 15:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WCL+UTDyFHk1FkAY0CukkmHnR472fs1W8gsmYZn0wlA=;
 b=qyEG95lG4OkwDxcm3JE2MBdhyabjRrenuuvXsl7XGQbsmRbBsgk6HNzgCU2u5mcFLI
 46c5fg0DlDDHw8yaMC0Q6fbTs9xyOmz/tE+A80Nc4ikUjxqOOv9tPNREZssEeINW8b6z
 XUkdtgGSuneOfGVBGQxc9cC+juWTEHXueWZI8of6NSSNWwcGWvQxlCNQyJKXuxmVOZ3O
 nEZOknThAvs37MWJroDzqHRQXp6Lqi24w8MqewrPD6J+kKfLIt2bboUReKXQPkpZEwni
 E4LUNghGm59cS4bzfIsq6hkBhptwXbUid9WlAqdEIwiTkw9gIvoG1QcNwvKLmqjkvfGt
 1YEw==
X-Gm-Message-State: APjAAAWg61AQ9lyYFuUC2lA58yt3qsGcz+aNUp6HZnV4v4+0HirqqNqS
 h55eAB0KalgpcQ9Lm45a2ljUaUnYMOcl3lOYlYR4CYNQ5WRhjEH/ZMpxdG7AyHBAnFLjKmDGF9X
 mJ0KuJnxoCDuCO1k=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr28994682wrv.308.1579044933217; 
 Tue, 14 Jan 2020 15:35:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDBYQbLmQO74n9rHScXJXto1VVjlS/X3R86tZAoK2wehyMiCGsFnJtIP2K1uQY/ZS/LZw+6w==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr28994665wrv.308.1579044932998; 
 Tue, 14 Jan 2020 15:35:32 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id p17sm20775612wmk.30.2020.01.14.15.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 15:35:32 -0800 (PST)
Subject: Re: [PATCH 0/3] linux-user: Implement x86_64 vsyscalls
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200114210921.11216-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5782d783-b868-9836-0715-28239138e6a1@redhat.com>
Date: Wed, 15 Jan 2020 00:35:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200114210921.11216-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: ak3kZZslOeupKUc6rao9Mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/01/20 22:09, Richard Henderson wrote:
> I vaguely remember someone (Paolo?) implementing something like
> this many years ago, but clearly it never got merged.

Nope, certainly not me.

> In any case, this emulation has been missing for too long.
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>   target/i386: Renumber EXCP_SYSCALL
>   linux-user/i386: Split out gen_signal
>   linux-user/i386: Emulate x86_64 vsyscalls
> 
>  target/i386/cpu.h          |   6 +-
>  linux-user/i386/cpu_loop.c | 197 ++++++++++++++++++++++++++-----------
>  target/i386/translate.c    |  16 ++-
>  3 files changed, 155 insertions(+), 64 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


