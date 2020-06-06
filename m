Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA30C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F912053B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alOt6q94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F912053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheIq-0001rM-0d
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheHo-0000sQ-7y
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:15:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheHm-0004re-Q8
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:15:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id d66so6589888pfd.6
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=dxl34nCISd4h1eCXV0iOt7lT91aX39igUoOYBnhQ/v8=;
 b=alOt6q94UPZ6CGN2E4a/CwUMVJZyy79uDOLNqvNDt4/KVbPNtBRepLfkWKTL7957Gv
 U166DPQHksMmCGX+/NsKhN7Al1FUDu3zlIyRkBYEpCt3BEGT0lgSJvEHHELNFK1SWASO
 niFac4TGGvHKmfrugDfD9G52YAqEE9kZQ6Mm1OyKeRYrg7XFufVyT/KCJKPe/0XXCXOv
 BJSQtLcEmb7PLyRD4Ita0rRQAJB5inO1NI3CbknusluvIHMGzyEwoI8uO6/VRyDYTew1
 xB4c7XC0M8pQ+wGAOHfkd3gpmSSevPvVdhvnRB5K6NwL0cGDviOdX3P/iYcSy8gXvHgD
 IKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dxl34nCISd4h1eCXV0iOt7lT91aX39igUoOYBnhQ/v8=;
 b=O0xRxNpStpfhVDuO9U6tSAuyM0WLpW5sFsnrL4vWdhJLta5Izj3/MG9+8P8UT2lrPx
 5eCcRPP4C9PAJDrrSUFawKqhGAv2bEcSvYz8zbHP94kri5J2L95bzSCbvzBpNnkKrjeI
 QGObM8iVUenRsE2AkHn54nAr8he2JBNLfx3NlszOxO/9q9V3incDJxwmvfBFeDYWgHRF
 DFLvCLuYGXTkVyv8yf84N2/+yR/cuvLUL5iNMVc8aN+XREoURm8QcyvkSUPGJdzSWqWG
 5oo9vof3iQNQPKILjMkHgnudCuhJzIK+9yLrqMQXBcG9ZClEtmeRd7awb+uY3QTqH3tK
 dqAw==
X-Gm-Message-State: AOAM532KbB8rXyjp8B8si0aGN1RKF0PVwlXitrg8TAGut2xaVUcbrKtV
 VQoYNA98Bu2fniHT3xWt7Swqtw==
X-Google-Smtp-Source: ABdhPJzkcniRttFJXNvICeFB+/WGeP+34aEAobDZBbc+Hh7c+lePAzLx1J3wERrpGrxW+PS9e8uMHQ==
X-Received: by 2002:a63:a55c:: with SMTP id r28mr14120900pgu.108.1591470917368; 
 Sat, 06 Jun 2020 12:15:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id nl8sm12260088pjb.13.2020.06.06.12.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2020 12:15:16 -0700 (PDT)
Subject: Re: [PATCH 5/7] softfloat: return low bits of quotient from
 floatx80_modrem
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 laurent@vivier.eu, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051901120.13777@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bce722e6-0db2-43e4-f495-fbf5d1e2ce53@linaro.org>
Date: Sat, 6 Jun 2020 12:15:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006051901120.13777@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 12:01 PM, Joseph Myers wrote:
> Both x87 and m68k need the low parts of the quotient for their
> remainder operations.  Arrange for floatx80_modrem to track those bits
> and return them via a pointer.
> 
> The architectures using float32_rem and float64_rem do not appear to
> need this information, so the *_rem interface is left unchanged and
> the information returned only from floatx80_modrem.  The logic used to
> determine the low 7 bits of the quotient for m68k
> (target/m68k/fpu_helper.c:make_quotient) appears completely bogus (it
> looks at the result of converting the remainder to integer, the
> quotient having been discarded by that point); this patch does not
> change that, but the m68k maintainers may wish to do so.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  fpu/softfloat.c         | 23 ++++++++++++++++++-----
>  include/fpu/softfloat.h |  3 ++-
>  2 files changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

