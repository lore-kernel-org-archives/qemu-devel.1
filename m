Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1800AC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD31C21582
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0A2T0XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD31C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygXX-0000xi-1f
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygVi-0007kt-0h
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygVf-00013m-RX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:31:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygVf-00012G-Jm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AERIUfV6tPsARlvCzUTAaEGmRotpxwQkKJUa3Tp6WJQ=;
 b=Z0A2T0XErU15Tu/TgOyg6aSS9U366emeA+n6zZq5sPQ8xXGESHVM/oKNil3ef2pBQTCBT/
 7rYutL1gbmeETypnuUz6CB55efawbWexyudoLYqD2eEeyH+8wvmtgrQVPezZDGitR9Haua
 y+8VjD6YOuXJ9vUFO/JqPAAAWd/9sxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-lCgEsJLQN4qkbZUe_t_wOw-1; Mon, 03 Feb 2020 13:31:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778E51800D41;
 Mon,  3 Feb 2020 18:31:40 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF285D9CA;
 Mon,  3 Feb 2020 18:31:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/13] Ram blocks with resizable anonymous allocations
 under POSIX
Date: Mon,  3 Feb 2020 19:31:12 +0100
Message-Id: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lCgEsJLQN4qkbZUe_t_wOw-1
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
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
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

[1] https://lore.kernel.org/kvm/20191212171137.13872-1-david@redhat.com/

David Hildenbrand (13):
  util: vfio-helpers: Factor out and fix processing of existings ram
    blocks
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
  numa: Introduce ram_block_notify_resized() and
    ram_block_notifiers_support_resize()
  util: vfio-helpers: Implement ram_block_resized()
  util: oslib: Resizable anonymous allocations under POSIX
  exec: Ram blocks with resizable anonymous allocations under POSIX

 exec.c                    |  99 ++++++++++++++++++----
 hw/core/numa.c            |  39 +++++++++
 include/exec/cpu-common.h |   3 +
 include/exec/memory.h     |   8 ++
 include/exec/ramlist.h    |   4 +
 include/qemu/mmap-alloc.h |  21 +++--
 include/qemu/osdep.h      |   6 +-
 stubs/ram-block.c         |  20 -----
 util/mmap-alloc.c         | 168 ++++++++++++++++++++++++--------------
 util/oslib-posix.c        |  37 ++++++++-
 util/oslib-win32.c        |  14 ++++
 util/trace-events         |   5 +-
 util/vfio-helpers.c       |  33 ++++----
 13 files changed, 331 insertions(+), 126 deletions(-)

--=20
2.24.1


