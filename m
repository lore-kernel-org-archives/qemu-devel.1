Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B2AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0A020702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFRMJ6NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0A020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnq3J-00073E-7F
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnpy4-0006gQ-8M
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:56:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnpy2-0004MR-FX
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592945789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MlJoVmOdUKhj9POKBV8MHsQyod8nMw31OAsxNPmC4E=;
 b=jFRMJ6NVtZYhWAvD5A511WsAQZaokrjzTO3i0gZIcs5VYVNShRQXepXPm3IcfKfMQq8RlG
 Yi4y8aXf54Y2CdBfeklZS1oavyn9uMUqB5KCZW5r6q32jLpGapwA+EPB4MtxPSQrgT+1jZ
 jurAIzeRrCWuu3ng9fpTDEUQB3bqcBc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-zwiradJfNsqn7heO70JgVA-1; Tue, 23 Jun 2020 16:56:23 -0400
X-MC-Unique: zwiradJfNsqn7heO70JgVA-1
Received: by mail-wm1-f72.google.com with SMTP id h6so23383wmb.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 13:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6MlJoVmOdUKhj9POKBV8MHsQyod8nMw31OAsxNPmC4E=;
 b=KCM+3kC1QRgZv37k5tnD/bU+3nii+NpeK/TZiRRTmlz2M+3ip5HKXbkFnw1MSw96g3
 ITG3+pC4tNPnffemEjmI9nYMhJY7TjCMMYmyKlmSFNWB7NEbHKs5hlkVnBg1QCmasQGT
 /Xb9773w00X4DBoj6VVpCITAmdSluouK4DxFRx7/BcK8SiSZXf2bqh++3rHXW9OESbe3
 1I1sgIZLh5o+I4z7R9OdvjAytUaMY0rIT0Hfq+gXCSNtQ9pY0+k3goITwhqFFr5g0waP
 cTw/v+Rt2kRJ+RX2sgbwYcA4SOLwevuZ5Mti/BfRBErskVT0huHs4H68CriKATeRJWfC
 Yfdw==
X-Gm-Message-State: AOAM5328YnN+LFKQF2uHY1UdLZq3Nzo0LnkOvJUuBlAI7kGc5DXHLxXJ
 JRA8ryRnlmCC5gzDqAw648ydYkmaLNyBAkPCF8hm46FbPRZ9JzoYKacHPcU5bBOuGxq+ApggnxB
 vkiKJjvio9OWh9K4=
X-Received: by 2002:a05:6000:100c:: with SMTP id
 a12mr14891334wrx.81.1592945782697; 
 Tue, 23 Jun 2020 13:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCWUJjzJ2ePq3q9mGHfj8LQ6iGfIOXG6KS4KonCOJynihqBA2rPEtsVh8Gx3wd3rfkqb7oaA==
X-Received: by 2002:a05:6000:100c:: with SMTP id
 a12mr14891005wrx.81.1592945777572; 
 Tue, 23 Jun 2020 13:56:17 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 p13sm13711098wrn.0.2020.06.23.13.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 13:56:17 -0700 (PDT)
Date: Tue, 23 Jun 2020 16:56:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] libqos: usb-hcd-ehci: use 32-bit write for config register
Message-ID: <20200623165556-mutt-send-email-mst@kernel.org>
References: <20200623161852.19477-2-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623161852.19477-2-pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 12:18:52PM -0400, Paolo Bonzini wrote:
> The memory region ops have min_access_size == 4 so obey it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Makes sense.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I assume you are queueing this with the memory core change.

> ---
>  tests/qtest/usb-hcd-ehci-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
> index 5251d539e9..c51e8bb223 100644
> --- a/tests/qtest/usb-hcd-ehci-test.c
> +++ b/tests/qtest/usb-hcd-ehci-test.c
> @@ -96,7 +96,7 @@ static void pci_ehci_port_1(void)
>  static void pci_ehci_config(void)
>  {
>      /* hands over all ports from companion uhci to ehci */
> -    qpci_io_writew(ehci1.dev, ehci1.bar, 0x60, 1);
> +    qpci_io_writel(ehci1.dev, ehci1.bar, 0x60, 1);
>  }
>  
>  static void pci_uhci_port_2(void)
> -- 
> 2.26.2


