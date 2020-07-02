Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38199C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F4D20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+LWNT4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F4D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0ek-0007Jl-9o
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr0e5-0006NC-Dz
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:57:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr0e2-0006Fs-Rr
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593701817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sm7ijuKCgEejrMqORXBLIJQwttgafgjtZjdBi7Dnnrw=;
 b=S+LWNT4V/4rN5daGve+lYbYCRWjpl2vODUL4wR9RuG0bESiYXI5ZGPko/bhmXw1uEy1PrH
 D/axWSokNR5ZPrdKEGiX3XMgLujsn8tyqfvSIchWU3XU/WIYCkChE/sr5a6nrIpXLptF9O
 mtYphJBysFU6mMQd70SfVBbPNVbsdO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-UkxrAnZ1PHCXXGHdtK7kwQ-1; Thu, 02 Jul 2020 10:56:56 -0400
X-MC-Unique: UkxrAnZ1PHCXXGHdtK7kwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D530D19057A0;
 Thu,  2 Jul 2020 14:56:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 464CC10016DA;
 Thu,  2 Jul 2020 14:56:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BEEB51138648; Thu,  2 Jul 2020 16:56:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 03/46] qdev: Smooth error checking of qdev_realize() &
 friends
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-4-armbru@redhat.com>
 <f75c7f3b-477f-f662-5239-87a14c996aa8@virtuozzo.com>
 <87tuyys61a.fsf@dusky.pond.sub.org>
Date: Thu, 02 Jul 2020 16:56:52 +0200
In-Reply-To: <87tuyys61a.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 26 Jun 2020 08:19:29 +0200")
Message-ID: <87v9j655jf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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

Markus Armbruster <armbru@redhat.com> writes:

> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>
>> 24.06.2020 19:43, Markus Armbruster wrote:
>>> Convert
>>>
>>>      foo(..., &err);
>>>      if (err) {
>>>          ...
>>>      }
>>>
>>> to
>>>
>>>      if (!foo(..., &err)) {
>>>          ...
>>>      }
>>>
>>> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
>>> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
>>> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
>>> Coccinelle script:
>>
>> Please, also mention a command to run the script
>>
>>>
>>>      @@
>>>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>>>      expression list args, args2;
>>>      typedef Error;
>>>      Error *err;
>>>      identifier errp;
>>>      @@
>>>      -      fun(args, &err, args2);
>>>      -      if (err) {
>>>      +      if (!fun(args, errp, args2)) {
>>> 	       ... when != err
>>>      -	   error_propagate(errp, err);
>>> 	       ...
>>> 	   }
>>>
>>>      @@
>>>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>>>      expression list args, args2;
>>>      typedef Error;
>>>      Error *err;
>>>      @@
>>>      -      fun(args, &err, args2);
>>>      -      if (err) {
>>>      +      if (!fun(args, &err, args2)) {
>>> 	       ...
>>> 	   }
>>>
>>> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
>>> ARMSSE being used both as typedef and function-like macro there.
>>> Convert manually.
>>>
>>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>>> that are now unused.  Clean up whitespace.
>>>
>>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>>> ---
>>>   hw/arm/allwinner-a10.c          |  21 ++-----
>>>   hw/arm/armsse.c                 | 104 ++++++++------------------------
>>>   hw/arm/armv7m.c                 |  12 +---
>>>   hw/arm/aspeed_ast2600.c         |  68 ++++++---------------
>>>   hw/arm/aspeed_soc.c             |  60 +++++-------------
>>>   hw/arm/bcm2835_peripherals.c    |  60 +++++-------------
>>>   hw/arm/bcm2836.c                |  12 +---
>>>   hw/arm/cubieboard.c             |   3 +-
>>>   hw/arm/digic.c                  |  12 +---
>>>   hw/arm/digic_boards.c           |   3 +-
>>>   hw/arm/fsl-imx25.c              |  44 ++++----------
>>>   hw/arm/fsl-imx31.c              |  32 +++-------
>>>   hw/arm/fsl-imx6.c               |  48 ++++-----------
>>>   hw/arm/msf2-soc.c               |  21 ++-----
>>>   hw/arm/nrf51_soc.c              |  24 ++------
>>>   hw/arm/stm32f205_soc.c          |  29 +++------
>>>   hw/arm/stm32f405_soc.c          |  32 +++-------
>>>   hw/arm/xlnx-zynqmp.c            |  61 +++++--------------
>>>   hw/block/fdc.c                  |   4 +-
>>>   hw/block/xen-block.c            |   3 +-
>>>   hw/char/serial-pci-multi.c      |   5 +-
>>>   hw/char/serial-pci.c            |   5 +-
>>>   hw/char/serial.c                |  10 +--
>>>   hw/core/cpu.c                   |   3 +-
>>>   hw/cpu/a15mpcore.c              |   5 +-
>>>   hw/cpu/a9mpcore.c               |  21 ++-----
>>>   hw/cpu/arm11mpcore.c            |  17 ++----
>>>   hw/cpu/realview_mpcore.c        |   9 +--
>>>   hw/display/virtio-gpu-pci.c     |   6 +-
>>>   hw/display/virtio-vga.c         |   5 +-
>>>   hw/intc/armv7m_nvic.c           |   9 +--
>>>   hw/intc/pnv_xive.c              |   8 +--
>>>   hw/intc/realview_gic.c          |   5 +-
>>>   hw/intc/spapr_xive.c            |   8 +--
>>>   hw/intc/xics.c                  |   5 +-
>>>   hw/intc/xive.c                  |   3 +-
>>>   hw/isa/piix4.c                  |   5 +-
>>>   hw/microblaze/xlnx-zynqmp-pmu.c |   9 +--
>>>   hw/mips/cps.c                   |  17 ++----
>>>   hw/misc/macio/cuda.c            |   5 +-
>>>   hw/misc/macio/macio.c           |  25 ++------
>>>   hw/misc/macio/pmu.c             |   5 +-
>>>   hw/pci-host/pnv_phb3.c          |  13 +---
>>>   hw/pci-host/pnv_phb4.c          |   5 +-
>>>   hw/pci-host/pnv_phb4_pec.c      |   5 +-
>>>   hw/ppc/e500.c                   |   5 +-
>>>   hw/ppc/pnv.c                    |  53 ++++------------
>>>   hw/ppc/pnv_core.c               |   4 +-
>>>   hw/ppc/pnv_psi.c                |   9 +--
>>>   hw/ppc/spapr_cpu_core.c         |   3 +-
>>>   hw/ppc/spapr_irq.c              |   5 +-
>>>   hw/riscv/opentitan.c            |   9 +--
>>>   hw/riscv/sifive_e.c             |   6 +-
>>>   hw/riscv/sifive_u.c             |   5 +-
>>>   hw/s390x/event-facility.c       |  13 ++--
>>>   hw/s390x/s390-pci-bus.c         |   3 +-
>>>   hw/s390x/sclp.c                 |   3 +-
>>>   hw/s390x/virtio-ccw-crypto.c    |   5 +-
>>>   hw/s390x/virtio-ccw-rng.c       |   5 +-
>>>   hw/scsi/scsi-bus.c              |   4 +-
>>>   hw/sd/aspeed_sdhci.c            |   4 +-
>>>   hw/sd/ssi-sd.c                  |   3 +-
>>>   hw/usb/bus.c                    |   3 +-
>>>   hw/virtio/virtio-rng-pci.c      |   5 +-
>>>   qdev-monitor.c                  |   3 +-
>>>  65 files changed, 248 insertions(+), 768 deletions(-)
>>
>> Almost all of this diff-stat may be generated by more obvious script:
>>
>> @rule1@
>> identifier fun = {qdev_realize, qdev_realize_and_unref, sysbus_realize};
>> expression list args;
>> typedef Error;
>> Error *err;
>> identifier errp;
>> @@
>>
>> -      fun(args, &err);
>> -      if (err)
>> +      if (!fun(args, errp))
>>        {
>> -              error_propagate(errp, err);
>>            return;
>>        }
>>
>> @depends on rule1@
>> identifier err;
>> @@
>>
>> -    Error *err = NULL;
>>      ... when != err
>>
>>
>> ===
>> Script started by command
>> spatch --sp-file x.cocci --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff --max-width 80 --use-gitgrep hw
>>
>> You see, I consider only obvious case, where we have only error_propagate + return in the if. I suggest to make a separate generated patch, based on my cocci script (it's mostly yours, actually), and as a second patch - the remaining of your patch. I do think that this will simplify the review.
>
> I can try this idea.  It's not just this patch, though, it's four more:
> PATCH 17+23+38+42.

I did this instead for v2:

* Use a trivial, safe script for converting to use the returned bool to
  check for failure.

  65 files changed, 248 insertions(+), 495 deletions(-)
  32 files changed, 71 insertions(+), 132 deletions(-)
  46 files changed, 97 insertions(+), 188 deletions(-)
  28 files changed, 96 insertions(+), 142 deletions(-)
  3 files changed, 4 insertions(+), 7 deletions(-)

* Use a an admittedly more complex script for eliminating many
  error_propagate().  I consider the script safe.  I believe it's
  reasonably easy to understand.

  114 files changed, 376 insertions(+), 884 deletions(-)

* Use an unsafe variant of the same script for eliminating a few more:

  23 files changed, 32 insertions(+), 78 deletions(-)

Even though rather I like how it came out, it may have been a bad idea,
because time's awfully short now.


