Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D63C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9DD2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdwW42Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9DD2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5VH-0003SA-7E
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb5RW-0004oU-FT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:14 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb5RV-0006GD-F2
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:14 -0400
Received: by mail-ej1-x643.google.com with SMTP id x20so12586757ejb.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=55bQkbFFJCvAackSLpnujnB8eaStUkWuBK+vBDQ1s1o=;
 b=kdwW42RelgwJSpwiWN+nweI06p+Cq7hjDyfr261nfvIIqDMuyRxhWgTgKAkMI6Fh9Q
 /uj7eUa+N+fPWnbE5pO+PiJHaIm2Yq5D0WfWtNQzgBK/HC9odgnjlLnlN7AxCCouGK2f
 qbo6gf2inI6d+eXsRT5tRmSFA29ahkrMyopVrGpDNdk14ml2xrtieUCLYWRH6MRhG9B7
 UPeV77z8nlRlg/9t1w7kASp3IHIDgiFhkmTGOOpDtbgamNjuV79BapaXIBFFRZYmx8By
 K8XcK524V4fkm/aEsBhN7cr/GC2QuGWXSfN4CUh5A02BVvRXU2cO7T0FJ/003vjhCpxJ
 XUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=55bQkbFFJCvAackSLpnujnB8eaStUkWuBK+vBDQ1s1o=;
 b=Smu0lr0F1ncQZNQ6d7NylSoUcMxtPZRuQ5M55WJFvSGPwz8wL0Ac/zl+7+ONwVREYh
 sHXoAv5d+wqwoO0/m+tXYloRdS6CjqvCRTFG9lPCmcpeRxHcZ6ptlHmLcQwE6WpeHvY7
 wKEWUm2Z3MwMmNgnZpdqT94t9o897jUrqeP3xL+KNmfzOnxxnZENm1kOw9VQon6x50Og
 UfGr+QB508LNsEtEoV+dIrxAYp/jof7G61XGBFDwHJkleEi0lOEFNjSxIc1vQ5LlBT/R
 0IRhZAAqtEwA8CSoPhZMYuQVw1ylQCFgn4OI2yYiCHnZhHo2TSc+ERZPRWt2wiuRcW4o
 HL4g==
X-Gm-Message-State: AOAM530UnAzJK7nJF3AOi5SLjCODFnPyulUN2DgazBPeTJnxoe1fbte5
 boybL/MTwLEt9WKDqcnDlEwXBw==
X-Google-Smtp-Source: ABdhPJzCtl54iGZvaZrPZflxp6LJzvVET2LwXTcc/01J9ITRNqcvYHFM9D9heZpoczyqbwXrj2E7cQ==
X-Received: by 2002:a17:906:4dd6:: with SMTP id
 f22mr142599ejw.468.1589907011549; 
 Tue, 19 May 2020 09:50:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id bz8sm47439ejc.94.2020.05.19.09.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:50:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7BCAB1FF7E;
 Tue, 19 May 2020 17:50:08 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-4-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 03/17] Hoist trace file opening
In-reply-to: <20200519025355.4420-4-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 17:50:08 +0100
Message-ID: <875zcrj2db.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We will want to share this code with --dump.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/risu.c b/risu.c
> index 059348f..1c66885 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -363,6 +363,21 @@ int main(int argc, char **argv)
>          }
>      }
>=20=20
> +    if (trace) {
> +        if (strcmp(trace_fn, "-") =3D=3D 0) {
> +            comm_fd =3D ismaster ? STDOUT_FILENO : STDIN_FILENO;
> +        } else {
> +            if (ismaster) {
> +                comm_fd =3D open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
> +            } else {
> +                comm_fd =3D open(trace_fn, O_RDONLY);
> +            }
> +#ifdef HAVE_ZLIB
> +            gz_trace_file =3D gzdopen(comm_fd, ismaster ? "wb9" : "rb");
> +#endif
> +        }
> +    }
> +
>      imgfile =3D argv[optind];
>      if (!imgfile) {
>          fprintf(stderr, "Error: must specify image file name\n\n");
> @@ -373,31 +388,13 @@ int main(int argc, char **argv)
>      load_image(imgfile);
>=20=20
>      if (ismaster) {
> -        if (trace) {
> -            if (strcmp(trace_fn, "-") =3D=3D 0) {
> -                comm_fd =3D STDOUT_FILENO;
> -            } else {
> -                comm_fd =3D open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
> -#ifdef HAVE_ZLIB
> -                gz_trace_file =3D gzdopen(comm_fd, "wb9");
> -#endif
> -            }
> -        } else {
> +        if (!trace) {
>              fprintf(stderr, "master port %d\n", port);
>              comm_fd =3D master_connect(port);
>          }
>          return master();
>      } else {
> -        if (trace) {
> -            if (strcmp(trace_fn, "-") =3D=3D 0) {
> -                comm_fd =3D STDIN_FILENO;
> -            } else {
> -                comm_fd =3D open(trace_fn, O_RDONLY);
> -#ifdef HAVE_ZLIB
> -                gz_trace_file =3D gzdopen(comm_fd, "rb");
> -#endif
> -            }
> -        } else {
> +        if (!trace) {
>              fprintf(stderr, "apprentice host %s port %d\n", hostname, po=
rt);
>              comm_fd =3D apprentice_connect(hostname, port);
>          }


--=20
Alex Benn=C3=A9e

