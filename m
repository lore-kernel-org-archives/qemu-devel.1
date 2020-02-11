Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD2C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546FF206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOX27XWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546FF206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Zo3-0003KC-HK
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1Zmz-0002c8-I9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1Zmx-0005UI-Hr
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:57:37 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1Zmw-0005SM-C6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:57:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id w21so6104444pgl.9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SDZZr3UK0EUHfgutaaAqk5vDGz+kWkhZ5mCsuFrQjKU=;
 b=sOX27XWvu4IKj5mmdK1pCHN4g+F6bXeCvRMjVAxKIQ9eRBdxdVoYu1GSMHfSaw3xLI
 TxBdKe317ATRycaoJgbnmoqKZgx4Zng0A1ChgyyIeQHbuKJWEtdG0V7xM5/ZixiAmc9N
 Yk+CG6w9QP4oxXU3O9GFzfPslZzi4iCaYiM1XMlSD8SXtljbpDV6UKQCkE5X6T3VHcJV
 Q/FOU+MLgH75qMZrDr6YyN4nROSCf0PVByZPfhhDqFuPVvnVN4EvfzxM/2LN4DzcOKQR
 7at0xZTc8JK++FEsa1Ecs1gM+HoKHS0wGc/6qWp5RjPHlKVe/KXJbzq31zDM4Ejm1qKi
 HcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SDZZr3UK0EUHfgutaaAqk5vDGz+kWkhZ5mCsuFrQjKU=;
 b=KUf7MO6KCFSuUE1x2dqVqfifWv1/VhcKaqAweucrwZxdD+H+y4qfkpIRHE1zfKsdRV
 rV5wNtElj4vOY1Bv8V7+hximL8nVewLJ06BsASK5W/eK9rz9u/YCRYcJUoyHKRO6eqT4
 9f0CWLVnhCPm//CV8jcxh2+VQXPxwpb+DFM+D332YlOOQ/KJJ5G3HO41pfDiUxUCaHFi
 cASjd/020b7syMrA9BTaSX/bJImmRRQfo8o7ura2HT4fVNMJsye1p/cjrK75FgeAGDJm
 0JIu0wEyPB3KxgNyXE/y8Nejyf1+r7bycQMJWtvl7XfkETRX1kE39AqaX6MM4V2vMtUL
 xu7w==
X-Gm-Message-State: APjAAAUrN/8UgHFZZTlbhs1ZntwUJsfv7fyoepAj0hZvdGbo9GYXPver
 Z7DrmpuMztsBdINf2JJ/LjPCzw==
X-Google-Smtp-Source: APXvYqx/NK13WfU4mSY7ubf0aM9T5sOnRI5LcmColx97k6dS4ylTSsCc/fblCOsFQIPjsxZNlzOvwg==
X-Received: by 2002:a63:d0d:: with SMTP id c13mr4117918pgl.388.1581443853304; 
 Tue, 11 Feb 2020 09:57:33 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 hg11sm4053252pjb.14.2020.02.11.09.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 09:57:32 -0800 (PST)
Subject: Re: [PATCH v1 3/5] tests/plugin: prevent uninitialized warning
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200207150118.23007-1-alex.bennee@linaro.org>
 <20200207150118.23007-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4e12f3f-54af-8480-e612-ca19a227ca4b@linaro.org>
Date: Tue, 11 Feb 2020 09:57:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207150118.23007-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Thomas Huth <thuth@redhat.com>, robert.foley@linaro.org,
 peter.puhov@linaro.org, robhenry@microsoft.com, aaron@os.amperecomputing.com,
 cota@braap.org, Euler Robot <euler.robot@huawei.com>, kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 7:01 AM, Alex Bennée wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> According to the glibc function requirements, we need initialise

s/glibc/glib/

>  the variable. Otherwise there will be compilation warnings:
> 
> glib-autocleanups.h:28:3: warning: ‘out’ may be
> used uninitialized in this function [-Wmaybe-uninitialized]
>    g_free (*pp);
>    ^~~~~~~~~~~~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
> [AJB: uses Thomas's single line allocation]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/plugin/bb.c   | 6 +++---
>  tests/plugin/insn.c | 3 +--
>  2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


