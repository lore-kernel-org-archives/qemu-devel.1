Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E162C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F892245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrUQ068N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F892245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id5j1-0007hT-K6
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1id5i2-0007HC-M6
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 23:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1id5hy-00030q-Gy
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 23:59:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1id5hx-0002tq-GD
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 23:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575608352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QPjLWPI/hdWo6bQrg/TI5tjPZ9/Ne2JsC/zMzNrc9B4=;
 b=KrUQ068NodnOrJiRZLd+hUaWCph1uidMsvDpp47RTIO5hzFL3b2J+8Z+aidX4RZyyOWrUP
 5/Qv3KoOb8eWFpbtaNyLkKOkPEAwTbbikcn5JFEeB48hM7rcZBd//YquWJkzQLXhP35Kxr
 MySTbKMZXsk13n15y/ke4HnZrUt13Dk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-1cuVvn3IOhSr28IXPvoPUQ-1; Thu, 05 Dec 2019 23:59:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3E198017DF
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 04:59:09 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-97.ams2.redhat.com [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63AB110016E8;
 Fri,  6 Dec 2019 04:59:09 +0000 (UTC)
Subject: Re: [PATCH] hw/misc/ivshmem: Bury dead legacy INTx code
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191205203557.11254-1-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b7f1090c-9b7c-933d-1f11-74c9e23f2db1@redhat.com>
Date: Fri, 6 Dec 2019 05:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205203557.11254-1-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 1cuVvn3IOhSr28IXPvoPUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/12/2019 21.35, Markus Armbruster wrote:
> Devices "ivshmem-plain" and "ivshmem-doorbell" support only MSI-X.
> Config space register Interrupt Pin is zero.  Device "ivshmem"
> additionally supported legacy INTx, but it was removed in commit
> 5a0e75f0a9 "hw/misc/ivshmem: Remove deprecated "ivshmem" legacy
> device".  The commit left ivshmem_update_irq() behind.  Since the
> Interrupt Pin register is zero, the function does nothing.  Remove it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/misc/ivshmem.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 5e3b05eae0..710cdb7263 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -136,44 +136,11 @@ static inline bool ivshmem_is_master(IVShmemState *s)
>      return s->master == ON_OFF_AUTO_ON;
>  }
>  
> -static void ivshmem_update_irq(IVShmemState *s)
> -{
> -    PCIDevice *d = PCI_DEVICE(s);
> -    uint32_t isr = s->intrstatus & s->intrmask;
> -
> -    /*
> -     * Do nothing unless the device actually uses INTx.  Here's how
> -     * the device variants signal interrupts, what they put in PCI
> -     * config space:
> -     * Device variant    Interrupt  Interrupt Pin  MSI-X cap.
> -     * ivshmem-plain         none            0         no
> -     * ivshmem-doorbell     MSI-X            1        yes(1)
> -     * ivshmem,msi=off       INTx            1         no
> -     * ivshmem,msi=on       MSI-X            1(2)     yes(1)
> -     * (1) if guest enabled MSI-X
> -     * (2) the device lies
> -     * Leads to the condition for doing nothing:
> -     */
> -    if (ivshmem_has_feature(s, IVSHMEM_MSI)
> -        || !d->config[PCI_INTERRUPT_PIN]) {
> -        return;
> -    }
> -
> -    /* don't print ISR resets */
> -    if (isr) {
> -        IVSHMEM_DPRINTF("Set IRQ to %d (%04x %04x)\n",
> -                        isr ? 1 : 0, s->intrstatus, s->intrmask);
> -    }
> -
> -    pci_set_irq(d, isr != 0);
> -}
> -
>  static void ivshmem_IntrMask_write(IVShmemState *s, uint32_t val)
>  {
>      IVSHMEM_DPRINTF("IntrMask write(w) val = 0x%04x\n", val);
>  
>      s->intrmask = val;
> -    ivshmem_update_irq(s);
>  }
>  
>  static uint32_t ivshmem_IntrMask_read(IVShmemState *s)
> @@ -189,7 +156,6 @@ static void ivshmem_IntrStatus_write(IVShmemState *s, uint32_t val)
>      IVSHMEM_DPRINTF("IntrStatus write(w) val = 0x%04x\n", val);
>  
>      s->intrstatus = val;
> -    ivshmem_update_irq(s);
>  }
>  
>  static uint32_t ivshmem_IntrStatus_read(IVShmemState *s)
> @@ -198,7 +164,6 @@ static uint32_t ivshmem_IntrStatus_read(IVShmemState *s)
>  
>      /* reading ISR clears all interrupts */
>      s->intrstatus = 0;
> -    ivshmem_update_irq(s);
>      return ret;
>  }
>  
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


