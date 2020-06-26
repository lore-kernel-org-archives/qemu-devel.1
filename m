Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0438C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E8720702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gePIGgoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E8720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1johil-00079f-Oi
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 02:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1johi9-0006d9-UB
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 02:19:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1johi6-0000Mu-Fq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 02:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593152376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BfNAf2+UNOEeAle5g08bx+pjDNJe9ViExa/ANm4txcQ=;
 b=gePIGgoWFxcBNCi2UxkIGOygoQE1Za4jiJE/YUPaY1g06kRYU2xUKz1bW9pcf9YRiaQL7T
 s162UCIsE3mUdbD9Kgjlkqcmsc8jR2QW08DkOKBOED9giBbmhNXrjdPV26bq+JB3lE2Py4
 ahcQra59Q6VNh5qt2ZWFx0YxIfyRSQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-OiFSOcQYNAuZI6QmV5ngTw-1; Fri, 26 Jun 2020 02:19:32 -0400
X-MC-Unique: OiFSOcQYNAuZI6QmV5ngTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA058064B2;
 Fri, 26 Jun 2020 06:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA8A7C1FE;
 Fri, 26 Jun 2020 06:19:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84A9D11384D4; Fri, 26 Jun 2020 08:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 03/46] qdev: Smooth error checking of qdev_realize() &
 friends
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-4-armbru@redhat.com>
 <f75c7f3b-477f-f662-5239-87a14c996aa8@virtuozzo.com>
Date: Fri, 26 Jun 2020 08:19:29 +0200
In-Reply-To: <f75c7f3b-477f-f662-5239-87a14c996aa8@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 25 Jun 2020 22:00:36 +0300")
Message-ID: <87tuyys61a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> Convert
>>
>>      foo(..., &err);
>>      if (err) {
>>          ...
>>      }
>>
>> to
>>
>>      if (!foo(..., &err)) {
>>          ...
>>      }
>>
>> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
>> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
>> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
>> Coccinelle script:
>
> Please, also mention a command to run the script
>
>>
>>      @@
>>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>>      expression list args, args2;
>>      typedef Error;
>>      Error *err;
>>      identifier errp;
>>      @@
>>      -      fun(args, &err, args2);
>>      -      if (err) {
>>      +      if (!fun(args, errp, args2)) {
>> 	       ... when != err
>>      -	   error_propagate(errp, err);
>> 	       ...
>> 	   }
>>
>>      @@
>>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>>      expression list args, args2;
>>      typedef Error;
>>      Error *err;
>>      @@
>>      -      fun(args, &err, args2);
>>      -      if (err) {
>>      +      if (!fun(args, &err, args2)) {
>> 	       ...
>> 	   }
>>
>> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
>> ARMSSE being used both as typedef and function-like macro there.
>> Convert manually.
>>
>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>> that are now unused.  Clean up whitespace.
>>
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>> ---
>>   hw/arm/allwinner-a10.c          |  21 ++-----
>>   hw/arm/armsse.c                 | 104 ++++++++------------------------
>>   hw/arm/armv7m.c                 |  12 +---
>>   hw/arm/aspeed_ast2600.c         |  68 ++++++---------------
>>   hw/arm/aspeed_soc.c             |  60 +++++-------------
>>   hw/arm/bcm2835_peripherals.c    |  60 +++++-------------
>>   hw/arm/bcm2836.c                |  12 +---
>>   hw/arm/cubieboard.c             |   3 +-
>>   hw/arm/digic.c                  |  12 +---
>>   hw/arm/digic_boards.c           |   3 +-
>>   hw/arm/fsl-imx25.c              |  44 ++++----------
>>   hw/arm/fsl-imx31.c              |  32 +++-------
>>   hw/arm/fsl-imx6.c               |  48 ++++-----------
>>   hw/arm/msf2-soc.c               |  21 ++-----
>>   hw/arm/nrf51_soc.c              |  24 ++------
>>   hw/arm/stm32f205_soc.c          |  29 +++------
>>   hw/arm/stm32f405_soc.c          |  32 +++-------
>>   hw/arm/xlnx-zynqmp.c            |  61 +++++--------------
>>   hw/block/fdc.c                  |   4 +-
>>   hw/block/xen-block.c            |   3 +-
>>   hw/char/serial-pci-multi.c      |   5 +-
>>   hw/char/serial-pci.c            |   5 +-
>>   hw/char/serial.c                |  10 +--
>>   hw/core/cpu.c                   |   3 +-
>>   hw/cpu/a15mpcore.c              |   5 +-
>>   hw/cpu/a9mpcore.c               |  21 ++-----
>>   hw/cpu/arm11mpcore.c            |  17 ++----
>>   hw/cpu/realview_mpcore.c        |   9 +--
>>   hw/display/virtio-gpu-pci.c     |   6 +-
>>   hw/display/virtio-vga.c         |   5 +-
>>   hw/intc/armv7m_nvic.c           |   9 +--
>>   hw/intc/pnv_xive.c              |   8 +--
>>   hw/intc/realview_gic.c          |   5 +-
>>   hw/intc/spapr_xive.c            |   8 +--
>>   hw/intc/xics.c                  |   5 +-
>>   hw/intc/xive.c                  |   3 +-
>>   hw/isa/piix4.c                  |   5 +-
>>   hw/microblaze/xlnx-zynqmp-pmu.c |   9 +--
>>   hw/mips/cps.c                   |  17 ++----
>>   hw/misc/macio/cuda.c            |   5 +-
>>   hw/misc/macio/macio.c           |  25 ++------
>>   hw/misc/macio/pmu.c             |   5 +-
>>   hw/pci-host/pnv_phb3.c          |  13 +---
>>   hw/pci-host/pnv_phb4.c          |   5 +-
>>   hw/pci-host/pnv_phb4_pec.c      |   5 +-
>>   hw/ppc/e500.c                   |   5 +-
>>   hw/ppc/pnv.c                    |  53 ++++------------
>>   hw/ppc/pnv_core.c               |   4 +-
>>   hw/ppc/pnv_psi.c                |   9 +--
>>   hw/ppc/spapr_cpu_core.c         |   3 +-
>>   hw/ppc/spapr_irq.c              |   5 +-
>>   hw/riscv/opentitan.c            |   9 +--
>>   hw/riscv/sifive_e.c             |   6 +-
>>   hw/riscv/sifive_u.c             |   5 +-
>>   hw/s390x/event-facility.c       |  13 ++--
>>   hw/s390x/s390-pci-bus.c         |   3 +-
>>   hw/s390x/sclp.c                 |   3 +-
>>   hw/s390x/virtio-ccw-crypto.c    |   5 +-
>>   hw/s390x/virtio-ccw-rng.c       |   5 +-
>>   hw/scsi/scsi-bus.c              |   4 +-
>>   hw/sd/aspeed_sdhci.c            |   4 +-
>>   hw/sd/ssi-sd.c                  |   3 +-
>>   hw/usb/bus.c                    |   3 +-
>>   hw/virtio/virtio-rng-pci.c      |   5 +-
>>   qdev-monitor.c                  |   3 +-
>>  65 files changed, 248 insertions(+), 768 deletions(-)
>
> Almost all of this diff-stat may be generated by more obvious script:
>
> @rule1@
> identifier fun = {qdev_realize, qdev_realize_and_unref, sysbus_realize};
> expression list args;
> typedef Error;
> Error *err;
> identifier errp;
> @@
>
> -      fun(args, &err);
> -      if (err)
> +      if (!fun(args, errp))
>        {
> -              error_propagate(errp, err);
>            return;
>        }
>
> @depends on rule1@
> identifier err;
> @@
>
> -    Error *err = NULL;
>      ... when != err
>
>
> ===
> Script started by command
> spatch --sp-file x.cocci --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff --max-width 80 --use-gitgrep hw
>
> You see, I consider only obvious case, where we have only error_propagate + return in the if. I suggest to make a separate generated patch, based on my cocci script (it's mostly yours, actually), and as a second patch - the remaining of your patch. I do think that this will simplify the review.

I can try this idea.  It's not just this patch, though, it's four more:
PATCH 17+23+38+42.

> diffstat generated by my cocci script:
>  50 files changed, 230 insertions(+), 725 deletions(-)
>
> Difference with your patch, considering only files, touched by new script is very small:
>
> [root@kvm error-smooth-my-try]# git diff --name-only | xargs git diff bbdd4596d3e3290 --
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 416adfcce0..cacfcbac54 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -185,6 +185,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      const struct MemmapEntry *memmap = sifive_e_memmap;
> +
>      SiFiveESoCState *s = RISCV_E_SOC(dev);
>      MemoryRegion *sys_mem = get_system_memory();
>  diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 645b4080c5..32ff015c2c 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -442,13 +442,15 @@ static void init_event_facility(Object *obj)
>  static void realize_event_facility(DeviceState *dev, Error **errp)
>  {
>      SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
> +    Error *local_err = NULL;
>  -    if (!qdev_realize(DEVICE(&event_facility->quiesce),
> -                      BUS(&event_facility->sbus), errp)) {
> +    if (!qdev_realize(DEVICE(&event_facility->quiesce), BUS(&event_facility->sbus), errp)) {
>          return;
>      }
> -    if (!qdev_realize(DEVICE(&event_facility->cpu_hotplug),
> -                      BUS(&event_facility->sbus), errp)) {
> +    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
> +                 BUS(&event_facility->sbus), &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          qdev_unrealize(DEVICE(&event_facility->quiesce));
>          return;
>      }
>
>
>
> - Hmm, strange, "--max-width 80" doesn't help. So, we may keep the patch fully-generated with only one over-80 line, or write in commit message that the only manual fix is one over-80 line wrapping in hw/s390x/event-facility.c

In my experience, I need to correct Coccinelle's spacing more often than
not.  I usually don't bother to enumerate my corrections one by one, I
only document what kind of corrections I made.


