Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C6CC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B75120748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWCkTYNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B75120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4E5-0005dS-Ju
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is4Cn-0004fV-3w
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is4Ch-0000vu-L3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:24:56 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is4Ch-0000ur-7K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:24:51 -0500
Received: by mail-ot1-x344.google.com with SMTP id z9so17032550oth.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 04:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qC7hBoaIL8oUCA1xX16AOy/PcPLtnMR4zhXz9UbIBh8=;
 b=LWCkTYNsBWjgaf7cJPj8Ofy+vDMVLYHWW5kgTp/vzPLycGQXNGJF+eRm1pcEZ/l+AK
 tRE7RVfcY5zEBKCgF1on24P6HMv6dLnm667MlZ+4lSJvP7iKylp618O1bvtP5UZWntcx
 URlQUeO/9sWMFyhoWnEEOlohN1GE5+igbYcjLxlFhQlpHfb/pWcKSPt0wnTvjGJBHpLw
 jnpQB1OzeONRvfPK5DvcY1eo08AWd5dKluEn3CfyzkOeKV1WqaJryy5h09/6I1SJt4Nf
 W8hqUNQiPcOiP4O3zzOTs3TBJzrajqA1kRGClHPlBVvZMMLUpChywGBwn93b+aS3MaPM
 CkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qC7hBoaIL8oUCA1xX16AOy/PcPLtnMR4zhXz9UbIBh8=;
 b=tRExucw4L1MSTwhnC6xbZ5jTT4xGO/rM7hlahx4xiRIa1zbjpaE/54x41EIet9rLry
 ZVy421TkaJXzvHU7fBr/bZYrul/8YBH84FyfeX8nVS4uwMzJOrv1wk00hq4rLXnLZGvP
 UpZb2ERw7cTraywKSHwx8IxQam5DlJjJ74LMEfC5SPmQ0ruaMMx33VHMukdqoGYXpb4N
 a+CuxQT4wfscYvg1Tl6cQDDZDv8LvmzKZWHqP4CDb/cjM/xUtKLfwhh55CWZfXG5clYw
 2yiunVJZNfpE03VFdk5J3eh+t9wM/ksx2aaqdEWd95N6i8e9MH00SJjSGl8z38G5pCRi
 BeYA==
X-Gm-Message-State: APjAAAWv+AYbFNyFWqnHAemCjQYJdvyzDyDVlIhpAyVHMbloqB5+/kaq
 F438+foJ3cwbnAYJmt+e6z8J1Z2IjxW9KDXxT+CxQMmeXKA=
X-Google-Smtp-Source: APXvYqyObHPk2DOi39llRElgRwCKKdx7tlntEYnIY8/eYp5hkN6XifC3eUHf/VFPU3uRULeTPY1oXmGHp1dI1kabmPU=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr1741706ota.232.1579177490204; 
 Thu, 16 Jan 2020 04:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
 <bbf347fe-c4a4-c5bb-19c2-3a18571b658f@huawei.com>
 <20200115011412-mutt-send-email-mst@kernel.org>
 <7732900c-5490-6483-ca10-71c565e81945@huawei.com>
 <20200115055408-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200115055408-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 12:24:38 +0000
Message-ID: <CAFEAcA9AZS=aNBYNntTDNB0k4kORjMFJ6qOimASVV9JWs4VzTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified by
 _HID
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Corey Minyard <cminyard@mvista.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Guoheyi <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 at 10:55, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Here's a hopefully better patch. Peter does this address the issue?
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index f1ac2d7e96..3ab4872bd7 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -16,7 +16,10 @@
>   * 1. add empty files for new tables, if any, under tests/data/acpi
>   * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
>   * 3. commit the above *before* making changes that affect the tables
> - * Maintainer:
> + *
> + * Contributor or ACPI Maintainer (steps 4-7 need to be redone to resolve conflicts
> + * in binary commit created in step 6):
> + *
>   * After 1-3 above tests will pass but ignore differences with the expected files.
>   * You will also notice that tests/bios-tables-test-allowed-diff.h lists
>   * a bunch of files. This is your hint that you need to do the below:
> @@ -28,13 +31,23 @@
>   * output. If not - disassemble them yourself in any way you like.
>   * Look at the differences - make sure they make sense and match what the
>   * changes you are merging are supposed to do.
> + * Save the changes, preferably in form of ASL diff for the commit log in
> + * step 6.
>   *
>   * 5. From build directory, run:
>   *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
> - * 6. Now commit any changes.
> - * 7. Before doing a pull request, make sure tests/bios-tables-test-allowed-diff.h
> - *    is empty - this will ensure following changes to ACPI tables will
> - *    be noticed.
> + * 6. Now commit any changes to the expected binary, include diff from step 4
> + *    in commit log.
> + * 7. Before sending patches to the list (Contributor)
> + *    or before doing a pull request (Maintainer), make sure
> + *    tests/bios-tables-test-allowed-diff.h is empty - this will ensure
> + *    following changes to ACPI tables will be noticed.
> + *
> + * The resulting patchset/pull request then looks like this:
> + * - patch 1: list changed files in tests/bios-tables-test-allowed-diff.h.
> + * - patches 2 - n: real changes, may contain multiple patches.
> + * - patch n + 1: update golden master binaries and empty
> + *   tests/bios-tables-test-allowed-diff.h
>   */

I think that seems reasonable, but you're the ACPI expert.
As long as the patches on list:
 * can be reviewed by somebody for whether their ACPI changes
   are correct, including whether the golden-master changes are right
 * can be applied by a maintainer without having to do anything
   special
 * don't break bisection

then I'm happy. It sounds like those steps will work for that.

> diff --git a/roms/seabios b/roms/seabios
> index f21b5a4aeb..c9ba5276e3 160000
> --- a/roms/seabios
> +++ b/roms/seabios
> @@ -1 +1 @@
> -Subproject commit f21b5a4aeb020f2a5e2c6503f906a9349dd2f069
> +Subproject commit c9ba5276e3217ac6a1ec772dbebf568ba3a8a55d

You have a stray submodule update in your patch, though :-)

thanks
-- PMM

