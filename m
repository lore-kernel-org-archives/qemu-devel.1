Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4AC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D08421670
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhwPvoI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkn05-0007Bv-TQ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hkmxq-0005jT-4t
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hkmxo-0002Dh-V2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:03:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hkmxo-0002BT-KZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:03:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so2401282wmj.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RWp8PyFUvwxe4IGkdf/lfIE/HIqcrD/3ALTosh4dDng=;
 b=bhwPvoI1jHtgCV+YAZV+5Q/OhGDa2L01n9z9kBCUNBA6Dr4kMoHctP3hZpVukfAJQ3
 0NbxOmbY0dSM5FhUAralPdc6fIsvX0DuHKPGfFMaGNws046v0qDaZtlubn6uIU1DFvsP
 Z6VHBTOm60AtP9pRnSp1Uvj0w7a/Ki2eaj9cyQtNHUqGtL4AHlHrtQPIOYp5+MwaVYmh
 PlRta3fuVcnKQZi7hTv8GBT1isbUtZR35rk+Uw74qNPszVYKcYTqmXQ/2DtKOp+9MKEr
 UfuAwgb213l8cFbNL55RoYEAPRgHIGZ/eBIkud4x88pIa4JzST5F6dlPEfS8WkLD56EV
 N1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RWp8PyFUvwxe4IGkdf/lfIE/HIqcrD/3ALTosh4dDng=;
 b=ApTH3OIDyMkRFzBVpQfS0lLGKGHpNXHYFJCckbb1MQU9a3Rh/raiix24v0X2jeT0jp
 gPNCWyZXwdcqNve7P4tvUXt3XwGCNNUQL4mv3FW/phLtzeNGGICa7Gzr6IgRLtfQWKKr
 m2u0KtUuuq2cr7P2PSuyfcyLeBIMRvsOnUl0kZljb2aYghYtCVj9AAvJxhPlZBjGelSN
 ME/MCSXDYPBNckidSKlYWekMZzaeK2y0DA3jSCq9BHoPyo5QzQlkmBoWexcwEXDggDo2
 GTaeR2YinlRnIE9FqMyzu7d4VoZgQcLp11icuxEtf5dWE7+FtXQWIG4GxSSwv12q5QVQ
 9bGw==
X-Gm-Message-State: APjAAAWtI8DsTem6eUrETTiSH0Wr3H7VOh51BVJgLVWeQS3LehFbxw6g
 20DFMNQG9Ux1tCCKl1yjGK0hOg==
X-Google-Smtp-Source: APXvYqxykAQ3Zb5v2M6FUWvzoT6WVKP5tjAgjFv0Q2+pLui4n5KhN/RJiXMyGn2lzZu7oEW1aBlFKg==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr22481436wma.90.1562666586096; 
 Tue, 09 Jul 2019 03:03:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o126sm2294300wmo.1.2019.07.09.03.03.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 03:03:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D534B1FF87;
 Tue,  9 Jul 2019 11:03:04 +0100 (BST)
References: <20190709092049.13771-1-richard.henderson@linaro.org>
 <20190709092049.13771-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <20190709092049.13771-2-richard.henderson@linaro.org>
Date: Tue, 09 Jul 2019 11:03:04 +0100
Message-ID: <871ryzfrtz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 1/5] include/qemu/atomic.h: Add
 signal_barrier
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We have some potential race conditions vs our user-exec signal
> handler that will be solved with this barrier.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/atomic.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index a6ac188188..f9cd24c899 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -88,6 +88,13 @@
>  #define smp_read_barrier_depends()   barrier()
>  #endif
>
> +/*
> + * A signal barrier forces all pending local memory ops to be observed b=
efore
> + * a SIGSEGV is delivered to the *same* thread.  In practice this is exa=
ctly
> + * the same as barrier(), but since we have the correct builtin, use it.
> + */
> +#define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
> +
>  /* Sanity check that the size of an atomic operation isn't "overly large=
".
>   * Despite the fact that e.g. i686 has 64-bit atomic operations, we do n=
ot
>   * want to use them because we ought not need them, and this lets us do a
> @@ -308,6 +315,10 @@
>  #define smp_read_barrier_depends()   barrier()
>  #endif
>
> +#ifndef signal_barrier
> +#define signal_barrier()    barrier()
> +#endif
> +
>  /* These will only be atomic if the processor does the fetch or store
>   * in a single issue memory operation
>   */


--
Alex Benn=C3=A9e

