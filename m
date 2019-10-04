Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE99C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296FD20867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udWCi1qJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296FD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMcg-0003DF-If
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGMZe-0001YW-Ar
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGMZc-00013J-5i
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:20:41 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGMZb-000123-TG
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:20:40 -0400
Received: by mail-ot1-x341.google.com with SMTP id 60so5140267otu.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V9ce1jBEz8iT9saMzNDeWS3GmCvWAme8gBE3blLzf04=;
 b=udWCi1qJssTxhWTovq2dmC9gheCFRc7N1EdB0lepKaRdpliqHiuw756vwJlEH71P+g
 XeNTTa4nU3r+sf6+pww1UvdmDHGqAzng9CMGnetYJbzTGkQtmQQITVykoUdbts/Y2cMP
 FgJDhjFEqKv9mk5A3Ptd6U9tM9vj5UUk/LlaUseAF9jjpBVYAJiO2PS985kgl7KjvS0u
 OgzY46JQHWGu9pCCXxg7Xo5+1JhsqEbCdz/3LkLDpseD3fxAd2/Z9HGDEM7JIuXfGOJu
 8SNge/iuA7XG9aTuEFRUnwrLnW01L9hZHzRzJF32Ce93Sk7yJF5zJs68bfjcftMiBtef
 A/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V9ce1jBEz8iT9saMzNDeWS3GmCvWAme8gBE3blLzf04=;
 b=KAlSqUb5bVt/9NDBQg1XSzkA4aGGZD3ciTGYRVvkVleX0LbTrJ5Eh8tRnk9sFuElK9
 2dSuXKXTVp1tT0+ZvEQgI0uzyfPHEVIWGFrEHgmUgVySIgnw1h/s1lJH+NMmtrCqEsvS
 o9E8qAYzEewANHcaAgXxZAsj0RE1zAL6ZVcgX/mym6+2NXuLq9Uv7nSN+nc9F+HApCzw
 kmOQc2RAbuoR169yPe0j2yIgR6U21I7fHuIHMa56ToyxuvFj62NhrtCGI8dDcAFYiJGc
 7iLApRlN0ocnu3V4ydtOQdT9SoE6Avzfqb7WV81t5QjflRpYS8vjvWZGSr8TgZaw9LGR
 42mA==
X-Gm-Message-State: APjAAAV+MGC34BOXcBffm25EDwBxdOuje0ZqN+UTrP54zwX1y2ZKxFVV
 IaE0DTY1o+VkKc4eikNB8xy3J9e148RSuw7aYXTtxA==
X-Google-Smtp-Source: APXvYqwxSRkuEW9WDB58lJ0kSrEieDPJSFX/yxNxsLjNGc/WJ4561hm5G/X3hgHFz8gu2jld/RRPuMhAm2DDlbflprA=
X-Received: by 2002:a9d:562:: with SMTP id 89mr10754227otw.232.1570191637575; 
 Fri, 04 Oct 2019 05:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
 <1570035113-56848-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1570035113-56848-13-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 13:20:26 +0100
Message-ID: <CAFEAcA--sjm+ejLLdaQtsVC4u4adA9p+QDSJ2QKQ2hSBLt=oDw@mail.gmail.com>
Subject: Re: [PULL 12/30] Makefile: Remove generated files when doing
 'distclean'
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Oct 2019 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> When running "make distclean" we currently leave a lot of generated
> files in the build directory. Fix that.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451..48b52da 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema check-unit check-softfloat check-qtest chec
>  check-clean:
>         rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>         rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> -       rm -f tests/test-qapi-gen-timestamp
>         rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
> +       rm -f tests/qemu-iotests/common.env tests/qemu-iotests/check.*
> +       rm -f tests/test-qapi-gen-timestamp tests/qht-bench$(EXESUF) \
> +               tests/fp/fp-test tests/fp/*.out tests/qapi-schema/*.test.*
>
>  clean: check-clean

Hi; this change breaks the sequence
 'make clean; make; make check'

because now 'make clean' removes tests/qemu-iotests/common.env.
But this file is created by 'configure', not by 'make', so if there's
no other reason why 'make' needs to re-run configure then we get
to the 'make check' stage with the file not existing, and then
when we try to run the iotests they fail with:

./check: line 60:
/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/common.env:
No such file or directory
check: failed to source common.env (make sure the qemu-iotests are run
from tests/qemu-iotests in the build tree)
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:1102:
recipe for target 'check-tests/check-block.sh' failed

thanks
-- PMM

