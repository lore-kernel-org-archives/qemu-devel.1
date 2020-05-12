Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2511DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52C7206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frcgpB9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52C7206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUT8-0001vK-3a
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYURY-0000KC-Lh
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:55:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYURX-000586-5Y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:55:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so15237252wra.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6P45VwVvfAR1dcN5MUvpdsmRKM2CKUu53XUna1pkm7k=;
 b=frcgpB9+FoWKiE/i9+CAlgfJPXjdQ9t2xP4n1cS3YXQuqwUQT0TlpHsAlg6kp5nVY/
 gny8qtNxjzD2yeexga96ZeJXZi6UDL6BBrGd/RWyrOiqKicse9Bkdi3+5cNSUTc6vMAC
 TqLKL/QDPBq6YPHd95CWXSR1fQIqSUmafhws5IL7SdccJP7gGjrgRm0T4n8TpKXcPmhM
 K12kzUq5IFF35omR7ZBhm1XPD7vT1rllLubIIx2T2QUO7bNQU1lHkdmh9vpVv8xQ55Kp
 H+zPTqTAWbhKBOi9gVhXVKoj5WbW7usOjFp5EE6xOk5JUBUyu4xYrVOt72wU6BKCi92B
 2XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6P45VwVvfAR1dcN5MUvpdsmRKM2CKUu53XUna1pkm7k=;
 b=erLUWsKdmQQy94P0bdifH8WYgsctwjiCcs3dPQMPzwymr7TrczmvxTIVQSjp7NOOPg
 +FmGE38Vas+kWoaZfRli9sHJDI6V4wzSbGDbSfSMBTy9H1ME/AUDMy3a+abEbtQJuXKi
 b8oPMvMhimHRlyAQDFDuOg1DJ7aD4vUlO9uICfhAvYe0HNWQWypSkNPx/78fg36gY8hz
 gMWkM0ON56RJcOTKEuskUhd8oz9Osb4k1FM7MdbA+P+ujMZq/glVNEk1k3Z9TCPWQfgX
 UP1LD9L6wCY/Otq0FF3D+1BG5cN4jelNBgX8PnDc3vPzXS1i4pT899sLnu4AMh9KiBLH
 wH3Q==
X-Gm-Message-State: AGi0PuZVpOVQlo8s4pYo3CqVyL86JkQHOhItI9F4grsB+NfTI3dgU1Kg
 QKHlrjR5J+xuwWNIfKZGg47NJWS2xv6NXHH/xl0=
X-Google-Smtp-Source: APiQypIRTiyaQcPrXe9GV6ssovmZ3x6PM8nrGiRvPLlssTasPHimK8lvidqnDPkC5QYL3ybhDQaQOGuHzrcyG+RWS+o=
X-Received: by 2002:adf:e989:: with SMTP id h9mr9061411wrm.420.1589288129325; 
 Tue, 12 May 2020 05:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <1588501221-1205-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 12 May 2020 14:54:38 +0200
Message-ID: <CAHiYmc4aK+hvrv337VreT9vKfbkNhUW3YEAzWpCXE-_bcQi03w@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 1/7] configure: Add KVM target support for
 MIPS64
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:23 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Preparing for Loongson-3 virtualization, add KVM target support for
> MIPS64 in configure script.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 23b5e93..7581e65 100755
> --- a/configure
> +++ b/configure
> @@ -198,7 +198,7 @@ supported_kvm_target() {
>          arm:arm | aarch64:aarch64 | \
>          i386:i386 | i386:x86_64 | i386:x32 | \
>          x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
> -        mips:mips | mipsel:mips | \
> +        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
>          ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | =
\
>          s390x:s390x)
>              return 0
> --
> 2.7.0
>

