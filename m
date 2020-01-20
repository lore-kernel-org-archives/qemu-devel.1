Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D378C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D1420674
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ismMqQpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D1420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUym-0005mo-09
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itUp9-0008Us-Kf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itUp8-0007kg-8o
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:02:27 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itUp7-0007hA-Vw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:02:26 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so14211078wmi.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=giGqgVPaSqm1wmSnQabUdHw3pB84zxh//e/wHV/jIfc=;
 b=ismMqQpWTlQiztoIC7rqP0U8qKO7FXmVzvDLkgxFlSbvP+cYofWDoyRcUASXi1DEYv
 YGuvu0+kpGMFs/gEEgRcK8ETP5ko/VwjFf3jXjilUJBIEH2C0jYxM7qgfOki3HRzqnJP
 nQDfn0h9UC6BeNPtkvzsdk1LWV4CkEpzyfsRWjIrhOpmwnvf23cDcGkezJMbwydmjsOx
 KwjXZ+oeBK2lZYgE33UDuvW6nfP6T/a7jskVwX/fr3y9E6OioNUFYo03V3dw9pSzCey/
 X9LWtJckE/bSeIyy4MHyIUd7ThS3q8DEGCnsv+pQqeGo/vz05DrQiFcuqh1mz3tDqrMN
 2/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=giGqgVPaSqm1wmSnQabUdHw3pB84zxh//e/wHV/jIfc=;
 b=JnkFd66ILJnGHDbT0nUAX5usq130IU57hMX6vl82TTXcX97Lp0DxkgxwUP/BOO8BvA
 PbJKyHiYFt3gwn/3/+al56wbX09k/WR9bCB6NgNy01k6TwzDhtMBTy3rVR0ThhyN3m63
 GIPFdSG0PXpIBsuKGnoQ3bkElM8aCZZWyPS94LIiijcHyoqcXUreeqaWB7byfZRTHmCg
 znx2bzj9e4rQY8Ahf9jNdl/IHHSzb5Nhh+ykSIPSUmBb7W7LGWLdhtDfthYStWAFOJT/
 nZh6n9MNMeQTA+/Hi1YYxfZr11NnVb1kMN7UUclGMi5y8elPWsN2PXVJbDVxuH3OyQkL
 c84w==
X-Gm-Message-State: APjAAAWttV13VdMs5f+wPPQMfskRh8nKSvq+PB2LMGWpkbntnkhFDx55
 1AQ31d0mRHjjaRAPRN/0SUhVHQ==
X-Google-Smtp-Source: APXvYqwwo1blg0+GvT3OwSnZQ1H5xRUbFQoFL2SG5FQXSgr2fPsLq7its7Ssm92u0zS31LhIobTVxQ==
X-Received: by 2002:a05:600c:2406:: with SMTP id
 6mr18459212wmp.30.1579518144787; 
 Mon, 20 Jan 2020 03:02:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r6sm48423763wrq.92.2020.01.20.03.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 03:02:23 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 978D01FF87;
 Mon, 20 Jan 2020 11:02:22 +0000 (GMT)
References: <20200118140619.26333-1-philmd@redhat.com>
 <20200118140619.26333-2-philmd@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/6] configure: Do not build libfdt if not required
In-reply-to: <20200118140619.26333-2-philmd@redhat.com>
Date: Mon, 20 Jan 2020 11:02:22 +0000
Message-ID: <87iml64cht.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> We only require libfdt for system emulation, in a small set
> of architecture:
>
> 4077  # fdt support is mandatory for at least some target architectures,
> 4078  # so insist on it if we're building those system emulators.
> 4079  fdt_required=3Dno
> 4080  for target in $target_list; do
> 4081    case $target in
> 4082      aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|=
mips64el-softmmu|riscv*-softmmu)
> 4083        fdt_required=3Dyes
>
> Do not build libfdt if we did not manually specified --enable-fdt,
> or have one of the platforms that require it in our target list.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Improved description (thuth)
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configure b/configure
> index 557e4382ea..c67a7e73db 100755
> --- a/configure
> +++ b/configure
> @@ -4095,6 +4095,8 @@ if test "$fdt_required" =3D "yes"; then
>        "targets which need it (by specifying a cut down --target-list)."
>    fi
>    fdt=3Dyes
> +elif test "$fdt" !=3D "yes" ; then
> +  fdt=3Dno
>  fi
>=20=20
>  if test "$fdt" !=3D "no" ; then


--=20
Alex Benn=C3=A9e

