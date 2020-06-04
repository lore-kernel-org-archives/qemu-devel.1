Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D834C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F5D206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DePSPU/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F5D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoHJ-0004IP-Ag
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoFZ-0002SA-Kd
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:41:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoFX-0004Vn-Dn
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591270889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SG+hBvXP6e9Y6/LrKmefUDXkEF9JFsqTDvpq8V98864=;
 b=DePSPU/YnYyHTNrsahc5JmfhvWrAhS/D8QzABH6sZFip5AKBN4Blty9umjSvfwjuKah48Q
 q6evFHMkCe0lMWnLGRj0VqtsElfzU6kfLomt1d9866uZSKxHkqBvShUEAkymD0IRVgMem+
 IWT4OpLvFf5sgDyvnvyrG6DXkM0fO58=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-FkEMjKPJODiPWMCpYxzppw-1; Thu, 04 Jun 2020 07:41:27 -0400
X-MC-Unique: FkEMjKPJODiPWMCpYxzppw-1
Received: by mail-wr1-f70.google.com with SMTP id t5so2310685wro.20
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7lFGsZLk7z0NMynbSrbY7KEmq9EyQqcAVBnn/b0Nyd8=;
 b=nRqh8jBonigZtdfQAqq1llsUbqyBB4cu91GftHE1icu6LBR7uokHC4HuGsHeBaZh6p
 8vcv4pGLdmOnt7WN0uwp+HQRsd/GmvTl/3GFIHsVcMmYzhlQTz7CiaGEl+79UQcNxzLs
 SMPmHaEVmFe7gTkftrnEVxJ8LmUsECNXv3YcRhAFqYrM9xlDhTVhyw2Ov1qZBedyIV1E
 DcmtA0bkaW3Axgl4asPDAms0S6qCmNjZOEC4rkESoHZjOQioRbQ2aZbLT+sx7FvUaepG
 wCEpP4rBgi6ArGy7WBWsmQZup/sYPC6VmGF+HSVbs/j20a+8Ith6RKA9J9zkyvfC+LC2
 MmYA==
X-Gm-Message-State: AOAM531aeZDvvijT3Qr9PArlZJ90DPg2wW5q1RcJGoFMh3GzHu61Azmo
 PCcQXt1blPSt0iL7xHJ3t94B64nlK3flF8z4YgyiluenQgKiaBzAX3RUgTeo6Wp0U7jZdo488Y5
 Txtd82X2J6TOVDak=
X-Received: by 2002:a5d:5261:: with SMTP id l1mr4169247wrc.246.1591270886596; 
 Thu, 04 Jun 2020 04:41:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZC2n2y2mjz3WFS/a9SJXabW78Tsd9MEbWeeV3m7b87x0lSGJFgQBpWyKtxjNUqyRwsFoapg==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr4169222wrc.246.1591270886415; 
 Thu, 04 Jun 2020 04:41:26 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id b8sm7392683wrm.35.2020.06.04.04.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:41:25 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:41:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] pci: assert configuration access is within bounds
Message-ID: <20200604074050-mutt-send-email-mst@kernel.org>
References: <20200604113525.58898-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604113525.58898-1-ppandit@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 05:05:25PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While accessing PCI configuration bytes, assert that
> 'address + len' is within PCI configuration space.
> 
> Generally it is within bounds. This is more of a defensive
> assert, in case a buggy device was to send 'address' which
> may go out of bounds.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Update v1: defensive assert as separate patch
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00957.html
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00960.html
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..7bf2ae6d92 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
>  {
>      uint32_t val = 0;
>  
> +    assert(address + len <= pci_config_size(d));
> +
>      if (pci_is_express_downstream_port(d) &&
>          ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
>          pcie_sync_bridge_lnk(d);
> @@ -1394,6 +1396,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>      int i, was_irq_disabled = pci_irq_disabled(d);
>      uint32_t val = val_in;
>  
> +    assert(addr + l <= pci_config_size(d));
> +
>      for (i = 0; i < l; val >>= 8, ++i) {
>          uint8_t wmask = d->wmask[addr + i];
>          uint8_t w1cmask = d->w1cmask[addr + i];
> -- 
> 2.26.2


