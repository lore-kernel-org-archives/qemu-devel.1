Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3222EC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 18:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004E820716
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Fb3kBtlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004E820716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibTsd-0006ko-3S
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 13:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1ibTrn-0006IF-Jp
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1ibTrl-0005Ug-Mo
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:22:42 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:44006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1ibTrl-0005QS-Ai
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:22:41 -0500
Received: by mail-yb1-xb41.google.com with SMTP id r201so13559127ybc.10
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8QfZ+VHkLC681gwzKj8avS3dfY0eBHB1p3xC65/UmSc=;
 b=Fb3kBtlE9T28qq8Bf/8WsORm8lN7AxUrAHoyKWMEnm8lWPY7uCjhjrCMQ95yGMBzfu
 pLyr9rZfTUDqxjm6+sbVuoY1t5lIMyQg7horjItb7Vh1Zd/PzAIQkZow/xPbROC3x0GB
 dU0mIs+vmkhXyPjrgS9ImC5rW/7cTAcHeQQbQZCD+/SVAZyt75jDlgqCwApN3yrp9dyb
 1t0P9z+pAvr90RdmPnR7xZkiYB+VNJ8M6U7243/VxEq/6pymqz3e5NoBLlgUIlF7x8FI
 8Vn6RtglfAIPpKtrFszyGW2FNua14GqzTlGuo5FycD/uF2glJs2rnEGC2mxB/PHjFfFm
 3tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=8QfZ+VHkLC681gwzKj8avS3dfY0eBHB1p3xC65/UmSc=;
 b=Y2MFYim/jEuktW7pbDE5oxuJC7Zik//W552qJpB/w71JWebhhqgzhGeY7AeZ+Prd8v
 r0ud3gAIl32uicu0bRnvXIUqzMcd7t7BxAVCL+CarQhEkbumYzXWqyEfdlgt/V9vAJBj
 a6j2yimGsVvQDDr16loNIoNSEMlDZCVu9RkX8ETj0d5l4zZE+u1wtA3PKj9XBhZ1PcB7
 F1uIOZTfebjP+05wcZhnOoI+TJjH513XvzsK3EmUn+aDcAsMK8lkxuVMTHtchcZCriN+
 zYws7hJd5Ynl9Yae1xqu6vHIHeyqPABECpgWJSEc3D/OeAZGVDs0U/cj2V8H0eobmcxW
 6ieg==
X-Gm-Message-State: APjAAAXBGD8xN3KdVPatYCFacMrOfczFfjPya5SiRf6t3qL9nFna/ZRR
 WsEXL2GWQyTHYqdQ1rljwOll2w==
X-Google-Smtp-Source: APXvYqxWFmMq4GshjCSrjn9b5LMXEXxcowrR++cJ+zv7mfYmKEIUi1THVsmAP59Lx/POeRqF0jrBMA==
X-Received: by 2002:a25:6789:: with SMTP id
 b131mr48651468ybc.429.1575224557888; 
 Sun, 01 Dec 2019 10:22:37 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id m16sm8138621ywa.90.2019.12.01.10.22.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 01 Dec 2019 10:22:36 -0800 (PST)
Date: Sun, 1 Dec 2019 12:22:34 -0600
From: Corey Minyard <cminyard@mvista.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 11/21] hw/ipmi: Fix latent realize() error handling bugs
Message-ID: <20191201182234.GA18195@minyard.net>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-12-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130194240.10517-12-armbru@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Reply-To: cminyard@mvista.com
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 30, 2019 at 08:42:30PM +0100, Markus Armbruster wrote:
> isa_ipmi_bt_realize(), ipmi_isa_realize(), pci_ipmi_bt_realize(), and
> pci_ipmi_kcs_realize() crash when IPMIInterfaceClass method init()
> fails and their @errp argument is null.  First messed up in commit
> 0719029c47 "ipmi: Add an ISA KCS low-level interface", then imitated
> in commit a9b74079cb "ipmi: Add a BT low-level interface" and commit
> 12f983c6aa "ipmi: Add PCI IPMI interfaces".
> 
> The bug can't bite as no caller actually passes null, and none of the
> init() methods can actually fail.  Fix it anyway.

Well, whatever.  It looks correct and is better style.  I've added this
to my tree.

-corey

> 
> Cc: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ipmi/isa_ipmi_bt.c  | 7 +++++--
>  hw/ipmi/isa_ipmi_kcs.c | 7 +++++--
>  hw/ipmi/pci_ipmi_bt.c  | 6 ++++--
>  hw/ipmi/pci_ipmi_kcs.c | 6 ++++--
>  4 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index 9a87ffd3f0..9fba5ed383 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -70,6 +70,7 @@ static void isa_ipmi_bt_lower_irq(IPMIBT *ib)
>  
>  static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
>  {
> +    Error *err = NULL;
>      ISADevice *isadev = ISA_DEVICE(dev);
>      ISAIPMIBTDevice *iib = ISA_IPMI_BT(dev);
>      IPMIInterface *ii = IPMI_INTERFACE(dev);
> @@ -85,9 +86,11 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
>      iib->bt.bmc->intf = ii;
>      iib->bt.opaque = iib;
>  
> -    iic->init(ii, 0, errp);
> -    if (*errp)
> +    iic->init(ii, 0, &err);
> +    if (err) {
> +        error_propagate(errp, err);
>          return;
> +    }
>  
>      if (iib->isairq > 0) {
>          isa_init_irq(isadev, &iib->irq, iib->isairq);
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index ca3ea36a3f..cc6bd817f2 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -69,6 +69,7 @@ static void isa_ipmi_kcs_lower_irq(IPMIKCS *ik)
>  
>  static void ipmi_isa_realize(DeviceState *dev, Error **errp)
>  {
> +    Error *err = NULL;
>      ISADevice *isadev = ISA_DEVICE(dev);
>      ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(dev);
>      IPMIInterface *ii = IPMI_INTERFACE(dev);
> @@ -84,9 +85,11 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
>      iik->kcs.bmc->intf = ii;
>      iik->kcs.opaque = iik;
>  
> -    iic->init(ii, 0, errp);
> -    if (*errp)
> +    iic->init(ii, 0, &err);
> +    if (err) {
> +        error_propagate(errp, err);
>          return;
> +    }
>  
>      if (iik->isairq > 0) {
>          isa_init_irq(isadev, &iik->irq, iik->isairq);
> diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
> index 6ed925a665..ba9cf016b5 100644
> --- a/hw/ipmi/pci_ipmi_bt.c
> +++ b/hw/ipmi/pci_ipmi_bt.c
> @@ -54,6 +54,7 @@ static void pci_ipmi_lower_irq(IPMIBT *ik)
>  
>  static void pci_ipmi_bt_realize(PCIDevice *pd, Error **errp)
>  {
> +    Error *err = NULL;
>      PCIIPMIBTDevice *pik = PCI_IPMI_BT(pd);
>      IPMIInterface *ii = IPMI_INTERFACE(pd);
>      IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
> @@ -74,8 +75,9 @@ static void pci_ipmi_bt_realize(PCIDevice *pd, Error **errp)
>      pik->bt.raise_irq = pci_ipmi_raise_irq;
>      pik->bt.lower_irq = pci_ipmi_lower_irq;
>  
> -    iic->init(ii, 8, errp);
> -    if (*errp) {
> +    iic->init(ii, 8, &err);
> +    if (err) {
> +        error_propagate(errp, err);
>          return;
>      }
>      pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->bt.io);
> diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
> index eeba63baa4..99f46152f4 100644
> --- a/hw/ipmi/pci_ipmi_kcs.c
> +++ b/hw/ipmi/pci_ipmi_kcs.c
> @@ -54,6 +54,7 @@ static void pci_ipmi_lower_irq(IPMIKCS *ik)
>  
>  static void pci_ipmi_kcs_realize(PCIDevice *pd, Error **errp)
>  {
> +    Error *err = NULL;
>      PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(pd);
>      IPMIInterface *ii = IPMI_INTERFACE(pd);
>      IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
> @@ -74,8 +75,9 @@ static void pci_ipmi_kcs_realize(PCIDevice *pd, Error **errp)
>      pik->kcs.raise_irq = pci_ipmi_raise_irq;
>      pik->kcs.lower_irq = pci_ipmi_lower_irq;
>  
> -    iic->init(ii, 8, errp);
> -    if (*errp) {
> +    iic->init(ii, 8, &err);
> +    if (err) {
> +        error_propagate(errp, err);
>          return;
>      }
>      pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->kcs.io);
> -- 
> 2.21.0
> 

