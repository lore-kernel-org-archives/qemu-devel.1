Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D0DCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 15:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887C02067D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ENW0tbTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887C02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPTrQ-0003OW-Ix
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 11:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iPToT-00010x-K4
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 11:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iPToS-0003yP-4I
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 11:53:41 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:51646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iPToN-0003QA-QW; Tue, 29 Oct 2019 11:53:36 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F34F196EF0;
 Tue, 29 Oct 2019 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1572364412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqYpBlQ+UJk/As859C5hEMl6cmn01c4p9ov5XUh86og=;
 b=ENW0tbTmm9meiaO5aRnU0Y1xQRt6cv+WO5oPONDSe+lsnR0sBrl1PPk5WhefCyU1En/g5H
 uGajJhAAjAHcHO3fbdPpQnCli0LQlGXckIz1UC03DiM0Dt8A/pofDwmardaWCtVM92BF1E
 bUwqHEZmTRsPzkrLvGtzBAeJqgWxsZY=
Subject: Re: [PATCH v5 00/13] Multi-phase reset mechanism
To: qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <efef625a-8162-5454-128f-489d636563a1@greensocs.com>
Date: Tue, 29 Oct 2019 16:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1572364412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqYpBlQ+UJk/As859C5hEMl6cmn01c4p9ov5XUh86og=;
 b=tzeIYgYJTJP8HLcorleQ4nsHOlN4YE+4qMtP1bQS5s/vTnK8tNca0n8q9oBZgw4M+OVZip
 86zduxrP+F0L2R54KtEAXdUFS1Y1VyBDkDbcGv3u9qq619S8bED++0PJkDoFqnd2Bzwpt2
 IHyWnrZG0p5AoZcY3LA5gKqfg51GxqY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1572364412; a=rsa-sha256; cv=none;
 b=tYr7Cytk79AypKCLKkok71kSJVHhrlgOyqxI/qTY3O6dmr6mDns4U43WfQZNI307V13Joe
 +xDVpYUxy2LMS1q1qQNkG9mruDI/Zxj/woHcnZXwqcwp0i2B91fe5vYAC2LMl+KnMo2/Bm
 Sd5hASXKyiJV3iAch0Cfsq8AWu97dsI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Does anyone has comment about the interface / patch 3 ?
Should I try to split it ?

Thanks,
Damien

On 10/18/19 5:06 PM, Damien Hedde wrote:
> Hi all,
> 
> The purpose of this series is to split the current reset procedure
> into multiple phases. This will help to solve some ordering
> difficulties we have during reset. Previous version can be found here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg04359.html
> 
> This series adds resettable interface and transitions base Device and
> Bus classes (sysbus subclasses are ok too). It provides new reset
> functions but does not switch anymore the old functions
> (device_reset() and qdev/qbus_reset_all()) to resettable interface.
> These functions keep the exact same behavior as before.
> 
> The series also transition the main reset handlers registration which
> has no impact until devices and buses are transitioned.
> 
> I think this version is way better regarding the transition from the
> legacy to the resettable interface than the previous one.
> After this series, the plan is then to transition devices, buses and
> legacy reset call sites. Devices and buses have to be transitioned
> from mother class to daughter classes order but until the final
> (daughter) class is transitioned, old monolitic reset behavior will
> be kept for this class.
> 
> Changes v4 -> v5:
>   + various improvement in the resettable interface (regarding
>     transition, robustness and several reset types)
>   + better handling of transition from legacy reset to resettable
>   + device hotplug and parent bus 'hot' change support
>   + improved doc with examples and converted to rst format
> 
> Regarding the Resettable interface changes and how to handle more
> reset types, please read patch 3 message.
> 
> The series is organized as follows:
> Patch 1 is unmodified. Patch 2 adds some utility trace events.
> Patches 3 to 8 adds resettable api in devices and buses. Patch 9 adds
> some documentation. Patches 10 and 11 transition the call sites of
> qemu_register_reset(qdev/qbus_reset_all_fn, ...).
> 
> Apart from patch 7 about hotplug which is really a rfc. I think other
> patches are in pretty good shape.
> Patch 3 and 4 are quite big but I don't think it make much sense to
> split them. I could give it a try if you think it will ease reviews.
> Note that depending on what name we choose for device/bus reset
> functions (see patch 8), we may finally don't need patch 1.
> 
> I've also added patches 12 and 13 which handle the raspi sd card
> reparenting. I'm not sure they fit well in this series but at some
> point in this development I thought they had to be before patch 9
> (finally it is not the case). Since I had to develop some specific
> resettable support just for this case , I kept them as an example
> of what transition a device is. Note that patch 13 handle the only
> reset parent change (tricky) case I found (apart from hotplug).
> 
> Thanks for your feedback,
> Damien
> 
> Damien Hedde (13):
>   add device_legacy_reset function to prepare for reset api change
>   hw/core/qdev: add trace events to help with resettable transition
>   hw/core: create Resettable QOM interface
>   hw/core: add Resettable support to BusClass and DeviceClass
>   hw/core/resettable: add support for changing parent
>   hw/core/qdev: handle parent bus change regarding resettable
>   hw/core/qdev: update hotplug reset regarding resettable
>   hw/core: deprecate old reset functions and introduce new ones
>   docs/devel/reset.txt: add doc about Resettable interface
>   vl: replace deprecated qbus_reset_all registration
>   hw/s390x/ipl: replace deprecated qdev_reset_all registration
>   hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
>   hw/gpio/bcm2835_gpio: Update to resettable
> 
>  Makefile.objs            |   1 +
>  docs/devel/reset.rst     | 282 ++++++++++++++++++++++++++++++++++++++
>  hw/audio/intel-hda.c     |   2 +-
>  hw/core/Makefile.objs    |   1 +
>  hw/core/bus.c            | 102 ++++++++++++++
>  hw/core/qdev.c           | 156 +++++++++++++++++++--
>  hw/core/resettable.c     | 289 +++++++++++++++++++++++++++++++++++++++
>  hw/core/trace-events     |  27 ++++
>  hw/gpio/bcm2835_gpio.c   |  31 +++--
>  hw/hyperv/hyperv.c       |   2 +-
>  hw/i386/pc.c             |   2 +-
>  hw/ide/microdrive.c      |   8 +-
>  hw/intc/spapr_xive.c     |   2 +-
>  hw/ppc/pnv_psi.c         |   2 +-
>  hw/ppc/spapr_pci.c       |   2 +-
>  hw/ppc/spapr_vio.c       |   2 +-
>  hw/s390x/ipl.c           |  10 +-
>  hw/s390x/s390-pci-inst.c |   2 +-
>  hw/scsi/vmw_pvscsi.c     |   2 +-
>  hw/sd/omap_mmc.c         |   2 +-
>  hw/sd/pl181.c            |   2 +-
>  include/hw/qdev-core.h   |  58 +++++++-
>  include/hw/resettable.h  | 224 ++++++++++++++++++++++++++++++
>  tests/Makefile.include   |   1 +
>  vl.c                     |  10 +-
>  25 files changed, 1185 insertions(+), 37 deletions(-)
>  create mode 100644 docs/devel/reset.rst
>  create mode 100644 hw/core/resettable.c
>  create mode 100644 include/hw/resettable.h
> 

