Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FF0C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 16:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DFA20732
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 16:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJc9LBDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DFA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFh3e-0004wW-RU
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 12:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFh2x-0004Pp-MC
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 12:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFh2w-0005k2-5a
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 12:32:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFh2v-0005jG-Nn
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 12:32:26 -0400
Received: by mail-oi1-x243.google.com with SMTP id w13so10052636oih.4
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=guGBqHTgHj7fxVYDwbndUd+clOWJpa8ff0rnPSjz4JU=;
 b=yJc9LBDACrKKvncofBKd+wgMwtNKNh3ze+iXpoVSWI6RbDQ3LScpyYYTMabGUuuo1t
 troT5w/TT8II3WGNCST9L2v0qCfnMBA6O+85i13dCWBipor19IDMDy9jkHT7cT3msEsy
 gIp7Dht9lBnuQ+Z0MTf4EfMeOqR/bnPsSXsBqzqaHGhrI30pZcTJkjTVOsjnUpBlJ8aL
 n77SWoYY5I4WpP9kjC5BhIXSLkCwoYmcQo/d+I4orrAzw+2n3TL+vmfIGeZeeMkO0NZE
 jWf/RKRNXMInIGd7l/d65u16iEWOOa0YZitB35tEu12mn0YLeusPtEuduKiSp1Iw5Dlj
 tLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=guGBqHTgHj7fxVYDwbndUd+clOWJpa8ff0rnPSjz4JU=;
 b=HUmnI/kKYk0HER5nqvbDqgdh4cZe+fh9Q3sPiDQOWO+z+65Fr/U0QWzR/p5i2tMbQ+
 xRNQz1h8UvULDc/BoUAkAL8fJynmzj9IVhndy8x+MiwORduKFAV3XswrloVlRRkMIxc6
 zISluZ3v7/19Wfag9SW+8znOLAuSnJqye8ARaro/aX2syZ8DtZQDGIBL/KesLVoIz17F
 0fLhjR++6DMdRaIRC1Phqm/dz7CXAtru81i80o01+/8ffIKuPSd+HtZhdBqaBw/GDoQ4
 kMkmh9iZRQL1whDQkeDkVsQn2TJgA6OTvj30yl7qEPSsBtrW8njIINXHJcO5GM8/cVHD
 jnzQ==
X-Gm-Message-State: ANhLgQ2BdapqoOc0UOxk28uIZoveNAp40v80Z9QjRjOc8B9VUs4vJsX7
 mAfrU2+plqnmV64ydTYA5m5K47mwQrOXOjLmnIxXmA==
X-Google-Smtp-Source: ADFU+vvlyGft/qZoCxy46iV6oExPZANoimPGSXeGApRd9+yEbxAbgksdpHeqOXz3ZxtRDeKM70dQDIjd+Hk7wdV3JzE=
X-Received: by 2002:aca:c608:: with SMTP id w8mr11268117oif.163.1584808343664; 
 Sat, 21 Mar 2020 09:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200320152408.182899-1-laurent@vivier.eu>
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2020 16:32:12 +0000
Message-ID: <CAFEAcA_HXYMP99ai9QRf8OF+5k+QhUSXCcH01dfT_A0anSM-8Q@mail.gmail.com>
Subject: Re: [PULL v4 00/32] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 15:27, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:
>
>   qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to a64ddbb03acf1ee916c826ae89e0e1aa6500d5ae:
>
>   linux-user, openrisc: sync syscall numbers with kernel v5.5 (2020-03-20 16:02:00 +0100)
>
> ----------------------------------------------------------------
> update syscall numbers to linux 5.5 (with scripts)
> add clock_gettime64/clock_settime64
> add AT_EXECFN
>
> v4: restore syscall.tbl series but remove vsyscall series
> v3: remove syscall.tbl series
> v2: guard copy_to_user_timezone() with TARGET_NR_gettimeofday
>     remove "Support futex_time64" patch
>     guard sys_futex with TARGET_NR_exit
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

