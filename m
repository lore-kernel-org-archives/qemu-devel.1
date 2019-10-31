Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567E7CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AF3208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 15:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6rzzbFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AF3208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQCnW-0001ZD-7o
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 11:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iQCfl-0006V6-Ud
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iQCfk-0003q6-De
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:47:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iQCfk-0003po-9a
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572536859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OU9vwu2FN8vUKMRkapmeJjLmpIj50lC37JoBKr/eSNc=;
 b=g6rzzbFQkR+dRcXJjV9+oU+p/JC+PN9dD2ONOIF4BXtEcrMaEajamlYrjZG2z6vZU8VRVf
 mWwS0Zc4PNzi+353NziF/waRdh5YBOYQWy2bTwzM+p1smjbOwUe7T4lZn81GAbC8mCP4PD
 5nTU4EXSDpO7OszHzqnxOVh0H+7PHKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-OZ2wXzinOZ2k7alWa3IyVg-1; Thu, 31 Oct 2019 11:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD46107ACC0;
 Thu, 31 Oct 2019 15:47:36 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA357600CD;
 Thu, 31 Oct 2019 15:47:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6E10B2237B5; Thu, 31 Oct 2019 11:47:32 -0400 (EDT)
Date: Thu, 31 Oct 2019 11:47:32 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Message-ID: <20191031154732.GC7308@redhat.com>
References: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: OZ2wXzinOZ2k7alWa3IyVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 09:25:23PM +0900, Misono Tomohiro wrote:
> When writeback mode is enabled (-o writeback), O_APPEND handling is
> done in kernel. Therefore virtiofsd clears O_APPEND flag when open.
> Otherwise O_APPEND flag takes precedence over pwrite() and write
> data may corrupt.
>=20
> Currently clearing O_APPEND flag is done in lo_open(), but we also
> need the same operation in lo_create(). So, factor out the flag
> update operation in lo_open() to update_open_flags() and call it
> in both lo_open() and lo_create().
>=20
> This fixes the failure of xfstest generic/069 in writeback mode
> (which tests O_APPEND write data integrity).
>=20
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> ---
>  contrib/virtiofsd/passthrough_ll.c | 56 +++++++++++++++---------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
> index e8892c3c32..79fb78ecce 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1733,6 +1733,32 @@ static void lo_releasedir(fuse_req_t req, fuse_ino=
_t ino, struct fuse_file_info
>  =09fuse_reply_err(req, 0);
>  }
> =20
> +static void update_open_flags(int writeback, struct fuse_file_info *fi)
> +{
> +=09/* With writeback cache, kernel may send read requests even
> +=09   when userspace opened write-only */
> +=09if (writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> +=09=09fi->flags &=3D ~O_ACCMODE;
> +=09=09fi->flags |=3D O_RDWR;
> +=09}
> +
> +=09/* With writeback cache, O_APPEND is handled by the kernel.
> +=09   This breaks atomicity (since the file may change in the
> +=09   underlying filesystem, so that the kernel's idea of the
> +=09   end of the file isn't accurate anymore). In this example,
> +=09   we just accept that. A more rigorous filesystem may want
> +=09   to return an error here */
> +=09if (writeback && (fi->flags & O_APPEND))
> +=09=09fi->flags &=3D ~O_APPEND;
> +
> +=09/*
> +=09 * O_DIRECT in guest should not necessarily mean bypassing page
> +=09 * cache on host as well. If somebody needs that behavior, it
> +=09 * probably should be a configuration knob in daemon.
> +=09 */
> +=09fi->flags &=3D ~O_DIRECT;
> +}
> +
>  static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *nam=
e,
>  =09=09      mode_t mode, struct fuse_file_info *fi)
>  {
> @@ -1760,12 +1786,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t p=
arent, const char *name,
>  =09if (err)
>  =09=09goto out;
> =20
> -=09/*
> -=09 * O_DIRECT in guest should not necessarily mean bypassing page
> -=09 * cache on host as well. If somebody needs that behavior, it
> -=09 * probably should be a configuration knob in daemon.
> -=09 */
> -=09fi->flags &=3D ~O_DIRECT;
> +=09update_open_flags(lo->writeback, fi);
> =20
>  =09fd =3D openat(parent_inode->fd, name,
>  =09=09    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
> @@ -1966,28 +1987,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino=
, struct fuse_file_info *fi)
> =20
>  =09fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n", =
ino, fi->flags);
> =20
> -=09/* With writeback cache, kernel may send read requests even
> -=09   when userspace opened write-only */
> -=09if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> -=09=09fi->flags &=3D ~O_ACCMODE;
> -=09=09fi->flags |=3D O_RDWR;
> -=09}
> -
> -=09/* With writeback cache, O_APPEND is handled by the kernel.
> -=09   This breaks atomicity (since the file may change in the
> -=09   underlying filesystem, so that the kernel's idea of the
> -=09   end of the file isn't accurate anymore). In this example,
> -=09   we just accept that. A more rigorous filesystem may want
> -=09   to return an error here */
> -=09if (lo->writeback && (fi->flags & O_APPEND))
> -=09=09fi->flags &=3D ~O_APPEND;
> -
> -=09/*
> -=09 * O_DIRECT in guest should not necessarily mean bypassing page
> -=09 * cache on host as well. If somebody needs that behavior, it
> -=09 * probably should be a configuration knob in daemon.
> -=09 */
> -=09fi->flags &=3D ~O_DIRECT;
> +=09update_open_flags(lo->writeback, fi);
> =20
>  =09sprintf(buf, "%i", lo_fd(req, ino));
>  =09fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> --=20
> 2.21.0
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


