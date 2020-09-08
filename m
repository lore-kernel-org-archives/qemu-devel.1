Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E21C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB9F2087D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbOscF/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB9F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFejC-0002kv-Qu
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFehH-000149-V9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:34:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFehG-0008C6-6l
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iO88A+JSSW1s6Uv/2ZYrnBj0Eoi8puH9CuEdf/TY9b8=;
 b=FbOscF/cjfwiz2vj0hYgPtyntwyLLCIH+mIZWHF+p+Cm9krrbDJfla063+3LwmkCmTL7FI
 1tpOT8DHzxR00wW3GVcbwEpRFvk77Pc9S2m7vnPABIqtPiKHI81R/e2WCtS262CzzdSPNV
 y/esHs3jX8aeBizg6xNM2lQcrgXNep4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-NilgfrDENEyytfppWgbqaQ-1; Tue, 08 Sep 2020 10:34:07 -0400
X-MC-Unique: NilgfrDENEyytfppWgbqaQ-1
Received: by mail-wm1-f69.google.com with SMTP id s24so3552147wmh.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=iO88A+JSSW1s6Uv/2ZYrnBj0Eoi8puH9CuEdf/TY9b8=;
 b=AvpyEXuQ9oslsI+1/gyc0aivsW4gxLH90Kr7MiCRsyRipkaiS2KxWJFMHKfHn66tNy
 MsnUYV06coCwx81wqfaIHfE6DMl4wxfXhn6XW1oB4/Fnl6agasYIm+/PmuaBZoAiTtlL
 bZM1w3TnfqqsQft0dy2o82clRZC+tuGl2KvUpdgo0z8qT1u4j7fcqJgBDAcXrMVOEqmp
 wgDkXhYBOqxGmgWx9bYjbItmt2X/gPA7SFqCTjvWY1oqx2TVe+G4cycqvHQq12dNkhKJ
 zaFfm/pJV39ewlRhCE947bboEK+i1OsFIIdgfrw58BgDlbDMVXUcXKONUJwukx8gAm0P
 V4mA==
X-Gm-Message-State: AOAM53329ZNJMkvh/XiDUU4Z1lCYV6zFEmyOz3P0TePNxIV10PJC1XlX
 DqQVkcFsN6wCms4Bfo7TCx5LdDCDo55C/7tcz50ZPFZWcrPiRcWlixzL+WTczew9QI9W1N4yAM0
 1Eri4ph4ix5Qh/hw=
X-Received: by 2002:a1c:5641:: with SMTP id k62mr5053284wmb.13.1599575645212; 
 Tue, 08 Sep 2020 07:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgOQazp9i+mEl/fwg+6r3b/jhQKo4unGPP4zrO5e2G+NrYVky8R+6hOEU/XzaA5FvcssD/Rg==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr5053258wmb.13.1599575644996; 
 Tue, 08 Sep 2020 07:34:04 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t203sm34655314wmg.43.2020.09.08.07.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 07:34:04 -0700 (PDT)
Subject: Re: [PATCH 4/5] hw/xen: Split x86-specific declaration from generic
 hardware ones
To: qemu-devel@nongnu.org
References: <20200908142559.192945-1-philmd@redhat.com>
 <20200908142559.192945-5-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <82346995-4084-606d-719a-68bb556ec80a@redhat.com>
Date: Tue, 8 Sep 2020 16:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908142559.192945-5-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 4:25 PM, Philippe Mathieu-Daudé wrote:
> xen_hvm_init() is restricted to the X86 architecture.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/xen/xen-x86.h | 15 +++++++++++++++
>  include/hw/xen/xen.h     |  2 --
>  hw/i386/pc_piix.c        |  2 +-
>  hw/i386/xen/xen-hvm.c    |  1 +
>  4 files changed, 17 insertions(+), 3 deletions(-)
>  create mode 100644 include/hw/xen/xen-x86.h
> 
> diff --git a/include/hw/xen/xen-x86.h b/include/hw/xen/xen-x86.h
> new file mode 100644
> index 00000000000..85e3db1b8de
> --- /dev/null
> +++ b/include/hw/xen/xen-x86.h
> @@ -0,0 +1,15 @@
> +/*
> + * Xen X86-specific
> + *
> + * Copyright 2020 Red Hat, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QEMU_HW_XEN_X86_H
> +#define QEMU_HW_XEN_X86_H
> +
> +#include "hw/i386/pc.h"
> +
> +void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory);
> +
> +#endif /* QEMU_HW_XEN_X86_H */
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index b2b459964cb..1406648ca58 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -30,8 +30,6 @@ qemu_irq *xen_interrupt_controller_init(void);
>  
>  void xenstore_store_pv_console_info(int i, struct Chardev *chr);
>  
> -void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory);
> -
>  void xen_register_framebuffer(struct MemoryRegion *mr);
>  
>  #endif /* QEMU_HW_XEN_H */
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3e008bb0b1a..43205f48188 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -46,7 +46,7 @@
>  #include "hw/sysbus.h"
>  #include "sysemu/arch_init.h"
>  #include "hw/i2c/smbus_eeprom.h"
> -#include "hw/xen/xen.h"
> +#include "hw/xen/xen-x86.h"
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
>  #include "hw/acpi/acpi.h"
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 49748cda3fb..e03c59e53da 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -22,6 +22,7 @@
>  #include "hw/xen/xen_common.h"
>  #include "hw/xen/xen-legacy-backend.h"
>  #include "hw/xen/xen-bus.h"
> +#include "hw/xen/xen-x86.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qemu/error-report.h"
> 

I forgot to commit this hunk:

---
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index d14efef49e9..2ea81909217 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -8,6 +8,7 @@

 #include "qemu/osdep.h"
 #include "hw/xen/xen.h"
+#include "hw/xen/xen-x86.h"

 void xenstore_store_pv_console_info(int i, Chardev *chr)
 {
---


