Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C961C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33236208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDdlmsdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33236208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX03M-0005bQ-9Y
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX02K-00055h-OX
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:15:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX02I-000519-A1
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:15:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id h4so9639078wmb.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mH4zcj4jAFO6of/XHBeCHGTKbSV21AdNuIYsxQykbg0=;
 b=pDdlmsdZ8CkNvrQbbd4GjumxAzozSa2oP2fF1wBBFwzTGatcplKgpfDIqVQipqpecq
 4N9xuoN0ltj8m4CzfaDwc8g84ygpzkzAuddOyYBpIfvI8sy+5KAmizrto8RteRINems4
 Hy2XgXTNbdv9qFolyPghf1DVtzIieYcGZJitGh3HtL5CuLGvsuO/kl8wpLxVczKdS/r4
 WDJY3AE/TGyhu5uAgteiM9DqFuWZjZgd02ddFHImczuHt0kYfUPCBJ80KiI0OmqQLage
 8QlpThHUPyLS4+b5aAr5XiRyvoM3EtOZIz9XJ3nL6HFEsX4yNdiUgbNY8dNCFcNnuZmU
 9mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mH4zcj4jAFO6of/XHBeCHGTKbSV21AdNuIYsxQykbg0=;
 b=spYA7nYLJ8Xy2s/0TVkBsCc81KWx5x+mlPJ6OviblYSNa7k2ItVdmWEcEx5Ywyqk1Z
 QAzWmfvqGrJk0C1ajtRDg6+38c9E7nAiAoX9bcAj2ypZIrIQd36vRkyTIxtCPqkFEczk
 gKmQ9Swc4G7wBV7lKuThPncrm/KRPXSh7wlEO0f2Sj1pBxR8QFTSFVxVRQ7Q/JAmyK84
 lRCHZb/Q5E5sYZdxu8Zsw8WEAm1UcEO5HQ+Wy4h78acSkNNp6xPbcOc1eJG+1Au7/1Yc
 9xwdtNlYowRK7MyxgyliGg/kvqT2wIrBG0dhC0hdpZQTSY8BtZda382bT+YGZgvGlIos
 MKPw==
X-Gm-Message-State: AGi0PuYVrQG12DsQgtoJAyaAZlOgiBOEONJS87tQMo53WtejBU+6kw2g
 vn34rKCDMXGjsL6YyZBUDllCB3G/aL47/7G2i98=
X-Google-Smtp-Source: APiQypIREaQqmfF7+C8yUOxOZSymcWKhbwxCIVdrJyeSmilFqo7y6mn+Or2O1brlhklUlY5+b0V7MLT3rhV4/VuubS0=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr16390070wmi.50.1588932916746; 
 Fri, 08 May 2020 03:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:14:40 +0200
Message-ID: <CAHiYmc44B4e1PZXoyhBGy_AizLbbOrScPg2w=tZT1OPsnVcuUA@mail.gmail.com>
Subject: Re: [PATCH V3 02/14] KVM: MIPS: Fix VPN2_MASK definition for variable
 cpu_vmbits
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
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
 stable@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-mips@vger.kernel.org,
 Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:07 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> From: Xing Li <lixing@loongson.cn>
>
> If a CPU support more than 32bit vmbits (which is true for 64bit CPUs),
> VPN2_MASK set to fixed 0xffffe000 will lead to a wrong EntryHi in some
> functions such as _kvm_mips_host_tlb_inv().
>
> The cpu_vmbits definition of 32bit CPU in cpu-features.h is 31, so we
> still use the old definition.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xing Li <lixing@loongson.cn>
> [Huacai: Improve commit messages]
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/kvm_host.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm=
_host.h
> index a01cee9..caa2b936 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -274,7 +274,11 @@ enum emulation_result {
>  #define MIPS3_PG_SHIFT         6
>  #define MIPS3_PG_FRAME         0x3fffffc0
>
> +#if defined(CONFIG_64BIT)
> +#define VPN2_MASK              GENMASK(cpu_vmbits - 1, 13)
> +#else
>  #define VPN2_MASK              0xffffe000
> +#endif
>  #define KVM_ENTRYHI_ASID       cpu_asid_mask(&boot_cpu_data)
>  #define TLB_IS_GLOBAL(x)       ((x).tlb_lo[0] & (x).tlb_lo[1] & ENTRYLO_=
G)
>  #define TLB_VPN2(x)            ((x).tlb_hi & VPN2_MASK)
> --
> 2.7.0
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

