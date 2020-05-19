Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C132075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbuRjPtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C132075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb715-0004Et-Cq
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb6up-00035b-5x
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:24:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb6uk-0000MR-47
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:24:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id z4so241734wmi.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eNlKWpRqRb5z2hrqCd8+bNrjugM3z5Req+rwJsCMrfk=;
 b=JbuRjPtUdaj4hEJjvjTQhCpWKXsFJq/+zvtRK0yWVy5qT6E0zFBkzw2GrqK/2gneYi
 3Dx0EUePmmuLpK4cuXbGjcWjERuSTrgzpRN9OZGff5fyuXxE9tcHcsseZzDSTt4kXCjC
 sZkv0bm5BfcnVQw4ZnBuNrH4B/POjkWnOfhRfPA4QRVME3EMCLPsz5qExh8C6r1UtnWn
 JyQ/+ATUA0Y5fV6jwQGAaiNwgEaq6AHTBsoZRjYuS+L7w9vJekqeMBDvq0j730sg3aMv
 wYRh9aDNlAgh3ES74CkA41H3QZEmMgTUUQnA3KVMr8CmOi8ArgqvpM9g1ySFgibuhgds
 HkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eNlKWpRqRb5z2hrqCd8+bNrjugM3z5Req+rwJsCMrfk=;
 b=RbaF3/8qtw7zLNE/PzXbsjxeJY0/sUSroLpXA4wRdburPA5k3e0ISvZDnJ42alm0WO
 mqgaPsvO4R8n93zKjKnZyKHkud4ih+gOyWzdG1o2a8AB9SjiWHPuo+NxBbNONwG3sbpA
 Gwv56b85so/oDOIuAiGU8jV06GVrPuYXa+U91M2fmYPa1KgLNtyXGA9EszUK4oNqU2sR
 Xz4BnbCXRzljXd0ysvpECnvb1Twn+PYlQQK1mMwPb91dVcI8zY9TuFAes90PD17OL/G/
 /iUMQb/hyM6YLGbt8Gq0C/9mXHtOdVq7kOyzVmb2BpN1nG6GBNlps+exOKBEHtYGDjC4
 weRw==
X-Gm-Message-State: AOAM530LItu4ptzZOzDOnIWYRdrs23JRfDDjS1saFIiwdR4b+2aXJ3CC
 /wkhalpbHqUiFcg70ja1c5911g==
X-Google-Smtp-Source: ABdhPJxLQ+dALkN58Bh1n6CrcLdVdlpW6L3LmoUZeYdN9OS1L8LPdUJ6cZhq+RTGRXFcYf7vnRti7w==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr766398wmb.50.1589912668039; 
 Tue, 19 May 2020 11:24:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e5sm270333wro.3.2020.05.19.11.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:24:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C6031FF7E;
 Tue, 19 May 2020 19:24:26 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-5-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 04/17] Adjust tracefile open for write
In-reply-to: <20200519025355.4420-5-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 19:24:26 +0100
Message-ID: <87367viy05.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

> Truncate the new output file.  Rely on umask to remove
> group+other file permissions, if desired.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/risu.c b/risu.c
> index 1c66885..f404d8f 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -368,7 +368,7 @@ int main(int argc, char **argv)
>              comm_fd =3D ismaster ? STDOUT_FILENO : STDIN_FILENO;
>          } else {
>              if (ismaster) {
> -                comm_fd =3D open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
> +                comm_fd =3D open(trace_fn, O_WRONLY | O_CREAT | O_TRUNC,=
 0666);
>              } else {
>                  comm_fd =3D open(trace_fn, O_RDONLY);
>              }


--=20
Alex Benn=C3=A9e

