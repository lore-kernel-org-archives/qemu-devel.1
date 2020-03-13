Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823F2C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAE42072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRJ03mwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAE42072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkyk-00073u-Hs
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jCkxw-0006Ap-Oq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jCkxv-0005qs-ME
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:07:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jCkxv-0005g8-FF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:07:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id v11so12261531wrm.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=U/uXuR/Wlab8SolAJBgyrDnRZuUe3vsTkI8L6hNG0q8=;
 b=uRJ03mwltFzJQ8sa6L+Sv5/EvgGgGeHd5PwjnKbTrNcr1ao0joLXMdke9bobPI+l1R
 Y6AmpHHmqkZiUDAbFD2DJj3tJ5JwYpTEeoPNfDlz88NQzJ38bD4L9TcMWEy6rLChahTG
 OH9HzP71oa1t9VX7oXmfBF/Pzy5ClpvgjjA6veZc7jT2xLG+aNnsbbrbsbn6h6Mo9nPm
 DLRo87dq3yp1glfeEk1AQ5pCYUH0bpTA5mDWehFzzpG7lPYiYVOsBwh1izuZrPDwHnRR
 lN6zHxjcQ0kDb5o9aRXr3krsTqA5hf1QU/kZD0CDOiNzudcJ8lmJ9WmDN2oWyAcjWU2f
 hKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=U/uXuR/Wlab8SolAJBgyrDnRZuUe3vsTkI8L6hNG0q8=;
 b=fExrIbeskfZHNwoF3Sleeas7fm8PbZy+rAJerwUwi/LMU6yCKYEHp7jwCws59+XPSf
 fmvY3Prt3VlHsJu7k+9EBKdDJue4MR4wx40XRtd+7xqySkLxMVEU9CxSliGPiDJyE999
 NhQ1iy60cDFvZkbLQJDaWsloaXhhVluHIqs7j4WaPWj7TRbWtZpEGU89TVeL4kHyVUgq
 H7PeWg3w55rLIU7QAo/5g6qnvVetn8cYTuGtNde6XtVWzn2g3y51CsPFP3zmrZf+4NjY
 KMr1Ic16M3Ea87Z+4MibnobMAFBhfjSFdcHmR+8aHzsNv/DIUjIa8uycrQZlJ2FWvyOh
 xV+Q==
X-Gm-Message-State: ANhLgQ1Atvd3WfKc0jL/ZLxYxg7ABHilozZwKj+MEO618xK0FqGn1sRs
 jNFQ0yafgZfg6+N5ghob6w5MDg==
X-Google-Smtp-Source: ADFU+vvm8laCAI9CsQvOKcYhlhJ3Wpa16tGUiu3e8G79FySCo+zixyWFdN+Ir7JtV7ru+vYC7k4SKA==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr19301617wrw.157.1584108424846; 
 Fri, 13 Mar 2020 07:07:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t193sm17852448wmt.14.2020.03.13.07.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 07:07:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABF051FF7E;
 Fri, 13 Mar 2020 14:07:01 +0000 (GMT)
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-2-crosa@redhat.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 1/5] tests/docker: add CentOS 8 Dockerfile
In-reply-to: <20200312193616.438922-2-crosa@redhat.com>
Date: Fri, 13 Mar 2020 14:07:01 +0000
Message-ID: <87fteccpru.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Wainer Moschetta <wmoschet@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> Which is currenly missing, and will be referenced later in the
> contributed CI playbooks.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/centos8.docker | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/centos8.docker
>
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/docke=
rfiles/centos8.docker
> new file mode 100644
> index 0000000000..bfa0d33c9c
> --- /dev/null
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -0,0 +1,32 @@
> +FROM centos:8.1.1911
> +
> +RUN dnf -y update
> +ENV PACKAGES \
> +    SDL-devel \
> +    bison \
> +    bzip2 \
> +    bzip2-devel \
> +    dbus-daemon \
> +    flex \
> +    gcc \
> +    gcc-c++ \
> +    gettext \
> +    git \
> +    glib2-devel \
> +    libaio-devel \
> +    libepoxy-devel \
> +    lzo-devel \
> +    make \
> +    mesa-libEGL-devel \
> +    nettle-devel \
> +    perl-Test-Harness \
> +    pixman-devel \
> +    python36 \
> +    rdma-core-devel \
> +    spice-glib-devel \
> +    spice-server \
> +    tar \
> +    zlib-devel
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt


--=20
Alex Benn=C3=A9e

