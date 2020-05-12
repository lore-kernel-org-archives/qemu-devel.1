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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF803C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F11A206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEMIAQc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F11A206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUVY-0004xi-JE
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYUUA-0003PP-B2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:58:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYUU9-0005kX-Go
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:58:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id g12so23142378wmh.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UKwQtQFEKMdeQDcDu5410keHN8eT2IIs4GaOSIngBgc=;
 b=QEMIAQc8+uscNWMlPkiPiMugwoPOovFNh3paihydMY8Xb415cqGlhF5prsyOpUyej+
 jgk5wF0OzRvQWKun8rqDKTfKQZnBMmFrEFszag0FwrBH2N0p9hPPATYcUCNKREEeyu5K
 +1AOVlqxeQd9c1opVfEy4fDmGWDzbszpVvcuIXaV5drbUcSOGkVH7Fqy5+gwA50bY4do
 RMVlOIXddkiNKVNgmlYxw5DtfXvS35UE2jg6xQoTjYdP1FzEjndM3DJ3M2klV5cIBoKW
 3+irFEIMO8MLUTeRqXFAN89BC9XOsUnMg+P78m3AOVuj5Z8vhAMmaFwQHW9m/tMZlc8Q
 6Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UKwQtQFEKMdeQDcDu5410keHN8eT2IIs4GaOSIngBgc=;
 b=sr2uvBJNRzv/zTT1RoKS0LntQn2FFrdEarXi9xRYlCqhv7Io+oFiub9JO6vD0q+Uy7
 KCka1+yJt+EZAMM3U6ss8JdM6NY2201KTcVru2JezZlLbnt0wEP03fY9AaoPjxB0NLz0
 gS+iB6HL4s96bFef+h1w2F2Z93Y9zvMIf0Loz+QT9YqjVjVNrgQokz67ry/hLa45anet
 AZSvrp4ehpUBiB7ut3aJ0L2ywsFODHImW2gqBlkPkUkLKiV98oILyCsPNFq5UhV1YwJg
 czE9HWtyDG5IceEAZF5/PaffoIM/+Ic7vOieEyLRznMyEE8ZsnMb36Wff9iRn/9lk3LT
 a4qg==
X-Gm-Message-State: AGi0PubTtRM1ed/afjrH3HMPLVWysy+5oU6+wIvyvI4EPce4dXpTMxjE
 Vj3Zu+mZgV8f26biqBQHNfdX+DEynWLQWp5RlcM=
X-Google-Smtp-Source: APiQypLTqWzHjjQm7sRhp0w7vSKcbnjUw7fDQ1Fun9b9Mumv9IOOhC7wfEcb99c8ZLuOxpzgqr2Nqm6xFT6F4ntYJYg=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr40544027wmc.168.1589288291992; 
 Tue, 12 May 2020 05:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <1588501221-1205-4-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-4-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 12 May 2020 14:57:55 +0200
Message-ID: <CAHiYmc6W0o15RLjWRE4mi6+9OqRLLTh0N+rpC+yZLVX_UZW=HQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:24 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
> IP3 delivery as well, because Loongson-3 based machine use both IRQ2
> (CPU's IP2) and IRQ3 (CPU's IP3).
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

>  hw/mips/mips_int.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 796730b..982ce34 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -48,14 +48,14 @@ static void cpu_mips_irq_request(void *opaque, int ir=
q, int level)
>      if (level) {
>          env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
>
> -        if (kvm_enabled() && irq =3D=3D 2) {
> +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3)) {
>              kvm_mips_set_interrupt(cpu, irq, level);
>          }
>
>      } else {
>          env->CP0_Cause &=3D ~(1 << (irq + CP0Ca_IP));
>
> -        if (kvm_enabled() && irq =3D=3D 2) {
> +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3)) {
>              kvm_mips_set_interrupt(cpu, irq, level);
>          }
>      }
> --
> 2.7.0
>

