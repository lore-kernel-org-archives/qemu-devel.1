Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D7DC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD0320730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pg9N8Oel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD0320730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQON-0005QD-78
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isQNW-0004VA-3g
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isQNU-0007nn-F7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:05:29 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:36103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isQNU-0007mj-7D
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:05:28 -0500
Received: by mail-ot1-x32c.google.com with SMTP id m2so17489070otq.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 04:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M20d0Hf43fKbmuZOZCOH7FvWeOyLBBNIu+LwLx817/Q=;
 b=pg9N8OelLR9ZmNcr2BFl3AWVMihNEf1AhxwC02ug4t/xYQZzYWwBD7Ehn3hkqAFiHV
 Q2cvHdQGTJHeWi/PGypmdUrM3Puje60rRL7i9OukemsE+A5YEFbOokslFyfoZzq2UKMj
 3E6L8hAC5DqmH8XNgssrFRjwBJnacirtsy92XpBh7Z4BzZgH1WuLkmyPCipl8ULcYuWM
 O9TvfugOHOshJOeK5M+YbENGKluC4M02Zpqj0Nqlw05UHsMA+LWsKUHBp4vcFuRYRGta
 DQ0Q9tNHdyjC3UrwtI9I1Fy8bbRh8MNwQSddOcGFIxksZobovKw1EtVWuHRYLGLvHGBx
 w0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M20d0Hf43fKbmuZOZCOH7FvWeOyLBBNIu+LwLx817/Q=;
 b=Xuhxwlxux0oURPLrtXqRcCc7xgPlbKd1nshofQkezwDtjJAEhIqvyoKUHjWziiZ8zM
 PniYC6w72uitUG4bMiAUyA9gyjfKlnh9xTjIJTbIFrdvqQjhlbrHQTSrGkktuOwty0oU
 nimHsKRrmWRgHA+s/8GXoG6NbpoPzwexrhCfVFj9hIpEqgvQYe+Ze5uDuamMg6a1wRR7
 VsLaKiZQsKOq7GxbMKH47SiDmjqKcINiTy3nNlHAZ4M3GXY4PpTWS7206NQe+bB/BwWN
 4XjoDGYhnTFfAP4+9XpQsQ5pRm4R+oR63i6yrNmjlyI5jUMMcjnwoGiLN284WTtFpoBL
 UFMQ==
X-Gm-Message-State: APjAAAWrTgowEQyWK4xW8MjRwfBrrCTqQBCb/zpk1Tvwb+0bx5K7UU5H
 f/IRLUinLn+h2fVp45Ytk8jwhwHC39CEqU6nPCQHgQ==
X-Google-Smtp-Source: APXvYqy+b38DicrX69wtf62caGHpHt3FfQ4xAdJWDXF4AML82vmcmoKi7DAGs8QEmXocEgo/bjNlIA4Zsre96hanKi8=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr5759167otq.135.1579262726908; 
 Fri, 17 Jan 2020 04:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20200114125254.4515-1-quintela@redhat.com>
In-Reply-To: <20200114125254.4515-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 12:05:16 +0000
Message-ID: <CAFEAcA_n21bu1gk0fqbzSr7iwurYCVR+wS7-RpDAJWnrYdVQ5g@mail.gmail.com>
Subject: Re: [PULL 00/30] Migration pull patches (take 4)
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 12:53, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642cfa0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200113-pull-request' into staging (2020-01-13 14:19:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-request
>
> for you to fetch changes up to b039b02c25d1725cf0296721d98e35e024468b20:
>
>   migration: Support QLIST migration (2020-01-14 13:45:29 +0100)
>
> ----------------------------------------------------------------
> Migration pull request (take 4)
>
> - both patches for x32 archs in
> - reorder the pages to make git bisect happy
>
> Thanks a lot to Daniel for helping with the bugs.  Twice.

tests/qtest/migration-test seems to hang in the aarch32 environment:

peter.m+  3380  0.1  0.0  13484 12848 ?        S    11:10   0:03
                   \_ make -C build/all-a32 check V=1 GCC_COLORS= -j9
peter.m+  5471  0.0  0.0   1460   388 ?        S    11:11   0:00
                       \_ /bin/sh -c
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RAND
peter.m+  5472  0.3  0.0  12984  2228 ?        Sl   11:11   0:09
                       |   \_ tests/qtest/migration-test -m=quick -k
--tap
peter.m+ 17798 99.8  0.9 646064 150512 ?       Sl   11:13  43:04
                       |   |   \_ aarch64-softmmu/qemu-system-aarch64
-qtest unix:
peter.m+ 17814  0.0  0.0      0     0 ?        Z    11:13   0:00
                       |   |   \_ [qemu-system-aar] <defunct>
peter.m+  5473  0.0  0.0   8176  6652 ?        S    11:11   0:00
                       |   \_ perl ./scripts/tap-driver.pl
--test-name=migration-t
peter.m+ 17200  0.0  0.0   1460   404 ?        S    11:13   0:00
                       \_ /bin/sh -c
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RAND
peter.m+ 17201  0.3  0.0  13080  2340 ?        Sl   11:13   0:08
                       |   \_ tests/qtest/migration-test -m=quick -k
--tap
peter.m+ 24275  100  0.8 549340 144160 ?       Sl   11:15  41:32
                       |   |   \_ i386-softmmu/qemu-system-i386 -qtest
unix:/tmp/q
peter.m+ 24308  0.0  0.0      0     0 ?        Z    11:15   0:00
                       |   |   \_ [qemu-system-i38] <defunct>
peter.m+ 17202  0.0  0.0   8172  6772 ?        S    11:13   0:00
                       |   \_ perl ./scripts/tap-driver.pl
--test-name=migration-t
peter.m+ 25399  0.0  0.0   1460   384 ?        S    11:15   0:00
                       \_ /bin/sh -c
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RAND
peter.m+ 25400  0.3  0.0  13092  2280 ?        Sl   11:15   0:08
                           \_ tests/qtest/migration-test -m=quick -k
--tap
peter.m+  2755  100  0.8 557600 145696 ?       Sl   11:17  39:20
                           |   \_ x86_64-softmmu/qemu-system-x86_64
-qtest unix:/t
peter.m+  2763  0.0  0.0      0     0 ?        Z    11:17   0:00
                           |   \_ [qemu-system-x86] <defunct>
peter.m+ 25401  0.0  0.0   8172  6692 ?        S    11:15   0:00
                           \_ perl ./scripts/tap-driver.pl
--test-name=migration-t

(processes started 45 mins ago, unreaped processes in zombie state.)

It looks like the multifd/tcp test fails, but doesn't manage to
actually turn the failure into the test case exiting:

/i386/migration/multifd/tcp: qemu-system-i386: -accel kvm: invalid
accelerator kvm
qemu-system-i386: falling back to tcg
qemu-system-i386: -accel kvm: invalid accelerator kvm
qemu-system-i386: falling back to tcg
qemu-system-i386: multifd_send_sync_main: multifd_send_pages fail
qemu-system-i386: failed to save SaveStateEntry with id(name): 3(ram)
qemu-system-i386: Unable to write to socket: Broken pipe
qemu-system-i386: Unknown combination of migration flags: 0
qemu-system-i386: error while loading state section id 3(ram)
qemu-system-i386: load of migration failed: Invalid argument
[hangs here]

I think you need to find a system which has 32-bit ram_addr_t
and test this, because this is about the fourth time round
for this patchset failing on this configuration.

thanks
-- PMM

