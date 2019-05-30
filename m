Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA37C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597F4255AF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597F4255AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWHPN-0001s6-H9
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 05:31:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWHNK-0000dT-Ts
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWHNJ-00019u-Dt
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:29:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWHNJ-00019H-6M
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5296DC130719
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 09:29:28 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-221.pek2.redhat.com [10.72.12.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF781001E77;
	Thu, 30 May 2019 09:29:22 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 17:29:07 +0800
Message-Id: <20190530092919.26059-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 30 May 2019 09:29:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 00/12] kvm/migration: support
 KVM_CLEAR_DIRTY_LOG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v3 of the series.  Note that Paolo should have queued the
patch 1 so we can start review with patch 2.  I just kept it for
completeness.

v3:
- drop header update because another same patch already merged in
  master by cohuck
- drop qmp/hmp patches [Paolo]
- comment fixes [Paolo]
- fix misuse of kvm cap names in either strings or commit messages [Paolo]

v2:
- rebase, add r-bs from Paolo
- added a few patches
  - linux-headers: Update to Linux 5.2-rc1
    this is needed because we've got a new cap in kvm
  - checkpatch: Allow SPDX-License-Identifier
    picked up the standalone patch into the series in case it got lost
  - hmp: Expose manual_dirty_log_protect via "info kvm"
    qmp: Expose manual_dirty_log_protect via "query-kvm"
    add interface to detect the new kvm capability
- switched default chunk size to 128M

Performance update is here:

  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03621.html

Summary
=====================

This series allows QEMU to start using the new KVM_CLEAR_DIRTY_LOG
interface. For more on KVM_CLEAR_DIRTY_LOG itself, please refer to:

  https://github.com/torvalds/linux/blob/master/Documentation/virtual/kvm/api.txt#L3810

The QEMU work (which is this series) is pushed too, please find the
tree here:

  https://github.com/xzpeter/qemu/tree/kvm-clear-dirty-log

Meanwhile, For anyone who really wants to try this out, please also
upgrade the host kernel to linux 5.2-rc1.

Design
===================

I started with a naive/stupid design that I always pass all 1's to the
KVM for a memory range to clear all the dirty bits within that memory
range, but then I encountered guest oops - it's simply because we
can't clear any dirty bit from QEMU if we are not _sure_ that the bit
is dirty in the kernel.  Otherwise we might accidentally clear a bit
that we don't even know of (e.g., the bit was clear in migration's
dirty bitmap in QEMU) but actually that page was just being written so
QEMU will never remember to migrate that new page again.

The new design is focused on a dirty bitmap cache within the QEMU kvm
layer (which is per kvm memory slot).  With that we know what's dirty
in the kernel previously (note! the kernel bitmap is still growing all
the time so the cache will only be a subset of the realtime kernel
bitmap but that's far enough for us) and with that we'll be sure to
not accidentally clear unknown dirty pages.

With this method, we can also avoid race when multiple users (e.g.,
DIRTY_MEMORY_VGA and DIRTY_MEMORY_MIGRATION) want to clear the bit for
multiple time.  If without the kvm memory slot cached dirty bitmap we
won't be able to know which bit has been cleared and then if we send
the CLEAR operation upon the same bit twice (or more) we can still
face the same issue to clear something accidentally while we
shouldn't.

Summary: we really need to be careful on what bit to clear otherwise
we can face anything after the migration completes.  And I hope this
series has considered all about this.

Besides the new KVM cache layer and the new ioctl support, this series
introduced the memory_region_clear_dirty_bitmap() in the memory API
layer to allow clearing dirty bits of a specific memory range within
the memory region.

Implementations
============================

Patch 1-3:  these should be nothing directly related to the series but
            they are things I found during working on it.  They can be
            picked even earlier if reviewers are happy with them.

Patch 4:    pre-work on bitmap operations, and within the patch I added
            the first unit test for utils/bitmap.c.

Patch 5-6:  the new memory API interface.  Since no one is providing
            log_clear() yet so it's not working yet.  Note that this
            only splits the dirty clear operation from sync but it
            hasn't yet been splitted into smaller chunk so it's not
            really helpful for us yet.

Patch 7-10: kvm support of KVM_CLEAR_DIRTY_LOG.

Patch 11:   do the log_clear() splitting for the case of migration.
            Also a new parameter is introduced to define the block
            size of the small chunks (the unit to clear dirty bits)

Tests
===========================

- make check
- migrate idle/memory-heavy guests

(Not yet tested with huge guests but it'll be more than welcomed if
 someone has the resource and wants to give it a shot)

Please have a look, thanks.

Peter Xu (12):
  checkpatch: Allow SPDX-License-Identifier
  migration: No need to take rcu during sync_dirty_bitmap
  memory: Remove memory_region_get_dirty()
  memory: Don't set migration bitmap when without migration
  bitmap: Add bitmap_copy_with_{src|dst}_offset()
  memory: Pass mr into snapshot_and_clear_dirty
  memory: Introduce memory listener hook log_clear()
  kvm: Update comments for sync_dirty_bitmap
  kvm: Persistent per kvmslot dirty bitmap
  kvm: Introduce slots lock for memory listener
  kvm: Support KVM_CLEAR_DIRTY_LOG
  migration: Split log_clear() into smaller chunks

 accel/kvm/kvm-all.c      | 287 ++++++++++++++++++++++++++++++++++-----
 accel/kvm/trace-events   |   1 +
 exec.c                   |  15 +-
 include/exec/memory.h    |  36 ++---
 include/exec/ram_addr.h  |  91 ++++++++++++-
 include/qemu/bitmap.h    |   9 ++
 include/sysemu/kvm_int.h |   4 +
 memory.c                 |  64 +++++++--
 migration/migration.c    |   4 +
 migration/migration.h    |  27 ++++
 migration/ram.c          |  45 ++++++
 migration/trace-events   |   1 +
 scripts/checkpatch.pl    |   3 +-
 tests/Makefile.include   |   2 +
 tests/test-bitmap.c      |  81 +++++++++++
 util/bitmap.c            |  73 ++++++++++
 16 files changed, 673 insertions(+), 70 deletions(-)
 create mode 100644 tests/test-bitmap.c

-- 
2.17.1


