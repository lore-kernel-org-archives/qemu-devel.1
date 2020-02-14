Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE1FC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A114A2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTBKv9XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A114A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ajJ-0003qP-T9
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2aih-0003Rf-CX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2aif-0002oe-9G
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:09:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2aif-0002o7-51
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581685760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MjtHCzT9BV6DPpIpmLTClvax6mSUrvtlulsecprwlA=;
 b=KTBKv9XCZoZCOd1YiCGs0j9xiZo7JNc4wUWCbdoRxGxss0dOl56JJSFXRCvHh/6+9raaT2
 Plba3SPueWIMVg8aUYQ1NUirwQx9RLN9SlQKzygstonzDsu/noYBdVBmoXSJfE24yA9MT6
 YHQfLtcJj1DvOG+bdjFpOGPvP2fuV3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-6uHCaTNWMJKuE_f4naVP3A-1; Fri, 14 Feb 2020 08:09:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B95100550E;
 Fri, 14 Feb 2020 13:09:12 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FD041001B2C;
 Fri, 14 Feb 2020 13:08:57 +0000 (UTC)
Date: Fri, 14 Feb 2020 13:08:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 00/16] Ram blocks with resizable anonymous
 allocations under POSIX
Message-ID: <20200214130854.GF3283@work-vm>
References: <20200212134254.11073-1-david@redhat.com>
 <6dbb3f4a-95d4-5d64-860a-0583e90a760e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6dbb3f4a-95d4-5d64-860a-0583e90a760e@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6uHCaTNWMJKuE_f4naVP3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Greg Kurz <groug@kaod.org>, Paul Durrant <paul@xen.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 12.02.20 14:42, David Hildenbrand wrote:
> > We already allow resizable ram blocks for anonymous memory, however, th=
ey
> > are not actually resized. All memory is mmaped() R/W, including the mem=
ory
> > exceeding the used_length, up to the max_length.
> >=20
> > When resizing, effectively only the boundary is moved. Implement actual=
ly
> > resizable anonymous allocations and make use of them in resizable ram
> > blocks when possible. Memory exceeding the used_length will be
> > inaccessible. Especially ram block notifiers require care.
> >=20
> > Having actually resizable anonymous allocations (via mmap-hackery) allo=
ws
> > to reserve a big region in virtual address space and grow the
> > accessible/usable part on demand. Even if "/proc/sys/vm/overcommit_memo=
ry"
> > is set to "never" under Linux, huge reservations will succeed. If there=
 is
> > not enough memory when resizing (to populate parts of the reserved regi=
on),
> > trying to resize will fail. Only the actually used size is reserved in =
the
> > OS.
> >=20
> > E.g., virtio-mem [1] wants to reserve big resizable memory regions and
> > grow the usable part on demand. I think this change is worth sending ou=
t
> > individually. Accompanied by a bunch of minor fixes and cleanups.
> >=20
> > Especially, memory notifiers already handle resizing by first removing
> > the old region, and then re-adding the resized region. prealloc is
> > currently not possible with resizable ram blocks. mlock() should contin=
ue
> > to work as is. Resizing is currently rare and must only happen on the
> > start of an incoming migration, or during resets. No code path (except
> > HAX and SEV ram block notifiers) should access memory outside of the us=
able
> > range - and if we ever find one, that one has to be fixed (I did not
> > identify any).
> >=20
> > v1 -> v2:
> > - Add "util: vfio-helpers: Fix qemu_vfio_close()"
> > - Add "util: vfio-helpers: Remove Error parameter from
> >        qemu_vfio_undo_mapping()"
> > - Add "util: vfio-helpers: Factor out removal from
> >        qemu_vfio_undo_mapping()"
> > - "util/mmap-alloc: ..."
> >  -- Minor changes due to review feedback (e.g., assert alignment, retur=
n
> >     bool when resizing)
> > - "util: vfio-helpers: Implement ram_block_resized()"
> >  -- Reserve max_size in the IOVA address space.
> >  -- On resize, undo old mapping and do new mapping. We can later implem=
ent
> >     a new ioctl to resize the mapping directly.
> > - "numa: Teach ram block notifiers about resizable ram blocks"
> >  -- Pass size/max_size to ram block notifiers, which makes things easie=
r an
> >     cleaner
> > - "exec: Ram blocks with resizable anonymous allocations under POSIX"
> >  -- Adapt to new ram block notifiers
> >  -- Shrink after notifying. Always trigger ram block notifiers on resiz=
es
> >  -- Add a safety net that all ram block notifiers registered at runtime
> >     support resizes.
> >=20
> > [1] https://lore.kernel.org/kvm/20191212171137.13872-1-david@redhat.com=
/
> >=20
> > David Hildenbrand (16):
> >   util: vfio-helpers: Factor out and fix processing of existing ram
> >     blocks
> >   util: vfio-helpers: Fix qemu_vfio_close()
> >   util: vfio-helpers: Remove Error parameter from
> >     qemu_vfio_undo_mapping()
> >   util: vfio-helpers: Factor out removal from qemu_vfio_undo_mapping()
> >   exec: Factor out setting ram settings (madvise ...) into
> >     qemu_ram_apply_settings()
> >   exec: Reuse qemu_ram_apply_settings() in qemu_ram_remap()
> >   exec: Drop "shared" parameter from ram_block_add()
> >   util/mmap-alloc: Factor out calculation of pagesize to mmap_pagesize(=
)
> >   util/mmap-alloc: Factor out reserving of a memory region to
> >     mmap_reserve()
> >   util/mmap-alloc: Factor out populating of memory to mmap_populate()
> >   util/mmap-alloc: Prepare for resizable mmaps
> >   util/mmap-alloc: Implement resizable mmaps
> >   numa: Teach ram block notifiers about resizable ram blocks
> >   util: vfio-helpers: Implement ram_block_resized()
> >   util: oslib: Resizable anonymous allocations under POSIX
> >   exec: Ram blocks with resizable anonymous allocations under POSIX
> >=20
> >  exec.c                     | 104 +++++++++++++++++++----
> >  hw/core/numa.c             |  53 +++++++++++-
> >  hw/i386/xen/xen-mapcache.c |   7 +-
> >  include/exec/cpu-common.h  |   3 +
> >  include/exec/memory.h      |   8 ++
> >  include/exec/ramlist.h     |  14 +++-
> >  include/qemu/mmap-alloc.h  |  21 +++--
> >  include/qemu/osdep.h       |   6 +-
> >  stubs/ram-block.c          |  20 -----
> >  target/i386/hax-mem.c      |   5 +-
> >  target/i386/sev.c          |  18 ++--
> >  util/mmap-alloc.c          | 165 +++++++++++++++++++++++--------------
> >  util/oslib-posix.c         |  37 ++++++++-
> >  util/oslib-win32.c         |  14 ++++
> >  util/trace-events          |   9 +-
> >  util/vfio-helpers.c        | 145 +++++++++++++++++++++-----------
> >  16 files changed, 450 insertions(+), 179 deletions(-)
> >=20
>=20
> 1. I will do resizable -> resizeable
> 2. I think migration might indeed need some care regarding
>    max_length. We should never migrate anything beyond used_length. And
>    if we receive something, it should be discarded. Will look into that.

It feels like we should warn/error if we receive something beyond used?

Dave

> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


