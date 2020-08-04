Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E671C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326C0207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTrjH/ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326C0207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2z7F-0005Ap-Fv
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2z6U-0004hK-0U
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:43:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2z6S-000118-Cz
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:43:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id c19so2457312wmd.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TVjXClmNu8cZZNGqnjl3IWlPPLBSdtLFHE3aLGSYWXU=;
 b=FTrjH/akl9Pb/vH1bzmvrx2xwA67wR1qMJ/3aj9B87xpFkFAzycnBRnjTyyNMUJ00a
 qHtU8gbYfalqdZe/WEw2g2c2GSUwjgpHS4XSiLdcJcXJLNgReUaRQ6Od51RFjfnUSorx
 +v7ExlTytvguLMBGr+NNklVEIv5XlhhIQDUjgxqJ3CpXftGghOnhLhG5ogIjEkhpGF5x
 srZTi14gxao9J0TveU1UOYKvEeHmWwQWZYHNpeMouiFLsSnK3qyzxK2ffPnrp7NCqdEO
 NN+h/vECn0PkFl82clq+Z3TWHvImZQNLHVQ78ibAw7F9lHkc+BbTjQ+8qUBabFXUc/IK
 rQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TVjXClmNu8cZZNGqnjl3IWlPPLBSdtLFHE3aLGSYWXU=;
 b=EgV6hfozpuS0/dJ1A/W0OZH6FTotUmpze1Gno9IrUe6cfkJBSJMPRRu8lgzoOeE9y2
 +9/pqjYOC5T7kXCjv2Kb5NtkKnm/beoyuZY9k/95OoxZMF3rHjdF7xZUD3/SA5iQ4NRt
 MFefzEU5g/YTFi111O7UOBqVEMVS0sOkNsyt6bLmdS8VqdGQnOxLfQJpv7k6KMnyfvEV
 yYCKtxvT48h5u6Oxe5Js8fW08mz4PqmZ7O+mQWR/Xbp4v5RYV3tTtrhVgvesRRTN8E0C
 RKAoEzYW17a1168e7roPWoYxDrODRXe3oHB8tzD1q5dHasHt3fqjZJUaGC9rz+2imH4d
 0RIA==
X-Gm-Message-State: AOAM533dP6SoiLTvEDLIqGO2kH2E37GrWSGdtNzkLQqUhgfKlWNMWmze
 U2v1bRuYtRfmXrDwO3XEY/9JcA==
X-Google-Smtp-Source: ABdhPJx5CltB8BbG2rnrUhLiYARsw5wz2btWy9LMuJb0Ycq4LbRoccq8WiwnKF9glEa1ILDWKH4wkg==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr4619672wmj.92.1596555825398; 
 Tue, 04 Aug 2020 08:43:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k204sm5237127wma.21.2020.08.04.08.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 08:43:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C3D0A1FF7E;
 Tue,  4 Aug 2020 16:43:42 +0100 (BST)
References: <20200804083040.24659-1-philmd@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1] .travis.yml: Deprecate it in favor of GitLab CI
In-reply-to: <20200804083040.24659-1-philmd@redhat.com>
Date: Tue, 04 Aug 2020 16:43:42 +0100
Message-ID: <87imdymn69.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
Cc: libvir-list@redhat.com, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> As of QEMU 5.2 we prefer to focus our CI development on GitLab.
> Mark Travis-CI as deprecated (adding a big warning).

Subject doesn't match body (5.1 vs 5.2)

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  docs/system/deprecated.rst | 11 +++++++++++
>  .travis.yml                |  7 +++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 851dbdeb8a..c17a5b0896 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -17,6 +17,17 @@ they were first deprecated in the 2.10.0 release.
>  What follows is a list of all features currently marked as
>  deprecated.
>=20=20
> +Build and test automation
> +-------------------------
> +
> +``Travis-CI`` (Since 5.2)
> +'''''''''''''''''''''''''
> +
> +``Travis-CI`` is deprecated in favor of GitLab-CI.
> +
> +The '.travis.yml' configuration should only be modified to remove jobs
> +when equivalent exist on GitLab-CI. Adding new jobs is not allowed.
> +

As others have pointed out I think we need to start a new document -
docs/devel/ci.rst and start putting things in there.

>  System emulator command line arguments
>  --------------------------------------
>=20=20
> diff --git a/.travis.yml b/.travis.yml
> index 6695c0620f..4ad243f511 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,3 +1,10 @@
> +#  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
> +#
> +#  As of QEMU 5.2, this file is now deprecated in favor of GitLab CI.
> +#  Do not modify, except to remove jobs ported to GitLab CI.
> +#
> +#  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
> +
>  # The current Travis default is a VM based 16.04 Xenial on GCE
>  # Additional builds with specific requirements for a full VM need to
>  # be added as additional matrix: entries later on


--=20
Alex Benn=C3=A9e

