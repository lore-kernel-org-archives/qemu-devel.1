Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9BBC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68918206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEwWFmeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68918206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic5BN-0005No-0a
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 05:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ic55f-0003JV-BO
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ic55Z-0003G0-I0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:07:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48299
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ic55Z-00035T-3T
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575367642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8crGNRJWKGYhR6vWuJjFkitcLzFutIoE8N1QERJx/4=;
 b=LEwWFmeGMR4Zmkxgrydzonnbe2rmCzDLgbHdtl23y/qE9uXiXn0E2X/253eC26Ub1qTvqv
 cr1cvuyhk9dHqgbWk92ViqwKUcT6yWXhTe3wORfEx3iNg4G9bgaQ0CW7JfLDlEMXCotLvY
 76gv84Kpgc5nPYXuq1AWsPRXLcq9H9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-yBpcfnEKN266a-zZE7oZtA-1; Tue, 03 Dec 2019 05:07:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6790C1883523;
 Tue,  3 Dec 2019 10:07:17 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 503E85DA2C;
 Tue,  3 Dec 2019 10:07:11 +0000 (UTC)
Date: Tue, 3 Dec 2019 10:07:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH] virtiofs: Relax DAX window protection for ppc
Message-ID: <20191203100708.GA3078@work-vm>
References: <20191202202639.102322-1-farosas@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191202202639.102322-1-farosas@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: yBpcfnEKN266a-zZE7oZtA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: virtio-fs@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Fabiano Rosas (farosas@linux.ibm.com) wrote:
> When setting up the DAX window during the virtiofs driver probe inside
> the guest, the Linux arch-specific function arch_add_memory is called,
> which on ppc tries to do a cache flush [1] of the recently added
> memory. At this point the window is mmap'ed PROT_NONE by QEMU, which
> causes the following:
>=20
> <snip>
> [   10.136703] virtio_fs virtio0: Cache len: 0x80000000 @ 0x210000000000
> [   10.165106] radix-mmu: Mapped 0xc000210000000000-0xc000210080000000 wi=
th 1.00 GiB pages
> error: kvm run failed Bad address
> NIP c000000000072350   LR c000000000072304 CTR 0000000001000000 XER 00000=
00020040000 CPU#0
> MSR 8000000002009033 HID0 0000000000000000  HF 8000000000000000 iidx 3 di=
dx 3
> TB 00000000 00000000 DECR 0
> GPR00 c000000000072304 c0000000fa383100 c000000001190300 0000000000000000
> GPR04 0000000000000001 0000000000000000 c0000000fa383208 0000000000000080
> GPR08 c000210000000000 000000008000007f 0000000001000000 6874697720303030
> <snip>
>=20
> The problem is the same for the memory device removal path
> (e.g. during filesystem unmount).
>=20
> Since powerpc expects the memory to be accessible during device
> addition/removal, this patch makes the DAX window readable at creation
> and after virtio-fs unmap.
>=20
> 1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dfb5924fd
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks, I'll do a pull after the tree opens again.

Dave

> ---
>  hw/virtio/vhost-user-fs.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 455e97beea..92958797d0 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -24,6 +24,16 @@
>  #include "exec/address-spaces.h"
>  #include "trace.h"
> =20
> +/*
> + * The powerpc kernel code expects the memory to be accessible during
> + * addition/removal.
> + */
> +#if defined(TARGET_PPC64) && defined(CONFIG_LINUX)
> +#define DAX_WINDOW_PROT PROT_READ
> +#else
> +#define DAX_WINDOW_PROT PROT_NONE
> +#endif
> +
>  uint64_t vhost_user_fs_slave_map(struct vhost_dev *dev, VhostUserFSSlave=
Msg *sm,
>                                   int fd)
>  {
> @@ -133,8 +143,8 @@ uint64_t vhost_user_fs_slave_unmap(struct vhost_dev *=
dev, VhostUserFSSlaveMsg *s
>              continue;
>          }
> =20
> -        ptr =3D mmap(cache_host + sm->c_offset[i], sm->len[i],
> -                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, =
0);
> +        ptr =3D mmap(cache_host + sm->c_offset[i], sm->len[i], DAX_WINDO=
W_PROT,
> +                   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>          if (ptr !=3D (cache_host + sm->c_offset[i])) {
>              res =3D -errno;
>              fprintf(stderr, "%s: mmap failed (%s) [%d] %"
> @@ -485,8 +495,9 @@ static void vuf_device_realize(DeviceState *dev, Erro=
r **errp)
> =20
>      if (fs->conf.cache_size) {
>          /* Anonymous, private memory is not counted as overcommit */
> -        cache_ptr =3D mmap(NULL, fs->conf.cache_size, PROT_NONE,
> +        cache_ptr =3D mmap(NULL, fs->conf.cache_size, DAX_WINDOW_PROT,
>                           MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +
>          if (cache_ptr =3D=3D MAP_FAILED) {
>              error_setg(errp, "Unable to mmap blank cache");
>              return;
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


