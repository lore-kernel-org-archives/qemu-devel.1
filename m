Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE669C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8217D2064C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR7O0WHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8217D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jivzc-0003r3-Ol
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 04:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivz0-0003QF-Gp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 04:21:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivyy-0002ad-Gl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 04:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591777270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+OELjDU4Bh9a1/jzWHuXTrf4F6I6r1niynX9mD90gOQ=;
 b=dR7O0WHPtYPREy0Wkc/C4cjm2nn+avxriiNQ+7kgwd2eI5FXuuLjpHyEiEknXbvIMPWfiW
 rrGpvhnS42rHX2gcbDC4Isnm23uy5qSYzbqm6IeJmBCWW/9V2wLYHR9p5NDSU43Satt7+o
 TZqsbGmsJv+QNY+WZGN8EHkgOpNN6e4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-8xVJ9vfcNO-IzWppogxKTw-1; Wed, 10 Jun 2020 04:21:08 -0400
X-MC-Unique: 8xVJ9vfcNO-IzWppogxKTw-1
Received: by mail-wr1-f71.google.com with SMTP id d6so761936wrn.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 01:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+OELjDU4Bh9a1/jzWHuXTrf4F6I6r1niynX9mD90gOQ=;
 b=JT0vh1b5GcftOCND9T+I6Pfoa1pz/8HYLiii2vW7Qd3dBCR4ndTFw8H7JfWjwFgLps
 z0qqMQRp2ioCppUNXMRbAsCNVPGRiX6jFQesztcPVluqTYH6oaFfXtuhd8CYhIOoSGwc
 z6uc3+04YdsoDrMZARfzGgo++EKas6VLJogfYbgUH8AcE1mCpJGUMwucOPWO9ASxIuyv
 +WRjP/Z1RN/uW1aFurKlJQdeeNCP5x6rov6yOd15/qhd8slHr4ph3r+Wr779jsJGa59t
 oqh0Gu3T/oU8Kx+U4T4kF/ErVeJDwTHGEb+zBHg8Cfpv36MaqQFlttXAcqTLOzQZumfT
 uRgw==
X-Gm-Message-State: AOAM530ywRuYbpqy4aJYofkQxLEuK79yym8bIrRI0epf5vlTfkimFUgT
 Zc/rWzGow3VICRYxhPrnVwHUrSJEhsV/T+KwK8gccpRqFInwrWSnnowGiTRZSn6fWvACNuS3gTS
 SyiOMCNs4iJ5+fRg=
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr2060698wmk.91.1591777267308; 
 Wed, 10 Jun 2020 01:21:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh8dNtb/q7kiIk/IoO/kxHeSb3ijM34e1U4gqkHnd8qvlZWYGF06E+q9FGhXKrynA1H0HdDg==
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr2060674wmk.91.1591777266954; 
 Wed, 10 Jun 2020 01:21:06 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k12sm7073256wrn.42.2020.06.10.01.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 01:21:06 -0700 (PDT)
Subject: Re: [PATCH RESEND v3 56/58] qdev: Convert bus-less devices to
 qdev_realize() with Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200610053247.1583243-1-armbru@redhat.com>
 <20200610053247.1583243-57-armbru@redhat.com>
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
Message-ID: <0a4e8a47-5d11-0864-8ad8-700922d08712@redhat.com>
Date: Wed, 10 Jun 2020 10:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200610053247.1583243-57-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus, Peter.

On 6/10/20 7:32 AM, Markus Armbruster wrote:
> All remaining conversions to qdev_realize() are for bus-less devices.
> Coccinelle script:
> 
>     // only correct for bus-less @dev!
> 
>     @@
>     expression errp;
>     expression dev;
>     @@
>     -    qdev_init_nofail(dev);
>     +    qdev_realize(dev, NULL, &error_fatal);
> 
>     @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c")@
>     expression errp;
>     expression dev;
>     symbol true;
>     @@
>     -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
>     +    qdev_realize(DEVICE(dev), NULL, errp);
> 
>     @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c")@
>     expression errp;
>     expression dev;
>     symbol true;
>     @@
>     -    object_property_set_bool(dev, true, "realized", errp);
>     +    qdev_realize(DEVICE(dev), NULL, errp);

Finally. Now my ealier suggestion is easier to explain:
Rename qdev_realize() -> sysbus_realize(), extracting the qdev_realize()
part. qdev_realize() doesn't take a Bus argument anymore.
Left for later.

> 
> Note that Coccinelle chokes on ARMSSE typedef vs. macro in
> hw/arm/armsse.c.  Worked around by temporarily renaming the macro for
> the spatch run.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/arm/allwinner-a10.c                   |  2 +-
>  hw/arm/allwinner-h3.c                    |  2 +-
>  hw/arm/armsse.c                          | 20 ++++++---------
>  hw/arm/armv7m.c                          |  2 +-
>  hw/arm/aspeed.c                          |  3 +--
>  hw/arm/aspeed_ast2600.c                  |  2 +-
>  hw/arm/aspeed_soc.c                      |  2 +-
>  hw/arm/bcm2836.c                         |  3 +--
>  hw/arm/cubieboard.c                      |  2 +-
>  hw/arm/digic.c                           |  2 +-
>  hw/arm/digic_boards.c                    |  2 +-
>  hw/arm/exynos4210.c                      |  4 +--
>  hw/arm/fsl-imx25.c                       |  2 +-
>  hw/arm/fsl-imx31.c                       |  2 +-
>  hw/arm/fsl-imx6.c                        |  2 +-
>  hw/arm/fsl-imx6ul.c                      |  3 +--
>  hw/arm/fsl-imx7.c                        |  2 +-
>  hw/arm/highbank.c                        |  2 +-
>  hw/arm/imx25_pdk.c                       |  2 +-
>  hw/arm/integratorcp.c                    |  2 +-
>  hw/arm/kzm.c                             |  2 +-
>  hw/arm/mcimx6ul-evk.c                    |  2 +-
>  hw/arm/mcimx7d-sabre.c                   |  2 +-
>  hw/arm/mps2-tz.c                         |  9 +++----
>  hw/arm/mps2.c                            |  7 +++---
>  hw/arm/musca.c                           |  6 ++---
>  hw/arm/orangepi.c                        |  2 +-
>  hw/arm/raspi.c                           |  2 +-
>  hw/arm/realview.c                        |  2 +-
>  hw/arm/sabrelite.c                       |  2 +-
>  hw/arm/sbsa-ref.c                        |  2 +-
>  hw/arm/stm32f205_soc.c                   |  2 +-
>  hw/arm/stm32f405_soc.c                   |  2 +-
>  hw/arm/versatilepb.c                     |  2 +-
>  hw/arm/vexpress.c                        |  2 +-
>  hw/arm/virt.c                            |  2 +-
>  hw/arm/xilinx_zynq.c                     |  2 +-
>  hw/arm/xlnx-versal.c                     |  2 +-
>  hw/arm/xlnx-zcu102.c                     |  2 +-
>  hw/arm/xlnx-zynqmp.c                     | 10 +++-----

Peter you might want to skim at the changes (other
ARM devices out of hw/arm/ involved) but to resume
basically these types are not SysBusDev:

- cpu
- soc / container
- or-gate / irq-splitter

I reviewed all of them.

Next is for Markus.

>  hw/char/serial-isa.c                     |  2 +-
>  hw/char/serial-pci-multi.c               |  2 +-
>  hw/char/serial-pci.c                     |  2 +-
>  hw/char/serial.c                         |  4 +--

I need to review again hw/char/serial-isa.c, it is
not clear why it is a container and not a SysBusDevice.

>  hw/ide/microdrive.c                      |  3 ++-

I never had to look at the PCMCIA devices, they seem
an unfinished attempt to plug a the devices on a bus.
Maybe it is finished, but the code is not clear (and
not documented). I need more time to review.

>  hw/intc/pnv_xive.c                       |  4 +--
>  hw/intc/spapr_xive.c                     |  4 +--
>  hw/intc/xics.c                           |  2 +-
>  hw/intc/xive.c                           |  2 +-
>  hw/pci-host/pnv_phb3.c                   |  6 ++---
>  hw/pci-host/pnv_phb4.c                   |  2 +-
>  hw/pci-host/pnv_phb4_pec.c               |  2 +-
>  hw/pci-host/prep.c                       |  3 +--
>  hw/ppc/pnv.c                             | 32 ++++++++++--------------
>  hw/ppc/pnv_bmc.c                         |  2 +-
>  hw/ppc/pnv_core.c                        |  2 +-
>  hw/ppc/pnv_psi.c                         |  4 +--
>  hw/ppc/spapr.c                           |  5 ++--
>  hw/ppc/spapr_cpu_core.c                  |  2 +-
>  hw/ppc/spapr_drc.c                       |  2 +-
>  hw/ppc/spapr_iommu.c                     |  2 +-
>  hw/ppc/spapr_irq.c                       |  2 +-

Wow, lot of QOM code for PPC hardware. Not all clear
yet, in particular the pci-host devices. Apparently
a LPC bus in the middle. Need a bit more time.

>  hw/s390x/s390-skeys.c                    |  2 +-
>  hw/s390x/s390-stattrib.c                 |  2 +-
>  hw/s390x/s390-virtio-ccw.c               |  4 +--
>  hw/s390x/sclp.c                          |  2 +-
>  hw/s390x/tod.c                           |  2 +-

Eh, odd s390x stuff. No clue, I might review it too.

>  target/i386/cpu.c                        |  3 +--

What is this APIC stuff doing burried with TCG?...

All the rest that is elided and not commented is reviewed.

When do you plan to send a pullreq?

Regards,

Phil.


