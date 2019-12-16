Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62825C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D98B20684
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WewY0kIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D98B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igqEU-0006Jq-9B
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igqAJ-00025m-Nc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igqAI-0007EX-Ja
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igqAI-0007DV-Fw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576501918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IPkGhoQaMyuuMxfZ22vfywDxIiWsIX0Gx3A5XKdmDs=;
 b=WewY0kIl/P9l4Lj/x3E2GSNO2xDB2/UH6EpjZ0HIiIar0xCLE9+sCh3WHIDp8HgLDgKkgC
 KW/OwQ090UZNkK8eKtld5U/32hnwK7HBoZu38ALVT8ldrrvbpTr8nABLa7ueq8hXJNFh+5
 uaVF+duGEOYFigwi7rBJvTzU7ljD40Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-btBGIdTLM6Ox-UcA2IjEgg-1; Mon, 16 Dec 2019 08:11:56 -0500
Received: by mail-wm1-f69.google.com with SMTP id g26so1004636wmk.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OVZ8qCkz+iSuAIxbiMtdabWP4u3zkLCvZUfHLBEZANg=;
 b=fA4rIlbfB6sJ5vcAG97pJGkaiMBnbRwz8I+c3Tf84YFija9yfls15awGKTwcagnapL
 EM90skFUiO4dIKb55fEcYXObEdmMnyKitmqGa36EVHS9gI5SwQtxUc/iHe752MajGPR9
 EmaRKZa4YhS79XinpIfnZ6v4zSd6mcdPaAC8vGe/Rsubg7I6e1q4B5rJusRHGqFXD+P4
 IxwhrRq4H1E0TSySJaaGkF6ob15bXLXYI3PG+Hh6E/GXnXsps4Ave1A7h2xModvJZ8s4
 9W/moTo4BW2pFxMWjP/wkW/BeWQ+b+o+v+6QMxBzim/aIlrAtqXq7YN4Htae1uMoxh0X
 LfLg==
X-Gm-Message-State: APjAAAWr3pja9PprYWBpYJgKTpluk/pkrBHzlsYlCCS2HOMLljOn/Yyb
 3MNEvVdhaU/5mLa5uYUm0kABSpJ57x0u5E+fqdORsWEHJB1QW5+J88zLShqbUhxgeKGmzd+jDNZ
 F6+ET+6XnXV1AEwQ=
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr29515763wrm.210.1576501915281; 
 Mon, 16 Dec 2019 05:11:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2vtXsGXckWOealAxKsd8xz8B6EZdGgNEAj2cPIngxIU6E4STQELcYok94Tp665k14zzg/Fg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr29515741wrm.210.1576501915086; 
 Mon, 16 Dec 2019 05:11:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81?
 ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
 by smtp.gmail.com with ESMTPSA id o16sm6585832wmc.18.2019.12.16.05.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:11:54 -0800 (PST)
Subject: Re: [PATCH 09/12] hw/intc/ioapic: Make ioapic_print_redtbl() static
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-10-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <340e7a8b-b7c6-3f61-3646-c311c7c33f60@redhat.com>
Date: Mon, 16 Dec 2019 14:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213161753.8051-10-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: btBGIdTLM6Ox-UcA2IjEgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 17:17, Philippe Mathieu-Daud=C3=A9 wrote:
> Since commit 0c8465440 the ioapic_print_redtbl() function is not
> used outside of ioapic_common.c, make it static, and remove its
> prototype declaration in "ioapic_internal.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/i386/ioapic_internal.h | 1 -
>  hw/intc/ioapic_common.c           | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
> index d46c87c510..8b743aeed0 100644
> --- a/include/hw/i386/ioapic_internal.h
> +++ b/include/hw/i386/ioapic_internal.h
> @@ -118,7 +118,6 @@ struct IOAPICCommonState {
> =20
>  void ioapic_reset_common(DeviceState *dev);
> =20
> -void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s);
>  void ioapic_stat_update_irq(IOAPICCommonState *s, int irq, int level);
> =20
>  #endif /* QEMU_IOAPIC_INTERNAL_H */
> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> index 5538b5b86e..72ea945377 100644
> --- a/hw/intc/ioapic_common.c
> +++ b/hw/intc/ioapic_common.c
> @@ -76,7 +76,7 @@ static void ioapic_irr_dump(Monitor *mon, const char *n=
ame, uint32_t bitmap)
>      monitor_printf(mon, "\n");
>  }
> =20
> -void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
> +static void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
>  {
>      static const char *delm_str[] =3D {
>          "fixed", "lowest", "SMI", "...", "NMI", "INIT", "...", "extINT"}=
;
>=20

Queued, thanks.

Paolo


