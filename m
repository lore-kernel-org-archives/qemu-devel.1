Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE53C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 16:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722F72078E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 16:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phQU1moa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722F72078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNIgn-00060v-Ih
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 12:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNIgE-000549-02
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 12:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNIgC-0003FY-L9
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 12:08:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNIgC-0003FH-CU
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 12:08:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id b13so530528oti.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AlcP6kS8qP3Z5fnJSDqErjAvUylkt4ocBjCswQoLrJE=;
 b=phQU1moaYLgLVNkP8iWF/bm8B9a5i46fnX/QboBfXVsq00fuaeyx6jOrchNND9GIpL
 9qzqgGcg489Kyqksg67s07iWLy0xrGKqrkmEfmfFEUMzaCfsoli4NMVNzOY+1WiYetkk
 tYVIHo+APB2BLhIUb8wuZPnvXRtBv3GzOxPKZ3aahaFr2E1E0WmLDGyLpwzYBCiSRveu
 zSk7pCL7TxFpQ9L8/Y92Q1mLOKD80bPQ4tlQ1rAxq8cxn+60QZp7QsY1Ny6HGvkOjRD2
 Ux0yFJP+jn9qoJZr73Jhjz3gPJvd7no32uGYQoXOFJ1cCA7WFTWjl281Vk7eAh9swDDU
 CNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AlcP6kS8qP3Z5fnJSDqErjAvUylkt4ocBjCswQoLrJE=;
 b=L0lv8LNQcncP/jN5+D0YwiAngGevd0z6XSBwrDdzMmMMR1xW3ga2Ku3OjtSWHgSgiG
 ctQiIlQzaeOr6JUTSIUX60P0Qb6qFLXUW1kXnE82+zB+/gBqlTtWYW9lqkKH7WkU1Hhh
 nvY7YSmKxLTTe9wo2553S0acDDCBu7tLMLg2oMb8M4Hk4+azXYcMSpifp7rvxUXCdlt4
 dKGZT9iqnFTBA9Ymfer6yXPqNZF/55Swvw2MIXL+6uxU58g6ImIiOwKmosmSz+BSDe6a
 1TnibGrLuIjr4Fw3bjLC9vfv0uLV8+Iei+tUyy82k6SGQkAwPyW3c6Hwz6NOHka9cb1c
 VRLQ==
X-Gm-Message-State: AGi0PubJoT8lYqdXIQXAnetUZbczxrX0dwofURGFoPD3T+cy6EnAPZuu
 mebUP9YxL9SHoZl1L8clbhpuhEdU2GkzFQP/dwy7Bw==
X-Google-Smtp-Source: APiQypK6OwnJ9obudntsUWG+oOIj6r8JoEb1FUFc7M8arG5n8YjmZ7T+F8clL40mnH0b0HkgGVJtbqCX6UnVhrbp6pQ=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr8411927oth.135.1586621303255; 
 Sat, 11 Apr 2020 09:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200409174209.321725-1-stefanha@redhat.com>
In-Reply-To: <20200409174209.321725-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Apr 2020 17:08:12 +0100
Message-ID: <CAFEAcA-chv_410Cu7VP-vnx3fkC+G_0coy3zkHy8jKZrJgXG5w@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/3] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Apr 2020 at 18:42, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 8bac3ba57eecc466b7e73dabf7d19328a59f684e:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-rx-20200408' into staging (2020-04-09 13:23:30 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 5710a3e09f9b85801e5ce70797a4a511e5fc9e2c:
>
>   async: use explicit memory barriers (2020-04-09 16:17:14 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Fixes for QEMU on aarch64 ARM hosts and fdmon-io_uring.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

