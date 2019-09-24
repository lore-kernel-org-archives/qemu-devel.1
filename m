Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C0C4320D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE765217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auHJ8O5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE765217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCo4H-0005Rf-6i
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCn5k-0003Gi-UP
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCn5j-0005L8-Pa
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:51:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCn5j-0005Kg-Iw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:51:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id v17so608085wml.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r4SgzmwKdxJQB93mBgpVTzOKIPOHeR4CeMYrV4uJR0Q=;
 b=auHJ8O5eyKjvfnsYc82om9b5DrpvuTeHwOtNJ4whlYFkLZKb1azhkrK4r0ZD+6D/a5
 gdSFqxBbRh5XRvlbyMEAtc5wfQR9yr2MY6NJG8G1pzXy0wDWmkjO9VYtdHCFQRQLXz9E
 WIpSU/IGia36+O7cUbBdaXwtKkGfVCf4Rh0JBLOVG41hk9aTZYM/p4K1YjPdoAXDXVOF
 T1j+yS/I4XLExQYeWp7MwGI11ybRZYg5bLqcFnCwCTUCbkbQVpaEiois2gfLPqNhEpkI
 oIphoPEFBZoX3U3hMBNt8AUNkckmMvm6bbSPdCjh/jfzlvErwYqUuNP+KDoLyMh8/97o
 eoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r4SgzmwKdxJQB93mBgpVTzOKIPOHeR4CeMYrV4uJR0Q=;
 b=aIvOxr+xPB9riXbt7nhDzvQpetlT5oOj17huQGZC/zYLbqIGAvWsr562Zl3aRLV1ra
 Rfx8N2AJk64iZXvhyg5PPblqYncu0KJbUlnOotLNT+vdvLwuug3Ug5ZML4CPj7s+Okq8
 UCDByWVPiz7VuSULssJ55kqQaMhCJvNzFcfPcyiXwZGje6QI+XzrPBftMwFkUwy9DSrC
 90QUWcwfFVDo+A5bZgupvbtzm3RI/sGll3n5Vvolh2JKgqqnNO2iDUWdqMXydS9KqHfE
 6RCayG4JoZmGQcWOfs/6e2TVmgbf1jgPN0cZs3TiFjPV0WRZOr5z58RaN5o+spAQKW0p
 ks+A==
X-Gm-Message-State: APjAAAVW+VXOLXetT3ZfFyZ4gK22lm/zBcsjjdA5UVO1TMDIl09pjCgA
 R6sWrMpzUpoSX7oX2Nv/U/3Dow==
X-Google-Smtp-Source: APXvYqz1OKYwBYcNukMm+r++0i5TeQaeyCP2llM2+/whE/lQTp7h50YIZGOt6RwTlV33gKFBU3jPAw==
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr821057wma.102.1569340262134; 
 Tue, 24 Sep 2019 08:51:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g11sm181183wmh.45.2019.09.24.08.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:51:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0FFE1FF87;
 Tue, 24 Sep 2019 16:51:00 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 05/16] cputlb: Split out load/store_memop
In-reply-to: <20190923230004.9231-6-richard.henderson@linaro.org>
Date: Tue, 24 Sep 2019 16:51:00 +0100
Message-ID: <871rw5bsm3.fsf@linaro.org>
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We will shortly be using these more than once.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
<snip>
>  }
>
>  /*
> @@ -1415,7 +1412,8 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,
>  static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
>                                TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, MO_UB, false, full_ldub_m=
mu);
> +    return load_helper(env, addr, oi, retaddr, MO_UB, false,
> +                       full_ldub_mmu);

This is an unrelated change, otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>  }
>
>  tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong add=
r,
> @@ -1530,6 +1528,36 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *=
env, target_ulong addr,
>   * Store Helpers
>   */
>
> +static inline void QEMU_ALWAYS_INLINE
> +store_memop(void *haddr, uint64_t val, MemOp op)
> +{
> +    switch (op) {
> +    case MO_UB:
> +        stb_p(haddr, val);
> +        break;
> +    case MO_BEUW:
> +        stw_be_p(haddr, val);
> +        break;
> +    case MO_LEUW:
> +        stw_le_p(haddr, val);
> +        break;
> +    case MO_BEUL:
> +        stl_be_p(haddr, val);
> +        break;
> +    case MO_LEUL:
> +        stl_le_p(haddr, val);
> +        break;
> +    case MO_BEQ:
> +        stq_be_p(haddr, val);
> +        break;
> +    case MO_LEQ:
> +        stq_le_p(haddr, val);
> +        break;
> +    default:
> +        optimize_away();
> +    }
> +}
> +
>  static inline void QEMU_ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>               TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
> @@ -1657,31 +1685,7 @@ store_helper(CPUArchState *env, target_ulong addr,=
 uint64_t val,
>
>   do_aligned_access:
>      haddr =3D (void *)((uintptr_t)addr + entry->addend);
> -    switch (op) {
> -    case MO_UB:
> -        stb_p(haddr, val);
> -        break;
> -    case MO_BEUW:
> -        stw_be_p(haddr, val);
> -        break;
> -    case MO_LEUW:
> -        stw_le_p(haddr, val);
> -        break;
> -    case MO_BEUL:
> -        stl_be_p(haddr, val);
> -        break;
> -    case MO_LEUL:
> -        stl_le_p(haddr, val);
> -        break;
> -    case MO_BEQ:
> -        stq_be_p(haddr, val);
> -        break;
> -    case MO_LEQ:
> -        stq_le_p(haddr, val);
> -        break;
> -    default:
> -        optimize_away();
> -    }
> +    store_memop(haddr, val, op);
>  }
>
>  void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t va=
l,


--
Alex Benn=C3=A9e

