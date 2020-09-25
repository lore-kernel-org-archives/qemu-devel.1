Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1852086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxENK+v9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1852086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrZr-0000AK-1X
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLrUx-0003e0-Bh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLrUr-0007Ec-TV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:27:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601054821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=66oL3D5lzRUoqWi8bvrMPQnZkzWgskqyagude6h6vlc=;
 b=KxENK+v9oq2ctPcYWQBvn2GA+DrYPp1EZFbzxnmxjAAZoA+GlTmicnPg4OC4j6JE8fuWR1
 9eXaN1iwg7y/gCkYOvnDCpJvf+RCMzmWUqWJfwu+GOAVqFy17eWMTEYdaCbUumzkedyPS0
 0LiIl4Ie+WNMjRgNfS5L/XZje5wHfSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-QPaby4RyMKq50-q6B4oD4A-1; Fri, 25 Sep 2020 13:26:09 -0400
X-MC-Unique: QPaby4RyMKq50-q6B4oD4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6393A1902ECE
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 17:26:08 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8DB05D9F7;
 Fri, 25 Sep 2020 17:26:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] Fix scsi devices plug/unplug races w.r.t virtio-scsi
 iothread
Date: Fri, 25 Sep 2020 13:25:54 -0400
Message-Id: <20200925172604.2142227-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: stefanha@redhat.com, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is my take on Maxim's patches.  Mostly I am avoiding the problems with
"scsi/scsi_bus: switch search direction in scsi_device_find" by adding
a pre-realize callback for BusState that checks for the device address
being in use.

This makes it possible to avoid the tricky search for a preexisting device.


Maxim Levitsky (7):
  scsi/scsi_bus: switch search direction in scsi_device_find
  device_core: use drain_call_rcu in in hmp_device_del/qmp_device_add
  device-core: use RCU for list of children of a bus
  device-core: use atomic_set on .realized property
  scsi/scsi_bus: Add scsi_device_get
  virtio-scsi: use scsi_device_get
  scsi/scsi_bus: fix races in REPORT LUNS

Paolo Bonzini (3):
  qdev: add "check if address free" callback for buses
  scsi: switch to bus->check_address
  scsi/scsi-bus: scsi_device_find: don't return unrealized devices

 hw/core/bus.c          |  28 +++--
 hw/core/qdev.c         |  73 +++++++++---
 hw/net/virtio-net.c    |   2 +-
 hw/scsi/scsi-bus.c     | 262 ++++++++++++++++++++++++++---------------
 hw/scsi/virtio-scsi.c  |  27 +++--
 hw/sd/core.c           |   3 +-
 include/hw/qdev-core.h |  15 ++-
 include/hw/scsi/scsi.h |   1 +
 qdev-monitor.c         |  22 ++++
 9 files changed, 299 insertions(+), 134 deletions(-)

-- 
2.26.2


