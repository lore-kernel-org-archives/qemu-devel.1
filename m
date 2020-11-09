Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C7C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A237420637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzH/Q4gV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A237420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbufG-0007Kz-Pn
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 19:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbucq-0004QT-6G
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 19:01:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuco-00043v-Lv
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 19:01:35 -0500
Received: by mail-wr1-x443.google.com with SMTP id g12so6913161wrp.10
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 16:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NekG4E9NqAvb1mxr/XmtZiTz+THr5/dKNtYQ6dH5ybU=;
 b=lzH/Q4gVdvCTe5REOzNicOUXYd9mo+J2s5oQJf+pDHHdzJlXiongEoa1DYi51t90go
 vOmdkCqe/5Qb3ycA7zhsyrlRkfAwFjz45oThQf9rTB5mr1lml3D5+jrYku2Mc20PadUp
 HtNoW2BdjnyZ04H7dzRVtzrP+TmYtp9nuDNoEmocNITY9JafanWloZvxcJnzCJLjWQmT
 EV1Tq701fY2j7nHMWP/pHw/dXxuOHC4Ydl5f9Vrv2Su709LT3/h8BeAliu9qGp9r2Vf6
 TG6hAI10WWph46Xfg2h97M2o/kQmNHneJYemIUuuL/3E3LFnUNOfQ2V50m2d0wXprc6h
 aVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NekG4E9NqAvb1mxr/XmtZiTz+THr5/dKNtYQ6dH5ybU=;
 b=D9WjJZbZXj/R9x6yrQCQPX8Kh9ri7Fy9IgpUrqa1ptQhY6EEKaL8QURtXnHUJ8wI5M
 4XZGnP35kcD+G3zrqjHcdS0+y8a8KRfdvAxsRVvP2OOvFy2HaB6+zZVZJlntb+slfOx4
 ViPjbGqyOyW2gbN7zYKJ6Vf/mSRlFzZuQvALXPbIGRWfj8kyvo4PKnMy+eYK3KWCX8wE
 0ezv9aWOLoCHPdj47jxSyIN6aZROx6Lo/XPSshSmfF17K4IC8w/yB32j+7SKvp364W3p
 6BZ8WqgkSAZcHZz0YPzlxzFxXZwcIH3gaIbTwA4dUysiWaxLi846W7B7NSUgSPVUXsi5
 4X0w==
X-Gm-Message-State: AOAM532eEgXjJixSZyCrgJrLX13UDVbAvzlwznaKdYsqnxT0LKhpHTl2
 EFFOAVwjTgJ9uS89XwlCQjc=
X-Google-Smtp-Source: ABdhPJyejCBwj/qYYt7JS7YJkhiMLU5dpXbF8M7fS95ABvne4npqlkjJEU2mUyJJaEakE7o2fCsAwg==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr5634671wrv.122.1604880092663; 
 Sun, 08 Nov 2020 16:01:32 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s12sm10789294wmc.6.2020.11.08.16.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 16:01:31 -0800 (PST)
Subject: Re: [PATCH v5 4/7] coroutine: add libucontext as external library
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201108232425.1705-1-j@getutm.app>
 <20201108232425.1705-5-j@getutm.app>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2072d9a7-2aaa-fb1a-cf6f-d5eab3a378ae@amsat.org>
Date: Mon, 9 Nov 2020 01:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201108232425.1705-5-j@getutm.app>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 12:24 AM, Joelle van Dyne wrote:
> iOS does not support ucontext natively for aarch64 and the sigaltstack is
> also unsupported (even worse, it fails silently, see:
> https://openradar.appspot.com/13002712 )
> 
> As a workaround we include a library implementation of ucontext and add it
> as a build option.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  configure                 | 23 ++++++++++++++++++++---
>  meson.build               | 28 +++++++++++++++++++++++++++-
>  util/coroutine-ucontext.c |  9 +++++++++
>  .gitmodules               |  3 +++
>  libucontext               |  1 +
>  meson_options.txt         |  2 ++
>  6 files changed, 62 insertions(+), 4 deletions(-)

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

