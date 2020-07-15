Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEEAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C3E206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fE+/HjE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviwc-0006Eg-5Y
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jvivG-0004qv-3G
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:02:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jvivD-0004YG-6z
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594825329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uj+wU0mt1sV/8iDUjmjhd8DVIOts9z0ermRz2cyLVM4=;
 b=fE+/HjE4q3TbW6N5/TsgFZcaT7iyWWm+myJ2UTYdhOXIU78V1r2Kq/gZ+Bq5osAKM+V8PJ
 jmWVPEKGvX9r2XpLaNBPWGymM4rVjwtItsYZ5bIa10d+XAQB7UmiiVM5nPLmCEepxMpxP1
 vDCdpNoevYtYAd0Hpa9qB52zWo33w08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-ymEWgwn-Otigy6_o9e8icw-1; Wed, 15 Jul 2020 11:02:06 -0400
X-MC-Unique: ymEWgwn-Otigy6_o9e8icw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F264F8027FB;
 Wed, 15 Jul 2020 15:02:05 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7FDF710D6;
 Wed, 15 Jul 2020 15:02:00 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] Fix scsi devices plug/unplug races w.r.t virtio-scsi
 iothread
Date: Wed, 15 Jul 2020 18:01:52 +0300
Message-Id: <20200715150159.95050-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!=0D
=0D
This is a patch series that is a result of my discussion with Paulo on=0D
how to correctly fix the root cause of the BZ #1812399.=0D
=0D
The root cause of this bug is the fact that IO thread is running mostly=0D
unlocked versus main thread on which device hotplug is done.=0D
=0D
qdev_device_add first creates the device object, then places it on the bus,=
=0D
and only then realizes it.=0D
=0D
However some drivers and currently only virtio-scsi enumerate its child bus=
=0D
devices on each request that is received from the guest and that can happen=
 on the IO=0D
thread.=0D
=0D
Thus we have a window when new device is on the bus but not realized and ca=
n be accessed=0D
by the virtio-scsi driver in that state.=0D
=0D
Fix that by doing two things:=0D
=0D
1. Add partial RCU protection to the list of a bus's child devices.=0D
This allows the scsi IO thread to safely enumerate the child devices=0D
while it races with the hotplug placing the device on the bus.=0D
=0D
2. Make the virtio-scsi driver check .realized property of the scsi device=
=0D
and avoid touching the device if it isn't=0D
=0D
Note that in the particular bug report the issue wasn't a race but rather d=
ue=0D
to combination of things, the .realize code in the middle managed to trigge=
r IO on the virtqueue=0D
which caused the virtio-scsi driver to access the half realized device. How=
ever=0D
since this can happen as well with real IO thread, this patch series was do=
ne,=0D
which fixes this as well.=0D
=0D
Changes from V1:=0D
  * Patch 2 is new, as suggested by Stefan, added drain_call_rcu() to fix t=
he failing unit test,=0D
    make check pass now=0D
=0D
  * Patches 6,7 are new as well: I added scsi_device_get as suggested by St=
efan as well, although=0D
    this is more a refactoring that anything else as it doesn't solve=0D
    an existing race.=0D
=0D
  * Addressed most of the review feedback from V1=0D
    - still need to decide if we need QTAILQ_FOREACH_WITH_RCU_READ_LOCK=0D
=0D
Changes from V2:=0D
=0D
  * No longer RFC=0D
  * Addressed most of the feedback from Stefan=0D
  * Fixed reference count leak in patch 7 when device is about to be unreal=
ized=0D
  * Better testing=0D
=0D
This series was tested by adding a virtio-scsi drive with iothread,=0D
then running fio stress job in the guest in a loop, and then adding/removin=
g=0D
the scsi drive on the host in the loop.=0D
This test was failing usually on 1st iteration withouth this patch series,=
=0D
and now it seems to work smoothly.=0D
=0D
Best regards,=0D
=09Maxim Levitsky=0D
=0D
Maxim Levitsky (7):=0D
  scsi/scsi_bus: switch search direction in scsi_device_find=0D
  Implement drain_call_rcu and use it in hmp_device_del=0D
  device-core: use RCU for list of childs of a bus=0D
  device-core: use atomic_set on .realized property=0D
  virtio-scsi: don't touch scsi devices that are not yet realized or=0D
    about to be un-realized=0D
  scsi: Add scsi_device_get=0D
  virtio-scsi: use scsi_device_get=0D
=0D
 hw/core/bus.c          | 28 +++++++++++++--------=0D
 hw/core/qdev.c         | 56 +++++++++++++++++++++++++++++++-----------=0D
 hw/scsi/scsi-bus.c     | 48 +++++++++++++++++++++++++++++++-----=0D
 hw/scsi/virtio-scsi.c  | 47 ++++++++++++++++++++++++++++-------=0D
 include/hw/qdev-core.h | 11 +++++++++=0D
 include/hw/scsi/scsi.h |  2 ++=0D
 include/qemu/rcu.h     |  1 +=0D
 qdev-monitor.c         | 22 +++++++++++++++++=0D
 util/rcu.c             | 55 +++++++++++++++++++++++++++++++++++++++++=0D
 9 files changed, 230 insertions(+), 40 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


