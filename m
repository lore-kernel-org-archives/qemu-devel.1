Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CFE2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Makr/dWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CFE2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqiE-0006XO-Hx
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iMqhC-0005iX-Mf
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iMqhB-00021a-Kn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:43:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iMqhB-00021L-Eg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:43:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id a11so1171064wra.6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=bOO11wkg+2Pv2o27r/wTAOCc87SP9Q0u1nKIfbm7dc4=;
 b=Makr/dWtTrYdoqQAsMav8Vn9ebRf0GuVi0GlHq/CdPrEY7lPLP9o3hZzx+bM/c6od6
 lPNAcNXGHk6xc+eyl9pZuOFNtAsYSJF56xBE6l8wH8I+l5QPhoX3dzcg3znn0vfyHB5o
 gZePOcNqjyibY+fQktOvYeZRqHlGEODv0Jkzck6D+WO4wR7rJlSMZbFXKCFMkeqzgoqX
 sjp2Rf4vp5mB4rb03fR439sbTc21fR3mNolz9hE8oXNFgsz3M2gJorJNekSTm4bl7uos
 LSmgG/sUepd4aRnHEAftEiY8wv1ZJnCyOkpn7B1wVHyXG3m9DUdkKezwO39OiD5cJn3C
 U/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=bOO11wkg+2Pv2o27r/wTAOCc87SP9Q0u1nKIfbm7dc4=;
 b=mjbka24ZsCcokgk3mrr4dn/2C5Vxt5oLyyrP9atYIOZqlUAoLvZk3SVC+XvaoHIpAQ
 Li/xacIZ2pGUjr1ZkP08n71gi9+JWVsVxeCwiDi3OG6SNnIsM7KUdbZzzFYRZjbD+D30
 TjTxO4aqEg0EVGcl08mpmMn76p7EoMbhzOljQ+H/vwDydNUEOaRwWZNOJ3NfcETrfLQF
 5onrKH3mNvvzZA48nb5R3E02RrgK9u3D00dl6MlrJkvpRUe+zMAoWHLhQzAPOKZ7oonu
 zSjt7kWmJLz0gK08zPiZIHb9JO0Ih6RMkls1mnu1YKpKhRpgnCWC7qbDZAv2oiKDC2i9
 JMWA==
X-Gm-Message-State: APjAAAWxnQZsDqOQY3s3xIwtMicJe0r+a5YTwJ1qhCTNOlXCsFqsZjjj
 GsCQr3/foArBTfEKP5nm7E4=
X-Google-Smtp-Source: APXvYqxXLI5hVIo27IDWpEbmDG0UYH133w1mDm61eRNBrGPJ00fgYopAm7GZ0y/Rb1XxYHR9ffEDug==
X-Received: by 2002:a5d:498e:: with SMTP id r14mr2444844wrq.36.1571737396409; 
 Tue, 22 Oct 2019 02:43:16 -0700 (PDT)
Received: from ?IPv6:2a01:c23:604c:2a00:af2b:2e92:39f9:c05b?
 ([2a01:c23:604c:2a00:af2b:2e92:39f9:c05b])
 by smtp.gmail.com with ESMTPSA id p12sm5101204wrt.7.2019.10.22.02.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 02:43:15 -0700 (PDT)
Message-ID: <6289a119c4be0dcae17eecb6176acdd387206b02.camel@gmail.com>
Subject: Re: [PATCH v2 17/20] hw/pci-host/piix: Fix code style issues
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org
Date: Tue, 22 Oct 2019 11:39:44 +0200
In-Reply-To: <20191018134754.16362-18-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-18-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daudé escribió:
> We will move this code, fix its style first.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/pci-host/piix.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 95b04122fa..1544c4726b 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -133,9 +133,10 @@ static PCIINTxRoute
> piix3_route_intx_pin_to_irq(void *opaque, int pci_intx);
>  static void piix3_write_config_xen(PCIDevice *dev,
>                                 uint32_t address, uint32_t val, int
> len);
>  
> -/* return the global irq number corresponding to a given device irq
> -   pin. We could also use the bus number to have a more precise
> -   mapping. */
> +/*
> + * Return the global irq number corresponding to a given device irq
> + * pin. We could also use the bus number to have a more precise
> mapping.
> + */
>  static int pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
>  {
>      int slot_addend;
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


