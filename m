Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4061BC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033CA20753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9fgrNLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033CA20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbpk-0000zN-70
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMbon-0000Oy-3c
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMbol-0005bf-Sg
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:22:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMbol-0005bP-Oi
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586456543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzH+DbrLu5rc3bnn0Ln1sqPH+FauTt1jtZnTakHLx70=;
 b=U9fgrNLfcVAc2dn+HDS/Fd3xmXx7QJwXt1Nt5nZZTKgUMzo5cZ6eppfbshtYK1iURmkHkD
 LzUbErPpDtge6F0PujTNTf9cL4r2lZQC6C32BpznrPkn7U4xVbvbPTnOPpGqAhE3AuYRS/
 vDEtmUCFPKtwLQjnMbnDvTgYYmdEoJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-aRga1Cn4MzmViuSsk1U62g-1; Thu, 09 Apr 2020 14:22:21 -0400
X-MC-Unique: aRga1Cn4MzmViuSsk1U62g-1
Received: by mail-wr1-f71.google.com with SMTP id u16so7032407wrp.14
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 11:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9bESeGzaWTE2k0j6OtRnLCSqTAqmeIFREZ+eHInQRBo=;
 b=qVx6wLWG3lUbhyE0jm4u7f8Dm9AAFBFceO8YshlZswURbbUlNceMXbihkQGvUV4R0f
 W5Gc8WkM1Ea3WXWtPmJ5TtxLogUNOFEzbJmmsKEn5qijVIq5EAZ4SccsZ5CMw1/xSzw7
 ACovbu3f6TCa+XQjewqOCUVJGZWb4DF+zCRI/GvuuepzMQje1Xr8LM8wN0Jc6hqSlHYb
 iTYqdm3cUYO2k46AvSE/FHhTlCnm0GoPmwNwgPbHt9sTBx5eGISusam+VVRske+RBGQe
 vdV0PNFO09O11a8CI5Zxu328zj1LllCiafXQKzU1z4H+YHSnkgERkyH2jIFeOUdJRlae
 cGpA==
X-Gm-Message-State: AGi0PuZkcYt5hskz8RvFCdrZyL8/kbRl8KDEEW6b2KpO/ljyZo6dsqOK
 OIaxwcu9AJrk4khpckoOGxgo/66/ly/hNNYBz52EmidnwS2/88bQyDom9uAjorQGsdm5FvTRf/q
 ZeGQ5o4U0yNJEjec=
X-Received: by 2002:adf:ed8b:: with SMTP id c11mr479683wro.14.1586456540163;
 Thu, 09 Apr 2020 11:22:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKwyo6Q9kwMq2FBfI7LWy6g6lJWletlSfxfiRe38RRmdkw6SiHQfdoRuBCBcIeNjTazG+EGtQ==
X-Received: by 2002:adf:ed8b:: with SMTP id c11mr479660wro.14.1586456539981;
 Thu, 09 Apr 2020 11:22:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id e15sm6202541wrt.16.2020.04.09.11.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 11:22:19 -0700 (PDT)
Date: Thu, 9 Apr 2020 14:22:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] target/m68k/helper: Fix m68k_fpu_gdb_get_reg()
 use of GByteArray
Message-ID: <20200409182215.GA40299@xz-x1>
References: <20200409172509.4078-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200409172509.4078-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 07:25:08PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Since a010bdbe719 the gdbstub API takes a GByteArray*.
> Unfortunately we forgot to update the gdb_get_reg*()
> calls.  Do it now.
>=20
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")

Should this be instead 462474d760 ("target/m68k: use gdb_get_reg
helpers", 2020-03-17)?

> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
> Based-on: <20200409164954.36902-1-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

(One benigh extra line; same thing could happen to me when amending
 like this with "---")

> ---
>  target/m68k/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 014657c637..cad4083895 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GB=
yteArray *mem_buf, int n)
>  {
>      if (n < 8) {
>          int len =3D gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
> -        len +=3D gdb_get_reg16(mem_buf + len, 0);
> -        len +=3D gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
> +        len +=3D gdb_get_reg16(mem_buf, 0);
> +        len +=3D gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
>          return len;
>      }
>      switch (n) {
> --=20
> 2.21.1
>=20

--=20
Peter Xu


