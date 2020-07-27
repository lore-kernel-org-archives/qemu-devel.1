Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A9C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949EA2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2p3S6Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949EA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03a7-0004a2-TU
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k03YH-0001eN-3s
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:52:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k03YE-0002f5-Rr
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEh74gD+rAx7ukTboaG1WO4/7ysT1480XKGzm3H04jg=;
 b=T2p3S6MxJ6gpOjeve5Tv1IRE9wHc6gacUJEy0H4M1A29niPIdbLJum1SXl1fvOyAK2poZh
 UfEUz1ZBLQDM2BqO777gOr1/jPMF2JAIiJI4M1oUMXqh8UP/LgtqvvMCV+55bBw03eAMOF
 ltbFfZOe6i5qhBK7nKWJPAMVM48sfFo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-iW4P9KsTNHKYgMkoTZp73A-1; Mon, 27 Jul 2020 09:52:18 -0400
X-MC-Unique: iW4P9KsTNHKYgMkoTZp73A-1
Received: by mail-wm1-f72.google.com with SMTP id p23so839133wmc.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dEh74gD+rAx7ukTboaG1WO4/7ysT1480XKGzm3H04jg=;
 b=CeUkOAmBNKHoAJJmngyYtN/2bL9FiIz16gGZkRAcGJup2/b7niQwMkC6IxbM8d2FUD
 BVs3h6ZbCX5v2r/QUFmAZzJl/wBy3ASfFqpATYv4itz43zHuHZ3ByxoSCk7QE55TVZeL
 SCjBZu5+qf0CEahsYAgkSoVtbu0ha6xZCJGhWMTx7GZZVXLOYS+wHXZhYkiKTuKOJL+5
 AvUHiIr9DnGKBf4PQgc8C9O0YWw/upkRcMZCeHvDjw0KLsbjD4ZHIQ+pkXHBJSpfuZ/k
 /2buCMwn/Cd2U1DkOArip/eGt9t8FA6g4xdxA6MfBQX6dHYroMr1Yygrg5UqgnXaUhbI
 dITw==
X-Gm-Message-State: AOAM532d441qz8Ruhi/KwKmWAnMaGGJCUjvGo1TUZsMPxoVwCFUEws7/
 3ll97Cb9nhcw5NR8WGaXg9a+ciZnscO1KqykFKeylsGKJlxQ/8GiPrH9XqDBp5NufLeCcQrjlLi
 v+bf4EuPHfrCLtZ8=
X-Received: by 2002:adf:f64f:: with SMTP id x15mr9037601wrp.180.1595857936828; 
 Mon, 27 Jul 2020 06:52:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGLme77aIoKLJ9RA6JJ+DWJkhwD+9GXLckkBwAxT3jJUKdS9wYEuqFubXfbiUPrsMEOAz30Q==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr9037581wrp.180.1595857936531; 
 Mon, 27 Jul 2020 06:52:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4502:3ee3:2bae:c612?
 ([2001:b07:6468:f312:4502:3ee3:2bae:c612])
 by smtp.gmail.com with ESMTPSA id c4sm3515412wrt.41.2020.07.27.06.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 06:52:16 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1] hw/isa/lpc_ich9: Ignore reserved/invalid SCI
 IRQ
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200717151705.18611-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed1d1e59-bb09-1497-9b09-62051b191f6e@redhat.com>
Date: Mon, 27 Jul 2020 15:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717151705.18611-1-f4bug@amsat.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/20 17:17, Philippe Mathieu-Daudé wrote:
> libFuzzer triggered the following assertion:
> 
>   cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
>     -nographic -monitor none -serial none \
>     -qtest stdio -d guest_errors -trace pci\*
>   outl 0xcf8 0x8400f841
>   outl 0xcfc 0xebed205d
>   outl 0x5d02 0xedf82049
>   EOF
>   pci_cfg_write ICH9-LPC 31:0 @0x41 <- 0xebed205d
>   hw/pci/pci.c:268: int pci_bus_get_irq_level(PCIBus *, int): Assertion `irq_num < bus->nirq' failed.
> 
> This is because ich9_lpc_sci_irq() returns -1 for reserved
> (illegal) values, but ich9_lpc_pmbase_sci_update() considers
> it valid and store it in a 8-bit unsigned type. Then the 255
> value is used as GSI IRQ, resulting in a PIRQ value of 247,
> more than ICH9_LPC_NB_PIRQS (8).
> 
> Fix by simply ignoring the invalid access (and reporting it):
> 
>   pci_cfg_write ICH9-LPC 31:0 @0x41 <- 0xebed205d
>   ICH9 LPC: SCI IRQ SEL #3 is reserved
>   pci_cfg_read mch 00:0 @0x0 -> 0x8086
>   pci_cfg_read mch 00:0 @0x0 -> 0x29c08086
>   ...
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: 8f242cb724 ("ich9: implement SCI_IRQ_SEL register")
> BugLink: https://bugs.launchpad.net/qemu/+bug/1878642
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> RFC because I have no idea how to report the error. The LPC is on
> Device 31 Function 0. Should it trigger some error to the PCI bridge?
> I can't find that info in the ICH9 datasheet.
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

The patch is okay, but anything found by a fuzzer should really have a
qtest testcase.

Paolo

> ---
>  include/hw/i386/ich9.h |  1 +
>  hw/isa/lpc_ich9.c      | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index a98d10b252..60483b16cd 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -144,6 +144,7 @@ typedef struct ICH9LPCState {
>  #define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       Q35_MASK(32, 15, 7)
>  #define ICH9_LPC_PMBASE_RTE                     0x1
>  #define ICH9_LPC_PMBASE_DEFAULT                 0x1
> +
>  #define ICH9_LPC_ACPI_CTRL                      0x44
>  #define ICH9_LPC_ACPI_CTRL_ACPI_EN              0x80
>  #define ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK     Q35_MASK(8, 2, 0)
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index cd6e169d47..5ed28a726c 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -29,6 +29,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "cpu.h"
>  #include "qapi/visitor.h"
>  #include "qemu/range.h"
> @@ -312,10 +313,12 @@ void ich9_generate_smi(void)
>      cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
>  }
>  
> +/* Returns -1 on error, IRQ number on success */
>  static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
>  {
> -    switch (lpc->d.config[ICH9_LPC_ACPI_CTRL] &
> -            ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK) {
> +    uint8_t sel = lpc->d.config[ICH9_LPC_ACPI_CTRL] &
> +                  ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK;
> +    switch (sel) {
>      case ICH9_LPC_ACPI_CTRL_9:
>          return 9;
>      case ICH9_LPC_ACPI_CTRL_10:
> @@ -328,6 +331,8 @@ static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
>          return 21;
>      default:
>          /* reserved */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ICH9 LPC: SCI IRQ SEL #%u is reserved\n", sel);
>          break;
>      }
>      return -1;
> @@ -450,7 +455,7 @@ ich9_lpc_pmbase_sci_update(ICH9LPCState *lpc)
>  {
>      uint32_t pm_io_base = pci_get_long(lpc->d.config + ICH9_LPC_PMBASE);
>      uint8_t acpi_cntl = pci_get_long(lpc->d.config + ICH9_LPC_ACPI_CTRL);
> -    uint8_t new_gsi;
> +    int new_gsi;
>  
>      if (acpi_cntl & ICH9_LPC_ACPI_CTRL_ACPI_EN) {
>          pm_io_base &= ICH9_LPC_PMBASE_BASE_ADDRESS_MASK;
> @@ -461,6 +466,9 @@ ich9_lpc_pmbase_sci_update(ICH9LPCState *lpc)
>      ich9_pm_iospace_update(&lpc->pm, pm_io_base);
>  
>      new_gsi = ich9_lpc_sci_irq(lpc);
> +    if (new_gsi == -1) {
> +        return;
> +    }
>      if (lpc->sci_level && new_gsi != lpc->sci_gsi) {
>          qemu_set_irq(lpc->pm.irq, 0);
>          lpc->sci_gsi = new_gsi;
> 


