Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B135C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E552086A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mh0zZFss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E552086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sCi-0003BB-F7
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sBe-0001cx-4A
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBc-00064V-M8
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBc-00063l-IC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b3uKpoDUURGdcSnKDy/uidtkYSwTOgnldzk0XYQuajQ=;
 b=Mh0zZFssFpEe7xuJKC8Q7EVlQutN7LXXIBu2K2M0voTvBfdYxZPL7NyOmwrVDy2HAXMbXR
 GjLD566ltONWl1sI32VsFEru4oX87dtlD7vF+/9DYZevRVzBLJ8y++1uUbPm5sDwvb8hLH
 2YrTD0QrlrIfyAJpJghaLhhWOHlxR80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-KwJ-HguIOkq4wNif8HfyCA-1; Wed, 12 Feb 2020 08:36:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37AC5101FC60;
 Wed, 12 Feb 2020 13:36:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A239419C69;
 Wed, 12 Feb 2020 13:36:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/16] Ram blocks with resizable anonymous allocations
 under POSIX
Date: Wed, 12 Feb 2020 14:35:45 +0100
Message-Id: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: KwJ-HguIOkq4wNif8HfyCA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already allow resizable ram blocks for anonymous memory, however, they
are not actually resized. All memory is mmaped() R/W, including the memory
exceeding the used_length, up to the max_length.

When resizing, effectively only the boundary is moved. Implement actually
resizable anonymous allocations and make use of them in resizable ram
blocks when possible. Memory exceeding the used_length will be
inaccessible. Especially ram block notifiers require care.

Having actually resizable anonymous allocations (via mmap-hackery) allows
to reserve a big region in virtual address space and grow the
accessible/usable part on demand. Even if "/proc/sys/vm/overcommit_memory"
is set to "never" under Linux, huge reservations will succeed. If there is
not enough memory when resizing (to populate parts of the reserved region),
trying to resize will fail. Only the actually used size is reserved in the
OS.

E.g., virtio-mem [1] wants to reserve big resizable memory regions and
grow the usable part on demand. I think this change is worth sending out
individually. Accompanied by a bunch of minor fixes and cleanups.

Especially, memory notifiers already handle resizing by first removing
the old region, and then re-adding the resized region. prealloc is
currently not possible with resizable ram blocks. mlock() should continue
to work as is. Resizing is currently rare and must only happen on the
start of an incoming migration, or during resets. No code path (except
HAX and SEV ram block notifiers) should access memory outside of the usable
range - and if we ever find one, that one has to be fixed (I did not
identify any).

v1 -> v2:
- Add "util: vfio-helpers: Fix qemu_vfio_close()"
- Add "util: vfio-helpers: Remove Error parameter from
       qemu_vfio_undo_mapping()"
- Add "util: vfio-helpers: Factor out removal from
       qemu_vfio_undo_mapping()"
- "util/mmap-alloc: ..."
 -- Minor changes due to review feedback (e.g., assert alignment, return
    bool when resizing)
- "util: vfio-helpers: Implement ram_block_resized()"
 -- Reserve max_size in the IOVA address space.
 -- On resize, undo old mapping and do new mapping. We can later implement
    a new ioctl to resize the mapping directly.
- "numa: Teach ram block notifiers about resizable ram blocks"
 -- Pass size/max_size to ram block notifiers, which makes things easier an
    cleaner
- "exec: Ram blocks with resizable anonymous allocations under POSIX"
 -- Adapt to new ram block notifiers
 -- Shrink after notifying. Always trigger ram block notifiers on resizes
 -- Add a safety net that all ram block notifiers registered at runtime
    support resizes.

[1] https://lore.kernel.org/kvm/20191212171137.13872-1-david@redhat.com/

David Hildenbrand (16):
  util: vfio-helpers: Factor out and fix processing of existing ram
    blocks
  util: vfio-helpers: Fix qemu_vfio_close()
  util: vfio-helpers: Remove Error parameter from
    qemu_vfio_undo_mapping()
  util: vfio-helpers: Factor out removal from qemu_vfio_undo_mapping()
  exec: Factor out setting ram settings (madvise ...) into
    qemu_ram_apply_settings()
  exec: Reuse qemu_ram_apply_settings() in qemu_ram_remap()
  exec: Drop "shared" parameter from ram_block_add()
  util/mmap-alloc: Factor out calculation of pagesize to mmap_pagesize()
  util/mmap-alloc: Factor out reserving of a memory region to
    mmap_reserve()
  util/mmap-alloc: Factor out populating of memory to mmap_populate()
  util/mmap-alloc: Prepare for resizable mmaps
  util/mmap-alloc: Implement resizable mmaps
  numa: Teach ram block notifiers about resizable ram blocks
  util: vfio-helpers: Implement ram_block_resized()
  util: oslib: Resizable anonymous allocations under POSIX
  exec: Ram blocks with resizable anonymous allocations under POSIX

 exec.c                     | 104 +++++++++++++++++++----
 hw/core/numa.c             |  53 +++++++++++-
 hw/i386/xen/xen-mapcache.c |   7 +-
 include/exec/cpu-common.h  |   3 +
 include/exec/memory.h      |   8 ++
 include/exec/ramlist.h     |  14 +++-
 include/qemu/mmap-alloc.h  |  21 +++--
 include/qemu/osdep.h       |   6 +-
 stubs/ram-block.c          |  20 -----
 target/i386/hax-mem.c      |   5 +-
 target/i386/sev.c          |  18 ++--
 util/mmap-alloc.c          | 165 +++++++++++++++++++++++--------------
 util/oslib-posix.c         |  37 ++++++++-
 util/oslib-win32.c         |  14 ++++
 util/trace-events          |   9 +-
 util/vfio-helpers.c        | 145 +++++++++++++++++++++-----------
 16 files changed, 450 insertions(+), 179 deletions(-)

--=20
2.24.1


