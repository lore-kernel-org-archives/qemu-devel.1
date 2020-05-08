Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA9DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80B8208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3Xlt3s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80B8208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX04x-0006e3-21
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX04G-0006DC-52
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:17:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX04E-0006s3-S9
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:17:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id k12so9618804wmj.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wPlMYK4BGXFSp3IHXDTVLzq/iTbq1i6IWP1FINyN18k=;
 b=o3Xlt3s6++cHTq52sQjBq0wMEAi9y5SNlGe7QO0y6oq0KKhuZx3BfXIXmEfYSY8gPy
 ShBtS6suwtbVkvmGrQ2e8A/I43MBZUPQeiqtsaZJb1FFbeRZgKR8iSUOztdjptUPrT1s
 szfjPX0Z8PnOzgo33UCwDYMcUZP6OLIkuhIcL00gaWTNU9q5Q+nl4GqWCfr7c9CqUvgG
 zKWs+BsUdKrvk9WTceTlsjb87e7cZdpeYQgVn4KqtlbNHSlRBho6H31fdn4h88Y30FHx
 91pBNfpt+gcz/SqocY7WT5N5WMkUtk+GzRx6HvSfAAL8709C1ZlMtReRnBFVW1Ez2o14
 gVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wPlMYK4BGXFSp3IHXDTVLzq/iTbq1i6IWP1FINyN18k=;
 b=iBZ+tkDx1aBvxCb9yrZrFxuxmUpchpFgH+U+pZxAU2CNzhbHsMNGH4raAQMuG23Wr2
 blcTWvFIP0gNtiCPS5tuGEs3bw6y50+P1hzWCaEsqkSBeiZHUXxgtjMQznQ+IEPqyXIl
 YTpHR9ljWjS9pT3uusK2UoLIGdpkthNdgETRM28kBfIxg98izUoctc2P7CN5jhpXFWrW
 Uamrmq//cknHnsCns2ymNxdvP0FPj9bHSZI4qti4bLrxFJhs7Xl9qjsxqV5Jmh6Oi9rf
 p68GVjS7vWxVUaeE4rThQhZZh4UMXQWBNzC5MD284J5PeB7K/IfT19lwcMAQ658f/ZtR
 Ntnw==
X-Gm-Message-State: AGi0PubFhMELioDJ2tualEgpepiKsZeKVSLBfUDp91l9/0vrlOMWBRM6
 KV/azEqYBEA77laOXnS5/24NoRTwdn9x/alUNyk=
X-Google-Smtp-Source: APiQypIZFqnECJhCvIGLM3lIwRn5c3Wyc+b/srmG5x5QwvCo9yi/D+GdLPFD1hEudGcor71Fg5HQOE4XHmgrsmb6bp8=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr16902508wmc.168.1588933036896; 
 Fri, 08 May 2020 03:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-4-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-4-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:16:54 +0200
Message-ID: <CAHiYmc69=CNzXTtOSXg5ZxBy0+J4iRwct25O-ANw-=PEkcMTaA@mail.gmail.com>
Subject: Re: [PATCH V3 03/14] KVM: MIPS: Increase KVM_MAX_VCPUS and
 KVM_USER_MEM_SLOTS to 16
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:08 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> Loongson-3 based machines can have as many as 16 CPUs, and so does
> memory slots, so increase KVM_MAX_VCPUS and KVM_USER_MEM_SLOTS to 16.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/kvm_host.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm=
_host.h
> index caa2b936..a7758c0 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -78,8 +78,8 @@
>  #define KVM_REG_MIPS_CP0_KSCRATCH6     MIPS_CP0_64(31, 7)
>
>
> -#define KVM_MAX_VCPUS          8
> -#define KVM_USER_MEM_SLOTS     8
> +#define KVM_MAX_VCPUS          16
> +#define KVM_USER_MEM_SLOTS     16
>  /* memory slots that does not exposed to userspace */
>  #define KVM_PRIVATE_MEM_SLOTS  0
>
> --
> 2.7.0
>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

