Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3FAC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CDB2192A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbBiureW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CDB2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iznVi-0008OT-I7
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 15:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iznV5-0007wq-Uo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iznV4-0003Jy-4h
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:11:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iznV3-0003Gn-W6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 15:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581019905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9aoD5UNMxOvZIruDj5OKzAJd+8pjB96nm/Rf9NL/hQ=;
 b=ZbBiureWUfQqoUuVw5YJZgljUx4EQdPCzz7pF1GBBIp83qrt0xL0WkNTR4ENfxqgr739e9
 gTglmxaRn2t7Lx8gvGTbtab5ID9JgZa66ttuuTIC/sh0CJnL3+fFY/uHsDc9aBzbowg061
 DT1goZwyZgd6x/n9qUZUOfFD/hmQ8JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-5W-tQpTZONqsMFWrD6evbQ-1; Thu, 06 Feb 2020 15:11:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1577DB60;
 Thu,  6 Feb 2020 20:11:35 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37741859A5;
 Thu,  6 Feb 2020 20:11:24 +0000 (UTC)
Date: Thu, 6 Feb 2020 20:11:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 00/13] Ram blocks with resizable anonymous allocations
 under POSIX
Message-ID: <20200206201121.GM3655@work-vm>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5W-tQpTZONqsMFWrD6evbQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> We already allow resizable ram blocks for anonymous memory, however, they
> are not actually resized. All memory is mmaped() R/W, including the memor=
y
> exceeding the used_length, up to the max_length.
>=20
> When resizing, effectively only the boundary is moved. Implement actually
> resizable anonymous allocations and make use of them in resizable ram
> blocks when possible. Memory exceeding the used_length will be
> inaccessible. Especially ram block notifiers require care.
>=20
> Having actually resizable anonymous allocations (via mmap-hackery) allows
> to reserve a big region in virtual address space and grow the
> accessible/usable part on demand. Even if "/proc/sys/vm/overcommit_memory=
"
> is set to "never" under Linux, huge reservations will succeed. If there i=
s
> not enough memory when resizing (to populate parts of the reserved region=
),
> trying to resize will fail. Only the actually used size is reserved in th=
e
> OS.
>=20
> E.g., virtio-mem [1] wants to reserve big resizable memory regions and
> grow the usable part on demand. I think this change is worth sending out
> individually. Accompanied by a bunch of minor fixes and cleanups.
>=20
> [1] https://lore.kernel.org/kvm/20191212171137.13872-1-david@redhat.com/

There's a few bits I've not understood from skimming the patches:

  a) Am I correct in thinking you PROT_NONE the extra space so you can
gkrow/shrink it?
  b) What does kvm see - does it have a slot for the whole space or for
only the used space?
     I ask because we found with virtiofs/DAX experiments that on Power,
kvm gets upset if you give it a mapping with PROT_NONE.
     (That maybe less of an issue if you change the mapping after the
slot is created).

  c) It's interesting this is keyed off the RAMBlock notifiers - do
     memory_listener's on the address space the block is mapped into get
    triggered?  I'm wondering how vhost (and vhost-user) in particular
    see this.

Dave

>=20
> David Hildenbrand (13):
>   util: vfio-helpers: Factor out and fix processing of existings ram
>     blocks
>   exec: Factor out setting ram settings (madvise ...) into
>     qemu_ram_apply_settings()
>   exec: Reuse qemu_ram_apply_settings() in qemu_ram_remap()
>   exec: Drop "shared" parameter from ram_block_add()
>   util/mmap-alloc: Factor out calculation of pagesize to mmap_pagesize()
>   util/mmap-alloc: Factor out reserving of a memory region to
>     mmap_reserve()
>   util/mmap-alloc: Factor out populating of memory to mmap_populate()
>   util/mmap-alloc: Prepare for resizable mmaps
>   util/mmap-alloc: Implement resizable mmaps
>   numa: Introduce ram_block_notify_resized() and
>     ram_block_notifiers_support_resize()
>   util: vfio-helpers: Implement ram_block_resized()
>   util: oslib: Resizable anonymous allocations under POSIX
>   exec: Ram blocks with resizable anonymous allocations under POSIX
>=20
>  exec.c                    |  99 ++++++++++++++++++----
>  hw/core/numa.c            |  39 +++++++++
>  include/exec/cpu-common.h |   3 +
>  include/exec/memory.h     |   8 ++
>  include/exec/ramlist.h    |   4 +
>  include/qemu/mmap-alloc.h |  21 +++--
>  include/qemu/osdep.h      |   6 +-
>  stubs/ram-block.c         |  20 -----
>  util/mmap-alloc.c         | 168 ++++++++++++++++++++++++--------------
>  util/oslib-posix.c        |  37 ++++++++-
>  util/oslib-win32.c        |  14 ++++
>  util/trace-events         |   5 +-
>  util/vfio-helpers.c       |  33 ++++----
>  13 files changed, 331 insertions(+), 126 deletions(-)
>=20
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


