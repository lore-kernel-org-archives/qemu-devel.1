Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C6BC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC9B206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKWIi2wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC9B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYYU-0001G9-KK
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYWf-0008SH-Fs
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:40:01 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQYWd-0000sX-Mj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:40:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38896)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQYWd-0000os-9Z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:39:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id g12so20590wmh.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5ZzPYd75tQ3vMp0hx9EXDOrihpQ7Bi5inZTjOT6ib34=;
 b=pKWIi2wZrY0IeqCxFwsQmcSYm7tPKN4DNqRmzmQHGvQavvuIzeedgEtKgjBxonWKA6
 A5+oVJKuG0Ej5P+IHI8AlDhia3KunJ5D8J9FLkT4IFqM/YNoju+OEKLMWmGeAx4MYHGT
 g50LO3fQL8pjCRw24vdVRCuParVGjCchfs3CFXGYNI4bz/qkVGMtYHTlmjn2t9r0SexL
 7Ld9hTJjj+HKHMxX5DQw6Twtmj4t1REPNN8qz467fSJ3F0NYxyKMEFx3YRtTkl5Q4XDn
 ohtpzxT06b5lsqEab7wZuWPn736g+6YhP+S6MubGdZqIwsZgTL0u9K1gTFLoyU0hgKPd
 HDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5ZzPYd75tQ3vMp0hx9EXDOrihpQ7Bi5inZTjOT6ib34=;
 b=GqPxvBJiZzcQHKmxxefhy6gFZih5BhkDSRqs0QoAqzI3acbknq9E3A68IlV99gGvzA
 /+T6BsvFH5yRVdWIVHI6r7mYymdW2A3ZAOVUp28Neg86D0Ja87PV4LzmptqO3GUE8oyT
 aM7rrkxCry1l8UgdtHiCNqPfFiL4Wlwmq4gj1HC5Ko6EgcFKDjB2vLOiK6w8oZiArDKq
 HWChebepueinnaqrVcXMaOvNz8mBSjm3nch4l9x45Pu81WPR8lrAT1fwe2Sdz9GA1J9p
 E92UkF6CUkdc7vcp96VYi+gE1tciuaiPI1XuRaBRQqzxSNkmRUQ83n6OfPh42iv/FYiu
 RbsA==
X-Gm-Message-State: AGi0PuZDZetJ42OwsfABgHd4Z6a+ZCDV01w0siCdSd+keorhTs5WkmA/
 o4SxVib4K84VfNiPheLrpbI+uQ==
X-Google-Smtp-Source: APiQypLE7KE3+0s7PTtMoghqcom102DHqYbpvNkkybfHLwqpXwgn577mVeAnNC05Vs36Ob31iinMcg==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr17838780wmc.74.1587397196532; 
 Mon, 20 Apr 2020 08:39:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u7sm2002890wmg.41.2020.04.20.08.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 08:39:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E26B31FF7E;
 Mon, 20 Apr 2020 16:39:53 +0100 (BST)
References: <20200418161914.4387-1-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/16] tcg: Better handling of constants
In-reply-to: <20200418161914.4387-1-richard.henderson@linaro.org>
Date: Mon, 20 Apr 2020 16:39:53 +0100
Message-ID: <87a736dv3q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

> This promotes constants to full-fledged temporaries, which are then
> hashed so we have only a single copy across the TB.  If an opcode
> requires forcing one into a register, then we will only do this
> once -- at least until the register is killed, e.g. by a function call.
>
> While this is probably an modest improvement for integer code, it is
> significant for SVE vector code.  In particular, where a generator functi=
on
> loads a constant for the operation, and then the generator function is
> called N times for the N x 128-bit vector.  Previously we'd be loading
> up the same constant N times and now we do so only once.
>
> The existing tcg_const_{type}() functions are unchanged, allocating
> a new temporary and initializing it.  The constant propagation pass
> of the optimizer will generally remove the temporary when it turns
> out not to be modified further.
>
> This adds new tcg_constant_{type}() functions which produce a read-only
> temporary containing the constant which need not be freed.  I have
> updated the generic expanders to take advantage of this, but have not
> touched the target front ends.
>
> This also, in the end, allows the complete removal of the tcg opcodes
> that create a constant: INDEX_op_movi_{i32,i64} and INDEX_op_dupi_vec.
> Loading of constants into hard registers is completely controlled by
> the register allocator.
>
>
> r~
>
>
> Richard Henderson (16):
>   tcg: Add temp_readonly

The series failed to apply at the first patch. Should it be based on any
other patches?

--=20
Alex Benn=C3=A9e

