Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97148C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68673208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDqC8CKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68673208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50478 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJjI-0000Jg-Mv
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZIBe-0005Mn-S5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZIBc-0003uX-6h
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:57:54 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZIBb-0003m5-Us
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:57:52 -0400
Received: by mail-oi1-x241.google.com with SMTP id u64so1927793oib.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Cc0V5G2vFzypZ6DB/lLF9Bomy2PB9osiiYWSyLpUsfE=;
 b=sDqC8CKV8PCq4GZv8LpWWulPoXUoxPnJaQy8qtEfaHLV1GGIehAPGZ26bcBWuhtNMq
 4MU8nJVmeLDIlRUodySjf61auwr4UTIZdg2fHMdkr8io50Q6Hd7Umj8JFiPJGgN5d+b8
 8RGvJOn6Qi0hoto9V2eUxfcRchwp9OV55DAZR4XVNuewtSIZ9jQgg7URfkUIbgsb1cuM
 0OVACx9v1h6QmPUbSK10Lky3qwTw9xKH7e8ofgjBC+z2+xxL4y+c7M/0/yHpzFxphmU3
 bUIAZ6rGwRYGDVChxwyDFxj1KFUjzyPKHmClchcqLemdlodrbPuQXj68g4qG3KItoqZ/
 oNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Cc0V5G2vFzypZ6DB/lLF9Bomy2PB9osiiYWSyLpUsfE=;
 b=qtWvdMSxYLAZRpEVpCn139TqH//CcYPHTk2tL7bZaU12gc+0yhioKHxOFz3S7HOwON
 1gDlVga2Gc2Uv4kAQbl9v2EMEopU+TTrzZGtkPADK4bXfkYQnNH5OSbXcEiuQP1iEN9D
 oK+oJhkGr20sNwcEHCbQ7PTrtfaZzFfsCIo4T2jflaNYQQ2IgDb8NodrvA+3hiZpzXLM
 ubj6gX3PMS0ByL97q6FLzBmWLtzN4gurMPuwjO0z0VahLGlgwt1W2dRB/9AtE+dgFaWw
 ML6nYioO7sPE+uneWUx0bPnZjg4/1xy8gC2G6q7To2Wp4IrH/2O7aEpbRO9uU/1WXHed
 /bPQ==
X-Gm-Message-State: APjAAAW/n1GAPQLNzN6l1pHyYfVV4+e0Hwe0By1+T90LBoU7oIg0KjJX
 +uHDpXqNEyDgt/B8esoOo+hfPiPEWIKcRDesY5Rj2A==
X-Google-Smtp-Source: APXvYqx2yWUy3lvDLBZ/HophXAsp84nCNpG62D+47llQcCepVD0KjqTWQrcEbpM2yaD4iOEk07d9Mv/j0T3h5RHX5tw=
X-Received: by 2002:aca:c786:: with SMTP id x128mr4250484oif.146.1559926665962; 
 Fri, 07 Jun 2019 09:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190607153725.18055-1-philmd@redhat.com>
 <20190607153725.18055-29-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-29-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 17:57:34 +0100
Message-ID: <CAFEAcA-a=E2gD787dn8aW=_fZ47bXjNOBgNE5UH_QvQb=WnSvQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v18 28/29] hw/rx: Fix comments
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 17:52, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/rx/rx-virt.c | 2 +-
>  hw/rx/rx62n.c   | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
> index 49d04d22ea..53f43f62bd 100644
> --- a/hw/rx/rx-virt.c
> +++ b/hw/rx/rx-virt.c
> @@ -55,7 +55,7 @@ static void rxvirt_init(MachineState *machine)
>                             &error_fatal);
>      memory_region_add_subregion(sysmem, SDRAM_BASE, sdram);
>
> -    /* Initalize CPU */
> +    /* Initalize MCU */

typo: "Initialize" (extra 'i').

>
> +    /* Initalize CPU */
>      object_initialize_child(OBJECT(s), "cpu", &s->cpu,
>                              sizeof(RXCPU), RX_CPU_TYPE_NAME("rx62n"),
>                              errp, NULL);

ditto.

thanks
-- PMM

