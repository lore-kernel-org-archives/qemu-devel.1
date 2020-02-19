Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12679C3405E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44342464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU7EapJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44342464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SaC-0004mT-1l
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4S2q-0007zz-EC
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4S2p-0003tO-2G
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:17:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4S2o-0003tB-Ua
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582129070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ow5LP688GZb2KfHE0imGm/RWbvWVScxJqRC48hOZrO0=;
 b=FU7EapJwvyC2pNZydUfjjAbOhAiTvtJsvomvCFAg4XZiy1V9v7Y1EXRlU4Or+wKlJ7TEEN
 ehDCjnHDPcmmqr2LSI3qzqG7mUrByqIgz04OeTfTqqE22yUjfpWOggXMB5w/qMu5LVC4Hh
 nXXavpdtHf4ssMU7MY/W4WK8gOamHuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-M3iD0G8-MLaHlBeYWADqvQ-1; Wed, 19 Feb 2020 11:17:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC28D107ACCD;
 Wed, 19 Feb 2020 16:17:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 270E3857BF;
 Wed, 19 Feb 2020 16:17:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/13] migrate/ram: Fix resizing RAM blocks while migrating
Date: Wed, 19 Feb 2020 17:17:12 +0100
Message-Id: <20200219161725.115218-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: M3iD0G8-MLaHlBeYWADqvQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

David Hildenbrand (13):
  util: vfio-helpers: Factor out and fix processing of existing ram
    blocks
  stubs/ram-block: Remove stubs that are no longer needed
  numa: Teach ram block notifiers about resizeable ram blocks
  numa: Make all callbacks of ram block notifiers optional
  migrate/ram: Handle RAM block resizes during precopy
  migrate/ram: Discard new RAM when growing RAM blocks and the VM is
    stopped
  migrate/ram: Get rid of "place_source" in ram_load_postcopy()
  migrate/ram: Simplify host page handling in ram_load_postcopy()
  migrate/ram: Consolidate variable reset after placement in
    ram_load_postcopy()
  migrate/ram: Handle RAM block resizes during postcopy
  migrate/multifd: Print used_length of memory block
  migrate/ram: Use offset_in_ramblock() in range checks
  migrate/ram: Tolerate partially changed mappings in postcopy code

 exec.c                     |  23 +++++-
 hw/core/numa.c             |  41 ++++++++++-
 hw/i386/xen/xen-mapcache.c |   7 +-
 include/exec/cpu-common.h  |   1 +
 include/exec/memory.h      |  10 ++-
 include/exec/ramblock.h    |   9 +++
 include/exec/ramlist.h     |  13 +++-
 migration/migration.c      |   9 ++-
 migration/migration.h      |   1 +
 migration/multifd.c        |   2 +-
 migration/postcopy-ram.c   |  58 ++++++++++++---
 migration/ram.c            | 147 +++++++++++++++++++++++++++----------
 stubs/ram-block.c          |  20 -----
 target/i386/hax-mem.c      |   5 +-
 target/i386/sev.c          |  18 +++--
 util/vfio-helpers.c        |  41 ++++-------
 16 files changed, 280 insertions(+), 125 deletions(-)

--=20
2.24.1


