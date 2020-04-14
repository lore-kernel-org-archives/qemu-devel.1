Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F61C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08382075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0pkfaWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08382075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOAW-0000ve-2K
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOO84-000720-7S
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOO7y-0001r6-9U
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:09:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOO7y-0001qo-3E
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:09:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id k1so7770249wrx.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AHp1ilYodpJpUcrqOpNk4NCw+6CgnSj6HOmwN/Z8TEE=;
 b=y0pkfaWJGPiWEV2c/LsuY3mrAu1inzNNAhuwcVyWaaM3cxfiSlOeIhawu4L9tKUVbq
 fmN+Y3sA+xrY53hu8bo2O5jPXAarKO5eUcCZ3GDcu8BC/cyFY/ikMw0RVe3nRDudJL3p
 rzh3Tod7jJSDqxPVQokwU+0uacQCrk3vWGDvK20nvUu02pHStuL4rIvj69C12K6qA2ZR
 Xzfvs8bpCY7nLv4U88MPqfQf6VU6iouT0uY8CEJKO2GtN/LIgSFGg3itXL5IK3kBAR7w
 SiD/+1bl0B3oy4a9qH738ot7ljT8ojro4v70CT0l5S61aHV+rjsxNha/exq65+65i00J
 d4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AHp1ilYodpJpUcrqOpNk4NCw+6CgnSj6HOmwN/Z8TEE=;
 b=Ggn/E5cxhefMO1MnI4gJKsXpWhAI4+oJx8le5AwqeJOiwNjNl2PVPlosidiVgujyDT
 btqb84IvaXsEl91PFpVXD7xsw6taqRFdVG8jPeyFESJBx2X3oIjgDBiSHJBz1oHD4kDb
 9kILbJlzA25ToDIA6ghjj35yi3P0Q83lOknuGvGjz/cmnfM01JpjAppGonaY48vMKvrK
 tjpFc5iameeGY5NSYiRZ94QBQIIqyYSaTM+Y3e2VnsRElVKs0bcdDepJKOq5KdzPaPiw
 RSmsJ7dOcNLwfygH9ZX5tI5OY2AuVZOjzBV7LAAt2u3uWyJ/3aoJEg8xHl4624LAWtji
 6g4g==
X-Gm-Message-State: AGi0PuYDFLCgLInAJj92fenMiHVP2jGa68F1WDy1BpKNuOPfC3JhxzI4
 xzggeOI+1MerAEUkiOEWy0bLzg==
X-Google-Smtp-Source: APiQypIRavqG4b2i3O2jQGb52RQgH2azDhKP9ufVmjeuJWnc/O48y70fu3Nnn/eoAGf+hDi7e2e7DQ==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr8631045wrm.143.1586880572804; 
 Tue, 14 Apr 2020 09:09:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k9sm20550119wrd.17.2020.04.14.09.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:09:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C5F21FF7E;
 Tue, 14 Apr 2020 17:09:30 +0100 (BST)
References: <20200414102427.7459-1-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] gdbstub: Do not use memset() on GByteArray
In-reply-to: <20200414102427.7459-1-philmd@redhat.com>
Date: Tue, 14 Apr 2020 17:09:30 +0100
Message-ID: <87y2qy82x1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Introduce gdb_get_zeroes() to fill a GByteArray with zeroes.
>
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to for-5.0/more-random-fixes with Peter's alternative.

> ---
>  include/exec/gdbstub.h  | 9 +++++++++
>  target/arm/gdbstub.c    | 3 +--
>  target/xtensa/gdbstub.c | 6 ++----
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 30b909ebd2..b52d9933ee 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -125,6 +125,15 @@ static inline int gdb_get_reg128(GByteArray *buf, ui=
nt64_t val_hi,
>      return 16;
>  }
>=20=20
> +static inline int gdb_get_zeroes(GByteArray *array, size_t len)
> +{
> +    for (size_t i =3D 0; i < len; i++) {
> +        gdb_get_reg8(array, '\0');
> +    }
> +
> +    return len;
> +}
> +
>  /**
>   * gdb_get_reg_ptr: get pointer to start of last element
>   * @len: length of element
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 8efc535f2a..063551df23 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -47,8 +47,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray =
*mem_buf, int n)
>          if (gdb_has_xml) {
>              return 0;
>          }
> -        memset(mem_buf, 0, 12);
> -        return 12;
> +        return gdb_get_zeroes(mem_buf, 12);
>      }
>      switch (n) {
>      case 24:
> diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
> index 0ee3feabe5..4d43f1340a 100644
> --- a/target/xtensa/gdbstub.c
> +++ b/target/xtensa/gdbstub.c
> @@ -105,8 +105,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *mem_buf, int n)
>          default:
>              qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported size=
 %d\n",
>                            __func__, n, reg->size);
> -            memset(mem_buf, 0, reg->size);
> -            return reg->size;
> +            return gdb_get_zeroes(mem_buf, reg->size);
>          }
>=20=20
>      case xtRegisterTypeWindow: /*a*/
> @@ -115,8 +114,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *mem_buf, int n)
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported type %d\=
n",
>                        __func__, n, reg->type);
> -        memset(mem_buf, 0, reg->size);
> -        return reg->size;
> +        return gdb_get_zeroes(mem_buf, reg->size);
>      }
>  }


--=20
Alex Benn=C3=A9e

