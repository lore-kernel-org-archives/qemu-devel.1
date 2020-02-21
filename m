Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D1C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC62C24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1rvWVI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC62C24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BPX-0001AL-Re
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j5BNu-0007Fu-Ax
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j5BNs-0006Ex-Sl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:42:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j5BNs-0006Cy-OC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582303353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GuujhbnyF3f4n2NJ8rEFYuz2uV9/82tDYJxBP5q0YxU=;
 b=X1rvWVI0BH2OPqtfsMvviRvDEy/tIF0/PDEHT33T26nUZqrBgVXwfTDzW8g+Kvk2w5QXTz
 +CW49IBwlAlINRYnP/Dufy6EtC5ZJiUZSyozZ5K62Im4RU1s2X9D6QjD13wtnBKAVJCoKB
 c57JObn+AKWsXVBJF6rchHiPn/YLVJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-cfZxi4fFO9-s24wftHbuog-1; Fri, 21 Feb 2020 11:42:27 -0500
X-MC-Unique: cfZxi4fFO9-s24wftHbuog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F483107ACC5;
 Fri, 21 Feb 2020 16:42:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E59C5790CF;
 Fri, 21 Feb 2020 16:42:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] migrate/ram: Fix resizing RAM blocks while migrating
Date: Fri, 21 Feb 2020 17:41:51 +0100
Message-Id: <20200221164204.105570-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paul Durrant <paul@xen.org>, Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the follow up of
    "[PATCH RFC] memory: Don't allow to resize RAM while migrating" [1]

This series contains some (slightly modified) patches also contained in:
    "[PATCH v2 fixed 00/16] Ram blocks with resizable anonymous allocations
     under POSIX" [2]
That series will be based on this series. The last patch (#13) in this
series could be moved to the other series, but I decided to include it in
here for now (similar context).

I realized that resizing RAM blocks while the guest is being migrated
(precopy: resize while still running on the source, postcopy: resize
 while already running on the target) is buggy. In case of precopy, we
can simply cancel migration. Postcopy handling is more involved. Resizing
can currently happen during a guest reboot, triggered by ACPI rebuilds.

Along with the fixes, some cleanups.

[1] https://lkml.kernel.org/r/20200213172016.196609-1-david@redhat.com
[2] https://lkml.kernel.org/r/20200212134254.11073-1-david@redhat.com

I was now able to actually test resizing while migrating. I am using the
prototype of virtio-mem to test (which also makes use of resizable
allocations). Things I was able to reproduce:
- Resize while still running on the migration source. Migration is canceled
-- Test case for "migraton/ram: Handle RAM block resizes during precopy"
- Resize (grow+shrink) on the migration target during postcopy migration
  (when syncing RAM blocks), while not yet running on the target
-- Test case for "migration/ram: Discard new RAM when growing RAM blocks
   and the VM is stopped", and overall RAM size synchronization. Seems to
   work just fine.
- Resize (grow+shrink) on the migration tagret during postcopy migration
  while already running on the target.
-- Test case for "migration/ram: Handle RAM block resizes during postcopy"
-- Test case for "migration/ram: Tolerate partially changed mappings in
   postcopy code" - I can see that -ENOENT is actually triggered and that
   migration succeeds. Migration seems to work just fine.

In addition I run avocado-vt migration tests + usual QEMU checks.

v1 -> v2:
- "util: vfio-helpers: Factor out and fix processing of existing ram
   blocks"
-- Stringify error
- "migraton/ram: Handle RAM block resizes during precopy"
-- Simplified check if we're migrating on the source
- "exec: Relax range check in ram_block_discard_range()"
-- Added to make discard during resizes actually work
- "migration/ram: Discard new RAM when growing RAM blocks after
   ram_postcopy_incoming_init()"
-- Better checks if in the right postcopy mode.
-- Better patch subject/description/comments
- "migration/ram: Handle RAM block resizes during postcopy"
-- Better comments
-- Adapt to changed postcopy checks
- "migrate/ram: Get rid of "place_source" in ram_load_postcopy()"
-- Dropped, as broken
- "migration/ram: Tolerate partially changed mappings in postcopy code"
-- Better comment / description. Clarify that no implicit wakeup will
   happen
-- Warn on EINVAL (older kernels)
-- Wake up any waiter explicitly


David Hildenbrand (13):
  util: vfio-helpers: Factor out and fix processing of existing ram
    blocks
  stubs/ram-block: Remove stubs that are no longer needed
  numa: Teach ram block notifiers about resizeable ram blocks
  numa: Make all callbacks of ram block notifiers optional
  migration/ram: Handle RAM block resizes during precopy
  exec: Relax range check in ram_block_discard_range()
  migration/ram: Discard RAM when growing RAM blocks after
    ram_postcopy_incoming_init()
  migration/ram: Simplify host page handling in ram_load_postcopy()
  migration/ram: Consolidate variable reset after placement in
    ram_load_postcopy()
  migration/ram: Handle RAM block resizes during postcopy
  migration/multifd: Print used_length of memory block
  migration/ram: Use offset_in_ramblock() in range checks
  migration/ram: Tolerate partially changed mappings in postcopy code

 exec.c                     |  27 +++++--
 hw/core/numa.c             |  41 +++++++++--
 hw/i386/xen/xen-mapcache.c |   7 +-
 include/exec/cpu-common.h  |   1 +
 include/exec/memory.h      |  10 +--
 include/exec/ramblock.h    |  10 +++
 include/exec/ramlist.h     |  13 ++--
 migration/migration.c      |   9 ++-
 migration/migration.h      |   1 +
 migration/multifd.c        |   2 +-
 migration/postcopy-ram.c   |  52 +++++++++++++-
 migration/ram.c            | 144 ++++++++++++++++++++++++++++---------
 stubs/ram-block.c          |  20 ------
 target/i386/hax-mem.c      |   5 +-
 target/i386/sev.c          |  18 ++---
 util/vfio-helpers.c        |  41 ++++-------
 16 files changed, 283 insertions(+), 118 deletions(-)

--=20
2.24.1


