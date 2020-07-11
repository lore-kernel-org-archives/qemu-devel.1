Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37664C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043BF206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hibsdlGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043BF206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juCUB-0002XC-6f
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 06:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1juCT1-0000Z9-PM
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 06:10:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1juCSx-0008Cn-KX
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 06:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594462241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E5TVbsllvHb7k2KOJnzIsk6p4lNKAkI/R42Q7r3lHqI=;
 b=hibsdlGLl98wdQ9cWxTECRosR5SrJP0NnaXC0+s5fHACazeYzr47bNABo9DvrAmurG0sb3
 CAHxFwklFPAj4y+14e1pcrtr+xySaeVLglSMQ4P02lv/izEQsFJPHLPTNUiZVjS9KwQQ2l
 yuqeygr3HlklFU8RFj/DZEnTF8gnrqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-qCXivhVbO8y7MY2jp7bKbA-1; Sat, 11 Jul 2020 06:10:38 -0400
X-MC-Unique: qCXivhVbO8y7MY2jp7bKbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25D9B80183C;
 Sat, 11 Jul 2020 10:10:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6AD91E8;
 Sat, 11 Jul 2020 10:10:35 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH 0/3] hw/arm/virt: Introduce kvm-steal-time
Date: Sat, 11 Jul 2020 12:10:30 +0200
Message-Id: <20200711101033.47371-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 06:10:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM supports the ability to publish the amount of time that VCPUs
were runnable, but not running due to other host threads running
instead, to the guest. The guest scheduler may use that information
when making decisions and the guest may expose it to its userspace
(Linux publishes this information in /proc/stat). This feature is
called "steal time" as it represents the amount of time stolen from
a guest by scheduling out its VCPUs. To enable this feature KVM
userspace must provide a memory region that will be used to publish
the information to the guest. The memory region is typical migratable
region. The GPA of the region is given to KVM through a VCPU device
ioctl interface. This feature is only available for 64-bit hosts
running 64-bit guests.

This series provides the QEMU support of this feature. It will
be enabled by default for 5.1 machine types and later, but may
be disabled with a new CPU property "kvm-steal-time".

While testing migration it was observed that the amount of
steal time as viewed by the guest was getting reset on each
migration. Patch 3/5 of a pvtime fix series posted[*] for KVM
should fix that.

Migration testing:
* virt-5.0 can migrate as usual, no kvm-steal-time enabled
* virt-5.1 can migrate between hosts with steal-time enabled and
  disabled when both hosts support steal-time
* virt-5.1 with steal-time disabled can migrate to a host that
  does not support steal-time
* virt-5.1 with steal-time enabled will cleanly fail when migrating
  to a host that does not support steal-time

[*] https://lists.cs.columbia.edu/pipermail/kvmarm/2020-July/041538.html

Thanks,
drew


Andrew Jones (3):
  hw/arm/virt: Move post cpu realize check into its own function
  hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
  hw/arm/virt: Implement kvm-steal-time

 docs/system/arm/cpu-features.rst |  11 ++++
 hw/arm/virt.c                    | 103 +++++++++++++++++++++----------
 include/hw/arm/virt.h            |   2 +
 target/arm/cpu.c                 |  10 +++
 target/arm/cpu.h                 |   4 ++
 target/arm/kvm.c                 |  20 ++++++
 target/arm/kvm32.c               |   5 ++
 target/arm/kvm64.c               |  70 +++++++++++++++++++--
 target/arm/kvm_arm.h             |  24 ++++++-
 target/arm/monitor.c             |   2 +-
 tests/qtest/arm-cpu-features.c   |  25 ++++++--
 11 files changed, 232 insertions(+), 44 deletions(-)

-- 
2.25.4


