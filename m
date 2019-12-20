Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B01C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991EB24679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="6u72EZ9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991EB24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGqw-0003rf-LB
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGnw-00025O-Qp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiGnu-0006Iv-OS
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:50:48 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:45116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iiGnu-00066i-1G; Fri, 20 Dec 2019 06:50:46 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id A697496EF0;
 Fri, 20 Dec 2019 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576842642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ixGGzzdtrpfyATquHXyFz8FQ0rIGfLb+kLrO78gP98I=;
 b=6u72EZ9Y6xrfH/YNv5LxKM8UVaQPA5BMxIKiQQ/ufCXAQjarSnLcZh1EnnsvwraDSD99v5
 YnVGkGQSNDz+/Xs0q9yEyb/Aa/Vs1/qrZS++mJ8hTdmf5S9JFYBmrwC15HVV4+v8+nsgf4
 3JZOW5VEGqZc2Me3Ma/PvLhxvK5TxUc=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/11] Multi-phase reset mechanism
Date: Fri, 20 Dec 2019 12:50:24 +0100
Message-Id: <20191220115035.709876-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576842642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ixGGzzdtrpfyATquHXyFz8FQ0rIGfLb+kLrO78gP98I=;
 b=bWWaJJKUvxvKTzCPyhnXJ8CW5lxKXXY+jcb+dsCcrxP+i3nMfLidaXO71WIo+ItTTLhyoQ
 e7HS2rHpj5LEKt9k85VruPfuGjA6aHDlEQ8VgndvhXfWoAcNf3mccdtUDFFkx6wxXxRIlc
 CDlDjdLKWKHhYw7X8Rz1ld6702HBw+s=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576842642; a=rsa-sha256; cv=none;
 b=Dam3fXmxJxswu7vsfG1UclWoNnnr506OdgZ92Z8GkW1w1TSZlqMaW0s0ldwp7xFKQB90mn
 ANSTgRqpZGuCjR4VS2lX3/37DbGPnQuwZZrH+FkelqiVjs7kqmkZDiSlss5ov4yY/BVWVQ
 67i7s3BBWMoVJEv8lq1XFhiJV0kubpg=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

The purpose of this series is to split the current reset procedure
into multiple phases. This will help to solve some ordering
difficulties we have during reset.

Very few changes since last version (see below for the detail). Hotplug
patch (no. 7) was in fact ok. To have details about hotplug (and new
partial plug), see this related discussion:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04897.html

Only patches 5 and 7 still need a review.

This series adds resettable interface and transitions base Device and
Bus classes (sysbus subclasses are ok too). It provides new reset
functions but does not switch anymore the old functions
(device_reset() and qdev/qbus_reset_all()) to resettable interface.
These functions keep the exact same behavior as before.

The series also transition the main reset handlers registration which
has no impact until devices and buses are transitioned.

The series is organized as follows:
Patch 1 is unmodified. Patch 2 adds some utility trace events.
Patches 3 to 8 adds resettable api in devices and buses. Patch 9 adds
some documentation. Patches 10 and 11 transition the call sites of
qemu_register_reset(qdev/qbus_reset_all_fn, ...).

After this series, the plan is then to transition devices, buses and
legacy reset call sites. Devices and buses have to be transitioned
from mother class to daughter classes order but until the final
(daughter) class is transitioned, old monolitic reset behavior will
be kept for this class.

Thanks for your feedback,
Damien

v6:
  + patch 1
    - update (microvm machine) (rebase)
  + patch 2
    - added more info in trace_qdev_update_parent_bus (Philippe)
  + patch 3
    - typos (Peter)
    - missing gpl header in header (Peter)
    - clarify global entry_in_progress flag (Peter)
  + patch 4
    -  parent/child terminology (Peter)
  + patch 5
    - typos (Peter)
    - comment about global exit_in_progress flag (Peter)
  + patch 6
    -  update list of qdev_set_parent_bus() call sites (rebase)
  + patch 7
    - clear reset state in realize before doing the hotplug reset
  + patch 9
    - added entry in index.rst
    - fix commit message and various improvements (Peter)
    - do parent phase method before child actions (Peter)
    - clarify "Polling the reset state" paragraph=20
  + patch 12&13
    - removed (follow-up series to cleanup the raspi sd)

v5:
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04730.html
  + various improvement in the resettable interface (regarding
    transition, robustness and several reset types)
  + better handling of transition from legacy reset to resettable
  + device hotplug and parent bus 'hot' change support
  + improved doc with examples and converted to rst format

v4:
https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg04359.html

Damien Hedde (11):
  add device_legacy_reset function to prepare for reset api change
  hw/core/qdev: add trace events to help with resettable transition
  hw/core: create Resettable QOM interface
  hw/core: add Resettable support to BusClass and DeviceClass
  hw/core/resettable: add support for changing parent
  hw/core/qdev: handle parent bus change regarding resettable
  hw/core/qdev: update hotplug reset regarding resettable
  hw/core: deprecate old reset functions and introduce new ones
  docs/devel/reset.rst: add doc about Resettable interface
  vl: replace deprecated qbus_reset_all registration
  hw/s390x/ipl: replace deprecated qdev_reset_all registration

 docs/devel/index.rst     |   1 +
 docs/devel/reset.rst     | 289 ++++++++++++++++++++++++++++++++++++
 Makefile.objs            |   1 +
 include/hw/qdev-core.h   |  58 +++++++-
 include/hw/resettable.h  | 244 +++++++++++++++++++++++++++++++
 hw/audio/intel-hda.c     |   2 +-
 hw/core/bus.c            | 102 +++++++++++++
 hw/core/qdev.c           | 164 +++++++++++++++++++--
 hw/core/resettable.c     | 306 +++++++++++++++++++++++++++++++++++++++
 hw/hyperv/hyperv.c       |   2 +-
 hw/i386/microvm.c        |   2 +-
 hw/i386/pc.c             |   2 +-
 hw/ide/microdrive.c      |   8 +-
 hw/intc/spapr_xive.c     |   2 +-
 hw/ppc/pnv_psi.c         |   2 +-
 hw/ppc/spapr_pci.c       |   2 +-
 hw/ppc/spapr_vio.c       |   2 +-
 hw/s390x/ipl.c           |  10 +-
 hw/s390x/s390-pci-inst.c |   2 +-
 hw/scsi/vmw_pvscsi.c     |   2 +-
 hw/sd/omap_mmc.c         |   2 +-
 hw/sd/pl181.c            |   2 +-
 vl.c                     |  10 +-
 hw/core/Makefile.objs    |   1 +
 hw/core/trace-events     |  27 ++++
 tests/Makefile.include   |   1 +
 26 files changed, 1216 insertions(+), 30 deletions(-)
 create mode 100644 docs/devel/reset.rst
 create mode 100644 include/hw/resettable.h
 create mode 100644 hw/core/resettable.c

--=20
2.24.0


