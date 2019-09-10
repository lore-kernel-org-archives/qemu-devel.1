Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71652C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A8D206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZT+Lio8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A8D206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7coD-0005JQ-0j
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7cnD-0004jI-Ia
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7cnC-0007nh-BX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:50:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7cnC-0007mT-4b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:50:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id t16so18818529wra.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FUE9oJukkj1jq3GkCNRc0sekgNPaHnQq4gG4He90fw0=;
 b=ZT+Lio8pMng0N6sfnB2Rfrno91+uLOprLl3KQIUZGdZMRcFpyYU857MOLPQCPFm+uD
 0hr6q/p2RPH3OOUhRi+NdpyqpIamfATby/EK1bF8HrwptRhltWHCNUBcsOsTybP69gO9
 7+Y/G/K3ZuAlx7Hoa0o9kwStrAClk0EoMSD4MeNFRJG0ONGpN/+bGIrLArwDFbdxjrDj
 tQ/V5QxP5BetKr4ze/UQUbqEO3BiUHcTscieeoR1PkDuiF1B+SFwqmC6BcMX1uLE+p70
 llvUvX9brBV922fwkCNhXGQVG20292ZJtnYm6ofUjM49BOzsItUnZ8EmHqIk4j/Hbhyq
 tJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FUE9oJukkj1jq3GkCNRc0sekgNPaHnQq4gG4He90fw0=;
 b=rfx1ynyj0Ee6sGhNT5a5Td34DKV6EhJ14/jC7F4cyYXYJftAI+I1+/6Sra+PTWmjPA
 U8Mzox/40ASMRhSkn/4N30DO3lnDOzJhUz2ZFxhaGK4qMtcImVMLKK2ffCoEa4AAlrOb
 VrKnygJODbeZqupwYE7B3ITorwj6Cm4pGIyhyzSbksAd8EoPr6ROsgNnhoIoy1WGjE4H
 BSTDr2hL75QYXpGbUXTBh2v+K3HZ12008HTVxbdtFaPY1/4HzuBfeOxhJt8VAjXovVMe
 k5X6teHrGoC9v9tTeUZZDpdO5BZmnDZGYuhFd9ESFQw9xiHg2ZROxw5hgsCUEueXMaTK
 Pq4w==
X-Gm-Message-State: APjAAAWARXmzP0aBCAIt/uuBSCs28CeZN2sXii2K2HeBYJDecR/OkiKp
 3f1e/y4LTdxrUUjxkBhNBBuzJA==
X-Google-Smtp-Source: APXvYqwFSUEKfOjRnSLPqhK1DGdlGhCLyQC8TJ3n6APjp8ftdfn6gX/4P2Aofogx8IBY2vH+h+QoQA==
X-Received: by 2002:a5d:678d:: with SMTP id v13mr6583942wru.133.1568109031826; 
 Tue, 10 Sep 2019 02:50:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t25sm2188649wmj.29.2019.09.10.02.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:50:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C3481FF87;
 Tue, 10 Sep 2019 10:50:30 +0100 (BST)
References: <20190910090821.28327-1-sgarzare@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190910090821.28327-1-sgarzare@redhat.com>
Date: Tue, 10 Sep 2019 10:50:30 +0100
Message-ID: <87mufc1nvd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] elf-ops.h: fix int overflow in load_elf()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefano Garzarella <sgarzare@redhat.com> writes:

> This patch fixes a possible integer overflow when we calculate
> the total size of ELF segments loaded.
>
> Reported-by: Coverity (CID 1405299)
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Now we are limited to INT_MAX, should load_elf() returns ssize_t
> to support bigger ELFs?
> ---
>  include/hw/elf_ops.h | 6 ++++++
>  hw/core/loader.c     | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 1496d7e753..46dd3bf413 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -485,6 +485,12 @@ static int glue(load_elf, SZ)(const char *name, int =
fd,
>                  }
>              }
>
> +            if (mem_size > INT_MAX - total_size) {
> +                error_report("ELF total segments size is too big to load=
 "
> +                             "max is %d)", INT_MAX);
> +                goto fail;
> +            }
> +

Seem sensible enough (although gah, I hate these glue bits). Would the
large amount of goto fail logic be something that could be cleaned up
with the automatic cleanup functions we recently mentioned in
CODING_STYLE.rst?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>              /* address_offset is hack for kernel images that are
>                 linked at the wrong physical address.  */
>              if (translate_fn) {
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 32f7cc7c33..feda52fa88 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -44,6 +44,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "disas/disas.h"


--
Alex Benn=C3=A9e

