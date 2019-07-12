Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6344C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 18:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE7C205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 18:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0H/I8ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE7C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm08i-0004Mf-JI
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 14:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52906)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hm08Y-0003yp-LG
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hm08X-0000zX-Ke
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:19:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hm08X-0000yD-Bj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:19:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so10323066ote.13
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=YIOwViAwwSlvybnl8acK8XpdyOwMjSDyfGrwliC+PU0=;
 b=n0H/I8zeZE6oPQZWD9IN7TFcHTjsEP+8HRsyLmHkWbLODnqpPVr1vAsoQV1Z6OQ4WY
 vOp+BYKuFaar5fW9LXBrzHYp1jTIW8f7cJZhPAf/II/pjfhnMd9nJeqFRQoyQsJEx9M7
 nhKmzBhQIzezUnZsYs7pbcqvAaQdCPMx6eeZxtHXimOOph2kMf48sBCX0gkHOde2ZdWf
 2rxuxRRgqvTezekrMoI1m1+mmhW8DbsS+sxBfKI9ax4kLVYeXn/vlwsqpMw2A0hXJK+J
 dLW5a5dl062c21RyanWW5iUBVhI0mHJslVxBiVjhnYXQF9tpyP81RGmhzOvl+c6yLlbo
 XH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=YIOwViAwwSlvybnl8acK8XpdyOwMjSDyfGrwliC+PU0=;
 b=YC+3nk4/82yim2FlegCE3IJVJWQ1Fip/sRoXiP6xfZg0dI4MEIJ6Qhi/a5CEBF8cIw
 1a/9fbsRH7Q9hj8Zaaf/xPJMgZjhcN9/m4j9MO1Bu4N8pt4DwI1TivXaGmcYJmWIW4nl
 +jAPByCffg3EqvtF6u7KQ2SKUiO4JS0Oh2BduoS0G/67yKD/AvjrXa7KMf8G00s1/OC9
 rPAhSUwTbt0Wc0nprZri2Tw8IEZ9n1xtF5GJHQqswlwhHGVAuSfnnNsvjG8y0OS6Vcty
 BHdmYkmpMlkl3ybuhdWpuoNRa5ZDU1XeBBdYfXrb2IW3cR4ReWmAYpeqpzpA/fpduuNO
 F6iQ==
X-Gm-Message-State: APjAAAVdIki7iw1MgFOfjtTyM7hWEOFYD6uCXDadwd5LBFXqzHSX+2qp
 LFvlIrHNGPvA91RgtHCqgSLFjqO24NEhID7zadY=
X-Google-Smtp-Source: APXvYqwTj/oLu5QYwWVwpR3rKxyhRx2DzAN9YUKJBWRnJXIKIFXhWuhwMl5zIEeBNSvqi5RTUuFOKr+WrB5pjbEuEfA=
X-Received: by 2002:a05:6830:c6:: with SMTP id x6mr6429779oto.64.1562955552298; 
 Fri, 12 Jul 2019 11:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=ixrEhBeakGDW8xJVBBzRkZTR4d69w38HHmvxVUzOCkSw@mail.gmail.com>
In-Reply-To: <CAL1e-=ixrEhBeakGDW8xJVBBzRkZTR4d69w38HHmvxVUzOCkSw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 12 Jul 2019 20:19:01 +0200
Message-ID: <CAL1e-=h83cwAvzEna1Tg3CShLV9DthbtS2Exh3JcOAtqCYHWrw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Fri, Jul 12, 2019 at 8:09 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> Hello, Richard, Peter, and others.
>
> As a part of activities before 4.1 release, I tested nanoMIPS support
> in QEMU (which was officially fully integrated in 4.0, is currently
> limited to system mode only, and was tested in a similar fashion right
> prior to 4.0).
>
> This support appears to be broken now. Following command line works in
> 4.0, but results in kernel panic for the current tip of the tree:
>
> ~/Build/qemu-test-revert-c6fb8c0cf704/mipsel-softmmu/qemu-system-mipsel
> -cpu I7200 -kernel generic_nano32r6el_page4k -M malta -serial stdio -m
> 1G -hda nanomips32r6_le_sf_2017.05-03-59-gf5595d6.ext4 -append
> "mem=256m@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
>
> (kernel and rootfs image files used in this commend line can be
> downloaded from the locations mentioned in our user guide)
>
> The quick bisect points to the commit:
>
> commit c6fb8c0cf704c4a1a48c3e99e995ad4c58150dab
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Feb 25 11:42:35 2019 -0800
>
>     tcg/i386: Support INDEX_op_extract2_{i32,i64}
>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Please advise on further actions.
>

Just to add a data point:

If the following change is applied:

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 928e8b8..b6a4cf2 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -124,7 +124,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     1
+#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -163,7 +163,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     1
+#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1

... the problem disappears.


> Yours,
> Aleksandar

