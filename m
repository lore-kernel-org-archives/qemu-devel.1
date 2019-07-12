Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D3EC742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8280320838
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRH0Pzxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8280320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlyV1-000513-7O
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 12:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlyUq-0004OM-E6
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlyUp-0003Tj-6V
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:34:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlyUp-0003SF-0N
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:34:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id b7so10006298otl.11
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8M9k3vaoESH9FTV02BiV6DPoDuMicpuNdRGJ4JunVi0=;
 b=VRH0PzxukwZZ+q7SG4lesnPsEkQYk3CxXfe3harpH8lzCZeXV4gpRliZeLYOdw+y28
 Z8Gua50+IjaG8uj2/pLHEnhV9e3p6nx40gaM/MrFsZiyLuwQmJlAdOLzDyMpLpaOx5ao
 ZpXO0NWHcVj7dNxXrERHhuAPH6syIYeBFyWhnO+GC8JFsynMwVIWMxMkktdWGfEYekGM
 eLfaaOEYa3l8kovhYifwOmZ6pEXu4I7wEUUx5HIfSWpEw8/dSa1iNgctZAkVxjUeTCh2
 cYVhchpkObSqe+ZwpY/ncQ3sqRBRVoipy+b2RMrg53EDCnNqPcu+kVVCVkZR5COIpF5k
 y7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8M9k3vaoESH9FTV02BiV6DPoDuMicpuNdRGJ4JunVi0=;
 b=Llz3sSr6NZjhLFlZubcWC8xNJokr9uU2dDwO9MuaDYFJPDV1qNZ26DsuJGU1Tx6vNc
 Dmo5bC6oHvnhzLJuWVBC6CNPzsw4uVKOLloQJ1UzoJl7N01I+BvR+7glHbPuLALii+vl
 /9/FlgP1OtOC2QkWx5etg4MLBb0ws5Nmas/MHq/m6dQZ+57zP3P3T0UvVXn5m2V2Nme/
 wbOOMrUxNxK8lvTTU0ZuJfzCkjp8R34RNeBuKLXZjHd+NebPmCEUGNhedeILyZCl08yj
 /WLTcGMVAXzOJqQFGgp7gzJ4CSINklFBT9SNFreySdSmFMfksRxfwVnnqmB1sQiRidu2
 LDgQ==
X-Gm-Message-State: APjAAAUxYX80FsFKv3IgDNUewpsjtoGGh6NGSfImgJ58O0xiEiuDWR7N
 McDrLIDCwdRB6FIzPC+4is8oeOr4866S9DGbF44hWA==
X-Google-Smtp-Source: APXvYqylwE8qWDgRFiXH/TgR4x9jB931lqPFqDQHpf/AJqOkaw45guOK47bJolGjBLdqpPmh1AtBjSlVnMIlz4mVlfI=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr8725936otj.97.1562949245064; 
 Fri, 12 Jul 2019 09:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190712143207.4214-1-quintela@redhat.com>
In-Reply-To: <20190712143207.4214-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2019 17:33:54 +0100
Message-ID: <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jul 2019 at 15:32, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit a2a9d4adabe340617a24eb73a8b2a116d28a6b38:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190712' into staging (2019-07-12 11:06:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>
> for you to fetch changes up to a48ad5602f496236b4e1955d9e2e8228a7d0ad56:
>
>   migration: allow private destination ram with x-ignore-shared (2019-07-12 16:25:59 +0200)
>
> ----------------------------------------------------------------
> Migration pull request
>
> Fix the issues with the previous pull request and 32 bits.
>
> Please apply.
>

Still fails on aarch32 host, I'm afraid:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
QTEST_QEMU_IMG=qemu-img tests/migration-test -m=quick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name="migration-test"
PASS 1 migration-test /aarch64/migration/deprecated
PASS 2 migration-test /aarch64/migration/bad_dest
PASS 3 migration-test /aarch64/migration/fd_proto
PASS 4 migration-test /aarch64/migration/postcopy/unix
PASS 5 migration-test /aarch64/migration/postcopy/recovery
PASS 6 migration-test /aarch64/migration/precopy/unix
PASS 7 migration-test /aarch64/migration/precopy/tcp
PASS 8 migration-test /aarch64/migration/xbzrle/unix
malloc(): memory corruption
Broken pipe
qemu-system-aarch64: load of migration failed: Invalid argument
/home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
terminate QEMU process but encountered exit status 1
Aborted
ERROR - too few tests run (expected 9, got 8)
/home/peter.maydell/qemu/tests/Makefile.include:899: recipe for target
'check-qtest-aarch64' failed


thanks
-- PMM

