Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF09C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930332070B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hzp1Lad9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930332070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYB1i-0003r2-NF
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0F-00026G-Q5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0E-000133-5O
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589213400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=NItxou2MhyC4rZ5KZILchlqDOZFZD61dIXTY6SYBmpw=;
 b=Hzp1Lad9MkkYDUHrZRMlbfKas1Xb840DbKMQD5M9t+czItWFequ7avO4Z0C5cxZsIGOV+p
 bbhLQpjfaiNygZSZ+ruIbbqpVLYnM7SB9/OOwKULVhSWg2J6C7uuMfmWOkdBexS02/ZeCu
 sauevt9fuBmIO9JqfTp5t289rZRVUMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-N3KPBpEOMdu-n64qKP7wpA-1; Mon, 11 May 2020 12:09:58 -0400
X-MC-Unique: N3KPBpEOMdu-n64qKP7wpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE498005B7;
 Mon, 11 May 2020 16:09:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFFC65C1B5;
 Mon, 11 May 2020 16:09:52 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Date: Mon, 11 May 2020 19:09:44 +0300
Message-Id: <20200511160951.8733-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

This is a patch series that is a result of my discussion with Paulo on
how to correctly fix the root cause of the BZ #1812399.

The root cause of this bug is the fact that IO thread is running mostly
unlocked versus main thread on which device hotplug is done.

qdev_device_add first creates the device object, then places it on the bus,
and only then realizes it.

However some drivers and currently only virtio-scsi enumerate its child bus
devices on each request that is received from the guest and that can happen on the IO
thread.

Thus we have a window when new device is on the bus but not realized and can be accessed
by the virtio-scsi driver in that state.

Fix that by doing two things:

1. Add partial RCU protection to the list of a bus's child devices.
This allows the scsi IO thread to safely enumerate the child devices
while it races with the hotplug placing the device on the bus.

2. Make the virtio-scsi driver check .realized property of the scsi device
and avoid touching the device if it isn't

Note that in the particular bug report the issue wasn't a race but rather due
to combination of things, the .realize code in the middle managed to trigger IO on the virtqueue
which caused the virtio-scsi driver to access the half realized device. However
since this can happen as well with real IO thread, this patch series was done,
which fixes this as well.

Changes from V1:
  * Patch 2 is new, as suggested by Stefan, added drain_call_rcu() to fix the failing unit test,
    make check pass now

  * Patches 6,7 are new as well: I added scsi_device_get as suggested by Stefan as well, although
    this is more a refactoring that anything else as it doesn't solve
    an existing race.

  * Addressed most of the review feedback from V1
    - still need to decide if we need QTAILQ_FOREACH_WITH_RCU_READ_LOCK

The series were tested with make check and smoke tested by booting a VM and
adding/removing few virtio-scsi disks from it in a loop.

Best regards,
	Maxim Levitsky

Maxim Levitsky (7):
  scsi/scsi_bus: switch search direction in scsi_device_find
  Implement drain_call_rcu and use it in hmp_device_del
  device-core: use RCU for list of childs of a bus
  device-core: use atomic_set on .realized property
  virtio-scsi: don't touch scsi devices that are not yet realized or
    about to be un-realized
  scsi: Add scsi_device_get
  virtio-scsi: use scsi_device_get

 hw/core/bus.c          | 36 ++++++++++++++++++-----------
 hw/core/qdev.c         | 52 ++++++++++++++++++++++++++++++------------
 hw/scsi/scsi-bus.c     | 48 +++++++++++++++++++++++++++++++++-----
 hw/scsi/virtio-scsi.c  | 46 +++++++++++++++++++++++++++++--------
 include/hw/qdev-core.h |  3 +++
 include/hw/scsi/scsi.h |  2 ++
 include/qemu/rcu.h     |  1 +
 qdev-monitor.c         |  3 +++
 util/rcu.c             | 33 +++++++++++++++++++++++++++
 9 files changed, 181 insertions(+), 43 deletions(-)

-- 
2.17.2


