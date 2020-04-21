Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935CC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53FC20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0bl+oW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53FC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoga-0000Eo-OF
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQoep-0006Vz-FO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQoeo-0007ub-A9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:53:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jQoen-0007qr-Mj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587459207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mw4SrbU4/55b8yrt3xVZLrngcH8pDnoNQuTApn6zoJc=;
 b=W0bl+oW9x3ibODvsnlHvltkCIZvvVJeAk+aFKsQzhH2ZKeFMjjG2hEDtLofSg/EiP/ECUC
 uNi0C/SB0zSh2PA3w9/I3hNd/XhhGVjGJEhPCNgHf9XA1wVQ9K1gJBsH5uHtbSLc7s2L1p
 P8EDMEjZxWsWd0yKkzxh5XI+C34QOwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-W9dU6KdRPvKY-hWm4yWlaA-1; Tue, 21 Apr 2020 04:53:21 -0400
X-MC-Unique: W9dU6KdRPvKY-hWm4yWlaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A78D190B2A0;
 Tue, 21 Apr 2020 08:53:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C4D61001DDE;
 Tue, 21 Apr 2020 08:53:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/13] migrate/ram: Fix resizing RAM blocks while migrating
Date: Tue, 21 Apr 2020 10:52:47 +0200
Message-Id: <20200421085300.7734-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paul Durrant <paul@xen.org>, Alex Williamson <alex.williamson@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basically a resend. Who's the lucky winner to pick this up for 5.1? :)

---

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

v3 -> v4:
- Rebased and retested
- Added RBs

v2 -> v3:
- Rebased on current master
- Added RBs
- "migration/ram: Tolerate partially changed mappings in postcopy code"
-- Extended the comment for the uffdio unregister part.

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

 exec.c                     |  25 +++++--
 hw/core/numa.c             |  41 +++++++++--
 hw/i386/xen/xen-mapcache.c |   7 +-
 include/exec/cpu-common.h  |   1 +
 include/exec/memory.h      |  10 +--
 include/exec/ramblock.h    |  10 +++
 include/exec/ramlist.h     |  13 ++--
 migration/migration.c      |   9 ++-
 migration/migration.h      |   1 +
 migration/multifd.c        |   2 +-
 migration/postcopy-ram.c   |  54 +++++++++++++-
 migration/ram.c            | 144 ++++++++++++++++++++++++++++---------
 stubs/ram-block.c          |  20 ------
 target/i386/hax-mem.c      |   5 +-
 target/i386/sev.c          |  18 ++---
 util/vfio-helpers.c        |  41 ++++-------
 16 files changed, 283 insertions(+), 118 deletions(-)

--=20
2.25.1


