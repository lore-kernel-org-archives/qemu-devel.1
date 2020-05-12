Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E1C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA8A206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd4QSR2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA8A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQby-00088a-Pp
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQbO-0007Tz-86
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:49:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQbL-00037D-4w
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589273361;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=J1nl7Wgh21TEwCxHTJRcetGml7AbHXJHpMOxEJtr+kQ=;
 b=Yd4QSR2zQFhFA16hk2iAqQup48IBrmYNWEesgZoyhVQqfAdGphpiEF3BDGVqnucmkcPisJ
 IqrGu1/pcAQkq92stZSz6q/Hp+R1j4YGK9BVL/LjyaDwGMUg4zN8NCUFby3quzD77YhljA
 eYZdNQIPGaAI/+/qlt/6MxGwnRF6d0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-Xhsl0hyWOnaXzVdIGGVpww-1; Tue, 12 May 2020 04:49:17 -0400
X-MC-Unique: Xhsl0hyWOnaXzVdIGGVpww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0528C80B719;
 Tue, 12 May 2020 08:49:15 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4904270947;
 Tue, 12 May 2020 08:48:57 +0000 (UTC)
Date: Tue, 12 May 2020 09:48:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
Message-ID: <20200512084855.GC1191162@redhat.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 09:13:36PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
> 
> Allow RAM MemoryRegion to be created from an offset in a file, instead
> of allocating at offset of 0 by default. This is needed to synchronize
> RAM between QEMU & remote process.

Can you elaborate on why remote processes require the RAM to be offset
from zero ?

NB, I'm not objecting - I'm just curious to understand more.

> 
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c                    | 11 +++++++----
>  include/exec/ram_addr.h   |  2 +-
>  include/qemu/mmap-alloc.h |  3 ++-
>  memory.c                  |  2 +-
>  util/mmap-alloc.c         |  7 ++++---
>  util/oslib-posix.c        |  2 +-
>  6 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 2874bb5088..d0ac9545f4 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1801,6 +1801,7 @@ static void *file_ram_alloc(RAMBlock *block,
>                              ram_addr_t memory,
>                              int fd,
>                              bool truncate,
> +                            off_t offset,
>                              Error **errp)
>  {
>      void *area;
> @@ -1851,7 +1852,8 @@ static void *file_ram_alloc(RAMBlock *block,
>      }
>  
>      area = qemu_ram_mmap(fd, memory, block->mr->align,
> -                         block->flags & RAM_SHARED, block->flags & RAM_PMEM);
> +                         block->flags & RAM_SHARED, block->flags & RAM_PMEM,
> +                         offset);
>      if (area == MAP_FAILED) {
>          error_setg_errno(errp, errno,
>                           "unable to map backing store for guest RAM");
> @@ -2283,7 +2285,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>  #ifdef CONFIG_POSIX
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd,
> -                                 Error **errp)
> +                                 off_t offset, Error **errp)
>  {
>      RAMBlock *new_block;
>      Error *local_err = NULL;
> @@ -2328,7 +2330,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block->used_length = size;
>      new_block->max_length = size;
>      new_block->flags = ram_flags;
> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
> +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
> +                                     errp);
>      if (!new_block->host) {
>          g_free(new_block);
>          return NULL;
> @@ -2358,7 +2361,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> -    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
> +    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
>      if (!block) {
>          if (created) {
>              unlink(mem_path);
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 5e59a3d8d7..1b9f489ff0 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -121,7 +121,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>                                     Error **errp);
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd,
> -                                 Error **errp);
> +                                 off_t offset, Error **errp);
>  
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                    MemoryRegion *mr, Error **errp);
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index e786266b92..4f579858bc 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -25,7 +25,8 @@ void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
>                      bool shared,
> -                    bool is_pmem);
> +                    bool is_pmem,
> +                    off_t start);
>  
>  void qemu_ram_munmap(int fd, void *ptr, size_t size);
>  
> diff --git a/memory.c b/memory.c
> index 601b749906..f5fec476b7 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1596,7 +1596,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
>                                             share ? RAM_SHARED : 0,
> -                                           fd, &err);
> +                                           fd, 0, &err);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
>          mr->size = int128_zero();
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..a28f7025f0 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -86,7 +86,8 @@ void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
>                      bool shared,
> -                    bool is_pmem)
> +                    bool is_pmem,
> +                    off_t start)
>  {
>      int flags;
>      int map_sync_flags = 0;
> @@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
>      offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
>  
>      ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -               flags | map_sync_flags, fd, 0);
> +               flags | map_sync_flags, fd, start);
>  
>      if (ptr == MAP_FAILED && map_sync_flags) {
>          if (errno == ENOTSUP) {
> @@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
>           * we will remove these flags to handle compatibility.
>           */
>          ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -                   flags, fd, 0);
> +                   flags, fd, start);
>      }
>  
>      if (ptr == MAP_FAILED) {
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 062236a1ab..4c6b9e90c6 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -209,7 +209,7 @@ void *qemu_memalign(size_t alignment, size_t size)
>  void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
>  {
>      size_t align = QEMU_VMALLOC_ALIGN;
> -    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
> +    void *ptr = qemu_ram_mmap(-1, size, align, shared, false, 0);
>  
>      if (ptr == MAP_FAILED) {
>          return NULL;
> -- 
> 2.25.GIT
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


