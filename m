Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3684C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5992189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umohnz+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5992189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Gmp-0006P1-J4
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3Gm3-0005wc-2x
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3Gm1-0006XN-Sl
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:31:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3Gm0-0006WL-VX
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:31:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id j11so2631841wrp.11
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=C/J0PKmzZrQKiws/WNhAJI9OBFkz1kLSLCXerpGeWCc=;
 b=umohnz+iEmCKYKTg5Gch3QkjJNNn94vqIDcFzNm29S1Fnmm47UyR2ir84PqQFzsiNI
 rwjkALPuJPeY8Hr6edWLl1k/pOc3SKfQa4eJOoWVxswG4uL0mD6ufpTIGuTFCdVRo1TK
 SsPQBwlhVyn9/87RhShnZIord40JPEsBJEvwefPVk1xhMp69KNv26/NJGguZzANXeUJr
 XbOpjb1ZBjp33Gh4hJsPew9vqOhovSP8xIhbSJMvrAP8utyPxuQ84hyAoywWd1eoJnQ7
 fgL09foAERMW/iNdQy9VHsWhVQbqD9uCCmKDObfPMkR2JPB8KYaI8wBCVOaP0Dn+TXdk
 fS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=C/J0PKmzZrQKiws/WNhAJI9OBFkz1kLSLCXerpGeWCc=;
 b=mjfQbga2OI5GwvB1cC0GOalKZH6znXzA9z6MttLH1CO4GfcKP87Xp/UlgUSZnhIhPL
 orlUl/E0AyglyaKhtBkGQB31QtNxiJ8NCy9Kpt7PAIIIrZSIekPH7wR4UWXsK3tFuD5l
 8EjArlTlZGJwi6254YHc1yq46zzDznkEHYpOigXZAy0/tmRJSsibxEM1nUlXrsewgywn
 mVgwLxT4NFxenq0ljCpz4l+K06c3uPWFzY68l92zWf05KRGBSUm7PNduCMFxYYl3k8xh
 BqUq795StBhPVpZEaHbi8YVFbKyKFQ1zLJJyanTQy6MD1L5GIEMmDvQRozqNm5x/BKhD
 Zzsw==
X-Gm-Message-State: APjAAAU74iqgODPseNGWQo2jY/aWNMgMkmy0FFPCtIgqPZPdoekg8Ja1
 J9Ni2h04AcuX6W0rdPSD16gJSw==
X-Google-Smtp-Source: APXvYqxM6Gtx2bZ9DruSJAtD8MctDqd29tISuVPojIiOBAZ/ZSc4PFNwugch5G68my0ys3swMVUiMA==
X-Received: by 2002:a5d:5689:: with SMTP id f9mr1267165wrv.224.1567071078308; 
 Thu, 29 Aug 2019 02:31:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h8sm2293368wrq.49.2019.08.29.02.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 02:31:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D99721FF87;
 Thu, 29 Aug 2019 10:31:16 +0100 (BST)
References: <20190828165307.18321-1-alex.bennee@linaro.org>
 <20190828165307.18321-9-alex.bennee@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190828165307.18321-9-alex.bennee@linaro.org>
Date: Thu, 29 Aug 2019 10:31:16 +0100
Message-ID: <8736hk5ndn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 8/9] accel/stubs: reduce headers from
 tcg-stub
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> We don't need much for these. However I do wonder why these aren't
> just null inlines in exec-all.h
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/stubs/tcg-stub.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index e2d23edafe0..75b10ab54be 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -11,10 +11,8 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
>  #include "cpu.h"
>  #include "tcg/tcg.h"
> -#include "exec/exec-all.h"
>
>  void tb_flush(CPUState *cpu)
>  {

I'll drop this one as it doesn't merge build cleanly against master on
Travis (but oddly built on my machine).

--
Alex Benn=C3=A9e

