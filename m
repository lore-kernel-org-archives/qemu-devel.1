Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC0BC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6245D20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LawzVokY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6245D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lSI-00006U-Kc
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1lRf-0007iU-7M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1lRd-0005FG-WE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:24:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1lRd-0005EY-Sr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581488661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLJsY1zh4i95gzmLiOkmmst3nsrUsra632KEofrJVFs=;
 b=LawzVokYRdBB9joceLK3mqsADgbc6XF3o0YjnJCUgZPlPAKMf615OYVljfHNm98WyMtH6y
 8akpyc0MJXmzdfE6FalSAdPHpmz8r3YFJNCHou9e26oknpqsOwg7WvdVWBpV69hGmlLZGd
 CStnCPc7n0mbTVj9FExbXDlm2JrEnYY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-88VYHYp3PkiwJrQ0XYK2yQ-1; Wed, 12 Feb 2020 01:24:19 -0500
Received: by mail-wr1-f69.google.com with SMTP id 50so405789wrc.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qNIQQI6fzzS4j/sDTlpsUO20OEIG94qmeSjGRr1VfPM=;
 b=jxnNAQDS5YrSVZmWMzFmgoVoiQPBLHxYsayAQGLRgmhs8aUpujVTnSrhBaj1vHXst5
 qJpL3/x/oNkxW3Z2asDcMRX8G8cjNjZuYiqjU8rOuLxshoCP9Q6rwlB1eKbNFi32cUwX
 L4A+0yYEr7Oz5rJznKpAOQJBJOexNgcwB9b9+SW9WC85/IpSICGSBxq095axSjjmyRGc
 c/zWw5m+QezYebt5VXhHHXXIaRPAPz7Ycalz5x0+fuxF4CBQAj3DM98pqHu5sEjhX5S4
 wwJ0S66Jo3XK6W+I2gRWeo8ThPe2l04YVQ/7Zn5NjMMLnEpLQKqXZgZRt4aIw3jW6uMM
 ucxg==
X-Gm-Message-State: APjAAAV4yrG4HApuEdJc2WvzHGzJw/uqNKH36pcobuWSyj+PXvlEvkTI
 jlhxzHUzrcEsF0IHriZ14BiPF1CKhos6q4rJMbxx5nVz1WCeXoae0S4XQTB2dbZQ8GJ1VvqXjI3
 btkPaYVHEPjMh500=
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr12864712wro.209.1581488658025; 
 Tue, 11 Feb 2020 22:24:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzf66GaYvdmwbB91XKkaBDk91VeLwJ6GRX0steJC6fxtgPBhQ6k+lMTjQSQy8RfQfC+UkLpDQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr12864687wro.209.1581488657707; 
 Tue, 11 Feb 2020 22:24:17 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s65sm7071329wmf.48.2020.02.11.22.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:24:17 -0800 (PST)
Subject: Re: [PATCH 02/13] target/arm: Add isar_feature_any_fp16 and document
 naming/usage conventions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a29a217b-f602-8925-4265-9a78030b6d73@redhat.com>
Date: Wed, 12 Feb 2020 07:24:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-3-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: 88VYHYp3PkiwJrQ0XYK2yQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 6:37 PM, Peter Maydell wrote:
> Our current usage of the isar_feature feature tests almost always
> uses an _aa32_ test when the code path is known to be AArch32
> specific and an _aa64_ test when the code path is known to be
> AArch64 specific. There is just one exception: in the vfp_set_fpscr
> helper we check aa64_fp16 to determine whether the FZ16 bit in
> the FP(S)CR exists, but this code is also used for AArch32.
> There are other places in future where we're likely to want
> a general "does this feature exist for either AArch32 or
> AArch64" check (typically where architecturally the feature exists
> for both CPU states if it exists at all, but the CPU might be
> AArch32-only or AArch64-only, and so only have one set of ID
> registers).
>=20
> Introduce a new category of isar_feature_* functions:
> isar_feature_any_foo() should be tested when what we want to
> know is "does this feature exist for either AArch32 or AArch64",
> and always returns the logical OR of isar_feature_aa32_foo()
> and isar_feature_aa64_foo().

Good idea.

>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h        | 19 ++++++++++++++++++-
>   target/arm/vfp_helper.c |  2 +-
>   2 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ad2f0e172a7..ac4b7950166 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3400,7 +3400,16 @@ extern const uint64_t pred_esz_masks[4];
>    * Naming convention for isar_feature functions:
>    * Functions which test 32-bit ID registers should have _aa32_ in
>    * their name. Functions which test 64-bit ID registers should have
> - * _aa64_ in their name.
> + * _aa64_ in their name. These must only be used in code where we
> + * know for certain that the CPU has AArch32 or AArch64 respectively
> + * or where the correct answer for a CPU which doesn't implement that
> + * CPU state is "false" (eg when generating A32 or A64 code, if adding
> + * system registers that are specific to that CPU state, for "should
> + * we let this system register bit be set" tests where the 32-bit
> + * flavour of the register doesn't have the bit, and so on).
> + * Functions which simply ask "does this feature exist at all" have
> + * _any_ in their name, and always return the logical OR of the _aa64_
> + * and the _aa32_ function.
>    */
>  =20
>   /*
> @@ -3702,6 +3711,14 @@ static inline bool isar_feature_aa64_bti(const ARM=
ISARegisters *id)
>       return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) !=3D 0;
>   }
>  =20
> +/*
> + * Feature tests for "does this exist in either 32-bit or 64-bit?"
> + */
> +static inline bool isar_feature_any_fp16(const ARMISARegisters *id)
> +{
> +    return isar_feature_aa64_fp16(id) || isar_feature_aa32_fp16_arith(id=
);
> +}
> +
>   /*
>    * Forward to the above feature tests given an ARMCPU pointer.
>    */
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 0ae7d4f34a9..930d6e747f6 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -185,7 +185,7 @@ uint32_t vfp_get_fpscr(CPUARMState *env)
>   void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>   {
>       /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
> -    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
> +    if (!cpu_isar_feature(any_fp16, env_archcpu(env))) {

So we had a potential bug on aa32?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           val &=3D ~FPCR_FZ16;
>       }
>  =20
>=20


