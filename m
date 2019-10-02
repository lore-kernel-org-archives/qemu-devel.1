Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13954C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6D5218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUOsIa4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6D5218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFbPb-0003C5-UU
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 05:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFbOZ-0002hy-3s
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFbOX-0007Zd-MN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:58:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFbOX-0007ZA-Dq
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:58:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id q17so18891091wrx.10
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6y6JdRjMr2qKDWQonNL2ywML1yD/Akz04vmL/2MT1HU=;
 b=rUOsIa4nEv1wb/tNhPYLXKGJMLDwqSnjUgzqBM2ZnN7cujDbBvcpc+AbBp7/vEVoSy
 Wd8an1ESqiJT1c28As9CEAElfnWnAJOJfEZbLFs+vb3psQ4OHoCC0tVDaHpZ7fH+2tyc
 WlVf9dEQ+wAmbYjZq7morunYwHPkUpg8t/JhJx5gBiYu/7pbae7W0AqyJuvIgZUQt1Jj
 4GmWVQWQQc6ZF/LvItl2R9KTnJWv0SLX2NqLNtqY4Wk2KVyEw+PU2Nrco0ax2cFCnZMD
 H/SOtZZGuyNA/Aei7hbQf0ZUkvao0XeOp+cgNnw+wipR1F4SQ7OmOjK4kxqAE4j5ekgb
 +gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6y6JdRjMr2qKDWQonNL2ywML1yD/Akz04vmL/2MT1HU=;
 b=oFdUkjMP6U3FLbW4Hg9YED8Mf1U3kzlUesgm5y3JA+nz7gk+RfqAx1ED2fjF60fBhZ
 6fQ4KsARCf7FENKWsBB6vueoyqfa3R+DRqrXilhsTfwCaTyida5YvhHIBTJoDYSTh14W
 k/A0nJl1ooglLFxr2wWtCn7IwHPKVpmceGD/lyoyUaBdsnt7YaZyqGPnPH67cNRlUaeE
 KKUNKy/YUAYkcT8iY0IsVmEiyO8RJnBdwaf6BxRuCjpWgwYe8it4mp6oXKhOTPlMOYIN
 kx5oNxjnnkbiyKNfEbFYtmlXkW3mf2lvnjpZXjZsfZR2gg879jOt1NbP+NEMpRjb0ByH
 pBAg==
X-Gm-Message-State: APjAAAW3X0Q0DdsvS+ZwxrbtLhPAkINqg1smiWNMTwmGzJMJUGN6Ryyv
 hyVPfvFtEV5xu66w3sbfjWR9sg==
X-Google-Smtp-Source: APXvYqxNy1Wyuw1IgPxfMEzIA4sxj444BeJ9TvXFgf5yyYPopIlKCYk2NcHhFSuhXNgHy+8oFRH80A==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr1905865wru.242.1570010284166; 
 Wed, 02 Oct 2019 02:58:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j1sm40976035wrg.24.2019.10.02.02.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 02:58:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C917E1FF87;
 Wed,  2 Oct 2019 10:58:02 +0100 (BST)
References: <20191002082636.7739-1-david@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
In-reply-to: <20191002082636.7739-1-david@redhat.com>
Date: Wed, 02 Oct 2019 10:58:02 +0100
Message-ID: <87zhijjwph.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> MVCL is interruptible and we should check for interrupts and process
> them after writing back the variables to the registers. Let's check
> for any exit requests and exit to the main loop.
>
> When booting Fedora 30, I can see a handful of these exits and it seems
> to work reliable. (it never get's triggered via EXECUTE, though)
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> v1 -> v2:
> - Check only if icount_decr.u32 < 0
> - Drop should_interrupt_instruction() and perform the check inline
> - Rephrase comment, subject, and description
>
> ---
>  target/s390x/mem_helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 4254548935..87e4ebd169 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1015,6 +1015,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t =
r1, uint32_t r2)
>      uint64_t srclen =3D env->regs[r2 + 1] & 0xffffff;
>      uint64_t src =3D get_address(env, r2);
>      uint8_t pad =3D env->regs[r2 + 1] >> 24;
> +    CPUState *cs =3D env_cpu(env);
>      S390Access srca, desta;
>      uint32_t cc, cur_len;
>
> @@ -1065,7 +1066,14 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t=
 r1, uint32_t r2)
>          env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destle=
n);
>          set_address_zero(env, r1, dest);
>
> -        /* TODO: Deliver interrupts. */
> +        /*
> +         * MVCL is interruptible. Check if somebody (e.g., cpu_interrupt=
() or
> +         * cpu_exit()) asked us to return to the main loop. In case ther=
e is
> +         * no deliverable interrupt, we'll end up back in this handler.
> +         */
> +        if
> (unlikely((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0)) {

I'm not sure about directly checking the icount_decr here. It really is
an internal implementation detail for the generated code. Having said
that is seems cpu_interrupt() is messing with this directly rather than
calling cpu_exit() which sets the more easily checked &cpu->exit_request.

This is potentially problematic as in other points in the cpu loop code
you see checks like this:

    /* Finally, check if we need to exit to the main loop.  */
    if (unlikely(atomic_read(&cpu->exit_request))
        || (use_icount
            && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra =3D=3D=
 0)) {
        atomic_set(&cpu->exit_request, 0);
        if (cpu->exception_index =3D=3D -1) {
            cpu->exception_index =3D EXCP_INTERRUPT;
        }
        return true;
    }

although I guess this is because interrupts and "exits" take subtly
different paths through the outer loop. Given that exits and interrupts
are slightly different is what you want to check
atomic_read(&cpu->interrupt_request))?

> +            cpu_loop_exit_restore(cs, ra);
> +        }
>      }
>      return cc;
>  }


--
Alex Benn=C3=A9e

