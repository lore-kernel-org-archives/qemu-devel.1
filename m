Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B3C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D0C22268
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCAkNSZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D0C22268
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcra-000757-Nm
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kZcmm-0003Dk-8r
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:34:24 -0500
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:34420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kZcmi-00013f-Bv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:34:23 -0500
Received: by mail-vs1-xe41.google.com with SMTP id b129so7800168vsb.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YkCmdokUG70n/lP0Yg3aq5llbLTxN2eE6dBP9DGCPTI=;
 b=aCAkNSZlqaJlmomKa5MZoFM68wdB1hak7x5oXCTQOp67+tQlWuxKA2xvaCYue87T05
 vAehkUH89x8LWH9unqlSPyOOpLx9SVHMnjTycyL1zdClimGWw3fMnry3RL+PMMa1qr5R
 UZa9CirfaTcNO85foGXu1oK1T+ykA0bpjlBUDHRi5U2Kf0yGyi5JdQAil+r1VEv9+jD7
 v6ewmOx3sd6JiUn2tg+mort4075B3bN4etph+S7C5axa80rK3kFY0dMsbysXU/V/ovoM
 RKw8pMqkBtZY/8J1v0WJGlRXa6/FMFD66MJcyg7w44HP6WcmjYrs0v8Bqisb/wNW84fN
 NzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YkCmdokUG70n/lP0Yg3aq5llbLTxN2eE6dBP9DGCPTI=;
 b=fjpNcjPndWWej6UwF+hOWn0KXq0hoTffPripw+pP+I7g/2S4bg56FW1g7MO4FfEIYw
 WBDP+Zkh0hehD1IHpRL5wC/bG4AEwHZfNlOJTqHhvuuSjSzvPIUzEhY4Wg4yZRPddYBv
 xQzrRty16MR6KuMEmdlLosNuzqrY/pmKK0iU5Jqgm7/17So8YW+SZG7HbYf84fkjLRPb
 +VQ0DKdbFQBHa7Ta318RFEyA91TvmB9beNYZddSdEqzEDukDm17nvWP5CFldUSqKagbH
 yakMkCzHx6CrjK1W6Rb8rl+RvMG6fx9KYiTaaH4DT20iN38ApjoPiCu/4HnyAoyb87oF
 kirA==
X-Gm-Message-State: AOAM533Pgh49UvczGI04bCiIHIbKEcajXgGGL4inb7LuqX0GfqSdZCZb
 ee2IuI01utun4yOzQPi0VSURW/GNzyMTqMoH4R6Ybw==
X-Google-Smtp-Source: ABdhPJzIt2Nd2xiju/fdv2gWTSStWHpfzB5/Ss3Ge83HgiN0FvepFR+ePeFIBnIBprt/Zzon8AQYU4Bx8OwP2Scar8Y=
X-Received: by 2002:a67:2545:: with SMTP id l66mr14572906vsl.1.1604334856444; 
 Mon, 02 Nov 2020 08:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20201102152454.8287-1-peter.maydell@linaro.org>
In-Reply-To: <20201102152454.8287-1-peter.maydell@linaro.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Mon, 2 Nov 2020 08:34:05 -0800
Message-ID: <CAFQmdRbEJCD3t2=6omuq3PC5N6Rzvii5Tw+K3bme76jXGOkCdA@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest/npcm7xx_rng-test: Disable randomness tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 Tyrone Ting <kfting@nuvoton.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 2, 2020 at 7:24 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The randomness tests in the NPCM7xx RNG test fail intermittently
> but fairly frequently. On my machine running the test in a loop:
>  while QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/npcm7xx_rng-test; do true; done
>
> will fail in less than a minute with an error like:
> ERROR:../../tests/qtest/npcm7xx_rng-test.c:256:test_first_byte_runs:
> assertion failed (calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE) > 0.01): (0.00286205989 > 0.01)
>
> (Failures have been observed on all 4 of the randomness tests,
> not just first_byte_runs.)
>
> It's not clear why these tests are failing like this, but intermittent
> failures make CI and merge testing awkward, so disable running them
> unless a developer specifically sets QEMU_TEST_FLAKY_RNG_TESTS when
> running the test suite, until we work out the cause.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/npcm7xx_rng-test.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qtest/npcm7xx_rng-test.c b/tests/qtest/npcm7xx_rng-test.c
> index da6e639bf6f..e7cde85fbbc 100644
> --- a/tests/qtest/npcm7xx_rng-test.c
> +++ b/tests/qtest/npcm7xx_rng-test.c
> @@ -265,10 +265,16 @@ int main(int argc, char **argv)
>
>      qtest_add_func("npcm7xx_rng/enable_disable", test_enable_disable);
>      qtest_add_func("npcm7xx_rng/rosel", test_rosel);
> -    qtest_add_func("npcm7xx_rng/continuous/monobit", test_continuous_monobit);
> -    qtest_add_func("npcm7xx_rng/continuous/runs", test_continuous_runs);
> -    qtest_add_func("npcm7xx_rng/first_byte/monobit", test_first_byte_monobit);
> -    qtest_add_func("npcm7xx_rng/first_byte/runs", test_first_byte_runs);
> +    /*
> +     * These tests fail intermittently; only run them on explicit
> +     * request until we figure out why.
> +     */
> +    if (getenv("QEMU_TEST_FLAKY_RNG_TESTS")) {
> +        qtest_add_func("npcm7xx_rng/continuous/monobit", test_continuous_monobit);
> +        qtest_add_func("npcm7xx_rng/continuous/runs", test_continuous_runs);
> +        qtest_add_func("npcm7xx_rng/first_byte/monobit", test_first_byte_monobit);
> +        qtest_add_func("npcm7xx_rng/first_byte/runs", test_first_byte_runs);
> +    }

Reviewed-by: Havard Skinnemoen <hskinnemoen@google.com>

Thanks!

>      qtest_start("-machine npcm750-evb");
>      ret = g_test_run();
> --
> 2.20.1
>

