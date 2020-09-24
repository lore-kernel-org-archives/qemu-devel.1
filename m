Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF5C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 05:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4FB235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 05:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCSD06rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4FB235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLJzJ-0000Fl-8g
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 01:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLJyG-0008I3-VB
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 01:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLJyE-00051F-FU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 01:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600925944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4dW7uoZyL5heEVUAkzmqyJHjMLLA6+l5Q3XC7+YfoU=;
 b=NCSD06rnvYnKYDRQLH2mXdcgYAl8CKu/4+LCFbvBNFPYCXTdHVbUFj1qYQwEoeRx9AGkSJ
 MJ1l9fbsV636ZM8aY3+F3yJ4HOblHSM9H/GihjGo8Ot+5xKdtEqUQaIELq+uwxcWTxrSUq
 ZD+FO0Zj5OeX9oIeR4AwuRLrn3FZjXs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-OujkNTb5NQ-mp5DjCRU1GQ-1; Thu, 24 Sep 2020 01:39:00 -0400
X-MC-Unique: OujkNTb5NQ-mp5DjCRU1GQ-1
Received: by mail-wm1-f71.google.com with SMTP id 23so436513wmk.8
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 22:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h4dW7uoZyL5heEVUAkzmqyJHjMLLA6+l5Q3XC7+YfoU=;
 b=NdiZ7c27E0rXx/JVYNcBuhQSHCSg/dq/Yaansp4PktG3T1hkw0Vh4MOe2K531tWB/s
 VJ6+ApHoMghlLI0+yj2zyJjod7k+jnHzonJsT+F+Hcju9N3LMAEls/PsAfiRZjBkHwx6
 AdVPhKki6BRchfWSnJtmylhy3uZ6MikoLJZVk6c/FPzt6q7EhEy9OM35gTKEHo/btJh7
 vp7Uh+M+007aM0nFj+bZTNXF27h8nPCUBdtUIoG0wTRAsFFkdhgh0fr5MhmvxdzNwdsf
 Djf3JbjEO7BUNv8CjweOZ9fnE6tGWvP6tGLS0o/cS8hr0nYk673olfH7lAP0XJEn3Jd+
 Hx1Q==
X-Gm-Message-State: AOAM533Vogdx+7VJTdun0QTEzDOldRxuTmdTYCuQDPgo86GqVG40eAHX
 fbJGM8wklZopwoPa71+ZXXrcgQpSS+MDLvvVD/IQYaryWrwqe7gEcsp0S83QcFqn+gZvtlLWSL4
 roSL/19ealZt1MPM=
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr2944407wmc.112.1600925939426; 
 Wed, 23 Sep 2020 22:38:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynKbmWs0pjqGawS5nT5bdUZHZIP/IdkzL03OtDo4dlbSa3l9jWhHp5uRyk5lUYDIrCrGwMKQ==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr2944395wmc.112.1600925939113; 
 Wed, 23 Sep 2020 22:38:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec8f:2b97:1838:78bf?
 ([2001:b07:6468:f312:ec8f:2b97:1838:78bf])
 by smtp.gmail.com with ESMTPSA id a81sm2131350wmf.32.2020.09.23.22.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 22:38:58 -0700 (PDT)
Subject: Re: [PULL 00/11] capstone + disassembler patch queue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200922174741.475876-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4d02599-7d96-d589-c827-1d97e8e282ef@redhat.com>
Date: Thu, 24 Sep 2020 07:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 19:47, Richard Henderson wrote:
> The following changes since commit 834b9273d5cdab68180dc8c84d641aaa4344b057:
> 
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2-pull-request' into staging (2020-09-22 15:42:23 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/rth7680/qemu.git tags/pull-cap-20200922
> 
> for you to fetch changes up to fcfea6ced053045beb1dc8d22bdeaacc9c03d0b9:
> 
>   disas/capstone: Add skipdata hook for s390x (2020-09-22 08:59:28 -0700)
> 
> ----------------------------------------------------------------
> Update capstone submodule from v3.0.5 to v5 ("next").
> Convert submodule build to meson.
> Enable capstone disassembly for s390x.
> Code cleanups in disas.c
> 
> ----------------------------------------------------------------
> Richard Henderson (11):
>       capstone: Convert Makefile bits to meson bits
>       capstone: Update to upstream "next" branch
>       capstone: Require version 4.0 from a system library
>       disas: Move host asm annotations to tb_gen_code
>       disas: Clean up CPUDebug initialization
>       disas: Use qemu/bswap.h for bfd endian loads
>       disas: Cleanup plugin_disas
>       disas: Configure capstone for aarch64 host without libvixl
>       disas: Split out capstone code to disas/capstone.c
>       disas: Enable capstone disassembly for s390x
>       disas/capstone: Add skipdata hook for s390x
> 
>  configure                 |  64 +----
>  Makefile                  |  16 --
>  meson.build               | 124 +++++++-
>  include/disas/dis-asm.h   | 104 +++----
>  include/disas/disas.h     |   2 +-
>  include/exec/log.h        |   4 +-
>  accel/tcg/translate-all.c |  24 +-
>  disas.c                   | 707 +++++++++++-----------------------------------
>  disas/capstone.c          | 326 +++++++++++++++++++++
>  target/s390x/cpu.c        |   4 +
>  tcg/tcg.c                 |   4 +-
>  capstone                  |   2 +-
>  disas/meson.build         |   1 +
>  meson_options.txt         |   4 +
>  14 files changed, 681 insertions(+), 705 deletions(-)
>  create mode 100644 disas/capstone.c
> 

I will pull this as well into my branch (as a kind of topic branch) to
avoid further conflicts.

Paolo


