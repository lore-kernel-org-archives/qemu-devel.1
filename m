Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A69C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F2F207FC
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdxLL4+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F2F207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpF7B-0002k3-3z
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF69-0001UO-Ht
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:58:41 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpF67-0004xt-W3
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:58:41 -0400
Received: by mail-ed1-x543.google.com with SMTP id e15so9364668edr.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cH77IBzOr/NxzU+S2E8cbfsg5QULDuG57xg5VTa2ujg=;
 b=mdxLL4+px77PzfqU5uN44OFFHbZ+c7BzcGa+BYNGYVXHBMd93sLjRJqjtKSvMX4DuQ
 XqLPKRbSepvbaLg8Mggqq9R2dV9/r3H432ScNRVrXjZsbFGBApEOVMu5MgTCGgPGSpAr
 L7cR4h4cw37HO5qtt7FsotBDYBD7frTsLh61A4cozDW0zRkG3hkof5XY0BujowdCOFLm
 58fn+sruLteCPWK4LyTvGtZh/wkLEf0hvfrvksE1edm4W+DWzWd5K1s3FeSFdn6Qnlzk
 KRVUARnE9G5b9bmrjysfkvj/ibsHdbhgvu+ihrMZv/PYXYGoco7g/dx1E1je4ko0PeTT
 /aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cH77IBzOr/NxzU+S2E8cbfsg5QULDuG57xg5VTa2ujg=;
 b=G5HTgpqZzLScdyeCW/UWy5E9OJfT0a4fAMxfLPsh9b8vbihUrwIDnO94WgY3v59IRW
 Y694iWQkEv2vaQ9hEMKQ8lBf3DmL6JoFSZHL9c6vkc++lnLlv3unJAxbVX0cYcetkefW
 J6M650TpNMCopjj90hNdd6I25Hq7pf/wNYYOnCqdvbP2Rzldg0+6H/dbbHrm/q4jaNcg
 fqJ8FUCDVYu0ExzWFq5EBX+LAxuGmJpVwtrn5dhb3bg/4Lx9xvex8sMvTmXgd4mg/cIt
 y+1WfpYNn8/PBad6QQHT78QScyt5wTE+M1PXQus21hfDjapEveYxVJqKtPlOeZMUHwXO
 AqeA==
X-Gm-Message-State: AOAM531koORER9Mctyp2oXLNin6LuhuMFDIA57FYpRkw25okGXv8eapu
 oY2TD0OgHWuZLWKnd2EMH/CkY7GTGZ/BuqWFvZ0=
X-Google-Smtp-Source: ABdhPJz3QnV6zu3RIgfNz9e9PIatOyqDVYsYxzS4CJesnPAP8eQ0N1+dvTpwvmb7SMG3RYfLLSzMjgPCfcRMkf/seDk=
X-Received: by 2002:a50:f413:: with SMTP id r19mr9925195edm.17.1593280718754; 
 Sat, 27 Jun 2020 10:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200626164546.22102-1-ahmedkhaledkaraman@gmail.com>
 <20200626164546.22102-4-ahmedkhaledkaraman@gmail.com>
In-Reply-To: <20200626164546.22102-4-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 27 Jun 2020 19:58:27 +0200
Message-ID: <CAL1e-=hEsSScvwA-T9RLSEPSfrTjLWGfR1TibKjrfwofSgKa_A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add 'Performance Tools and
 Tests'subsection
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 7:02 PM Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> wrote:
>
> This commit creates a new 'Miscellaneous' section which hosts a new
> 'Performance Tools and Tests' subsection.
> The subsection will contain the the performance scripts and benchmarks
> written as a part of the 'TCG Continuous Benchmarking' project.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Applied to "TCG Continuous Benchmarking" queue.

>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b40446c73..c510c942ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3019,3 +3019,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: docs/conf.py
>  F: docs/*/conf.py
> +
> +Miscellaneous
> +-------------
> +Performance Tools and Tests
> +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +S: Maintained
> +F: scripts/performance/
> --
> 2.17.1
>
>

