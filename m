Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24AC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552C520757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO6AdlVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552C520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcMP-0007GO-Is
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMcLT-0006L3-NY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMcLS-0007RM-Ni
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:56:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59663
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMcLS-0007Qz-Iy
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586458569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AImWi1qfVjLZ9cIosDLagwg4wgU2GY4KBvwJrLZ7Trs=;
 b=SO6AdlVnMPARsh9wNY7uQ9UY0tPUPMzvAfdJ6Po8jY0X2JSKC6zuwpKl7/yIQNrjRKD6Md
 w5x9fKR5Jj6E8trM11Zw1Qr62gkKawQ4RBogb1vB/mIJUCM5PLQqSZd9+VATevFOF/d036
 qP6FYKiYyB6PCQn4n/P/FxNYdajcM2M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-2i-Xf-k3N6avW53mclXrFQ-1; Thu, 09 Apr 2020 14:56:06 -0400
X-MC-Unique: 2i-Xf-k3N6avW53mclXrFQ-1
Received: by mail-wm1-f72.google.com with SMTP id y1so531142wmj.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 11:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hYMwAUN9005u1k4S4HE8N4Pxn5WyuHriISCiAyqv1h8=;
 b=mlA/j4icTyROkUtkyzszUpqpgg92giZ73xUoAq6NO4hfxiCaGTzfE9YppEqz9LJmRy
 MQI6y5lQbCH3yokJqWib+5okAhePKe3RYp+39reKh8illXIzRYQTzTVE5KurbWxiPVTB
 B9tYjpdoAevKPecSQqzxToJoBjelkx/DzlQd2ZiZ+O11o2s1cdRnVAr65BdQi/fH8uyc
 HkQusrgZUsKwX9Eh7MBv1jHy9uwrCDVaF1If+aXB7kiN0SziGyaKyUuXCYyVADk+KfOQ
 QKFHQHN1LNYoYlg13sk4CHP9CMafXepwierqOf6Rsit+mXRg7bw/N73OrbHTyQWNDChO
 ZJsg==
X-Gm-Message-State: AGi0PuY46lKsdZscDKqy/iSmBozhA2+3owIye160u/ZD61+Q1Bmrgw9E
 a4Hdgb8lHphHzE1aOMBsxNab2921uxgiqCXHJKwoD/+sRT7jjFN1uah4j1uBdPCWLNwq+vpcawk
 g+SEwhM6LbwvGdBI=
X-Received: by 2002:a5d:5230:: with SMTP id i16mr573936wra.15.1586458564727;
 Thu, 09 Apr 2020 11:56:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypJwdwjjBZ68XxAzBiip2rd4Cb+fDC16Z6NI6rFIBa2DfO+v0ym91Tys/Agjv5B/75FL9+Ujgg==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr573916wra.15.1586458564496;
 Thu, 09 Apr 2020 11:56:04 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id t2sm22721839wrs.7.2020.04.09.11.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 11:56:04 -0700 (PDT)
Date: Thu, 9 Apr 2020 14:56:01 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
Message-ID: <20200409185601.GC40299@xz-x1>
References: <20200409182538.40816-1-peterx@redhat.com>
 <20200409182538.40816-3-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200409182538.40816-3-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 02:25:38PM -0400, Peter Xu wrote:
> We should only pass in gdb_get_reg16() with the GByteArray* object
> itself, no need to shift.  Without this patch, gdb remote attach will
> crash QEMU.
>=20
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Fixes: b7b8756a9c ("target/i386: use gdb_get_reg helpers", 2020-03-17)

So I think this should still be:

Fixes: a010bdbe71 ("gdbstub: extend GByteArray to read register helpers")

As Phil & Laurent pointed out.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  target/i386/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
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
> --=20
> 2.24.1
>=20

--=20
Peter Xu


