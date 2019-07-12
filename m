Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24040C742D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 19:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A5C2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 19:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv3l/3Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A5C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm0tf-0000Z5-Tx
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 15:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39163)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hm0tV-0000Ad-Mu
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hm0tU-0007Wq-6K
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:07:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hm0tT-0007Ul-K5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:07:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id s20so10485131otp.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=/uuqjhc2SDk+XG7NnGfKzZRrfRlJDOAI8Cqus9nJiL0=;
 b=Gv3l/3OxpfQuF+3qGNWLN7/DIV9aiv9ssy2zXIsM7XGSOuhGblr2PqeIQJwsEtzqSD
 G1OmRS8I+VCU2sIqBwfb2wpOm6i8z1zH4N1lg+Dx5gL54Q6/zKYcCUNuhVkmemllrlHd
 8NiDO871uzsZFfJb+89Fqb/NWQWy8ay3kk8n7AqZdjX+QljnPU8NtoZDTDG2ZdKutWSh
 i5HljHFxeM3cg0agEk4dyc6TM3XSCEw5M8w2v26DiEzx2CRrVFk726jAtN9866ahSS6J
 Ug+iS+5oLxy7pnf3zENzlcDFDnE1AkQFVJGpItbDqmx1JNoXRQKOides3uC+J2dq6aUh
 jxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=/uuqjhc2SDk+XG7NnGfKzZRrfRlJDOAI8Cqus9nJiL0=;
 b=jNKwN4WuiVPPKY8oPVyuawAA6LC+SdC1TWKYanapFMVy300a4eu+GQgi7KxM4vJ1tT
 TaX82mORNB49iIhfy1JTSHM6aUCH1z43V/ewWHLEwBbljBPQor6Z7MuwPV1s68vUBufM
 zIPgX/1y8a3w6yZEbBANRRV5KkUCWlUl1SwAPQ8OJWQjGaioKl9bi9JsMsA+z9MoiqvF
 KF4OqigtAs2/3DyZeIRWbiR2xhQ+RNKo3R00onsf0YEEbYJd53eVS+o3gBLvC/v8Qf6z
 vGY27esLe/PY/x6pKX2drTM1X8ttI59cni9aP9nfG01tzt4A9pACuVrn3IShHC8WlDtG
 ip5w==
X-Gm-Message-State: APjAAAURHTfzkmMX+igCoN3hfBK1m+jfC0TYvOZOY5VTCCouVwFH8T1b
 Vx2jw8KZ3avXZs6Q95lzSnTDLGneMzCn60AKf7s=
X-Google-Smtp-Source: APXvYqzjH4v4nesTa9dU3Px1VIGz+LjwwLh1hSgyxqjNesO7CxtdLaJXyy/M37m/D4M1H5xlhT4Wzz6d0AVyhkGlG5U=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr1695510oti.341.1562958462612; 
 Fri, 12 Jul 2019 12:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=ixrEhBeakGDW8xJVBBzRkZTR4d69w38HHmvxVUzOCkSw@mail.gmail.com>
 <CAL1e-=h83cwAvzEna1Tg3CShLV9DthbtS2Exh3JcOAtqCYHWrw@mail.gmail.com>
In-Reply-To: <CAL1e-=h83cwAvzEna1Tg3CShLV9DthbtS2Exh3JcOAtqCYHWrw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 12 Jul 2019 21:07:31 +0200
Message-ID: <CAL1e-=iaSHtcMzuXPc-=7TsPpKOWQ9cHsa_50t=bQQDo_AFbcA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [BUG] nanoMIPS support problem related to extract2
 support for i386 TCG target
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 8:19 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 8:09 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > Hello, Richard, Peter, and others.
> >
> > As a part of activities before 4.1 release, I tested nanoMIPS support
> > in QEMU (which was officially fully integrated in 4.0, is currently
> > limited to system mode only, and was tested in a similar fashion right
> > prior to 4.0).
> >
> > This support appears to be broken now. Following command line works in
> > 4.0, but results in kernel panic for the current tip of the tree:
> >
> > ~/Build/qemu-test-revert-c6fb8c0cf704/mipsel-softmmu/qemu-system-mipsel
> > -cpu I7200 -kernel generic_nano32r6el_page4k -M malta -serial stdio -m
> > 1G -hda nanomips32r6_le_sf_2017.05-03-59-gf5595d6.ext4 -append
> > "mem=256m@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
> >
> > (kernel and rootfs image files used in this commend line can be
> > downloaded from the locations mentioned in our user guide)
> >
> > The quick bisect points to the commit:
> >
> > commit c6fb8c0cf704c4a1a48c3e99e995ad4c58150dab
> > Author: Richard Henderson <richard.henderson@linaro.org>
> > Date:   Mon Feb 25 11:42:35 2019 -0800
> >
> >     tcg/i386: Support INDEX_op_extract2_{i32,i64}
> >
> >     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> > Please advise on further actions.
> >
>
> Just to add a data point:
>
> If the following change is applied:
>
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 928e8b8..b6a4cf2 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -124,7 +124,7 @@ extern bool have_avx2;
>  #define TCG_TARGET_HAS_deposit_i32      1
>  #define TCG_TARGET_HAS_extract_i32      1
>  #define TCG_TARGET_HAS_sextract_i32     1
> -#define TCG_TARGET_HAS_extract2_i32     1
> +#define TCG_TARGET_HAS_extract2_i32     0
>  #define TCG_TARGET_HAS_movcond_i32      1
>  #define TCG_TARGET_HAS_add2_i32         1
>  #define TCG_TARGET_HAS_sub2_i32         1
> @@ -163,7 +163,7 @@ extern bool have_avx2;
>  #define TCG_TARGET_HAS_deposit_i64      1
>  #define TCG_TARGET_HAS_extract_i64      1
>  #define TCG_TARGET_HAS_sextract_i64     0
> -#define TCG_TARGET_HAS_extract2_i64     1
> +#define TCG_TARGET_HAS_extract2_i64     0
>  #define TCG_TARGET_HAS_movcond_i64      1
>  #define TCG_TARGET_HAS_add2_i64         1
>  #define TCG_TARGET_HAS_sub2_i64         1
>
> ... the problem disappears.
>

It looks the problem is in this code segment in of tcg_gen_deposit_i32():

        if (ofs == 0) {
            tcg_gen_extract2_i32(ret, arg1, arg2, len);
            tcg_gen_rotli_i32(ret, ret, len);
            goto done;
        }

)

If that code segment is deleted altogether (which effectively forces
usage of "fallback" part of tcg_gen_deposit_i32()), the problem also
vanishes (without changes from my previous mail).

>
> > Yours,
> > Aleksandar

