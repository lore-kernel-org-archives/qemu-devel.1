Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D9C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1352084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiRgYQl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1352084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqOu-0007OD-8H
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 03:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hlqOk-0006wH-Fy
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hlqOj-0001f2-Gu
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:55:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hlqOj-0001eQ-2I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:55:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id x4so8896402wrt.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5KxKAEwho4J/ZngTh1mES1M/ojCXrTU9e6+TtoYyVb8=;
 b=OiRgYQl5X9qreDA49pRTac2PxR5llIO4blV3FGNLiwywJMYrM67ocLtymhUhqxvSpy
 Lb9m5ApMkZ/Ij2yX416J1a1e4oEX1sB+Vpd03EdM5JCpkpePrloceLXr0AlWzfS93ZVO
 2EIytLLAle9rvylYBcjIEUB14y0qZaDIN/GOIfUk5l9sAbf6TpO0SJiwxdQrHZzSNGaz
 cycJA27AmRsavfjoNox/psuJUaUrh510mCGWBD2p1jKjQX61c9YabndjfprzG4r3V9u9
 T3OzuZcz2oHSGfpYZwBjPlrvoF+YyXIFkGJjioW3xPwsGaCo0h/uwG2vKKZoFrO/Zs61
 j8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5KxKAEwho4J/ZngTh1mES1M/ojCXrTU9e6+TtoYyVb8=;
 b=S86iinPNpLJA7VrCdNTGDh0OcDdrSmVfA+Avp0Wf2mVKo0k/o9JquXOhlFa1VLKGuY
 dgBwzzi3IwEiq5fCyynIEG4ho6E/LSZQwsbdnB3Eh+YwKPI5YMLGZ6jElAsQuoc6/3PR
 PFsLiUP2fhSTdrnQIHTPIDkkGgsh0TLwvpiKTJuZbY04EeyCX9QZJpCa5JFfxu5ZJT1v
 AZeYL1YqwEeBQAjezMcFf0HsbMJblI75GnELp5eudXUKYAQfBKLyZC0OYoabd7TBUa1/
 kXAu2CKxMMJBooT0BoRiiXRzmtV5nXx6+InSodanKRBSoziNL9paydRP61Xzg8pPGT+4
 +hOA==
X-Gm-Message-State: APjAAAXrvwEEMcyGx7wx6/k/Jy/8pdLyipSnJURAlOR3Q1COa4U8alwt
 7JWB/kPiH+zUGi2uFSHruhtegghz
X-Google-Smtp-Source: APXvYqzcylkhrncvSQE+tJGJRdXK4bs5msh72avr4fgOUaMmVw6LlWfcBoOW10SCjfPrCCSCZ5Dbxg==
X-Received: by 2002:adf:f186:: with SMTP id h6mr9798954wro.274.1562918115642; 
 Fri, 12 Jul 2019 00:55:15 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id f17sm7088375wmf.27.2019.07.12.00.55.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 00:55:15 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190711192512.31936-1-mst@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <31f0357b-7117-45e8-230e-d13f326b202c@gmail.com>
Date: Fri, 12 Jul 2019 10:55:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190711192512.31936-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] xio3130_downstream: typo fix
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/11/19 10:25 PM, Michael S. Tsirkin wrote:
> slt ctl/status are passed in incorrect order.
> Fix this up.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/pci-bridge/xio3130_downstream.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 899b0fd6c9..182e164f74 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -43,7 +43,7 @@ static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>   {
>       uint16_t slt_ctl, slt_sta;
>   
> -    pcie_cap_slot_get(d, &slt_sta, &slt_ctl);
> +    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
>       pci_bridge_write_config(d, address, val, len);
>       pcie_cap_flr_write_config(d, address, val, len);
>       pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

