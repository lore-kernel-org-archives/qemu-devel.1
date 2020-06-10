Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F6FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9D5204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOz1ybR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9D5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixBy-000312-KZ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 05:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jixBM-0002IX-45
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:38:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jixBK-0000nK-0P
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591781880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3ylGyhNWx18vTtyhSRrRNVaT648sGai1d/pNJDWsyc=;
 b=AOz1ybR/QF1Wem9fA0mMcBB8wHm9K1X76yMg0apLhnxWNPA/ob1e9AXq3FC6WgiP+4oBHA
 130qz7T4y+SeHAjp/P5XUwqCtvaXgjcK9cBrFy3QLGWkwNhQmKQqrClFz4AAz013y10/Jp
 bmv6cLteNRu30HAZooOT2qfQvnM6rqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-TSpgZkIvM6yB7TGKZo8yag-1; Wed, 10 Jun 2020 05:37:59 -0400
X-MC-Unique: TSpgZkIvM6yB7TGKZo8yag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3E561883600;
 Wed, 10 Jun 2020 09:37:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73EA21002382;
 Wed, 10 Jun 2020 09:37:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0767A11386A6; Wed, 10 Jun 2020 11:37:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH RESEND v3 56/58] qdev: Convert bus-less devices to
 qdev_realize() with Coccinelle
References: <20200610053247.1583243-1-armbru@redhat.com>
 <20200610053247.1583243-57-armbru@redhat.com>
 <0a4e8a47-5d11-0864-8ad8-700922d08712@redhat.com>
Date: Wed, 10 Jun 2020 11:37:55 +0200
In-Reply-To: <0a4e8a47-5d11-0864-8ad8-700922d08712@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 10 Jun 2020 10:21:05
 +0200")
Message-ID: <87sgf3feh8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus, Peter.
>
> On 6/10/20 7:32 AM, Markus Armbruster wrote:
>> All remaining conversions to qdev_realize() are for bus-less devices.
>> Coccinelle script:
>>=20
>>     // only correct for bus-less @dev!
>>=20
>>     @@
>>     expression errp;
>>     expression dev;
>>     @@
>>     -    qdev_init_nofail(dev);
>>     +    qdev_realize(dev, NULL, &error_fatal);
>>=20
>>     @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c=
")@
>>     expression errp;
>>     expression dev;
>>     symbol true;
>>     @@
>>     -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
>>     +    qdev_realize(DEVICE(dev), NULL, errp);
>>=20
>>     @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c=
")@
>>     expression errp;
>>     expression dev;
>>     symbol true;
>>     @@
>>     -    object_property_set_bool(dev, true, "realized", errp);
>>     +    qdev_realize(DEVICE(dev), NULL, errp);
>
> Finally. Now my ealier suggestion is easier to explain:
> Rename qdev_realize() -> sysbus_realize(), extracting the qdev_realize()
> part. qdev_realize() doesn't take a Bus argument anymore.
> Left for later.

I'm still confused.

Cases:

* Devices that plug into a bus: use qdev_realize() passing that bus.

  If there is a bus-specific wrapper, use that, for legibility.

  In particular, use sysbus_realize() for sysbus devices plugging into
  the main system bus.

* Devices that don't plug into a bus: use qdev_realize() passing a null
  bus.

What would you like me to improve here?

>
>>=20
>> Note that Coccinelle chokes on ARMSSE typedef vs. macro in
>> hw/arm/armsse.c.  Worked around by temporarily renaming the macro for
>> the spatch run.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/arm/allwinner-a10.c                   |  2 +-
>>  hw/arm/allwinner-h3.c                    |  2 +-
>>  hw/arm/armsse.c                          | 20 ++++++---------
>>  hw/arm/armv7m.c                          |  2 +-
>>  hw/arm/aspeed.c                          |  3 +--
>>  hw/arm/aspeed_ast2600.c                  |  2 +-
>>  hw/arm/aspeed_soc.c                      |  2 +-
>>  hw/arm/bcm2836.c                         |  3 +--
>>  hw/arm/cubieboard.c                      |  2 +-
>>  hw/arm/digic.c                           |  2 +-
>>  hw/arm/digic_boards.c                    |  2 +-
>>  hw/arm/exynos4210.c                      |  4 +--
>>  hw/arm/fsl-imx25.c                       |  2 +-
>>  hw/arm/fsl-imx31.c                       |  2 +-
>>  hw/arm/fsl-imx6.c                        |  2 +-
>>  hw/arm/fsl-imx6ul.c                      |  3 +--
>>  hw/arm/fsl-imx7.c                        |  2 +-
>>  hw/arm/highbank.c                        |  2 +-
>>  hw/arm/imx25_pdk.c                       |  2 +-
>>  hw/arm/integratorcp.c                    |  2 +-
>>  hw/arm/kzm.c                             |  2 +-
>>  hw/arm/mcimx6ul-evk.c                    |  2 +-
>>  hw/arm/mcimx7d-sabre.c                   |  2 +-
>>  hw/arm/mps2-tz.c                         |  9 +++----
>>  hw/arm/mps2.c                            |  7 +++---
>>  hw/arm/musca.c                           |  6 ++---
>>  hw/arm/orangepi.c                        |  2 +-
>>  hw/arm/raspi.c                           |  2 +-
>>  hw/arm/realview.c                        |  2 +-
>>  hw/arm/sabrelite.c                       |  2 +-
>>  hw/arm/sbsa-ref.c                        |  2 +-
>>  hw/arm/stm32f205_soc.c                   |  2 +-
>>  hw/arm/stm32f405_soc.c                   |  2 +-
>>  hw/arm/versatilepb.c                     |  2 +-
>>  hw/arm/vexpress.c                        |  2 +-
>>  hw/arm/virt.c                            |  2 +-
>>  hw/arm/xilinx_zynq.c                     |  2 +-
>>  hw/arm/xlnx-versal.c                     |  2 +-
>>  hw/arm/xlnx-zcu102.c                     |  2 +-
>>  hw/arm/xlnx-zynqmp.c                     | 10 +++-----
>
> Peter you might want to skim at the changes (other
> ARM devices out of hw/arm/ involved) but to resume
> basically these types are not SysBusDev:
>
> - cpu
> - soc / container
> - or-gate / irq-splitter
>
> I reviewed all of them.
>
> Next is for Markus.
>
>>  hw/char/serial-isa.c                     |  2 +-
>>  hw/char/serial-pci-multi.c               |  2 +-
>>  hw/char/serial-pci.c                     |  2 +-
>>  hw/char/serial.c                         |  4 +--
>
> I need to review again hw/char/serial-isa.c, it is
> not clear why it is a container and not a SysBusDevice.

TYPE_SERIAL is a bus-less TYPE_DEVICE.

TYPE_ISA_SERIAL is its adapter for the ISA bus.  It contains one
TYPE_SERIAL child.

TYPE_SERIAL_MM is its adapter for the sysbus pseudo-bus.  It contains
one TYPE_SERIAL child.

TYPE_PCI_SERIAL, "pci-serial-2x", "pci-serial-4x" are adapters for the
PCI bus.  They contain one, two and four TYPE_SERIAL respectively.

Exemplary use of QOM, I think.

>>  hw/ide/microdrive.c                      |  3 ++-
>
> I never had to look at the PCMCIA devices, they seem
> an unfinished attempt to plug a the devices on a bus.
> Maybe it is finished, but the code is not clear (and
> not documented). I need more time to review.
>
>>  hw/intc/pnv_xive.c                       |  4 +--
>>  hw/intc/spapr_xive.c                     |  4 +--
>>  hw/intc/xics.c                           |  2 +-
>>  hw/intc/xive.c                           |  2 +-
>>  hw/pci-host/pnv_phb3.c                   |  6 ++---
>>  hw/pci-host/pnv_phb4.c                   |  2 +-
>>  hw/pci-host/pnv_phb4_pec.c               |  2 +-
>>  hw/pci-host/prep.c                       |  3 +--
>>  hw/ppc/pnv.c                             | 32 ++++++++++--------------
>>  hw/ppc/pnv_bmc.c                         |  2 +-
>>  hw/ppc/pnv_core.c                        |  2 +-
>>  hw/ppc/pnv_psi.c                         |  4 +--
>>  hw/ppc/spapr.c                           |  5 ++--
>>  hw/ppc/spapr_cpu_core.c                  |  2 +-
>>  hw/ppc/spapr_drc.c                       |  2 +-
>>  hw/ppc/spapr_iommu.c                     |  2 +-
>>  hw/ppc/spapr_irq.c                       |  2 +-
>
> Wow, lot of QOM code for PPC hardware. Not all clear
> yet, in particular the pci-host devices. Apparently
> a LPC bus in the middle. Need a bit more time.
>
>>  hw/s390x/s390-skeys.c                    |  2 +-
>>  hw/s390x/s390-stattrib.c                 |  2 +-
>>  hw/s390x/s390-virtio-ccw.c               |  4 +--
>>  hw/s390x/sclp.c                          |  2 +-
>>  hw/s390x/tod.c                           |  2 +-
>
> Eh, odd s390x stuff. No clue, I might review it too.
>
>>  target/i386/cpu.c                        |  3 +--
>
> What is this APIC stuff doing burried with TCG?...
>
> All the rest that is elided and not commented is reviewed.
>
> When do you plan to send a pullreq?

I want to get this wrapped as quickly as possible; rebasing has been
quite a time sink.  But not at the price of rushed review.


