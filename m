Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B8C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C692C21721
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1Xow6q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C692C21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEroJ-00059s-Hb
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 05:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iErmq-0004hC-EH
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iErmp-0006QJ-CO
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:16:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iErmo-0006Pl-Nk
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:16:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id m18so11858242wmc.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cOgt/pFLQ+SFiVlyLGF/h5+XPzghdGzSa4tyq+Hu6IU=;
 b=d1Xow6q1VJW+jITW9cHuvbNXTn47bOH6j4kuSzG7pdaQw4qF+26GS+TMbzvBxHjrPE
 tmjXllgpLDJhyck96iubX3OQv2SBA2vCisGvNfeQY8JBd1nAAuXDMRLCvRQCZXmENDEU
 XaImwLv/xhZj7cP29Am46SjZa/whLMfP/Ym932qLYIdtHavYyN3QcgD2geHa5+8MdNZl
 LlBeih98vMTEBeK982z4bEogfdZBWtJHOW21ZNVrBXQFDQ3Ph1XvmYUE7T1yO35o/jUe
 WScoJv14COm6BDnTCSl6u1ik/cfdczHzB1txDRheip9hgcNtus7ZKVIns6RDwQ7A0g4y
 W5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cOgt/pFLQ+SFiVlyLGF/h5+XPzghdGzSa4tyq+Hu6IU=;
 b=eUOqg86tDlPx94vN5LAFdK/+B3BcIV2lW18z8rXbEp72VGWmgiOlf92aW8/+seoNB6
 JWr+6tg4TgNPwaxfCqwg+3N6dFdnzwOAPCbxJsK1Z0kyVqXBTwz8UKGNFPwSctTkStx7
 Yrpwpx4gR0h72ySa/AHOFZdG/LSUiwCEaK2132x4+bfLWDy3P79DAxdLxEPUqdtJzelp
 UwrGHAaQT7LOl5KBa3WyDY6gcFjE4icJBM8mleDflx2VznR684wUse3LmwOVjjqOhfHk
 0zSRNfaxKN+7KAhQrLfRTPP8vmoLUsV77sXm+/LVpU6reG6oHCMEPbQaN07bNcA0ScEh
 DVNg==
X-Gm-Message-State: APjAAAUhsmyfOiBQ8E4yb9SAdMGUj4zvpCMFUOW7C+rVaHo3pydz+PAE
 JBSOdMUFGMMrHvXzGaqnisCIszjTom8=
X-Google-Smtp-Source: APXvYqyGD87gq90YxcI83dN0VdK2poXdEO60geh/y5WXzrOrajt91ho0NN+/5BzMTofH4nCZXuFixg==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr17523606wmg.25.1569834965368; 
 Mon, 30 Sep 2019 02:16:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l1sm11436021wrb.1.2019.09.30.02.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 02:16:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 290F01FF87;
 Mon, 30 Sep 2019 10:16:04 +0100 (BST)
References: <20190928190334.6897-1-thuth@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] configure: Remove s390 (31-bit mode) from the list of
 supported CPUs
In-reply-to: <20190928190334.6897-1-thuth@redhat.com>
Date: Mon, 30 Sep 2019 10:16:04 +0100
Message-ID: <87k19qkuuj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On IBM Z, KVM in the kernel is only implemented for 64-bit mode, and
> with regards to TCG, we also only support 64-bit host CPUs (see the
> check at the beginning of tcg/s390/tcg-target.inc.c), so we should
> remove s390 (without "x", i.e. the old 31-bit mode CPUs) from the
> list of supported CPUs.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 397bb476e1..a4488c6705 100755
> --- a/configure
> +++ b/configure
> @@ -728,7 +728,7 @@ ARCH=3D
>  # Normalise host CPU name and set ARCH.
>  # Note that this case should only have supported host CPUs, not guests.
>  case "$cpu" in
> -  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
> +  ppc|ppc64|s390x|sparc64|x32|riscv32|riscv64)
>      supported_cpu=3D"yes"
>    ;;
>    ppc64le)


--
Alex Benn=C3=A9e

