Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000CBC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC1D2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpZO+NMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC1D2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2L4I-0002u2-Uw
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i2L3I-000215-8Q
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i2L3H-0006Ge-CL
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:53:20 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:42288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1i2L3H-0006GU-8K
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:53:19 -0400
Received: by mail-yw1-xc44.google.com with SMTP id z63so7055664ywz.9
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ob0xbk3NS8CVaIiAhV/jNSrVxEEbJTZNiMgwY9K8ec=;
 b=UpZO+NMNdbGkLvVcuHj7d6ejaFOejHm4g/UPiut/LMXujEAfZErXxNtg5ljKJUplZj
 0jboUGe2oxBu4e3DvEa54TszIdLD+GmCKirexrPmUDD6C20LV08J2QXn0ghpzg2oqAT5
 Pjeenxd63bl3Ngz3v5VlCe575xM1Gmsj+4T3xlipjhWGgW/WzGYnHsb/wH9OScclKnvM
 5Lqw8V1ZCryexgT00Q+O4H0gI+3W5ZZEtVdSVyTZa2LFc3P2Bn7J2rOVfcl+ED88jhYB
 Ljm0JWAiYKoLnAsnVR4JFEwgIR8b08LljvizmFsrFMLLpYXGN0Y45I3bSrJHOP/UhQ2t
 VHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ob0xbk3NS8CVaIiAhV/jNSrVxEEbJTZNiMgwY9K8ec=;
 b=ln9Q5gxDiIJOC54CBGD35nGfdieJNbdJJ2VsINEEgMVjimjn+ABMzzDkdXKleyLkDD
 umuDhwANMlQb57+HuyqZrIpzEwHeIyEZ9SsNzTAZgFGvyj1h6GlsXvNH50QYV+XLNDpX
 O14jYd7UP7Z9XVPsdy6mUk4Cdr2kBQtJVSjXjEscuNfCZgOaY3sA4OKvlTrHi79Gynz6
 Xd0Dir5FDA4xXp74ClCNWCN3yUlFFkaSEXNFnNuJN31A3IYDITEet8cNev+TgNp/CI5J
 Uyqx6fOR22DYuLZTVfA6b2Nq2F2nfZBynFUuVhmLneYqPGW70JB8T7j4sKxGZFbwmzny
 itgg==
X-Gm-Message-State: APjAAAWw5Dw5OaHyLgyvOD1HgYpPaNLN8pClb4ZV4vi+6GRz+2aIGdKL
 j/n0nBhrJMpO7OEmfZdG3T7Pj1YIR6hVXWnIcU3Gnoci
X-Google-Smtp-Source: APXvYqyNWyhlgzJ57dQrMZEXHgylXZ6dvQrOt7U5CT+JUGi0zd3ssSq63WURWdViPkLbSDcCq7uUCvx5kFmRd/Fu1wo=
X-Received: by 2002:a0d:d4c4:: with SMTP id
 w187mr14279521ywd.409.1566849198339; 
 Mon, 26 Aug 2019 12:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190826181723.14008-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190826181723.14008-1-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 26 Aug 2019 12:53:07 -0700
Message-ID: <CAMo8BfLu5aog_3WrHbN+75ARTa14ydwkM79RBLn=3r9m8o8FGA@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: linux-user: add call0
 ABI support
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 11:17 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Xtensa binaries built for call0 ABI don't rotate register window on
> function calls and returns. Invocation of signal handlers from the
> kernel is therefore different in windowed and call0 ABIs.
> There's currently no way to determine xtensa ELF binary ABI from the
> binary itself. Add handler for the --xtensa-abi-call0 command line
> parameter/QEMU_XTENSA_ABI_CALL0 envitonment variable to the qemu-user
> and record ABI choice. Use it to initialize PS.WOE in xtensa_cpu_reset
> and in setup_rt_frame to determine how a signal should be delivered.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
>
> - move handling of QEMU_XTENSA_ABI_CALL0 to linux-user/main.c
> - check xtensa_abi_call0 instead of PS.WOE in the setup_rt_frame

Thought about it some more and decided that checking PS.WOE
was a better choice. Will send v3.

-- 
Thanks.
-- Max

