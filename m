Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D9FC3B186
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6F320661
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWjQtBAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6F320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1wN5-00051X-Mp
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1wMT-0004cM-81
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1wMQ-0003YS-EH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:03:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33696
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1wMQ-0003W1-0A
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581530620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zV0bbivRsNq0/U4zNl2G1x+JF/+PeBIS7L1jE5fhgcE=;
 b=eWjQtBAfNyRiU92uNj+soM8XIe3GdoZpgdebEtSaVVIr5mJGMARXftYrgb7fmiYH7nKSyw
 1OpUvXxvsZz7rpmioZvQZyntbwcZuwfrclsR3AEbJ4i1QYckLWqQ0NlZw9ADp9kPYmtUwx
 2MER4VQ9N6GJCbmlqwrj1/c5qVeRc7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-JC6uA0GLNe2bCvRgJtpFGA-1; Wed, 12 Feb 2020 13:03:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62116800E21;
 Wed, 12 Feb 2020 18:03:17 +0000 (UTC)
Received: from [10.36.117.92] (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C0BC5C10D;
 Wed, 12 Feb 2020 18:03:05 +0000 (UTC)
Subject: Re: [PATCH v2 fixed 00/16] Ram blocks with resizable anonymous
 allocations under POSIX
To: qemu-devel@nongnu.org
References: <20200212134254.11073-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <6dbb3f4a-95d4-5d64-860a-0583e90a760e@redhat.com>
Date: Wed, 12 Feb 2020 19:03:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-1-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: JC6uA0GLNe2bCvRgJtpFGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
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

On 12.02.20 14:42, David Hildenbrand wrote:
> We already allow resizable ram blocks for anonymous memory, however, they
> are not actually resized. All memory is mmaped() R/W, including the memory
> exceeding the used_length, up to the max_length.
> 
> When resizing, effectively only the boundary is moved. Implement actually
> resizable anonymous allocations and make use of them in resizable ram
> blocks when possible. Memory exceeding the used_length will be
> inaccessible. Especially ram block notifiers require care.
> 
> Having actually resizable anonymous allocations (via mmap-hackery) allows
> to reserve a big region in virtual address space and grow the
> accessible/usable part on demand. Even if "/proc/sys/vm/overcommit_memory"
> is set to "never" under Linux, huge reservations will succeed. If there is
> not enough memory when resizing (to populate parts of the reserved region),
> trying to resize will fail. Only the actually used size is reserved in the
> OS.
> 
> E.g., virtio-mem [1] wants to reserve big resizable memory regions and
> grow the usable part on demand. I think this change is worth sending out
> individually. Accompanied by a bunch of minor fixes and cleanups.
> 
> Especially, memory notifiers already handle resizing by first removing
> the old region, and then re-adding the resized region. prealloc is
> currently not possible with resizable ram blocks. mlock() should continue
> to work as is. Resizing is currently rare and must only happen on the
> start of an incoming migration, or during resets. No code path (except
> HAX and SEV ram block notifiers) should access memory outside of the usable
> range - and if we ever find one, that one has to be fixed (I did not
> identify any).
> 
> v1 -> v2:
> - Add "util: vfio-helpers: Fix qemu_vfio_close()"
> - Add "util: vfio-helpers: Remove Error parameter from
>        qemu_vfio_undo_mapping()"
> - Add "util: vfio-helpers: Factor out removal from
>        qemu_vfio_undo_mapping()"
> - "util/mmap-alloc: ..."
>  -- Minor changes due to review feedback (e.g., assert alignment, return
>     bool when resizing)
> - "util: vfio-helpers: Implement ram_block_resized()"
>  -- Reserve max_size in the IOVA address space.
>  -- On resize, undo old mapping and do new mapping. We can later implement
>     a new ioctl to resize the mapping directly.
> - "numa: Teach ram block notifiers about resizable ram blocks"
>  -- Pass size/max_size to ram block notifiers, which makes things easier an
>     cleaner
> - "exec: Ram blocks with resizable anonymous allocations under POSIX"
>  -- Adapt to new ram block notifiers
>  -- Shrink after notifying. Always trigger ram block notifiers on resizes
>  -- Add a safety net that all ram block notifiers registered at runtime
>     support resizes.
> 
> [1] https://lore.kernel.org/kvm/20191212171137.13872-1-david@redhat.com/
> 
> David Hildenbrand (16):
>   util: vfio-helpers: Factor out and fix processing of existing ram
>     blocks
>   util: vfio-helpers: Fix qemu_vfio_close()
>   util: vfio-helpers: Remove Error parameter from
>     qemu_vfio_undo_mapping()
>   util: vfio-helpers: Factor out removal from qemu_vfio_undo_mapping()
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
>   numa: Teach ram block notifiers about resizable ram blocks
>   util: vfio-helpers: Implement ram_block_resized()
>   util: oslib: Resizable anonymous allocations under POSIX
>   exec: Ram blocks with resizable anonymous allocations under POSIX
> 
>  exec.c                     | 104 +++++++++++++++++++----
>  hw/core/numa.c             |  53 +++++++++++-
>  hw/i386/xen/xen-mapcache.c |   7 +-
>  include/exec/cpu-common.h  |   3 +
>  include/exec/memory.h      |   8 ++
>  include/exec/ramlist.h     |  14 +++-
>  include/qemu/mmap-alloc.h  |  21 +++--
>  include/qemu/osdep.h       |   6 +-
>  stubs/ram-block.c          |  20 -----
>  target/i386/hax-mem.c      |   5 +-
>  target/i386/sev.c          |  18 ++--
>  util/mmap-alloc.c          | 165 +++++++++++++++++++++++--------------
>  util/oslib-posix.c         |  37 ++++++++-
>  util/oslib-win32.c         |  14 ++++
>  util/trace-events          |   9 +-
>  util/vfio-helpers.c        | 145 +++++++++++++++++++++-----------
>  16 files changed, 450 insertions(+), 179 deletions(-)
> 

1. I will do resizable -> resizeable
2. I think migration might indeed need some care regarding
   max_length. We should never migrate anything beyond used_length. And
   if we receive something, it should be discarded. Will look into that.

-- 
Thanks,

David / dhildenb


