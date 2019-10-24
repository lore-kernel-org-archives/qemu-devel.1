Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D121CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB0720659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgdKP4dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB0720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfra-0002Xv-Kb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iNeu8-0002MY-RN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iNeu7-00031c-4e
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:20:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iNeu6-00031V-N4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571930315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X9XFqqew8ivwraa0tClrLPJRNEA3ImkqAtcS+f9/2c=;
 b=XgdKP4ddY61EfPxD4Q54eDaurRHi8K/8pVspW6uZ88Iiq1bKvv4rsiPte2o2w1GkAnNSmE
 O21J5jM767xsbvHGhPhuG8qhTl43QAsm27lLFsXmYTvUasRA81JaksTCLGwa3ABRj/nK5P
 7PSHqlcKC5CEwPB066t2asV5Gu7nqnY=
Received: from mimecast-mx01.redhat.com (209.132.183.4 [209.132.183.4])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-RQaXjuezNxKTa6LIw-meRw-1; Thu, 24 Oct 2019 11:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EF4A801E77;
 Thu, 24 Oct 2019 15:02:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7739560E1C;
 Thu, 24 Oct 2019 15:02:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 06F662202E8; Thu, 24 Oct 2019 11:02:25 -0400 (EDT)
Date: Thu, 24 Oct 2019 11:02:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Message-ID: <20191024150225.GB6903@redhat.com>
References: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
 <20191023200752.GB6942@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191023200752.GB6942@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: RQaXjuezNxKTa6LIw-meRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 04:07:52PM -0400, Vivek Goyal wrote:
> On Wed, Oct 23, 2019 at 09:25:23PM +0900, Misono Tomohiro wrote:
> > When writeback mode is enabled (-o writeback), O_APPEND handling is
> > done in kernel. Therefore virtiofsd clears O_APPEND flag when open.
> > Otherwise O_APPEND flag takes precedence over pwrite() and write
> > data may corrupt.
> >=20
> > Currently clearing O_APPEND flag is done in lo_open(), but we also
> > need the same operation in lo_create().
>=20
> > So, factor out the flag
> > update operation in lo_open() to update_open_flags() and call it
> > in both lo_open() and lo_create().
> >=20
> > This fixes the failure of xfstest generic/069 in writeback mode
> > (which tests O_APPEND write data integrity).
> >=20

Hi Misono,

Have you tried running pjdfstests. Looks like with the patch applied I
see following tests failing which were passing without the patch. Can
you please have a look. I ran daemon with options "-o cache=3Dalways -o
writeback"

/root/git/pjdfstest/tests/chmod/00.t          (Wstat: 0 Tests: 119 Failed: =
1)
  Failed test:  64
/root/git/pjdfstest/tests/chown/00.t          (Wstat: 0 Tests: 1323 Failed:=
 1)
  Failed test:  946
  TODO passed:   1107, 1112, 1116, 1122, 1127, 1131, 1137
                1142, 1146, 1152, 1157, 1161, 1167, 1172
                1176, 1182, 1187
/root/git/pjdfstest/tests/link/00.t           (Wstat: 0 Tests: 202 Failed: =
1)
  Failed test:  134
/root/git/pjdfstest/tests/utimensat/01.t      (Wstat: 0 Tests: 7 Failed: 1)
  Failed test:  4
Files=3D232, Tests=3D8789, 375 wallclock secs ( 4.00 usr  2.65 sys + 51.48 =
cusr 262.19 csys =3D 320.32 CPU)
Thanks
Vivek

>=20
> Hi,
>=20
> Consolidating updation of flags both for lo_create() and lo_open() makes
> sense to me. I will test it tomorrow.
>=20
> Thanks
> Vivek
>=20
> > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > ---
> >  contrib/virtiofsd/passthrough_ll.c | 56 +++++++++++++++---------------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/pas=
sthrough_ll.c
> > index e8892c3c32..79fb78ecce 100644
> > --- a/contrib/virtiofsd/passthrough_ll.c
> > +++ b/contrib/virtiofsd/passthrough_ll.c
> > @@ -1733,6 +1733,32 @@ static void lo_releasedir(fuse_req_t req, fuse_i=
no_t ino, struct fuse_file_info
> >  =09fuse_reply_err(req, 0);
> >  }
> > =20
> > +static void update_open_flags(int writeback, struct fuse_file_info *fi=
)
> > +{
> > +=09/* With writeback cache, kernel may send read requests even
> > +=09   when userspace opened write-only */
> > +=09if (writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> > +=09=09fi->flags &=3D ~O_ACCMODE;
> > +=09=09fi->flags |=3D O_RDWR;
> > +=09}
> > +
> > +=09/* With writeback cache, O_APPEND is handled by the kernel.
> > +=09   This breaks atomicity (since the file may change in the
> > +=09   underlying filesystem, so that the kernel's idea of the
> > +=09   end of the file isn't accurate anymore). In this example,
> > +=09   we just accept that. A more rigorous filesystem may want
> > +=09   to return an error here */
> > +=09if (writeback && (fi->flags & O_APPEND))
> > +=09=09fi->flags &=3D ~O_APPEND;
> > +
> > +=09/*
> > +=09 * O_DIRECT in guest should not necessarily mean bypassing page
> > +=09 * cache on host as well. If somebody needs that behavior, it
> > +=09 * probably should be a configuration knob in daemon.
> > +=09 */
> > +=09fi->flags &=3D ~O_DIRECT;
> > +}
> > +
> >  static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *n=
ame,
> >  =09=09      mode_t mode, struct fuse_file_info *fi)
> >  {
> > @@ -1760,12 +1786,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t=
 parent, const char *name,
> >  =09if (err)
> >  =09=09goto out;
> > =20
> > -=09/*
> > -=09 * O_DIRECT in guest should not necessarily mean bypassing page
> > -=09 * cache on host as well. If somebody needs that behavior, it
> > -=09 * probably should be a configuration knob in daemon.
> > -=09 */
> > -=09fi->flags &=3D ~O_DIRECT;
> > +=09update_open_flags(lo->writeback, fi);
> > =20
> >  =09fd =3D openat(parent_inode->fd, name,
> >  =09=09    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
> > @@ -1966,28 +1987,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t i=
no, struct fuse_file_info *fi)
> > =20
> >  =09fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n"=
, ino, fi->flags);
> > =20
> > -=09/* With writeback cache, kernel may send read requests even
> > -=09   when userspace opened write-only */
> > -=09if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> > -=09=09fi->flags &=3D ~O_ACCMODE;
> > -=09=09fi->flags |=3D O_RDWR;
> > -=09}
> > -
> > -=09/* With writeback cache, O_APPEND is handled by the kernel.
> > -=09   This breaks atomicity (since the file may change in the
> > -=09   underlying filesystem, so that the kernel's idea of the
> > -=09   end of the file isn't accurate anymore). In this example,
> > -=09   we just accept that. A more rigorous filesystem may want
> > -=09   to return an error here */
> > -=09if (lo->writeback && (fi->flags & O_APPEND))
> > -=09=09fi->flags &=3D ~O_APPEND;
> > -
> > -=09/*
> > -=09 * O_DIRECT in guest should not necessarily mean bypassing page
> > -=09 * cache on host as well. If somebody needs that behavior, it
> > -=09 * probably should be a configuration knob in daemon.
> > -=09 */
> > -=09fi->flags &=3D ~O_DIRECT;
> > +=09update_open_flags(lo->writeback, fi);
> > =20
> >  =09sprintf(buf, "%i", lo_fd(req, ino));
> >  =09fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> > --=20
> > 2.21.0
> >=20
> > _______________________________________________
> > Virtio-fs mailing list
> > Virtio-fs@redhat.com
> > https://www.redhat.com/mailman/listinfo/virtio-fs
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


