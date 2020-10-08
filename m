Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E3C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F4B2076B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ydb+ScBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F4B2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQmk-0004hy-Vk
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQQl9-0003Xs-69
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQQl5-0001Ih-KR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602143678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lyrlnaYbELH2akq0NywekLP4YPDo6/Cx3j78dO73u38=;
 b=Ydb+ScBOqCaRB0vo/e6c29RH9qvBYMUiSJmMQApz/yxhHNqS5ovr9h3/+68U9R21+sEJ6f
 aGxHpwpmVxID5j6UvYkbuc6K326GZIzIgY2z2ABP/tD++hAYaJ/QfwYBz3n2m008zicsZB
 2RFLqcHSExeKNaFss6rHSPZ8KRq2ZC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-rQBsYK8EOleNonjGYAmpfQ-1; Thu, 08 Oct 2020 03:54:36 -0400
X-MC-Unique: rQBsYK8EOleNonjGYAmpfQ-1
Received: by mail-wm1-f70.google.com with SMTP id d197so2854115wmd.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lyrlnaYbELH2akq0NywekLP4YPDo6/Cx3j78dO73u38=;
 b=RYOUxwy5Eusojs5xaArV9rgRV7yDmrFNXLxZzAm3FL3tXHr/vgK09re031vO3qsFF8
 1Zvhz47n2UmHfT++J0/mNwkAHntdvxQbJqPwjJkkYa5tkeBUUexBhg/28uMNO3KfwLrl
 Rz87QvgXjRCxQ+HyRP3sRGVpFneNJa6YdPR0OE4nnHF931WCJeXx+sJl7BlcgtJLN4Lm
 ZAz3+d0+vnHIXqm9iwDm7XdaHMerTHPogA+MDzN0DwEsIklZb+1+vHDttMlbIszU9kR1
 ypA9izAlWoMwdAB85xbBQ/0HQ8Yh5PZxwJkkddM8tD4zaB4ZGFlZQBfJDZeXCO7eqA82
 x0gw==
X-Gm-Message-State: AOAM531HUxUbAQD4QHClhT7s7FPXSChUXFbnaLjZi+yGRwOobulqaQrM
 kj3w9zvoS/qxpH3aMd1h+Jp8TsyrU8KIRc3bc3szKjNuvJLx7iJgZa2ywkQpxW76UMn/TsY5Kfc
 YZdNHQWIvunbTxGE=
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr7326563wmc.100.1602143674818; 
 Thu, 08 Oct 2020 00:54:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTSwMvOO2ytmnp5MnRioEsuQrAG72K0bunK4U1U/nyhvw4SvqbR9rYDijeq7hHSiEngigXZQ==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr7326541wmc.100.1602143674428; 
 Thu, 08 Oct 2020 00:54:34 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u8sm5740697wrn.62.2020.10.08.00.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:54:33 -0700 (PDT)
Subject: Re: [PATCH] Fixing LGPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201008060528.68579-1-chetan4windows@gmail.com>
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
Message-ID: <df199cc8-c383-ed03-6244-7a204e92397b@redhat.com>
Date: Thu, 8 Oct 2020 09:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008060528.68579-1-chetan4windows@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/8/20 8:05 AM, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License. It is
> either "GPL version 2.0" or "LGPL version 2.1". This patch replaces all
> occurrences of "LGPL version 2" with "LGPL version 2.1" in comment section.

This looks like a good cleanup!

Since you already listed all the files using this license,
it can be a good opportunity to correct and use the full
license text (which is miswritten in various places):

---

 Copyright (C) <year> <name of author>

This library is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or (at
your option) any later version.

This library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this library; if not, write to the Free Software Foundation,
Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

---

Or simpler, add the SPDX identifier tag:

  SPDX-License-Identifier: LGPL-2.1-or-later

But IANAL so better wait what the project maintainer prefer.


Also, if you use a script to do that cleanup, it would be
useful to include it in the commit description.

Regards,

Phil.

> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  authz/base.c                                 | 2 +-
>  authz/list.c                                 | 2 +-
>  authz/listfile.c                             | 2 +-
>  authz/pamacct.c                              | 2 +-
>  authz/simple.c                               | 2 +-
>  backends/cryptodev-builtin.c                 | 2 +-
>  backends/cryptodev-vhost-user.c              | 2 +-
>  backends/cryptodev-vhost.c                   | 2 +-
>  backends/cryptodev.c                         | 2 +-
>  backends/tpm/tpm_emulator.c                  | 2 +-
>  backends/tpm/tpm_passthrough.c               | 2 +-
>  backends/tpm/tpm_util.c                      | 2 +-
>  block/commit.c                               | 2 +-
>  block/crypto.c                               | 2 +-
>  block/crypto.h                               | 2 +-
>  block/mirror.c                               | 2 +-
>  block/qed-check.c                            | 2 +-
>  block/qed-cluster.c                          | 2 +-
>  block/qed-l2-cache.c                         | 2 +-
>  block/qed-table.c                            | 2 +-
>  block/qed.c                                  | 2 +-
>  block/qed.h                                  | 2 +-
>  block/stream.c                               | 2 +-
>  block/vhdx-endian.c                          | 2 +-
>  block/vhdx-log.c                             | 2 +-
>  block/vhdx.c                                 | 2 +-
>  block/vhdx.h                                 | 2 +-
>  block/write-threshold.c                      | 2 +-
>  cpus-common.c                                | 2 +-
>  disas/lm32.c                                 | 2 +-
>  exec-vary.c                                  | 2 +-
>  exec.c                                       | 2 +-
>  gdbstub.c                                    | 2 +-
>  hw/acpi/core.c                               | 2 +-
>  hw/acpi/hmat.c                               | 2 +-
>  hw/acpi/hmat.h                               | 2 +-
>  hw/acpi/ich9.c                               | 2 +-
>  hw/acpi/nvdimm.c                             | 2 +-
>  hw/acpi/pcihp.c                              | 2 +-
>  hw/acpi/piix4.c                              | 2 +-
>  hw/audio/milkymist-ac97.c                    | 2 +-
>  hw/block/pflash_cfi01.c                      | 2 +-
>  hw/block/pflash_cfi02.c                      | 2 +-
>  hw/block/vhost-user-blk.c                    | 2 +-
>  hw/char/lm32_juart.c                         | 2 +-
>  hw/char/lm32_uart.c                          | 2 +-
>  hw/char/milkymist-uart.c                     | 2 +-
>  hw/core/bus.c                                | 2 +-
>  hw/core/loader-fit.c                         | 2 +-
>  hw/core/platform-bus.c                       | 2 +-
>  hw/core/qdev.c                               | 2 +-
>  hw/core/sysbus.c                             | 2 +-
>  hw/display/bcm2835_fb.c                      | 2 +-
>  hw/display/milkymist-tmu2.c                  | 2 +-
>  hw/display/milkymist-vgafb.c                 | 2 +-
>  hw/display/milkymist-vgafb_template.h        | 2 +-
>  hw/gpio/mpc8xxx.c                            | 2 +-
>  hw/i2c/pm_smbus.c                            | 2 +-
>  hw/ide/ahci.c                                | 2 +-
>  hw/ide/ahci_internal.h                       | 2 +-
>  hw/ide/ich.c                                 | 2 +-
>  hw/ide/qdev.c                                | 2 +-
>  hw/input/milkymist-softusb.c                 | 2 +-
>  hw/intc/apic.c                               | 2 +-
>  hw/intc/apic_common.c                        | 2 +-
>  hw/intc/arm_gicv2m.c                         | 2 +-
>  hw/intc/arm_gicv3_its_kvm.c                  | 2 +-
>  hw/intc/ioapic.c                             | 2 +-
>  hw/intc/ioapic_common.c                      | 2 +-
>  hw/intc/lm32_pic.c                           | 2 +-
>  hw/intc/xics_pnv.c                           | 2 +-
>  hw/isa/apm.c                                 | 2 +-
>  hw/isa/i82378.c                              | 2 +-
>  hw/isa/isa-bus.c                             | 2 +-
>  hw/lm32/lm32_boards.c                        | 2 +-
>  hw/lm32/lm32_hwsetup.h                       | 2 +-
>  hw/lm32/milkymist.c                          | 2 +-
>  hw/mem/nvdimm.c                              | 2 +-
>  hw/mem/pc-dimm.c                             | 2 +-
>  hw/mips/boston.c                             | 2 +-
>  hw/mips/cps.c                                | 2 +-
>  hw/misc/applesmc.c                           | 2 +-
>  hw/misc/milkymist-hpdmc.c                    | 2 +-
>  hw/misc/milkymist-pfpu.c                     | 2 +-
>  hw/misc/mips_cpc.c                           | 2 +-
>  hw/misc/mips_itu.c                           | 2 +-
>  hw/net/e1000.c                               | 2 +-
>  hw/net/e1000e.c                              | 2 +-
>  hw/net/e1000e_core.c                         | 2 +-
>  hw/net/e1000e_core.h                         | 2 +-
>  hw/net/e1000x_common.c                       | 2 +-
>  hw/net/e1000x_common.h                       | 2 +-
>  hw/net/milkymist-minimac2.c                  | 2 +-
>  hw/pci-bridge/i82801b11.c                    | 2 +-
>  hw/pci-host/designware.c                     | 2 +-
>  hw/pci-host/xilinx-pcie.c                    | 2 +-
>  hw/ppc/pnv.c                                 | 2 +-
>  hw/ppc/pnv_core.c                            | 2 +-
>  hw/ppc/pnv_lpc.c                             | 2 +-
>  hw/ppc/pnv_psi.c                             | 2 +-
>  hw/ppc/pnv_xscom.c                           | 2 +-
>  hw/ppc/ppce500_spin.c                        | 2 +-
>  hw/ppc/spapr_iommu.c                         | 2 +-
>  hw/ppc/spapr_vio.c                           | 2 +-
>  hw/scsi/megasas.c                            | 2 +-
>  hw/scsi/mptconfig.c                          | 2 +-
>  hw/scsi/mptendian.c                          | 2 +-
>  hw/scsi/mptsas.c                             | 2 +-
>  hw/scsi/vhost-scsi-common.c                  | 2 +-
>  hw/scsi/vhost-scsi.c                         | 2 +-
>  hw/scsi/vhost-user-scsi.c                    | 2 +-
>  hw/sd/milkymist-memcard.c                    | 2 +-
>  hw/timer/hpet.c                              | 2 +-
>  hw/timer/lm32_timer.c                        | 2 +-
>  hw/timer/milkymist-sysctl.c                  | 2 +-
>  hw/tpm/tpm_prop.h                            | 2 +-
>  hw/tricore/tricore_testboard.c               | 2 +-
>  hw/usb/ccid-card-emulated.c                  | 2 +-
>  hw/usb/ccid.h                                | 2 +-
>  hw/usb/hcd-ohci.c                            | 2 +-
>  hw/usb/hcd-xhci-nec.c                        | 2 +-
>  hw/usb/hcd-xhci-pci.c                        | 2 +-
>  hw/usb/hcd-xhci-pci.h                        | 2 +-
>  hw/usb/hcd-xhci.c                            | 2 +-
>  hw/usb/hcd-xhci.h                            | 2 +-
>  hw/virtio/vhost-scsi-pci.c                   | 2 +-
>  hw/virtio/vhost-user-blk-pci.c               | 2 +-
>  hw/virtio/vhost-user-input-pci.c             | 2 +-
>  hw/virtio/vhost-user-scsi-pci.c              | 2 +-
>  hw/xen/xen_pvdev.c                           | 2 +-
>  include/authz/base.h                         | 2 +-
>  include/authz/list.h                         | 2 +-
>  include/authz/listfile.h                     | 2 +-
>  include/authz/pamacct.h                      | 2 +-
>  include/authz/simple.h                       | 2 +-
>  include/block/write-threshold.h              | 2 +-
>  include/exec/cpu-all.h                       | 2 +-
>  include/exec/cpu-defs.h                      | 2 +-
>  include/exec/cpu_ldst.h                      | 2 +-
>  include/exec/cputlb.h                        | 2 +-
>  include/exec/exec-all.h                      | 2 +-
>  include/exec/ioport.h                        | 2 +-
>  include/exec/memory_ldst.h.inc               | 2 +-
>  include/exec/memory_ldst_cached.h.inc        | 2 +-
>  include/exec/memory_ldst_phys.h.inc          | 2 +-
>  include/exec/tb-context.h                    | 2 +-
>  include/exec/tb-hash.h                       | 2 +-
>  include/exec/user/thunk.h                    | 2 +-
>  include/hw/acpi/acpi.h                       | 2 +-
>  include/hw/acpi/ich9.h                       | 2 +-
>  include/hw/acpi/pcihp.h                      | 2 +-
>  include/hw/display/milkymist_tmu2.h          | 2 +-
>  include/hw/i386/apic_internal.h              | 2 +-
>  include/hw/i386/ioapic.h                     | 2 +-
>  include/hw/i386/ioapic_internal.h            | 2 +-
>  include/hw/ide/ahci.h                        | 2 +-
>  include/hw/loader-fit.h                      | 2 +-
>  include/hw/mips/cps.h                        | 2 +-
>  include/hw/misc/mips_cpc.h                   | 2 +-
>  include/hw/misc/mips_itu.h                   | 2 +-
>  include/hw/pci-host/designware.h             | 2 +-
>  include/hw/pci-host/spapr.h                  | 2 +-
>  include/hw/pci-host/xilinx-pcie.h            | 2 +-
>  include/hw/platform-bus.h                    | 2 +-
>  include/hw/ppc/pnv.h                         | 2 +-
>  include/hw/ppc/pnv_core.h                    | 2 +-
>  include/hw/ppc/pnv_homer.h                   | 2 +-
>  include/hw/ppc/pnv_lpc.h                     | 2 +-
>  include/hw/ppc/pnv_occ.h                     | 2 +-
>  include/hw/ppc/pnv_psi.h                     | 2 +-
>  include/hw/ppc/pnv_xscom.h                   | 2 +-
>  include/hw/ppc/spapr_vio.h                   | 2 +-
>  include/hw/semihosting/semihost.h            | 2 +-
>  include/hw/virtio/vhost-scsi-common.h        | 2 +-
>  include/hw/virtio/vhost-scsi.h               | 2 +-
>  include/hw/virtio/vhost-user-blk.h           | 2 +-
>  include/hw/virtio/vhost-user-scsi.h          | 2 +-
>  include/io/channel-buffer.h                  | 2 +-
>  include/io/channel-command.h                 | 2 +-
>  include/io/channel-file.h                    | 2 +-
>  include/io/channel-socket.h                  | 2 +-
>  include/io/channel-tls.h                     | 2 +-
>  include/io/channel-util.h                    | 2 +-
>  include/io/channel-watch.h                   | 2 +-
>  include/io/channel-websock.h                 | 2 +-
>  include/io/channel.h                         | 2 +-
>  include/io/dns-resolver.h                    | 2 +-
>  include/io/task.h                            | 2 +-
>  include/qemu/base64.h                        | 2 +-
>  include/qemu/buffer.h                        | 2 +-
>  include/qemu/coroutine.h                     | 2 +-
>  include/qemu/filemonitor.h                   | 2 +-
>  include/qemu/lockable.h                      | 2 +-
>  include/qemu/ratelimit.h                     | 2 +-
>  include/sysemu/cryptodev-vhost-user.h        | 2 +-
>  include/sysemu/cryptodev-vhost.h             | 2 +-
>  include/sysemu/cryptodev.h                   | 2 +-
>  include/sysemu/tpm_util.h                    | 2 +-
>  io/channel-buffer.c                          | 2 +-
>  io/channel-command.c                         | 2 +-
>  io/channel-file.c                            | 2 +-
>  io/channel-socket.c                          | 2 +-
>  io/channel-tls.c                             | 2 +-
>  io/channel-util.c                            | 2 +-
>  io/channel-watch.c                           | 2 +-
>  io/channel-websock.c                         | 2 +-
>  io/channel.c                                 | 2 +-
>  io/dns-resolver.c                            | 2 +-
>  io/task.c                                    | 2 +-
>  linux-user/aarch64/target_cpu.h              | 2 +-
>  linux-user/aarch64/target_structs.h          | 2 +-
>  linux-user/alpha/target_cpu.h                | 2 +-
>  linux-user/alpha/target_structs.h            | 2 +-
>  linux-user/arm/target_cpu.h                  | 2 +-
>  linux-user/arm/target_structs.h              | 2 +-
>  linux-user/cris/target_cpu.h                 | 2 +-
>  linux-user/cris/target_structs.h             | 2 +-
>  linux-user/hppa/target_cpu.h                 | 2 +-
>  linux-user/hppa/target_structs.h             | 2 +-
>  linux-user/i386/target_cpu.h                 | 2 +-
>  linux-user/i386/target_structs.h             | 2 +-
>  linux-user/microblaze/target_cpu.h           | 2 +-
>  linux-user/microblaze/target_structs.h       | 2 +-
>  linux-user/mips/target_cpu.h                 | 2 +-
>  linux-user/mips/target_structs.h             | 2 +-
>  linux-user/mips64/target_cpu.h               | 2 +-
>  linux-user/nios2/target_cpu.h                | 2 +-
>  linux-user/nios2/target_structs.h            | 2 +-
>  linux-user/ppc/target_cpu.h                  | 2 +-
>  linux-user/ppc/target_structs.h              | 2 +-
>  linux-user/ppc/target_syscall.h              | 2 +-
>  linux-user/s390x/target_structs.h            | 2 +-
>  linux-user/sparc/target_cpu.h                | 2 +-
>  linux-user/sparc/target_structs.h            | 2 +-
>  linux-user/sparc64/target_structs.h          | 2 +-
>  linux-user/tilegx/target_cpu.h               | 2 +-
>  linux-user/tilegx/target_structs.h           | 2 +-
>  linux-user/x86_64/target_structs.h           | 2 +-
>  memory_ldst.c.inc                            | 2 +-
>  migration/tls.c                              | 2 +-
>  migration/tls.h                              | 2 +-
>  net/hub.c                                    | 2 +-
>  net/hub.h                                    | 2 +-
>  qdev-monitor.c                               | 2 +-
>  scripts/analyze-migration.py                 | 2 +-
>  scripts/decodetree.py                        | 2 +-
>  scripts/replay-dump.py                       | 2 +-
>  target/alpha/cpu.h                           | 2 +-
>  target/alpha/fpu_helper.c                    | 2 +-
>  target/alpha/gdbstub.c                       | 2 +-
>  target/alpha/helper.c                        | 2 +-
>  target/alpha/int_helper.c                    | 2 +-
>  target/alpha/mem_helper.c                    | 2 +-
>  target/alpha/sys_helper.c                    | 2 +-
>  target/alpha/translate.c                     | 2 +-
>  target/alpha/vax_helper.c                    | 2 +-
>  target/arm/a32-uncond.decode                 | 2 +-
>  target/arm/a32.decode                        | 2 +-
>  target/arm/arm_ldst.h                        | 2 +-
>  target/arm/cpu.h                             | 2 +-
>  target/arm/crypto_helper.c                   | 2 +-
>  target/arm/gdbstub.c                         | 2 +-
>  target/arm/gdbstub64.c                       | 2 +-
>  target/arm/helper-a64.c                      | 2 +-
>  target/arm/helper-a64.h                      | 2 +-
>  target/arm/helper-sve.h                      | 2 +-
>  target/arm/iwmmxt_helper.c                   | 2 +-
>  target/arm/neon-dp.decode                    | 2 +-
>  target/arm/neon-ls.decode                    | 2 +-
>  target/arm/neon-shared.decode                | 2 +-
>  target/arm/op_helper.c                       | 2 +-
>  target/arm/pauth_helper.c                    | 2 +-
>  target/arm/sve.decode                        | 2 +-
>  target/arm/sve_helper.c                      | 2 +-
>  target/arm/t16.decode                        | 2 +-
>  target/arm/t32.decode                        | 2 +-
>  target/arm/translate-a64.c                   | 2 +-
>  target/arm/translate-a64.h                   | 2 +-
>  target/arm/translate-neon.c.inc              | 2 +-
>  target/arm/translate-sve.c                   | 2 +-
>  target/arm/translate-vfp.c.inc               | 2 +-
>  target/arm/translate.c                       | 2 +-
>  target/arm/vec_helper.c                      | 2 +-
>  target/arm/vec_internal.h                    | 2 +-
>  target/arm/vfp-uncond.decode                 | 2 +-
>  target/arm/vfp.decode                        | 2 +-
>  target/cris/cpu.h                            | 2 +-
>  target/cris/crisv10-decode.h                 | 2 +-
>  target/cris/crisv32-decode.h                 | 2 +-
>  target/cris/gdbstub.c                        | 2 +-
>  target/cris/helper.c                         | 2 +-
>  target/cris/machine.c                        | 2 +-
>  target/cris/mmu.c                            | 2 +-
>  target/cris/op_helper.c                      | 2 +-
>  target/cris/translate.c                      | 2 +-
>  target/cris/translate_v10.c.inc              | 2 +-
>  target/hppa/cpu.h                            | 2 +-
>  target/hppa/gdbstub.c                        | 2 +-
>  target/hppa/helper.c                         | 2 +-
>  target/hppa/insns.decode                     | 2 +-
>  target/hppa/int_helper.c                     | 2 +-
>  target/hppa/machine.c                        | 2 +-
>  target/hppa/mem_helper.c                     | 2 +-
>  target/hppa/op_helper.c                      | 2 +-
>  target/hppa/translate.c                      | 2 +-
>  target/i386/bpt_helper.c                     | 2 +-
>  target/i386/cc_helper.c                      | 2 +-
>  target/i386/cc_helper_template.h             | 2 +-
>  target/i386/cpu.c                            | 2 +-
>  target/i386/cpu.h                            | 2 +-
>  target/i386/excp_helper.c                    | 2 +-
>  target/i386/fpu_helper.c                     | 2 +-
>  target/i386/gdbstub.c                        | 2 +-
>  target/i386/helper.c                         | 2 +-
>  target/i386/hvf/panic.h                      | 2 +-
>  target/i386/hvf/vmx.h                        | 2 +-
>  target/i386/hvf/x86.c                        | 2 +-
>  target/i386/hvf/x86.h                        | 2 +-
>  target/i386/hvf/x86_cpuid.c                  | 2 +-
>  target/i386/hvf/x86_decode.c                 | 2 +-
>  target/i386/hvf/x86_decode.h                 | 2 +-
>  target/i386/hvf/x86_descr.c                  | 2 +-
>  target/i386/hvf/x86_descr.h                  | 2 +-
>  target/i386/hvf/x86_emu.c                    | 4 ++--
>  target/i386/hvf/x86_emu.h                    | 2 +-
>  target/i386/hvf/x86_flags.c                  | 2 +-
>  target/i386/hvf/x86_flags.h                  | 2 +-
>  target/i386/hvf/x86_mmu.c                    | 2 +-
>  target/i386/hvf/x86_mmu.h                    | 2 +-
>  target/i386/hvf/x86hvf.c                     | 2 +-
>  target/i386/hvf/x86hvf.h                     | 2 +-
>  target/i386/int_helper.c                     | 2 +-
>  target/i386/mem_helper.c                     | 2 +-
>  target/i386/misc_helper.c                    | 2 +-
>  target/i386/mpx_helper.c                     | 2 +-
>  target/i386/ops_sse.h                        | 2 +-
>  target/i386/ops_sse_header.h                 | 2 +-
>  target/i386/seg_helper.c                     | 2 +-
>  target/i386/shift_helper_template.h          | 2 +-
>  target/i386/smm_helper.c                     | 2 +-
>  target/i386/svm_helper.c                     | 2 +-
>  target/i386/tcg-stub.c                       | 2 +-
>  target/i386/translate.c                      | 2 +-
>  target/lm32/cpu.h                            | 2 +-
>  target/lm32/gdbstub.c                        | 2 +-
>  target/lm32/helper.c                         | 2 +-
>  target/lm32/translate.c                      | 2 +-
>  target/microblaze/cpu.h                      | 2 +-
>  target/microblaze/gdbstub.c                  | 2 +-
>  target/microblaze/helper.c                   | 2 +-
>  target/microblaze/machine.c                  | 2 +-
>  target/microblaze/mmu.c                      | 2 +-
>  target/microblaze/mmu.h                      | 2 +-
>  target/microblaze/op_helper.c                | 2 +-
>  target/microblaze/translate.c                | 2 +-
>  target/mips/cp0_helper.c                     | 2 +-
>  target/mips/dsp_helper.c                     | 2 +-
>  target/mips/fpu_helper.c                     | 2 +-
>  target/mips/gdbstub.c                        | 2 +-
>  target/mips/helper.c                         | 2 +-
>  target/mips/lmmi_helper.c                    | 2 +-
>  target/mips/mips-semi.c                      | 2 +-
>  target/mips/msa_helper.c                     | 2 +-
>  target/mips/op_helper.c                      | 2 +-
>  target/mips/translate.c                      | 2 +-
>  target/mips/translate_init.c.inc             | 2 +-
>  target/ppc/compat.c                          | 2 +-
>  target/ppc/cpu-models.c                      | 2 +-
>  target/ppc/cpu-models.h                      | 2 +-
>  target/ppc/cpu.c                             | 2 +-
>  target/ppc/cpu.h                             | 2 +-
>  target/ppc/dfp_helper.c                      | 2 +-
>  target/ppc/excp_helper.c                     | 2 +-
>  target/ppc/fpu_helper.c                      | 2 +-
>  target/ppc/gdbstub.c                         | 2 +-
>  target/ppc/helper_regs.h                     | 2 +-
>  target/ppc/int_helper.c                      | 2 +-
>  target/ppc/internal.h                        | 2 +-
>  target/ppc/mem_helper.c                      | 2 +-
>  target/ppc/misc_helper.c                     | 2 +-
>  target/ppc/mmu-book3s-v3.c                   | 2 +-
>  target/ppc/mmu-book3s-v3.h                   | 2 +-
>  target/ppc/mmu-hash32.c                      | 2 +-
>  target/ppc/mmu-hash64.c                      | 2 +-
>  target/ppc/mmu-radix64.c                     | 2 +-
>  target/ppc/mmu_helper.c                      | 2 +-
>  target/ppc/timebase_helper.c                 | 2 +-
>  target/ppc/translate.c                       | 2 +-
>  target/ppc/translate_init.c.inc              | 2 +-
>  target/ppc/user_only_helper.c                | 2 +-
>  target/rx/insns.decode                       | 2 +-
>  target/sparc/cc_helper.c                     | 2 +-
>  target/sparc/cpu.c                           | 2 +-
>  target/sparc/fop_helper.c                    | 2 +-
>  target/sparc/gdbstub.c                       | 2 +-
>  target/sparc/helper.c                        | 2 +-
>  target/sparc/int32_helper.c                  | 2 +-
>  target/sparc/int64_helper.c                  | 2 +-
>  target/sparc/ldst_helper.c                   | 2 +-
>  target/sparc/mmu_helper.c                    | 2 +-
>  target/sparc/translate.c                     | 2 +-
>  target/sparc/vis_helper.c                    | 2 +-
>  target/sparc/win_helper.c                    | 2 +-
>  target/tilegx/cpu.h                          | 2 +-
>  target/tricore/gdbstub.c                     | 2 +-
>  target/xtensa/gdbstub.c                      | 2 +-
>  tests/acceptance/pc_cpu_hotplug_props.py     | 2 +-
>  tests/acceptance/x86_cpu_model_versions.py   | 2 +-
>  tests/decode/check.sh                        | 2 +-
>  tests/decode/err_argset1.decode              | 2 +-
>  tests/decode/err_argset2.decode              | 2 +-
>  tests/decode/err_field1.decode               | 2 +-
>  tests/decode/err_field2.decode               | 2 +-
>  tests/decode/err_field3.decode               | 2 +-
>  tests/decode/err_field4.decode               | 2 +-
>  tests/decode/err_field5.decode               | 2 +-
>  tests/decode/err_field6.decode               | 2 +-
>  tests/decode/err_init1.decode                | 2 +-
>  tests/decode/err_init2.decode                | 2 +-
>  tests/decode/err_init3.decode                | 2 +-
>  tests/decode/err_init4.decode                | 2 +-
>  tests/decode/err_overlap1.decode             | 2 +-
>  tests/decode/err_overlap2.decode             | 2 +-
>  tests/decode/err_overlap3.decode             | 2 +-
>  tests/decode/err_overlap4.decode             | 2 +-
>  tests/decode/err_overlap5.decode             | 2 +-
>  tests/decode/err_overlap6.decode             | 2 +-
>  tests/decode/err_overlap7.decode             | 2 +-
>  tests/decode/err_overlap8.decode             | 2 +-
>  tests/decode/err_overlap9.decode             | 2 +-
>  tests/decode/err_pattern_group_empty.decode  | 2 +-
>  tests/decode/err_pattern_group_ident1.decode | 2 +-
>  tests/decode/err_pattern_group_ident2.decode | 2 +-
>  tests/decode/err_pattern_group_nest1.decode  | 2 +-
>  tests/decode/err_pattern_group_nest2.decode  | 2 +-
>  tests/decode/err_pattern_group_nest3.decode  | 2 +-
>  tests/decode/err_width1.decode               | 2 +-
>  tests/decode/err_width2.decode               | 2 +-
>  tests/decode/err_width3.decode               | 2 +-
>  tests/decode/err_width4.decode               | 2 +-
>  tests/decode/succ_function.decode            | 2 +-
>  tests/decode/succ_pattern_group_nest1.decode | 2 +-
>  tests/decode/succ_pattern_group_nest2.decode | 2 +-
>  tests/decode/succ_pattern_group_nest3.decode | 2 +-
>  tests/decode/succ_pattern_group_nest4.decode | 2 +-
>  tests/io-channel-helpers.c                   | 2 +-
>  tests/io-channel-helpers.h                   | 2 +-
>  tests/migration/guestperf-batch.py           | 2 +-
>  tests/migration/guestperf-plot.py            | 2 +-
>  tests/migration/guestperf.py                 | 2 +-
>  tests/migration/guestperf/comparison.py      | 2 +-
>  tests/migration/guestperf/engine.py          | 2 +-
>  tests/migration/guestperf/hardware.py        | 2 +-
>  tests/migration/guestperf/plot.py            | 2 +-
>  tests/migration/guestperf/progress.py        | 2 +-
>  tests/migration/guestperf/report.py          | 2 +-
>  tests/migration/guestperf/scenario.py        | 2 +-
>  tests/migration/guestperf/shell.py           | 2 +-
>  tests/migration/guestperf/timings.py         | 2 +-
>  tests/migration/stress.c                     | 2 +-
>  tests/qemu-iotests/socket_scm_helper.c       | 2 +-
>  tests/test-aio-multithread.c                 | 2 +-
>  tests/test-aio.c                             | 2 +-
>  tests/test-authz-list.c                      | 2 +-
>  tests/test-authz-listfile.c                  | 2 +-
>  tests/test-authz-pam.c                       | 2 +-
>  tests/test-authz-simple.c                    | 2 +-
>  tests/test-base64.c                          | 2 +-
>  tests/test-bitcnt.c                          | 2 +-
>  tests/test-bitops.c                          | 2 +-
>  tests/test-blockjob-txn.c                    | 2 +-
>  tests/test-blockjob.c                        | 2 +-
>  tests/test-bufferiszero.c                    | 2 +-
>  tests/test-coroutine.c                       | 2 +-
>  tests/test-crypto-afsplit.c                  | 2 +-
>  tests/test-crypto-block.c                    | 2 +-
>  tests/test-crypto-cipher.c                   | 2 +-
>  tests/test-crypto-hash.c                     | 2 +-
>  tests/test-crypto-ivgen.c                    | 2 +-
>  tests/test-crypto-pbkdf.c                    | 2 +-
>  tests/test-crypto-secret.c                   | 2 +-
>  tests/test-crypto-xts.c                      | 2 +-
>  tests/test-int128.c                          | 2 +-
>  tests/test-io-channel-buffer.c               | 2 +-
>  tests/test-io-channel-command.c              | 2 +-
>  tests/test-io-channel-file.c                 | 2 +-
>  tests/test-io-channel-socket.c               | 2 +-
>  tests/test-io-task.c                         | 2 +-
>  tests/test-mul64.c                           | 2 +-
>  tests/test-qgraph.c                          | 2 +-
>  tests/test-shift128.c                        | 2 +-
>  tests/test-throttle.c                        | 2 +-
>  tests/test-timed-average.c                   | 2 +-
>  tests/test-uuid.c                            | 2 +-
>  tests/test-write-threshold.c                 | 2 +-
>  thunk.c                                      | 2 +-
>  ui/x_keymap.c                                | 2 +-
>  util/base64.c                                | 2 +-
>  util/buffer.c                                | 2 +-
>  util/filemonitor-inotify.c                   | 2 +-
>  util/filemonitor-stub.c                      | 2 +-
>  util/log.c                                   | 2 +-
>  util/oslib-win32.c                           | 2 +-
>  util/qemu-coroutine-sleep.c                  | 2 +-
>  util/qemu-coroutine.c                        | 2 +-
>  505 files changed, 506 insertions(+), 506 deletions(-)


