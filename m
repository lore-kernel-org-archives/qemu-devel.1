Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96220C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6292A20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5f5BRx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6292A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtujz-0005Ln-KO
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtuhu-0003Za-Cu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:12:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtuhp-0003Mz-LA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594393972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sd2OvhcRON3NpqfjEpSaTABPdowdkCxWiH8onWpY+gs=;
 b=d5f5BRx7QmSoYUIB+NDikvm5wOdXiQPDBA2Tn/fOOlaTpnNmu8Urw27H8ERIzQ674JhOAf
 A1rdw5wQD7nDM1TVXw8fvNypqZRQclSXqRcIE0VCPZ0ZpyVLA841X+nNlWvxd8VZTsPEyJ
 SrVQpyl9MCefVTDIbOjzbiN9Qv12z1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-oMZQPiFAO_aIyKwFEMhLPA-1; Fri, 10 Jul 2020 11:12:49 -0400
X-MC-Unique: oMZQPiFAO_aIyKwFEMhLPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1348100A8C1;
 Fri, 10 Jul 2020 15:12:47 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-41.ams2.redhat.com [10.36.114.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4E81A7D8;
 Fri, 10 Jul 2020 15:12:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv2 0/6] s390x: initial support for virtio-mem
Date: Fri, 10 Jul 2020 17:12:33 +0200
Message-Id: <20200710151239.39370-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This wires up the initial, basic version of virito-mem for s390x. General
information about virtio-mem can be found at [1] and in QEMU commit [2].
Patch #5 contains a short example for s390x.

virtio-mem for x86-64 Linux is part of v5.8-rc1. A branch with a s390x
prototype can be found at:
    git@github.com:davidhildenbrand/linux.git virtio-mem-s390x

Note that the kernel should either be compiled via
 CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE, or "memhp_default_state=online"
 should be passed on the kernel cmdline.

This series can be found at:
    git@github.com:davidhildenbrand/qemu.git virtio-mem-s390x-rfcv2

Related to s390x, we'll have to tackle migration of storage keys and
storage attributes (especially, skipping unplugged parts). Not sure if
I am missing something else (any ideas?). For virtio-mem in general, there
are a couple of TODOs, e.g., documented in [1] and [2], both in QEMU and
Linux. However, the basics are around.

I only tested this with fairly small amount of RAM in a z/VM environemnt
and under TCG ...

[1] https://virtio-mem.gitlab.io/
[2] 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")

RFCv1 -> RFCv2:
- "s390x/diag: no need to check for PGM_PRIVILEGED in diag308"
-- Added
- "s390x/diag: implement diag260"
-- Implement according to doc (fix error cases)
-- Implement subcode 0xc.
-- Enable the new diag unconditionally
- "s390x: prepare device memory address space"
-- Expose maxram size now via diag260 (0xc), not via SCLP. Unfmodified
   guests can now boot without any issues. This needed kernel changes
   (updated the Linux kernel branch)
- "s390x: implement virtio-mem-ccw"
-- Force virtio revision 1

David Hildenbrand (6):
  s390x: move setting of maximum ram size to machine init
  s390x/diag: no need to check for PGM_PRIVILEGED in diag308
  s390x/diag: implement diag260
  s390x: prepare device memory address space
  s390x: implement virtio-mem-ccw
  s390x: initial support for virtio-mem

 hw/s390x/Kconfig                   |   1 +
 hw/s390x/Makefile.objs             |   1 +
 hw/s390x/s390-virtio-ccw.c         | 178 ++++++++++++++++++++++++++++-
 hw/s390x/sclp.c                    |  23 +---
 hw/s390x/virtio-ccw-mem.c          | 167 +++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h              |  13 +++
 hw/virtio/virtio-mem.c             |   2 +
 include/hw/s390x/s390-virtio-ccw.h |   3 +
 target/s390x/diag.c                |  62 +++++++++-
 target/s390x/internal.h            |   2 +
 target/s390x/kvm.c                 |  11 ++
 target/s390x/misc_helper.c         |   6 +
 target/s390x/translate.c           |   7 ++
 13 files changed, 446 insertions(+), 30 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-mem.c

-- 
2.26.2


