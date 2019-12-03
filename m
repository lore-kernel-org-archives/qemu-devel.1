Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F52C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBB420803
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8vNMPhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBB420803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icCB7-0001wD-Ev
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 12:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icBVv-0005rZ-8P
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icBVj-0000gU-9x
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:58:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icBUg-0005IG-0f
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:58:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so4361922wma.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Kpsn4xS9G03kN0ktTPQW/4w1Qmudh/u4s0MQhKO1J4I=;
 b=N8vNMPhNOQh4PESRxiKr6XVbiCHP/KhK8t6+cknqfnDoiqtNHsvkgdSa79PG2D3jcY
 2e5YW72HPP4GH12D4MpaNSRBPW8gHdAGu+KIw+VpduAZZG9hzr0BF2SEn4Vy4Lu0NeW5
 DGOu1fGxckd1iT+3b7aVEJ+rqC2oUwcd/oDpRsKtmic1HVutXr4b+SkCGck8WMQIJMFR
 /9UvKMIdTEiw28ZH2CCb57TEroVciHJx0De7SJiJoDLCexFDZA30koUYgSpVIw0zp36b
 2ZNUPCCsQMdw4+70FQsatG52FQxXjLci00XT/jjJNvZwGuu371CMoesK7YktVgMvYBEs
 nj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Kpsn4xS9G03kN0ktTPQW/4w1Qmudh/u4s0MQhKO1J4I=;
 b=mwnpJ2GnD9aazA8WmNK7Z5+AJddsF7HSUwxJzJ1PYtNTm9n6phMliclAPD1nGW5H7U
 tirCmV26pYUuHpvyRZza5+t/wiAtDK9/UvyuZwWsaiiUtRdvckBaXFVq+MXshZyWQO+/
 rNipvuwelBb2RLRoFBG+s3UwLoH78xwooON8hvknKKzwdeBnU8NrqabMysPvNCjkZUet
 qPSF1VYeVWAioNF92MGn60nL7SqOPyVu5u3KI6OJ4pGTg4Pps/UtHTeN9gAEbYOjj+DG
 nrDSufjmwMImhUkHZzH9VpbwwZY65OBZT+8GNPgu8iJrqK08ZhEOX9f+SkVdf3aLwSXY
 L2Lw==
X-Gm-Message-State: APjAAAWSk380ppJHmNOMC8MwmKXERNYWhlEvpJJwAPJmZ486Wc41Tjex
 B6jGFouxAbuBB9jyuFo85bj4Zg==
X-Google-Smtp-Source: APXvYqxLOZx/MpVV09/q85koxeoGiHtjsGeICVPRcn7dAXN2nrOHOyNRTlJcIQowyWtkbp8PpLZxdw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr34854011wmc.21.1575392257067; 
 Tue, 03 Dec 2019 08:57:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z64sm3927933wmg.30.2019.12.03.08.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 08:57:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66F871FF87;
 Tue,  3 Dec 2019 16:57:34 +0000 (GMT)
References: <20191115180829.10275-1-wainersm@redhat.com>
 <20191115180829.10275-3-wainersm@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 2/4] python/qemu: accel: Add list_accel() method
In-reply-to: <20191115180829.10275-3-wainersm@redhat.com>
Date: Tue, 03 Dec 2019 16:57:34 +0000
Message-ID: <87tv6h9wjl.fsf@linaro.org>
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> Since commit cbe6d6365a48 the command `qemu -accel help` returns
> the list of accelerators enabled in the QEMU binary. This adds
> the list_accel() method which return that same list.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  python/qemu/accel.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index 1b825126c5..a63ff980a9 100644
> --- a/python/qemu/accel.py
> +++ b/python/qemu/accel.py
> @@ -18,6 +18,7 @@ accelerators.
>=20=20
>  import logging
>  import os
> +import subprocess
>=20=20
>  LOG =3D logging.getLogger(__name__)
>=20=20
> @@ -28,6 +29,25 @@ ADDITIONAL_ARCHES =3D {
>      "aarch64" : "armhf"
>  }
>=20=20
> +def list_accel(qemu_bin):
> +    """
> +    List accelerators enabled in the QEMU binary.
> +
> +    @param qemu_bin (str): path to the QEMU binary.
> +    @raise Exception: if failed to run `qemu -accel help`
> +    @return a list of accelerator names.
> +    """
> +    if not qemu_bin:
> +        return []
> +    try:
> +        out =3D subprocess.check_output("%s -accel help" % qemu_bin, she=
ll=3DTrue)
> +    except:
> +        LOG.debug("Failed to get the list of accelerators in %s" %
> qemu_bin)

Ahh here it is. So I guess either mention the fact we will be using it
in the previous commit or bring it in here when we do use it.

I see we use LOG.debug for a bunch of failure reasons but surely
LOG.error is the more correct level for something that failed? I guess
it doesn't matter as we don't mess with the levels.

> +        raise
> +    lines =3D out.decode().splitlines()
> +    # Skip the first line which is the header.
> +    return [l.strip() for l in lines[1:] if l]
> +
>  def kvm_available(target_arch=3DNone):
>      host_arch =3D os.uname()[4]
>      if target_arch and target_arch !=3D host_arch:

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e

