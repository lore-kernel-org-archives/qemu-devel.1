Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C3020719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYm0yLeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C3020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnYC-0005S7-7K
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLnUq-0000Ou-FS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLnUp-0007Pm-2k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:38:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLnUo-0007On-Oe
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:38:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id r26so1667180wmh.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=L8H7mvumjfpb1kla0GIYvTW0JoBG/XnhyZaIaP2ZqvM=;
 b=BYm0yLebTnqo89PxcKUEUJQVIZ1lZbqbvzrgYBVhMboeL1o2ZTTVCw1o1JZtiALeZN
 zTbrTmq9xpWF5G5M7dYQRJ3O8DtvjRjCYyARRyIlRhqd+cr/RrgrxydcBkWwOCKE4ecQ
 8dLu1ORHd+yOsWnKGJne1NzX2+qSnMuv3gaXOs4BmuZ0haunWXli7AvHjiFe6gydlZ8d
 e5GcIYrVdc7RaRJQUtEtSVZYZhaDUqOPzYWQDL94XiyWfq0oxmmCN/XMOPZscqa/tiWS
 9UBWi7iLICJLOkV9RjJWqZWagN/3AXBHSq2zDFdCUldOtPLciJfGUZ4PxpeUOGtzeUs+
 Zmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=L8H7mvumjfpb1kla0GIYvTW0JoBG/XnhyZaIaP2ZqvM=;
 b=KQbR84DP84VcSilgvN/uowJzLUgVwO4fdlp41t5/2ehm3wMfKckcpF/oq7qWcKoFKp
 VnvDS9hc6+6n/C9gYov2KHjW/6P8yQo418o4+ftmf5AAPfKoig+FIn7HuVmgfGQqUWQy
 uVSo/V7Nd4h/JayOZziDx4DuTdqAle4To5U9JzHEyuN85jRzI2mNA+V83ayNAKxFD6Rb
 IkgbGS/uuCn5LpoBB99O9bM+ftMLSeg7kNig3JmpeLJF+Ryg/Sb0OIe4J+5yywufxk7j
 igVDAgU2P3t1BLtbv2QMB8tT3NS62OKChuTxutj03pgZH/BCiuXW2u4+snZwN+MsBs8V
 U+YQ==
X-Gm-Message-State: AGi0PubO/NV3YjXNN0n+rAnjnGu1lfU1AUvY5lrN+O9ij4N4sf748WzX
 yzuLkAxLUO0So9Ggbnj/Wmlm5Q==
X-Google-Smtp-Source: APiQypLFYrYRz9QcQiUtNnYqSdrf9G74afoZxfgtvrcAXLYPqGIr4wjqLADD2gpxRMFpSOWep2QYnA==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr2211951wmc.15.1586263104945; 
 Tue, 07 Apr 2020 05:38:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f3sm2353931wmj.24.2020.04.07.05.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 05:38:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9EBCE1FF7E;
 Tue,  7 Apr 2020 13:38:22 +0100 (BST)
References: <20200406214125.18538-1-f4bug@amsat.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.0?] .github: Enable repo-lockdown bot to refuse
 GitHub pull requests
In-reply-to: <20200406214125.18538-1-f4bug@amsat.org>
Date: Tue, 07 Apr 2020 13:38:22 +0100
Message-ID: <87lfn7a2td.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Some GitHub users try to open pull requests against the GitHub
> mirror. Unfortunate these get ignored until eventually someone
> notices and closes the request.
>
> Enable the 'Repo Lockdown' [*] 3rd party bot which can autorespond
> to pull requests with a friendly comment, close the request, and
> then lock it to prevent further comments.
>
> [*] https://github.com/dessant/repo-lockdown
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Queued to pr/070420-misc-fixes-1, thanks.

> ---
> Repo Lockdown is enabled on https://github.com/qemu/qemu/
> ---
>  .github/lockdown.yml | 35 +++++++++++++++++++++++++++++++++++
>  MAINTAINERS          |  1 +
>  2 files changed, 36 insertions(+)
>  create mode 100644 .github/lockdown.yml
>
> diff --git a/.github/lockdown.yml b/.github/lockdown.yml
> new file mode 100644
> index 0000000000..94472d1256
> --- /dev/null
> +++ b/.github/lockdown.yml
> @@ -0,0 +1,35 @@
> +# Configuration for Repo Lockdown - https://github.com/dessant/repo-lock=
down
> +
> +# Close issues and pull requests
> +close: true
> +
> +# Lock issues and pull requests
> +lock: true
> +
> +issues:
> +  comment: |
> +    Thank you for your interest in the QEMU project.
> +
> +    This repository is a read-only mirror of the project's master
> +    repostories hosted on https://git.qemu.org/git/qemu.git.
> +    The project does not process issues filed on GitHub.
> +
> +    The project issues are tracked on Launchpad:
> +    https://bugs.launchpad.net/qemu
> +
> +    QEMU welcomes bug report contributions. You can fill new ones on:
> +    https://bugs.launchpad.net/qemu/+filebug
> +
> +pulls:
> +  comment: |
> +    Thank you for your interest in the QEMU project.
> +
> +    This repository is a read-only mirror of the project's master
> +    repostories hosted on https://git.qemu.org/git/qemu.git.
> +    The project does not process merge requests filed on GitHub.
> +
> +    QEMU welcomes contributions of code (either fixing bugs or adding new
> +    functionality). However, we get a lot of patches, and so we have some
> +    guidelines about submitting patches described in our Wiki:
> +    https://wiki.qemu.org/Contribute/SubmitAPatch and
> +    https://wiki.qemu.org/Contribute/FAQ
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d156d73b3..0559e84790 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2833,6 +2833,7 @@ M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  M: Fam Zheng <fam@euphon.net>
>  R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>  S: Maintained
> +F: .github/lockdown.yml
>  F: .travis.yml
>  F: scripts/travis/
>  F: .shippable.yml


--=20
Alex Benn=C3=A9e

