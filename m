Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD50C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02ADA2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRqwr4+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ADA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DbX-000551-5c
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 14:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9Dah-0004cn-GA
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9Daf-00023M-A9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:52:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33883
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9Daf-00022x-5e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583265148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDC2iERDklNu2GECM/ReQCb7pF5fN9uqXYGqI9qO95g=;
 b=XRqwr4+oQvm7CnpycaIUCx79uIjYcuPo4o/C+lptXtTMPdgL8H4mu9QbFogUWVMy3Dktwf
 BWYOQRlIPP3AdiWl4N6cYhiQgpgKotEyl3n2A/FQwQ+67wi38FUK48Y2+BPjktlHYjFD6s
 NxMZKOD2DsDOlyULid66LxNH5Txe//8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-ZwvXHhMUNeeNqHLz_ButuQ-1; Tue, 03 Mar 2020 14:52:24 -0500
X-MC-Unique: ZwvXHhMUNeeNqHLz_ButuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CEFB869ECB;
 Tue,  3 Mar 2020 19:52:22 +0000 (UTC)
Received: from work-vm (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8457828981;
 Tue,  3 Mar 2020 19:51:52 +0000 (UTC)
Date: Tue, 3 Mar 2020 19:51:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 01/50] multi-process: memory: alloc RAM from file at
 offset
Message-ID: <20200303195149.GV3170@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <e5ab1f93904f30113b358561e207a94076e24653.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e5ab1f93904f30113b358561e207a94076e24653.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> Allow RAM MemoryRegion to be created from an offset in a file, instead
> of allocating at offset of 0 by default. This is needed to synchronize
> RAM between QEMU & remote process.
> This will be needed for the following patches.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>

This looks reasonable to me, so :

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

but can I suggest you take simple things like this and split them out
into a separate little series;  I think people would probably take them
even though the current users have a 0 offset.

Dave

> ---
>  exec.c                    | 11 +++++++----
>  include/exec/ram_addr.h   |  2 +-
>  include/qemu/mmap-alloc.h |  3 ++-
>  memory.c                  |  2 +-
>  util/mmap-alloc.c         |  7 ++++---
>  util/oslib-posix.c        |  2 +-
>  6 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index c930040..e524185 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1841,6 +1841,7 @@ static void *file_ram_alloc(RAMBlock *block,
>                              ram_addr_t memory,
>                              int fd,
>                              bool truncate,
> +                            off_t offset,
>                              Error **errp)
>  {
>      Error *err =3D NULL;
> @@ -1893,7 +1894,8 @@ static void *file_ram_alloc(RAMBlock *block,
>      }
> =20
>      area =3D qemu_ram_mmap(fd, memory, block->mr->align,
> -                         block->flags & RAM_SHARED, block->flags & RAM_P=
MEM);
> +                         block->flags & RAM_SHARED, block->flags & RAM_P=
MEM,
> +                         offset);
>      if (area =3D=3D MAP_FAILED) {
>          error_setg_errno(errp, errno,
>                           "unable to map backing store for guest RAM");
> @@ -2322,7 +2324,7 @@ static void ram_block_add(RAMBlock *new_block, Erro=
r **errp, bool shared)
>  #ifdef CONFIG_POSIX
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd,
> -                                 Error **errp)
> +                                 off_t offset, Error **errp)
>  {
>      RAMBlock *new_block;
>      Error *local_err =3D NULL;
> @@ -2367,7 +2369,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, M=
emoryRegion *mr,
>      new_block->used_length =3D size;
>      new_block->max_length =3D size;
>      new_block->flags =3D ram_flags;
> -    new_block->host =3D file_ram_alloc(new_block, size, fd, !file_size, =
errp);
> +    new_block->host =3D file_ram_alloc(new_block, size, fd, !file_size, =
offset,
> +                                     errp);
>      if (!new_block->host) {
>          g_free(new_block);
>          return NULL;
> @@ -2397,7 +2400,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size,=
 MemoryRegion *mr,
>          return NULL;
>      }
> =20
> -    block =3D qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
> +    block =3D qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
>      if (!block) {
>          if (created) {
>              unlink(mem_path);
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 5e59a3d..1b9f489 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -121,7 +121,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, M=
emoryRegion *mr,
>                                     Error **errp);
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>                                   uint32_t ram_flags, int fd,
> -                                 Error **errp);
> +                                 off_t offset, Error **errp);
> =20
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                    MemoryRegion *mr, Error **errp);
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index e786266..4f57985 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -25,7 +25,8 @@ void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
>                      bool shared,
> -                    bool is_pmem);
> +                    bool is_pmem,
> +                    off_t start);
> =20
>  void qemu_ram_munmap(int fd, void *ptr, size_t size);
> =20
> diff --git a/memory.c b/memory.c
> index aeaa8dc..131bc6c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1595,7 +1595,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *m=
r,
>      mr->destructor =3D memory_region_destructor_ram;
>      mr->ram_block =3D qemu_ram_alloc_from_fd(size, mr,
>                                             share ? RAM_SHARED : 0,
> -                                           fd, &err);
> +                                           fd, 0, &err);
>      mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>      if (err) {
>          mr->size =3D int128_zero();
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd..a28f702 100644
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
>      int map_sync_flags =3D 0;
> @@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
>      offset =3D QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)gu=
ardptr;
> =20
>      ptr =3D mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -               flags | map_sync_flags, fd, 0);
> +               flags | map_sync_flags, fd, start);
> =20
>      if (ptr =3D=3D MAP_FAILED && map_sync_flags) {
>          if (errno =3D=3D ENOTSUP) {
> @@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
>           * we will remove these flags to handle compatibility.
>           */
>          ptr =3D mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -                   flags, fd, 0);
> +                   flags, fd, start);
>      }
> =20
>      if (ptr =3D=3D MAP_FAILED) {
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 5a291cc..bd221dd 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -205,7 +205,7 @@ void *qemu_memalign(size_t alignment, size_t size)
>  void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
>  {
>      size_t align =3D QEMU_VMALLOC_ALIGN;
> -    void *ptr =3D qemu_ram_mmap(-1, size, align, shared, false);
> +    void *ptr =3D qemu_ram_mmap(-1, size, align, shared, false, 0);
> =20
>      if (ptr =3D=3D MAP_FAILED) {
>          return NULL;
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


