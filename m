Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095D3C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC13D24680
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtCaSHZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC13D24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8Jz-0002Yh-9C
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1is8Gy-0007OU-Ch
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1is8Gr-0001WX-G6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:45:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1is8Gp-0001TM-NV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579193122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4pGY4zfLx97UvjWbeFH9Sa1S6YMGWpAMZ1qiLr+Zs0=;
 b=CtCaSHZI8uxfXgr9/tYgDzuPUhGG59ooPe6yGHDgPA+lXDdtQPq3OyMLR2Q2p9i7fo5bB0
 ZfskU3kSjcOOBMKw3C4i8SYEAlcp0Lz1vHYQ6EF2W+o2qojnlWptoVpPqWN77c6y42t7wM
 K/J6d0PaDxmlsTNjqwf6ai8HAgUyol0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-gv1cLK_OMF26Iy2bY4gDeA-1; Thu, 16 Jan 2020 11:45:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32267800D4E;
 Thu, 16 Jan 2020 16:45:18 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2318619C5B;
 Thu, 16 Jan 2020 16:45:13 +0000 (UTC)
Date: Thu, 16 Jan 2020 16:45:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>, mszeredi@redhat.com
Subject: Re: [PATCH 072/104] virtiofsd: passthrough_ll: fix refcounting on
 remove/rename
Message-ID: <20200116164511.GJ3108@work-vm>
References: <20191212163904.159893-73-dgilbert@redhat.com>
 <20200116115603.5415-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200116115603.5415-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gv1cLK_OMF26Iy2bY4gDeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >=20
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>=20
> I'm not familiar with qemu convention but shouldn't we put
> at least one line of description like linux kernel?

Miklos: would you like to suggest a better commit message?

> For code itself:
>  Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Thanks!

>=20
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 50 +++++++++++++++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 0f33c3c5e9..1b84d4f313 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -1077,17 +1077,42 @@ out_err:
> >      fuse_reply_err(req, saverr);
> >  }
> > =20
> > +static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
> > +                                    const char *name)
> > +{
> > +    int res;
> > +    struct stat attr;
> > +
> > +    res =3D fstatat(lo_fd(req, parent), name, &attr,
> > +                  AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
> > +    if (res =3D=3D -1) {
> > +        return NULL;
> > +    }
> > +
> > +    return lo_find(lo_data(req), &attr);
> > +}
> > +
> >  static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *na=
me)
> >  {
> >      int res;
> > +    struct lo_inode *inode;
> > +    struct lo_data *lo =3D lo_data(req);
> > +
> >      if (!is_safe_path_component(name)) {
> >          fuse_reply_err(req, EINVAL);
> >          return;
> >      }
> > =20
> > +    inode =3D lookup_name(req, parent, name);
> > +    if (!inode) {
> > +        fuse_reply_err(req, EIO);
> > +        return;
> > +    }
> > +
> >      res =3D unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
> > =20
> >      fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> > +    unref_inode_lolocked(lo, inode, 1);
> >  }
> > =20
> >  static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *n=
ame,
> > @@ -1095,12 +1120,23 @@ static void lo_rename(fuse_req_t req, fuse_ino_=
t parent, const char *name,
> >                        unsigned int flags)
> >  {
> >      int res;
> > +    struct lo_inode *oldinode;
> > +    struct lo_inode *newinode;
> > +    struct lo_data *lo =3D lo_data(req);
> > =20
> >      if (!is_safe_path_component(name) || !is_safe_path_component(newna=
me)) {
> >          fuse_reply_err(req, EINVAL);
> >          return;
> >      }
> > =20
> > +    oldinode =3D lookup_name(req, parent, name);
> > +    newinode =3D lookup_name(req, newparent, newname);
> > +
> > +    if (!oldinode) {
> > +        fuse_reply_err(req, EIO);
> > +        goto out;
> > +    }
> > +
> >      if (flags) {
> >  #ifndef SYS_renameat2
> >          fuse_reply_err(req, EINVAL);
> > @@ -1113,26 +1149,38 @@ static void lo_rename(fuse_req_t req, fuse_ino_=
t parent, const char *name,
> >              fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> >          }
> >  #endif
> > -        return;
> > +        goto out;
> >      }
> > =20
> >      res =3D renameat(lo_fd(req, parent), name, lo_fd(req, newparent), =
newname);
> > =20
> >      fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> > +out:
> > +    unref_inode_lolocked(lo, oldinode, 1);
> > +    unref_inode_lolocked(lo, newinode, 1);
> >  }
> > =20
> >  static void lo_unlink(fuse_req_t req, fuse_ino_t parent, const char *n=
ame)
> >  {
> >      int res;
> > +    struct lo_inode *inode;
> > +    struct lo_data *lo =3D lo_data(req);
> > =20
> >      if (!is_safe_path_component(name)) {
> >          fuse_reply_err(req, EINVAL);
> >          return;
> >      }
> > =20
> > +    inode =3D lookup_name(req, parent, name);
> > +    if (!inode) {
> > +        fuse_reply_err(req, EIO);
> > +        return;
> > +    }
> > +
> >      res =3D unlinkat(lo_fd(req, parent), name, 0);
> > =20
> >      fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> > +    unref_inode_lolocked(lo, inode, 1);
> >  }
> > =20
> >  static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *=
inode,
> > --=20
> > 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


