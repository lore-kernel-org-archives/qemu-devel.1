Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF6FC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E8420735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KltQn5yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E8420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkWN-0005tn-Uo
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVH-0003yW-BT
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVF-0001p0-Fl
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TJdGxPrmRxNLbSuDmMVhcujc7HtAytosKTgXd3rVYe4=;
 b=KltQn5ypEdTYji3z7ebrAUCcJflIvljjss+VY7yJFX0QYoAr4+ex+3edJw7OyOhzR9Nt//
 z7zIeaId2sGQlcytYx+JhSGl1xU1UpDDlNGgVSZ61Lm6PO6ZAInVOFUsSfJtvkYwcX6aUU
 jpyY0cgSdIte3h/FAi9DavO/XTHc4eY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-mka7kT-VM1OOBpVSMOKSwg-1; Thu, 07 May 2020 13:40:04 -0400
X-MC-Unique: mka7kT-VM1OOBpVSMOKSwg-1
Received: by mail-wm1-f71.google.com with SMTP id 72so4347530wmb.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xHF5K7oqfFaYp0OWLHurNYpggdARbZl46w/6f+onlRM=;
 b=ckkQw2n0+q4Y+a3MZSfjGhHK8rgJ/st3bNw9UACzfGr4S/TEq2uwsHlzzormZJHhBZ
 CkiK71Ef4ziHRNtEEJqAXJ5DGYCWMU4c5tfsFWgMyndE+uE21tM0kuIpMUYf67Nur3OM
 KyDEvtoxILiVezl+Z5XF7JKrTHwGuX5WtqGEepTUM9N+f9Vd+lM6b/ORW5ZUUxoNCmIW
 iNsmi83WPh7XRwdL9mifpVVQPx2VsKZHoKqdsgFnTOF/94WRnqDvRe2cD2+pJ5C+R74T
 nh6SsrsAAJ+AwdxSV5haJ2EeWMrIJRCBb55mwGc9y63wYzxSsKOBCrIRBHZGBPpIxn04
 CC/Q==
X-Gm-Message-State: AGi0PuY2WZLR1e6ANwJD3QpkLLsotHW1/+4eFv00eulPiCJx0Idv4+Jd
 Rp9OrAXY6uBEm52991c5ri3Qv3/jp1235aTAfXCG9ZIRTDimQN0sK0d9zYoPgxSk2FyY6pMyXwO
 rcuBJq1/4Bt9sIrA=
X-Received: by 2002:a1c:a344:: with SMTP id m65mr11442751wme.20.1588873202896; 
 Thu, 07 May 2020 10:40:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypKM/e5xG84b244Gq1xOPa/z8oKbKr/DBtpqpD5YFagwtLR4zvbNnNnPXkDOAQ5n1PCVeNJpdQ==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr11442708wme.20.1588873202555; 
 Thu, 07 May 2020 10:40:02 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm9732932wra.50.2020.05.07.10.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 00/10] exec: Shear 'exec/ram_addr.h' and make NVMe device
 target-agnostic
Date: Thu,  7 May 2020 19:39:48 +0200
Message-Id: <20200507173958.25894-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan suggested to make qemu_ram_writeback() target agnostic,
Paolo to add memory_region_msync(), and Peter to remove
"exec/ram_addr.h" [*].

I let a single function in this file,
cpu_physical_memory_sync_dirty_bitmap(), to let the maintainer
have the pleasure to remove this header definitively himself :)

Based-on: <20200507155813.16169-1-philmd@redhat.com>
"Move Xen accelerator code under accel/xen/"
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01722.html

[*] https://www.mail-archive.com/qemu-block@nongnu.org/msg66242.html

Philippe Mathieu-Daud=C3=A9 (10):
  exec: Rename qemu_ram_writeback() as qemu_ram_msync()
  exec/ramblock: Add missing 'qemu/rcu.h' include
  exec: Move tb_invalidate_phys_range() to 'exec/exec-all.h'
  exec/memory-internal: Check CONFIG_SOFTMMU instead of CONFIG_USER_ONLY
  exec: Move qemu_minrampagesize/qemu_maxrampagesize to 'qemu-common.h'
  exec: Move ramblock_recv_bitmap_offset() to migration/ram.c
  exec: Move all RAMBlock functions to 'exec/ramblock.h'
  hw/block: Let the NVMe emulated device be target-agnostic
  exec: Update coding style to make checkpatch.pl happy
  exec: Move cpu_physical_memory_* functions to 'exec/memory-internal.h'

 include/exec/cpu-common.h      |  24 --
 include/exec/exec-all.h        |  14 +-
 include/exec/memory-internal.h | 307 +++++++++++++++++++++++-
 include/exec/ram_addr.h        | 415 +--------------------------------
 include/exec/ramblock.h        | 135 +++++++++++
 include/qemu-common.h          |  10 +
 migration/migration.h          |   1 +
 accel/tcg/cputlb.c             |   1 -
 accel/tcg/translate-all.c      |   2 -
 exec.c                         |   2 +-
 hw/block/nvme.c                |   5 +-
 hw/ppc/spapr.c                 |   1 -
 hw/ppc/spapr_caps.c            |   2 +-
 hw/ppc/spapr_pci.c             |   1 -
 hw/s390x/s390-stattrib-kvm.c   |   1 -
 hw/s390x/s390-stattrib.c       |   1 -
 hw/s390x/s390-virtio-ccw.c     |   2 +-
 hw/vfio/spapr.c                |   2 +-
 hw/virtio/vhost-user.c         |   1 +
 hw/virtio/vhost.c              |   1 +
 hw/virtio/virtio-balloon.c     |   1 +
 memory.c                       |   4 +-
 migration/migration.c          |   1 +
 migration/postcopy-ram.c       |   1 +
 migration/ram.c                |   8 +
 migration/savevm.c             |   1 +
 stubs/ram-block.c              |   2 +-
 target/ppc/kvm.c               |   1 -
 target/s390x/kvm.c             |   1 -
 util/vfio-helpers.c            |   2 +-
 hw/block/Makefile.objs         |   2 +-
 31 files changed, 485 insertions(+), 467 deletions(-)

--=20
2.21.3


