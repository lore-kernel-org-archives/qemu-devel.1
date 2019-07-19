Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E406C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FBE2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWi6fyS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FBE2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVXr-0004E7-64
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40484)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoVXg-0003pP-HW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoVXd-0003xT-1g
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:15:31 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:41404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoVXb-0003uC-79
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:15:28 -0400
Received: by mail-oi1-x231.google.com with SMTP id g7so24663581oia.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1UeMxkq7t8QRKwKpCfqvz9Kzp5g1GEHGFFjvidCOKXQ=;
 b=BWi6fyS3fXkmRZ5zJT/oCT3tMmG6NjeVeIhUs08MnUhnKQSDE+FcIHFBz4RWZBHwsv
 2WyqoPdak2ub3qmWWIUYjaxFbo0F23EPwbsEPY1oK2lq36UGLxTjpfTOwyfaR8pOQhJL
 O1kgquggc4BPGHmEO1pty9grVT46i0H76I4fJYGVY3UzkZXsrtD47qNfECN+Ueqa62jM
 1IUJtsKLLaC9/nZxk5lLPuhOZ4H51dWBc8zAi8B2G1j6VeOdLiEMR/Ad4ld/K6x+hwOl
 SahntkDLem29Qn/EvddKHfcfOXvYflAdZnG+UZUoOaeyEODUjuq6WDjRwz6M3XszLNZ9
 nKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1UeMxkq7t8QRKwKpCfqvz9Kzp5g1GEHGFFjvidCOKXQ=;
 b=F2U7bQ8/hJB0sbIoBL28UF93yEgYpx/dM2QzhsqL8lPIQ58JM5LY90RK3Fz+5ADVXl
 /mOINrbDMI3VUfwYlfbsaERxPqPiCJsrwVi9CSzKn5C6HntDHWGrotWERjS0a9H8VwrX
 Kw+ay9jbmLY1h1PmMt/NQQ1G+Zw5VEgn7o+Zn+6+5OxMFFAsOZ5m38rVwTAna+Da12MI
 DkZr3JH+qXSOq+BBzp0zijVjIQ+oDDcM6pykKEMNpnUs4L+WRi7iofT74bFfQ7bl2LTC
 1Y2tnQKFMRKrmSUExUouKg4kB7rA9vJEM3QcoFx5Qcy0/6y+5+kj/cSKgwl/8BWKohjX
 v9mw==
X-Gm-Message-State: APjAAAVqMt6GmAuBUkXGLEsPNAsqelaFPd+W6X2BDegDIaG1XOK4Psed
 WCC2CslkAiaCXIoMU8txWNlFowQn/fYBoWBmvOHDmQ==
X-Google-Smtp-Source: APXvYqw/qhB4Pk1RBXFg7o+ZtCqOx0bB9pzYifsGVtCTYyvXK+14GkAOVjxAQxefqLZcLJWDmJbvPwB7H78d3K/+Cz8=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr26106671oij.98.1563552919444; 
 Fri, 19 Jul 2019 09:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 17:15:08 +0100
Message-ID: <CAFEAcA-Q6siS3gTRdq7+f0vx-Vd7-DmX1rW6+cS1yR7OqLHYyw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
Subject: Re: [Qemu-devel] [PULL 00/19] Bugfix/cleanup patches for 2019-07-16
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
Cc: Julio Montes <julio.montes@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 at 09:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 46cd24e7ed38191b5ab5c40a836d6c5b6b604f=
8a:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-07-12 17:34:13 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 45d8bc3adedeceaf449d758aee1810bfbe6feff4:
>
>   vl: make sure char-pty message displayed by moving setbuf to the beginn=
ing (2019-07-16 09:27:16 +0200)
>
> ----------------------------------------------------------------
> * VFIO bugfix for AMD SEV (Alex)
> * Kconfig improvements (Julio, Philippe)
> * MemoryRegion reference counting bugfix (King Wang)
> * Build system cleanups (Marc-Andr=C3=A9, myself)
> * rdmacm-mux off-by-one (Marc-Andr=C3=A9)
> * ZBC passthrough fixes (Shinichiro, myself)
> * WHPX build fix (Stefan)
> * char-pty fix (Wei Yang)

Hi Paolo -- it looks like this may have broken the
travis config "--without-default-devices":

Here's a sample failing build:
https://travis-ci.org/qemu/qemu/jobs/559509325

minikconf barfs with "contradiction between clauses"

Traceback (most recent call last):
  File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 703,
in <module>
    config =3D data.compute_config()
  File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 253,
in compute_config
    clause.process()
  File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 188, in pr=
ocess
    self.dest.set_value(False, self)
  File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 118,
in set_value
    raise KconfigDataError('contradiction between clauses when setting
%s' % self)
__main__.KconfigDataError: contradiction between clauses when setting VMMOU=
SE


I guess this is Julio's commit 97fd1ea8c10658?

thanks
-- PMM

