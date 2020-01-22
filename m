Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D74F20704
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3u89zai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D74F20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuCiW-0004Tb-JM
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 04:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iuChw-00042z-GO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iuChv-00073x-JK
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:53:56 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iuChv-00073e-FC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:53:55 -0500
Received: by mail-io1-xd42.google.com with SMTP id i7so6030521ioo.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=usmHTCWMdOKYbZ9EQHDUabDH16N8oLBZwEUZ10KRNjE=;
 b=I3u89zai+O8KoDYNfvnhFlfXVj20Zkw3jiTn+E0Q+3u+DLPB5CSIBVOjGCWTQ5DhWm
 06BViUWu/qy+1wHry2JWKf0der3JVtJnHZ9E7WyLZ82krpgusLUzgCvTNxqsduDFRecb
 VIV/P6HY0FKXw6mr+xHXrsxRvFSL8Ph+QRKZIvRXsuKQ4j/UjeCvhljEEmRUuTsN4gTw
 Oh5TjTuEj3h80dIh6+GyJcJ0YjFstjkFulYeHhNcI35+6MtdsvqPNxAhwkzemqVULW1i
 AJEIctvOptOGe3cW1jRoH7psHrNjZ7q41zs5rpG/7pm9TLrYF8aZiBKVVH6hIxEy3sCA
 qN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=usmHTCWMdOKYbZ9EQHDUabDH16N8oLBZwEUZ10KRNjE=;
 b=WnAnu1QkXXj38WxFRsdXdAdHoBy1TyjPSVwdoH79PTuVcDu0t2ZWKRDOtqAR+WurDq
 tCQIzeuMlChm8IKXrVbNOG01NkPnNOrDQThnvAuOV11evi3RkiiTuWO0KPQBJzMSxFdQ
 80NVEoOJ1XrJz4i5ZSbEKkSA0fxeLR+LJGmD1eYcYOvZpmCzQBIAyjwzvcBdh3M3uPN8
 dVu14upK1cTwjqKGJncvYZddAVZzT5FBXi1TpvrmY539KPBTuawXHKyHWpYbEoELY3PB
 AnomQomdk6n65UJeg6o+fY4PTvhgIrB6IOE6b/LE2I8LSpFDe7gHfFAui8cr95ZbOd8q
 LipA==
X-Gm-Message-State: APjAAAUqq3FzwlU5QRWG1EHCbLpcVO066eJt9LX+tnojx+Rzbu6ZeBsW
 P2u2bGmFMHgRj+RSKysvDR6oNdUCETl1Tw7lRzM=
X-Google-Smtp-Source: APXvYqxK885yMF84gNKEPNsZFjgdaJyaMz79xWqree712NFxOeo7Rp9xP6ZUyg0eVfgIOzWBUy2+7QbqJpDHnli0k0o=
X-Received: by 2002:a6b:8ecd:: with SMTP id q196mr6298122iod.136.1579686834745; 
 Wed, 22 Jan 2020 01:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20200122072448.18510-1-ianjiang.ict@gmail.com>
 <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
In-Reply-To: <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Wed, 22 Jan 2020 17:53:43 +0800
Message-ID: <CAMAD20=RS=tt04db3NfiPfXJo2Cr5PfCF-39E8qeuehnVGMdKg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--
Ian Jiang

Richard Henderson <richard.henderson@linaro.org> =E4=BA=8E2020=E5=B9=B41=E6=
=9C=8822=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 1/21/20 9:24 PM, Ian Jiang wrote:
> > For FMV.W.X that moves the lower 32 bits of an integer register to a
> > floating-point register, Rd should encoded with NoN-boxing scheme.
> > Note: This applies to RV64 only.
> >
> > Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
> > ---
> >  target/riscv/insn_trans/trans_rvf.inc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/ins=
n_trans/trans_rvf.inc.c
> > index 172dbfa919..62b7a36567 100644
> > --- a/target/riscv/insn_trans/trans_rvf.inc.c
> > +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> > @@ -368,6 +368,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fm=
v_w_x *a)
> >
> >  #if defined(TARGET_RISCV64)
> >      tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
> > +    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000=
ULL);
> >  #else
> >      tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
> >  #endif
> >
>
> This doesn't look right.  There's nothing in the spec that says the nan-b=
oxing
> is restricted to rv64.  NaN-boxing is all about FLEN, not XLEN.
>

Why the translation of FLW has a NaN-boxing?

file ./target/riscv/insn_trans/trans_rvf.inc.c
 26 static bool trans_flw(DisasContext *ctx, arg_flw *a)
 27 {
...
 34     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
 35     /* RISC-V requires NaN-boxing of narrower width floating point valu=
es */
 36     tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000U=
LL);
...
 41 }

