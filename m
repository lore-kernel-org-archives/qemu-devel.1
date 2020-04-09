Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65544C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4BA20753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vE9Sxbr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4BA20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMduj-0006RS-BG
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 16:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMduB-00060t-6A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMduA-0002HP-9Y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:36:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMduA-0002H4-2p
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:36:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id y24so178201wma.4
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iWk0IeITipPS78hWLX9HqLWWI7HBK4p/HBLMnpzqK9c=;
 b=vE9Sxbr/kXWeks4wd2EZF7FWbQGnRo4GE7wqDd5WFcfhyfroERipeTkBWmaOEB/BoD
 I+1KKoMwwYN886+AZn9pHHTg72kRxG7rurRiJfIzu+JBV/dk1IFRxCebCY7ReCXvOroU
 0EarnVhkpybx+VEXIVUo/Gbc/TKezeWJH3bh5d93EN2rSTdy/yLghGbGnA4Fzym8ZCP9
 3zCc29gv8fCkUsUOzgtN3G0plHburijoGr3T1FV8P7XAiL8vB3xWzOFsF1ts2WA7EfBd
 i+iEBbAvLm21ZCuFSa5njnBDB9G9XKWY7nxNdUynANAflHo+TU+h8SLDz8Kh6xlUZNjE
 a56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iWk0IeITipPS78hWLX9HqLWWI7HBK4p/HBLMnpzqK9c=;
 b=Gg3aenqzaoE0X7sJli+NP1qUhZKkk4vAA0hcfZ7XH/CHBMGpSGSJltOm+cKJH4IiOR
 EiY/OLxtE/rjoYammVrU7Vq3LF7ATj2n4h4ZpkFtijngqhAt5RZlEUhJnezNJ98S9Zbj
 JAJnxBFD6Ifm3TLE1eI0QzU1CFbzz8Ko8pG1AsgUuLu+bzLVR5EuD41+wfQFpiOIviNa
 p33k7ecucZpbmc9fdXwDeenPQlwbZr2ducvmxpdh2CCHH1CajWBHOVgQUqd+J4B0UnqC
 tK8dn6rQuQgbRwAhERarACIZedgdU1bRoKDJGeu8YxEbjvmvsr0PMUCXWZLMOX6S4+r2
 oSMg==
X-Gm-Message-State: AGi0PuZVR5Eg+6qAwasYi+fKpNFKE7Ly8c3fYfEZWL8Iukrqo1rygFwj
 r2F+9FnIyv/6IUuU7vNx41FHOdKQef4=
X-Google-Smtp-Source: APiQypJ+C7j3tOXAJsM/B2cmk4OCZARV/Ly/Sa7VLsm6HyEWiMPPpQlzrCEpPAwEK52ZHdxtc1RVpg==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr1595871wml.120.1586464564522; 
 Thu, 09 Apr 2020 13:36:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j11sm41426526wrt.14.2020.04.09.13.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 13:36:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B2FF41FF7E;
 Thu,  9 Apr 2020 21:36:02 +0100 (BST)
References: <20200409164954.36902-1-peterx@redhat.com>
 <20200409164954.36902-3-peterx@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
In-reply-to: <20200409164954.36902-3-peterx@redhat.com>
Date: Thu, 09 Apr 2020 21:36:02 +0100
Message-ID: <87o8s09z2l.fsf@linaro.org>
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Xu <peterx@redhat.com> writes:

> We should only pass in gdb_get_reg16() with the GByteArray* object
> itself, no need to shift.  Without this patch, gdb remote attach will
> crash QEMU.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Queued to for-5.0/more-random-fixes, thanks.

> ---
>  target/i386/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index f3d23b614e..b98a99500a 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>      } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>          floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
>          int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
> +        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
>          return len;
>      } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>          n -=3D IDX_XMM_REGS;


--=20
Alex Benn=C3=A9e

