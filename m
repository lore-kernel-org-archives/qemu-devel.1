Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38312C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019822070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA+79j36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019822070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwOh-0000DB-7d
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuwNW-0007Us-NZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuwNV-0006ii-AU
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:39:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34335
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuwNV-0006hD-6J
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579862392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txes1tHFlN8wGGxefrtpyxNb8B5mcTcHfPI095nKwOI=;
 b=dA+79j36bdBybNpV4enX3mYRN3Lpq15YfA3J+Z9yld03pk5emD0QpOF75a2EUs2bStc9g+
 qi2Byhid3rV/tF7BVrObzC2nGSdpKJCImKrJ3Nr4d1p+Boa8u44EmHCUeQNOryA6o5obYu
 5nfygAmD5CwGHOF6K4zbUePkRd7IEb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Fy8A_Ro3O_uPJZHUB_3WfA-1; Fri, 24 Jan 2020 05:39:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E46608010F5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 10:39:49 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F14FE28997;
 Fri, 24 Jan 2020 10:39:47 +0000 (UTC)
Date: Fri, 24 Jan 2020 10:39:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/21] ram_addr: Split RAMBlock definition
Message-ID: <20200124103945.GH2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-11-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-11-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Fy8A_Ro3O_uPJZHUB_3WfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> We need some of the fields without having to poison everything else.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

OK.
(I guess the copyright matches the file we're splitting from; would be
good to update the date some time).

I wondered if any of the RAMBlock related function declarations should
move as wlel; but it's not obvious which ones.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  MAINTAINERS             |  1 +
>  include/exec/ram_addr.h | 40 +-------------------------
>  include/exec/ramblock.h | 64 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 39 deletions(-)
>  create mode 100644 include/exec/ramblock.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c768ed3d8..3732f746b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1965,6 +1965,7 @@ F: ioport.c
>  F: include/exec/memop.h
>  F: include/exec/memory.h
>  F: include/exec/ram_addr.h
> +F: include/exec/ramblock.h
>  F: memory.c
>  F: include/exec/memory-internal.h
>  F: exec.c
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 5adebb0bc7..5e59a3d8d7 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -24,45 +24,7 @@
>  #include "hw/xen/xen.h"
>  #include "sysemu/tcg.h"
>  #include "exec/ramlist.h"
> -
> -struct RAMBlock {
> -    struct rcu_head rcu;
> -    struct MemoryRegion *mr;
> -    uint8_t *host;
> -    uint8_t *colo_cache; /* For colo, VM's ram cache */
> -    ram_addr_t offset;
> -    ram_addr_t used_length;
> -    ram_addr_t max_length;
> -    void (*resized)(const char*, uint64_t length, void *host);
> -    uint32_t flags;
> -    /* Protected by iothread lock.  */
> -    char idstr[256];
> -    /* RCU-enabled, writes protected by the ramlist lock */
> -    QLIST_ENTRY(RAMBlock) next;
> -    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> -    int fd;
> -    size_t page_size;
> -    /* dirty bitmap used during migration */
> -    unsigned long *bmap;
> -    /* bitmap of already received pages in postcopy */
> -    unsigned long *receivedmap;
> -
> -    /*
> -     * bitmap to track already cleared dirty bitmap.  When the bit is
> -     * set, it means the corresponding memory chunk needs a log-clear.
> -     * Set this up to non-NULL to enable the capability to postpone
> -     * and split clearing of dirty bitmap on the remote node (e.g.,
> -     * KVM).  The bitmap will be set only when doing global sync.
> -     *
> -     * NOTE: this bitmap is different comparing to the other bitmaps
> -     * in that one bit can represent multiple guest pages (which is
> -     * decided by the `clear_bmap_shift' variable below).  On
> -     * destination side, this should always be NULL, and the variable
> -     * `clear_bmap_shift' is meaningless.
> -     */
> -    unsigned long *clear_bmap;
> -    uint8_t clear_bmap_shift;
> -};
> +#include "exec/ramblock.h"
> =20
>  /**
>   * clear_bmap_size: calculate clear bitmap size
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> new file mode 100644
> index 0000000000..07d50864d8
> --- /dev/null
> +++ b/include/exec/ramblock.h
> @@ -0,0 +1,64 @@
> +/*
> + * Declarations for cpu physical memory functions
> + *
> + * Copyright 2011 Red Hat, Inc. and/or its affiliates
> + *
> + * Authors:
> + *  Avi Kivity <avi@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + *
> + */
> +
> +/*
> + * This header is for use by exec.c and memory.c ONLY.  Do not include i=
t.
> + * The functions declared here will be removed soon.
> + */
> +
> +#ifndef QEMU_EXEC_RAMBLOCK_H
> +#define QEMU_EXEC_RAMBLOCK_H
> +
> +#ifndef CONFIG_USER_ONLY
> +#include "cpu-common.h"
> +
> +struct RAMBlock {
> +    struct rcu_head rcu;
> +    struct MemoryRegion *mr;
> +    uint8_t *host;
> +    uint8_t *colo_cache; /* For colo, VM's ram cache */
> +    ram_addr_t offset;
> +    ram_addr_t used_length;
> +    ram_addr_t max_length;
> +    void (*resized)(const char*, uint64_t length, void *host);
> +    uint32_t flags;
> +    /* Protected by iothread lock.  */
> +    char idstr[256];
> +    /* RCU-enabled, writes protected by the ramlist lock */
> +    QLIST_ENTRY(RAMBlock) next;
> +    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> +    int fd;
> +    size_t page_size;
> +    /* dirty bitmap used during migration */
> +    unsigned long *bmap;
> +    /* bitmap of already received pages in postcopy */
> +    unsigned long *receivedmap;
> +
> +    /*
> +     * bitmap to track already cleared dirty bitmap.  When the bit is
> +     * set, it means the corresponding memory chunk needs a log-clear.
> +     * Set this up to non-NULL to enable the capability to postpone
> +     * and split clearing of dirty bitmap on the remote node (e.g.,
> +     * KVM).  The bitmap will be set only when doing global sync.
> +     *
> +     * NOTE: this bitmap is different comparing to the other bitmaps
> +     * in that one bit can represent multiple guest pages (which is
> +     * decided by the `clear_bmap_shift' variable below).  On
> +     * destination side, this should always be NULL, and the variable
> +     * `clear_bmap_shift' is meaningless.
> +     */
> +    unsigned long *clear_bmap;
> +    uint8_t clear_bmap_shift;
> +};
> +#endif
> +#endif
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


