Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E9C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD1520720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlyBQumd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD1520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdTb-0004IJ-GF
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izdSE-0003C7-IS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izdSD-0002WQ-5r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:28:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izdSD-0002Qn-0g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580981287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mckgbb65EHpdRRf4lJU2csVGiQYHvFShtu6TrtebHg=;
 b=NlyBQumdABtxTxnRIbDWXPnQQhtOvh3tC5CUAQbTMpXiE6sgOpV0qKsmqgd4uUw+cXExIQ
 C8PG1rgJvvtK+lAqcGj4YH7Zdori9V3uukSw/OceyAm+ukB8147+3SpkW7OCRtcUpjxEZT
 QHb9WQ4y+OspsdyGStn0rxM6fuADQZM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-iHX3n4ylP9WVlNvW79Skig-1; Thu, 06 Feb 2020 04:28:03 -0500
Received: by mail-qt1-f199.google.com with SMTP id g26so3392856qts.16
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 01:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eAhYArDTDSR90SX+3YgGRHpDrF5pfk9LHwubEX7Ln8o=;
 b=WHGg7wVmdfuQG17HNP04OWdypqWqIRauud0Hl4wZRalnllvH3JMHVq4yIhTZGka60K
 ca8fH5X+P15K5Z82r1EinTsfUZpDGcg2Ce/96kXQZFC5iBtZvYYI3vQ7HcYcvoHgyiEk
 whAMYxqLnYYYvnAJuI5qjEVMUc7sBUEg7CRBxa1v3rXF2YX6nxXXE63EfgB1YQIkhZIX
 rWBHliUL7mhTUfp3eA7G3dTI2kbFMdxo3LaF1+BAa1NPm1Md46J3gbwAUxLJwH7tRPyh
 Qh2tMHrcbNnddpAJpeGKfO2PuUhYiJHgmY/nN4PtOIPAspLZY1SAC83e8kAKK1lUg8id
 O5nQ==
X-Gm-Message-State: APjAAAVrNvhGFD70d1VrWbI3hiI+HXOvfiLFFs6+o1QeKCRajh8nCmVF
 vCmEk+geVqD2MNMlLOL9denrghvNslfDwE+AVLSTWpI1B/wfdPqlM/OcNwptjU7ljz9I3p4nvX+
 pfyc5YNQn8xlbWS4=
X-Received: by 2002:ac8:1ac1:: with SMTP id h1mr1723440qtk.255.1580981283227; 
 Thu, 06 Feb 2020 01:28:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwK1fL4hIVyvHOCvZ71vxeK3MySarEJnWLKBEVTnLl6OIYmzUWkps6mcpv2xNfYu8jtOu5XwQ==
X-Received: by 2002:ac8:1ac1:: with SMTP id h1mr1723435qtk.255.1580981282978; 
 Thu, 06 Feb 2020 01:28:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id a145sm1117886qkg.128.2020.02.06.01.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 01:28:02 -0800 (PST)
Date: Thu, 6 Feb 2020 04:27:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 00/13] Ram blocks with resizable anonymous allocations
 under POSIX
Message-ID: <20200206042723-mutt-send-email-mst@kernel.org>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
X-MC-Unique: iHX3n4ylP9WVlNvW79Skig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Stefan Weil <sw@weilnetz.de>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 07:31:12PM +0100, David Hildenbrand wrote:
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

How does this inteact with all the prealloc/mlock things designed
for realtime?

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


