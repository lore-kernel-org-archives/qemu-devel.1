Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35188C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF16221479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrPtT5ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF16221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8co-00077e-Dp
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4jX-0003j4-En
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4jU-0006l9-U2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:25:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4jR-0006kB-PO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:25:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so1213326oth.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AtNCVajgsZwa/StomNud26kciS92ZyHegidqhZS10w8=;
 b=YrPtT5kim9QxRnpSBr5p0suPohzsL/fdc8PJVBhD+AVAHVR0LGUwDUxRenh2bawYwT
 x8CjDKqJuaSCSxQa0JjA2P3cC3HY2bP/tAxTkGxKArLfG5kJbJ+goNG+8r7zJ315C/pp
 U32CMnVUJH4EBeEDymgLPQ47mSBxKwqcBlviIJmHxLZf33WLT3Ej16aXAAN3h7EhVb9H
 gtlC46vdGBiJdfFEMZ++L52F5XlTWXoT8ecciC7VBQ41eAV/qJpRw/GMX59YbG8faxxb
 Pigbp1Ur8J/SK1/p7sgcRMfCqnKpiX/GLvHbLyoSitb+oESfAsK4D4XUF/2Z8uLaQy/a
 rQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AtNCVajgsZwa/StomNud26kciS92ZyHegidqhZS10w8=;
 b=mLO+WuvXVSPS45Gkj7BlXOQM4W8uPhmsZhFd7F+6soT6hsdSmhplLsgX2PN4wgsPZi
 7/GjG5jlrntii704XyYB/fsUnnFTe1ODCUVFS9JYHuxpKmQS1e1shiuufcNsTMVaqdkz
 hZ/1RNK5m2R+jcu79C8evyO2hIEypriBDaGPWtmDlJhVnodNo4mOBV2W5Y+2g/yZxpxV
 by3SHiZ1Oz/iLjwudSUnVqJ5ovt0Jp12d1hfF8Kyb1BYdW+GNL9ZEFpkzxjlFbQJFubN
 maIkI5QYh+bCNJaRCdM7UjCItb6O8VFN+Ag7YEyTn30DiW+kzbCK+VjRQapVuQ3aK/Vb
 azhA==
X-Gm-Message-State: APjAAAXYNrsUixHiofoXIlO1Pku7hL60IKk1K3GxtiZsSOZ+1EjjigqP
 qyAT8BvaCaybvLxw2h5ASC4nWFuP5N0Of3l26rjqbHVVpyA=
X-Google-Smtp-Source: APXvYqwP7qXeR69xJD5LJF0Zqwnyf0wNAUkpD8db9S2Lsh3kl1f+fdfxgG7DR7mWo57rkrCfCn0qMXZlbArUg8F3lIw=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr21358824otk.232.1562000237264; 
 Mon, 01 Jul 2019 09:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190701164732.30518-1-alex.bennee@linaro.org>
In-Reply-To: <20190701164732.30518-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 17:57:06 +0100
Message-ID: <CAFEAcA9fRnH74+jOqxMPyZo-7pS45hHjnA5NdnpdSpNs30G--g@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH] migration: move port_attr inside
 CONFIG_LINUX
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 17:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Otherwise the FreeBSD compiler complains about an unused variable.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  migration/rdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 74cb2aa9f9..3036221ee8 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -839,10 +839,9 @@ static void qemu_rdma_dump_gid(const char *who, stru=
ct rdma_cm_id *id)
>   */
>  static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error=
 **errp)
>  {
> -    struct ibv_port_attr port_attr;
> -
>      /* This bug only exists in linux, to our knowledge. */
>  #ifdef CONFIG_LINUX
> +    struct ibv_port_attr port_attr;
>
>      /*
>       * Verbs are only NULL if management has bound to '[::]'.
> --
> 2.20.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

