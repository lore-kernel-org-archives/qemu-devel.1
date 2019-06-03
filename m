Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB2DC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88229250D6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88229250D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgqA-0000F1-K2
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:53:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgoD-0007HF-FC
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgoC-0001sE-39
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hXgoB-0001qD-Rr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 781A82F8BE5
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 06:51:02 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 286894E6AA;
	Mon,  3 Jun 2019 06:50:57 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 14:50:45 +0800
Message-Id: <20190603065056.25211-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 03 Jun 2019 06:51:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 00/11] kvm/migration: support
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

v4:
- add r-bs for Dave & Juan
- dropped patch 1 since queued
- fixup misc places in bitmap patch [Dave]
- indent and naming fixes in "pass mr into snapshot_and_clear_dirty"
  [Dave]
- allocate kvmslot dirty_bmap on first usage [Dave]
- comment fixup in clear-log split patch [Dave]

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

Please have a look, thanks.

Peter Xu (11):
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

 accel/kvm/kvm-all.c      | 260 ++++++++++++++++++++++++++++++++++++---
 accel/kvm/trace-events   |   1 +
 exec.c                   |  15 ++-
 include/exec/memory.h    |  36 +++---
 include/exec/ram_addr.h  |  92 +++++++++++++-
 include/qemu/bitmap.h    |   9 ++
 include/sysemu/kvm_int.h |   4 +
 memory.c                 |  64 ++++++++--
 migration/migration.c    |   4 +
 migration/migration.h    |  27 ++++
 migration/ram.c          |  45 +++++++
 migration/trace-events   |   1 +
 tests/Makefile.include   |   2 +
 tests/test-bitmap.c      |  72 +++++++++++
 util/bitmap.c            |  85 +++++++++++++
 15 files changed, 663 insertions(+), 54 deletions(-)
 create mode 100644 tests/test-bitmap.c

-- 
2.17.1


