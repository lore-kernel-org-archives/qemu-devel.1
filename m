Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1942084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggPhqQK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1942084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxTM-0005ha-1o
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNx75-0006vu-C8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNx74-0004zU-Bi
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:46:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iNx74-0004zM-4T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:46:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id d8so1741859otc.7
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=2sBzSENNy9SmDC2DfhiSXWQJgVbCLsB09LkKsTqTXM4=;
 b=ggPhqQK4rBEfLfHghMGW9fz0OsMzkqY8dkGHaECiTaNK74aRgM8xaebncyrCWzs3dU
 aMXRuui71X/pdTKqrYqZZZQt9rrpjBmhwp8n6gcbvjQnuYHHEOlMrr9DQEaHY7oeQYJ/
 uTm2AxMQCmxY1UQnHW79gh3eQUNho6q/DUp8v3V7l3ofwh7F0BWeP3jAqYSgaWd80kDa
 mPRUuuBlRoHeoy6AXdJWw606O3I+9o78NDsPfzbdQrLYP11IRrw8OG6CIHrJydoSuLmd
 LLHEJsdJI+A3pJfRpTFmfsmB0oKnhc2BPmfxX0PeEbGHe98dXg6Q4Ns1vWyFfSLqgKO8
 k6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=2sBzSENNy9SmDC2DfhiSXWQJgVbCLsB09LkKsTqTXM4=;
 b=HdtUax8SH9rK01KQTSVkBE6IeHD19g8i7rIGB5s67iX2N3nh0oDuLEDnCT3WzUkhSM
 rTJq5zKb8Ixh+AvKbW41RXTn4Bqn2lNN8sNy573VSCzC9F45B3d286gsUkwiSpGLB5KY
 s0j8xSxMKn0rwZKi8RErH60ptFnHv1+M2Hdyu5ZpPxpRvJdkLEeSKRzqjN6SdFOElIZW
 puBbpImodkEZfld4H7hgKzHA9GJd9KeETPB4+RQ9WWoMTqdxhP8l+hymPK5rud/kMthC
 hMeuEPHto+/eE9X4aad+YzePPN4E+hE3BZoTEAfTTin3xD7qiUEaBia9Ogh/T02qtyWC
 LKDw==
X-Gm-Message-State: APjAAAWW79/+UCqmKmjTfdznRJyZRWWTN3FqYGmxCYwDScs9H7OA7jAP
 sjZg+unTanEEanTN0swiwE781WMBCtLIoyN9hoA=
X-Google-Smtp-Source: APXvYqz2sYmw/ffq8hohI9P4+r2DfgIq5VC8Gjk+EXYCZlcm6Isws0eO0rwLEkRbIl2kGwnRNq8t/PWhxbWSY1IYT8U=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id
 y15mr2116624oti.121.1572000393518; 
 Fri, 25 Oct 2019 03:46:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 25 Oct 2019 03:46:33
 -0700 (PDT)
In-Reply-To: <1571837825-24438-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1571837825-24438-1-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 25 Oct 2019 12:46:33 +0200
Message-ID: <CAL1e-=iT0Mhiya9Rp3=263fnwzXDHsh0CTV9_dDSyzwYrirzNA@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/mips: Rearrange handling of vector compare
 instructions
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: multipart/alternative; boundary="0000000000000ae0580595b9ddaa"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000ae0580595b9ddaa
Content-Type: text/plain; charset="UTF-8"

On Wednesday, October 23, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:

> Simplify instructions by removing unnecessary argument and creating
> separate
> comparing functions for each instruction.
>
> Filip Bozuta (2):
>   target/mips: Rearrange vector compare equal instructions
>   target/mips: Rearrange vector compare less than (signed) instructions
>
>  target/mips/msa_helper.c | 160 +++++++++++++++++++++++++++++-
> -----------------
>  1 file changed, 100 insertions(+), 60 deletions(-)



Welcome to QEMU open source community, Filip!

This series looks good. I may do just some minor corrections in commit
messages, I'll do it while applying, you don't need to do anything.

Hope you'll do more refactoring like this in future!

Aleksandar



>
> --
> 2.7.4
>
>
>

--0000000000000ae0580595b9ddaa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, October 23, 2019, Filip Bozuta &lt;<a href=3D"mailto:=
Filip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Simplify instructions by removing unnecessary argument=
 and creating separate<br>
comparing functions for each instruction.<br>
<br>
Filip Bozuta (2):<br>
=C2=A0 target/mips: Rearrange vector compare equal instructions<br>
=C2=A0 target/mips: Rearrange vector compare less than (signed) instruction=
s<br>
<br>
=C2=A0target/mips/msa_helper.c | 160 +++++++++++++++++++++++++++++-<wbr>---=
--------------<br>
=C2=A01 file changed, 100 insertions(+), 60 deletions(-)</blockquote><div><=
br></div><div><br></div><div>Welcome to QEMU open source community, Filip!<=
/div><div><br></div><div>This series looks good. I may do just some minor c=
orrections in commit messages, I&#39;ll do it while applying, you don&#39;t=
 need to do anything.</div><div><br></div><div>Hope you&#39;ll do more refa=
ctoring like this in future!</div><div><br></div><div>Aleksandar</div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--0000000000000ae0580595b9ddaa--

