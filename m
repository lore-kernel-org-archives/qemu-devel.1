Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E324C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2936A2085A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb9YC4w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2936A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2DT-00022D-F8
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53698)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj2CM-0001WT-Pb
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj2CL-0004Rt-Mz
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:54:54 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:37887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj2CL-0004RQ-GV
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:54:53 -0400
Received: by mail-oi1-x22d.google.com with SMTP id t76so4998599oih.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BcJnkPVUuBJw2p5pJtwyjKocw+rUgX1kCGJBg1xUB1g=;
 b=Wb9YC4w7anxjfERa7LiDYRbnjNvW2/PM2Fg6/6iw1IsSJwhUEEeOnhfsmgNGBrimvP
 BXfUdtuDl27D/IpJ8XR8A4t51U60rLp59n4RNMmhIBnjY1eC8jieOb3Ue4nzRkmE/FTP
 XpfE8i/PtfjKBFluO1/3N8/4siwSAP770YMUCIlTYtNNs1ZHoDORpsykkSo0SOs/pLX7
 +7WEmV4OSh4t6UDE5l1rb9iSu1Yrcu9L5KRt8jMBzPodSuKVAf5aP47VUqvb0TQbMk/9
 SCNCo62U04ilKlPD/r4I17ufHabrjkUMSX+P/B2bOZriB1+PksCZErCHAPufDVcvKv8m
 2HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BcJnkPVUuBJw2p5pJtwyjKocw+rUgX1kCGJBg1xUB1g=;
 b=F3gzmVuP2VlBOt1FAVXs7ZYv+QkkHOZ0WZA9qzpCxK3wEYNj7rdHPC6dHKDmgeNVnH
 3cWpQr9Fx1DuwqDkvQs5tm7xU8tLsx311cJciEt+atLygjKzq21KqKhkm2Ub3TG093/c
 P15gwF2XF2stzo2oOBEXqfa5Svwchd9Gc0kPJQIlHHRrN7CX0v6Dqt4IPZ7HKthR1rIq
 MFYBf70ZujzzcEqB/cqHzREFoP5eBVwnafGU/tgtfWIQnpAtT2dQ0VwP8TzSZ0HJlkSr
 lIC8TNVePPx7YMVNFg+jPRdyX3p13yhEADNwwK7S1dKg/xqNQ2kSv915VlpQDYJLetg3
 qtdw==
X-Gm-Message-State: APjAAAUJyneUT8QVhy2uUNd5k8+Q/AM150w2f8Jb2Ubi5+psL+JsyROw
 Cx6k5wGpNRDb+9Q5w7A8NP9fcTTgO3h4PmHXCyYb4w==
X-Google-Smtp-Source: APXvYqxzj/Og6e+63+EVbvAkSOujtI2RrhTlGv9D/4d4shmAeVSEYBqtAirxxA7lTiYFzSHNG3JdDdEN5kPwBf5ute8=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr1865915oie.48.1562248492354; 
 Thu, 04 Jul 2019 06:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190703210821.27550-1-ehabkost@redhat.com>
In-Reply-To: <20190703210821.27550-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 14:54:41 +0100
Message-ID: <CAFEAcA-FjsmPXBJsxMC5rbKSvYixp_bWsg-xvYQs1ao3uHAZzw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL v5 00/43] Machine and x86 queue, 2019-07-03
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jul 2019 at 22:08, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Changes v4 -> v5:
> * Rebase and solve conflicts with commit 374f63f6810a ("Merge remote-tracking
>   branch 'remotes/armbru/tags/pull-monitor-2019-07-02-v2' into staging")
>
> Changes v3 -> v4:
> * Fix ppc64 "make check" failure
>
> Changes v2 -> v3:
> * Fix "make check" warnings (Igor Mammedov)
> * Fix conflicts of "hw/arm: Replace global smp variables with
>   machine smp properties" with recent arm changes (Eduardo Habkost)
> * x86 versioned CPU models (Eduardo Habkost)
> * SnowRidge CPU model (Paul Lai)
> * Add deprecation information to query-machines (Eduardo Habkost)
>
> Changes v1 -> v2:
> * Fix s390x build failure
>
>
> The following changes since commit 374f63f6810a2f99254cdf32af67035d951301c8:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-07-02-v2' into staging (2019-07-03 00:16:43 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to adae41278c7e3472b1f4f0228c37dbcfd95fa6a5:
>
>   tests: use -numa memdev option in tests instead of legacy 'mem' option (2019-07-03 15:41:29 -0300)
>
> ----------------------------------------------------------------
> Machine and x86 queue, 2019-07-03
>
> * CPU die topology support (Like Xu)
> * Deprecation of features (Igor Mammedov):
>   * 'mem' parameter of '-numa node' option
>   * implict memory distribution between NUMA nodes
>   * deprecate -mem-path fallback to anonymous RAM
> * x86 versioned CPU models (Eduardo Habkost)
> * SnowRidge CPU model (Paul Lai)
> * Add deprecation information to query-machines (Eduardo Habkost)
> * Other i386 fixes
>

Hi; this fails to link (all platforms):

hw/riscv/sifive_u.o: In function `riscv_sifive_u_soc_realize':
/home/petmay01/linaro/qemu-for-merges/hw/riscv/sifive_u.c:356:
undefined reference to `smp_cpus'
/home/petmay01/linaro/qemu-for-merges/hw/riscv/sifive_u.c:358:
undefined reference to `smp_cpus'
collect2: error: ld returned 1 exit status

I guess you have a conflict with the recent riscv pullreq.

thanks
-- PMM

