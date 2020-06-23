Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E729C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E4B2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDvRn03a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E4B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkfI-00084G-9G
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnkHz-0005fe-Sx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:52:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnkHy-00014w-0d
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:52:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id h15so889935wrq.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=n3MRUD+QRMjfDSjSikC2bHhO8rpeXdlIDDxtDUZz3Iw=;
 b=KDvRn03at0cn4SR3hDvUoJYQYEkz6Kc1wX3BosewmCrLHZnok9ujLCdqYadKflUFKD
 ofAxHsCuRRElXsKnw7sKWi33BN6TTf7KrvDcl/PCFkN8DU2RBwAqHW8M9tB/tXMyduIg
 mF+m/1wjCh6d4GrdsqzKlEmKYCjdifb+XwLGPYPfYmW8D3dUzjQgRxEff3+ZkXwu95PI
 God4XhTQfgJ6meNH3yLxeIsD7ffz3lPdQ8meABgnKAvZfgy5iZQna4GB8Ux12bxoIuoX
 YpXfQR3JZ2FySh1qfHW1stWHaaw2ozDL41FgsJfeHnh3PrrG0g3K4IGKN6KLI6lbVRtQ
 JTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=n3MRUD+QRMjfDSjSikC2bHhO8rpeXdlIDDxtDUZz3Iw=;
 b=Iw6bJifRMV12QcwTiiu4CaqxqZEf75IaY21etnvRqzrcpYUSfJIG+A7VoJi9FxXqC2
 +D05mwOiQykujvKlibxqUyZNZuxFm7QMTgLNkISDrZAIUCEXCAB5RnRbuJvyqp3AxI2s
 lwWfkmqKFAiZy73VSmWmTxuEyhOQIW2dbVaTXT8tT3I44Kho/cbcHR4AsbbCoK037Fga
 LfEZtUiT7loNkKKMprxBC37e7/wGBqehZQ3ov72kzcExNcZK3ZcGBZuItJuR4ZFx0tEp
 phi+3PowW1UgU0gwQLTj7i/RSrPVdW8KUo1B7H7pPEYK5q2IKsABTB4QIOSCUWsR7yug
 ogJA==
X-Gm-Message-State: AOAM533xUkuFE6c+bKznBadBr2NSdnmZz5WZu28kn0W+VZBbIYcgol33
 /fAfb9Mw4ZT2n/oJHpYU0jwgVw==
X-Google-Smtp-Source: ABdhPJxux8B3O8ZTp8BNGG90uhTWYb7FX6k8f59lK+qT7m/MdHZuzOfmVp1Upq+/7T2w3ajZNIQhDw==
X-Received: by 2002:a05:6000:1283:: with SMTP id
 f3mr7856198wrx.106.1592923960329; 
 Tue, 23 Jun 2020 07:52:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm3922833wma.48.2020.06.23.07.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:52:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D3771FF7E;
 Tue, 23 Jun 2020 15:52:38 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-18-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 17/25] Add magic and size to the trace header
In-reply-to: <20200522023440.26261-18-richard.henderson@linaro.org>
Date: Tue, 23 Jun 2020 15:52:38 +0100
Message-ID: <87k0zx96mh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Sanity check that we're not getting out of sync with
> the trace stream.  This will be especially bad with
> the change in size of the sve save data.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risu.h |  10 +++-
>  risu.c | 162 ++++++++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 136 insertions(+), 36 deletions(-)
>
> diff --git a/risu.h b/risu.h
> index dd9fda5..bfcf0af 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -55,7 +55,11 @@ typedef enum {
>      RES_END,
>      RES_MISMATCH_REG,
>      RES_MISMATCH_MEM,
> +    RES_MISMATCH_OP,
>      RES_BAD_IO,
> +    RES_BAD_MAGIC,
> +    RES_BAD_SIZE,
> +    RES_BAD_OP,
>  } RisuResult;
>=20=20
>  /* The memory block should be this long */
> @@ -69,10 +73,14 @@ typedef enum {
>  struct reginfo;
>=20=20
>  typedef struct {
> -   uintptr_t pc;
> +   uint32_t magic;
> +   uint32_t size;
>     uint32_t risu_op;
> +   uintptr_t pc;
>  } trace_header_t;
>=20=20
> +#define RISU_MAGIC  (('R' << 24) | ('I' << 16) | ('S' << 8) | 'U')
> +

I guess a fixed constant magic value should compress well.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

