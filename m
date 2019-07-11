Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2DCC74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D95221019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aw0PtbwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D95221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYj6-0003YW-6E
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33837)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlYhR-0001hd-UN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlYhP-0007cA-Eu
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlYhP-0007ap-5Y
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:01:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so5615499wme.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4tUPvhpmf4RjVrYJnAkw+1Jqpr5UUWhZW+cTOdAPB1g=;
 b=Aw0PtbwCDMc7jQ0OQqwVdBOC88gUehRfqVDD60CXIetxHSkAFYdXjCkS/MR4zIM4l5
 0uWl5DHNCH8IftRLkP0wQuLZWEs4QNsYoiT9tgDRvn0dK0dbS10eDnsTXzKcHH07n+3f
 r6u7NfTlCUZOQTai+gI68zAgjMfosIi5J4loxGVy5S6I9h4uVlR6vf3cxINWx8Xq3cM3
 PiPUc4h7r1Dlzs9oVluBe5hxcqweoejOKesfQFIDQNyr+KKqLOt4fm+ZibKiWzkdbTbC
 qUhVy/MK8US9PLZK5t/7WfZVVHyLm4wxjuURAJbD7P9sLvvczf1pKYJ0m3e2eCV9NyVq
 I2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4tUPvhpmf4RjVrYJnAkw+1Jqpr5UUWhZW+cTOdAPB1g=;
 b=pFWkzmAWXTDADoKZZKB/7wkfzCsQvia5Q3zSKp8Pg8Fim4gpPhNnEowLaq5S77L77W
 HyimX/gX+6LVWCvpJJ2fzIVXzSUqx5OAOAFEcHrnFYKk5ErP8XHJ05yZGDVHjgjGHGwG
 O+Aa/D6bhlEbZdDjIDX9cEAPcpVYvZup3RUicowZIQQnHRMjItkStbigRKOTCSZO4kzp
 3uihqI4g/npRliKkyWGNnqytrT8w6Z+4dyafGNcg03b5BVtAeCmmJrsCVzofLyg4EdCM
 I8X2bJjPFld401lLq8cBIjVKWYgE27aalneNMPi+uK/spo1uFfvvo0Uw1Uym9ouH3jg+
 gz0g==
X-Gm-Message-State: APjAAAUt+xnfUpFYVkKg7pK7t1LNqEQ0TxjPiHxnulQMmPKIgJ4N6fgS
 7g+aDhti/NwjYIpjrk+Pk2ZkFQ==
X-Google-Smtp-Source: APXvYqwAHrEJsIPgCfurYZ8pA9JkAEqGM40hUgrBZhq4AChnyYSTXABQhZ8qxYjMd5YyGyvaJ6y2Pw==
X-Received: by 2002:a7b:c84c:: with SMTP id c12mr4216634wml.70.1562850081707; 
 Thu, 11 Jul 2019 06:01:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v124sm5754810wmf.23.2019.07.11.06.01.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 06:01:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C6A5B1FF87;
 Thu, 11 Jul 2019 14:01:20 +0100 (BST)
References: <20190711121231.3601-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <20190711121231.3601-1-peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 14:01:20 +0100
Message-ID: <87d0igendr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Set VFP-related MVFR0
 fields for arm926 and arm1026
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
Cc: Christophe Lyon <christophe.lyon@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The ARMv5 architecture didn't specify detailed per-feature ID
> registers. Now that we're using the MVFR0 register fields to
> gate the existence of VFP instructions, we need to set up
> the correct values in the cpu->isar structure so that we still
> provide an FPU to the guest.
>
> This fixes a regression in the arm926 and arm1026 CPUs, which
> are the only ones that both have VFP and are ARMv5 or earlier.
> This regression was introduced by the VFP refactoring, and more
> specifically by commits 1120827fa182f0e76 and 266bd25c485597c,
> which accidentally disabled VFP short-vector support and
> double-precision support on these CPUs.
>
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 1120827fa182f0e
> Fixes: 266bd25c485597c
> Fixes: https://bugs.launchpad.net/qemu/+bug/1836192
> ---
> I've followed the existing approach we used for ISAR1 here
> of just filling in the fields we care about, rather than trying
> to set the entire register value.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Do you think we have caught them all now? If we end up removing the
other ARM_FEATURE_foo flags in favour of isar tests we shall have to be
careful not to re-introduce these sort of bugs.

>
>  target/arm/cpu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e75a64a25a4..446dd5163dc 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1666,6 +1666,12 @@ static void arm926_initfn(Object *obj)
>       * set the field to indicate Jazelle support within QEMU.
>       */
>      cpu->isar.id_isar1 =3D FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZE=
LLE, 1);
> +    /*
> +     * Similarly, we need to set MVFR0 fields to enable double precision
> +     * and short vector support even though ARMv5 doesn't have this regi=
ster.
> +     */
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
>  }
>
>  static void arm946_initfn(Object *obj)
> @@ -1713,6 +1719,12 @@ static void arm1026_initfn(Object *obj)
>          };
>          define_one_arm_cp_reg(cpu, &ifar);
>      }
> +    /*
> +     * Similarly, we need to set MVFR0 fields to enable double precision
> +     * and short vector support even though ARMv5 doesn't have this regi=
ster.
> +     */
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
> +    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
>  }
>
>  static void arm1136_r2_initfn(Object *obj)


--
Alex Benn=C3=A9e

