Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18701C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D255A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpnN9/+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D255A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfpR-0003xe-RB
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 07:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iWfoi-0003Oe-13
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iWfog-0001zb-P6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:07:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iWfog-0001z8-H1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:07:38 -0500
Received: by mail-wr1-x442.google.com with SMTP id b3so19148523wrs.13
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nA4alYErchJG6HWe6NFoRlMt3s2x5EPEsgLnUVTPlJI=;
 b=rpnN9/+CGkrJ+8wXYcsGFdmAHaLqshu8uEQTiA94GV/uYb56lvHCfhn7rQiGAfzHUz
 dAYjJzmdlQvGpspShkNCsxd13hM8ThoYsS9WdHztdRasWCUCK8uODxavSAsiNkzlz6yF
 It14snVUS0Br6syYE2qn9bPVvLhDNJ2RCVRHPOMaBOkVmEqQjhfYt5h09blxps1teF30
 pMovcUG47UyJNXZtIxbBba2bKkghihK1n/YsD+V/WM272f4Mj+LuGywQJdFX6EROS6oJ
 S0kS0r7FwBjNRo3o+yg1W0OE9rDCFm+ciF+tCB7BBx+eZdAq3y5TPju0YqlVHmwTZNEK
 raUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nA4alYErchJG6HWe6NFoRlMt3s2x5EPEsgLnUVTPlJI=;
 b=Lgho1UP4C3m5IrFwApbQNrEJ5Olva3sJ6ylHkuSEOw5Lk6wcttPh5mr6QdX8koQ1Cp
 vNh7At1qIRQtpg1V/hkFISvjO961CQRzMhilVYMhcBfgLeb3Cr6IoYMJDmzs3zDWGJ/Z
 jYC+scOd71fjSzAWhuo6k8FOjqUgVN2XeloSRqkI87O8h+xO66FXesDbmMhDtsL88w2z
 dsLl6hPsXorAjMKSlB+m57Vs5CMvYo0Do8kQKPuzfb/dg/gYr9K/k9nPxFRvyzppsLHZ
 NwEhc7i9J+IFjbINZXVyt4BFsKdZBbnywcPtai0Aico7qAJNrqb7b8KeX0eIWfMmc+9n
 qsdg==
X-Gm-Message-State: APjAAAVJGoLr3gMFJT0C3FW+Y5lsvx0aK0WbH5VS3AU+aVec/ZtsyhHm
 70EuAe4I2QQAzFgf0GqeavUGNw==
X-Google-Smtp-Source: APXvYqxJwpPpSOs/SXoP1pLSNZoIfJrbLYI8JYihvLI4pZwwT9bbLk4ODPUYRvQbnpr9MDlOKmhHaA==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr29273096wrv.66.1574078856895; 
 Mon, 18 Nov 2019 04:07:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p25sm19358943wma.20.2019.11.18.04.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 04:07:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E92791FF87;
 Mon, 18 Nov 2019 12:07:34 +0000 (GMT)
References: <20191115131040.2834-1-robert.foley@linaro.org>
 <20191115131040.2834-3-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 2/6] Cleaned up flow of code in qemu_set_log(), to
 simplify and clarify.
In-reply-to: <20191115131040.2834-3-robert.foley@linaro.org>
Date: Mon, 18 Nov 2019 12:07:34 +0000
Message-ID: <87ftilgzg9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.puhov@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Also added some explanation of the reasoning behind the branches.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2
>     - This is new in patch v2.
> ---
>  util/log.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/util/log.c b/util/log.c
> index 4316fe74ee..417d16ec66 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -54,12 +54,25 @@ static bool log_uses_own_buffers;
>  /* enable or disable low levels log */
>  void qemu_set_log(int log_flags)
>  {
> +    bool need_to_open_file =3D false;
>      qemu_loglevel =3D log_flags;
>  #ifdef CONFIG_TRACE_LOG
>      qemu_loglevel |=3D LOG_TRACE;
>  #endif
> -    if (!qemu_logfile &&
> -        (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
> +    /*
> +     * In all cases we only log if qemu_loglevel is set.
> +     * Also:
> +     *   If not daemonized we will always log either to stderr
> +     *     or to a file (if there is a logfilename).
> +     *   If we are daemonized,
> +     *     we will only log if there is a logfilename.
> +     */
> +    if (qemu_loglevel && (!is_daemonized() || logfilename)) {
> +        need_to_open_file =3D true;
> +    }
> +    if (qemu_logfile && !need_to_open_file) {
> +        qemu_log_close();
> +    } else if (!qemu_logfile && need_to_open_file) {
>          if (logfilename) {
>              qemu_logfile =3D fopen(logfilename, log_append ? "a" : "w");
>              if (!qemu_logfile) {
> @@ -93,10 +106,6 @@ void qemu_set_log(int log_flags)
>              log_append =3D 1;
>          }
>      }
> -    if (qemu_logfile &&
> -        (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) {
> -        qemu_log_close();
> -    }
>  }
>
>  void qemu_log_needs_buffers(void)


--
Alex Benn=C3=A9e

