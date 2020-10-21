Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F8FC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFF32224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUQSRFHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFF32224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFl2-0001Vh-QN
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVFYw-0002tb-DH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:58:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVFYu-0007y9-9M
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:58:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id x7so3516242wrl.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cS+b6VpymY0vFD7R1t3TRLWf9Y42Gv/nUe/vOPWo9OU=;
 b=DUQSRFHUMhqseO9Jm2LcacFqW12+CVuhPI6RQMMLVDoLEMo9nAXf76q+KpobpGsrXI
 xImoV1YBjtUZS0UnRlf3I4z9swpU8X9R2SsuQWxmnuQpA3ii7dZlQpJldkdm42Yd6Rxo
 T6Wl9DIlzFsQ1dsVnw+M8dMNyJwqjSQuacD+zw55gdsCBDRVfxm2oZhMmEIpT5R5rHMW
 6DPhk/jxbu65sKWJAK5BwuMsRLGldEpEMDA1tmdIeH5FsSTU/lp3rurMREaGEXTfVFyi
 Ef2xr67xTfMpGwaI+2jJg6EZKCWFvIb9A5qw+SA9QNQig4L/h5hpnS0D7cOQV/RnmWRL
 YyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cS+b6VpymY0vFD7R1t3TRLWf9Y42Gv/nUe/vOPWo9OU=;
 b=BlJ9R4JY6AraR1unvMhfpMaFL9QmPUduypLkp7kKDgK7dR/4cIkZvynKZ+rLJGVI04
 to2IH+9mJPgwZ7Co+nz3Ml0VDe+LQZwUhb4brfWaeyRl/9GdTWd69vHCqtw//gN9ma7+
 6lOzuoG6eaTMZR0eTIa4kkYN66dupJbiZW0WVqZx9sDzmqB+5d1X6r46adySOG2qklc9
 FvbkYGiSQZUPOx5Eqg7+U7UOcFx1jvlPMCEWrE9CJkVWoCSsLswVS7tybtppaStpv4cc
 DKz5eGdNZMY84zk5Ryq7xP+bmJoKVnEAaqyDMFLR/Jk7ZaJF2SWPAzOi5JbHAeImSPtr
 Kv1Q==
X-Gm-Message-State: AOAM5318m47k0BxcOGn+HZlGOoYzOQPJ5gX/e2J69I/w1qTyL4dyahZy
 88IIuNqwSgMsXP+nt2Pq5u8+SA==
X-Google-Smtp-Source: ABdhPJz3ZQbEYGIfXvavgTyKcB0b6GJh2ABR0o8AkZzxRYbTvbuU/EvCNN0tkG43Z6s7GzvWnYicaA==
X-Received: by 2002:adf:f101:: with SMTP id r1mr5605793wro.392.1603292277463; 
 Wed, 21 Oct 2020 07:57:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z191sm3911596wme.30.2020.10.21.07.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 07:57:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 49F121FF7E;
 Wed, 21 Oct 2020 15:57:55 +0100 (BST)
References: <20201013222330.173525-1-richard.henderson@linaro.org>
 <20201013222330.173525-3-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] tcg/optimize: Flush data at labels not TCG_OPF_BB_END
In-reply-to: <20201013222330.173525-3-richard.henderson@linaro.org>
Date: Wed, 21 Oct 2020 15:57:55 +0100
Message-ID: <878sbzwrrg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We can easily propagate temp values through the entire extended
> basic block (in this case, the set of blocks connected by fallthru),
> simply by not discarding the register state at the branch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 220f4601d5..9952c28bdc 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1484,29 +1484,30 @@ void tcg_optimize(TCGContext *s)
>                      }
>                  }
>              }
> -            goto do_reset_output;
> +            /* fall through */
>=20=20
>          default:
>          do_default:

A random aside:

The optimize function has a lot of goto's in it and I find generally
hard to follow. Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

