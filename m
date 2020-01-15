Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41880C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB0C20728
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwUUTzM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB0C20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irjm5-0008Hg-6H
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 09:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irjlL-0007nm-Q7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irjlH-0004qZ-Ch
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:35:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irjlH-0004pR-5O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579098909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUubML/dmF/piM8jSqKpQdKRe0+RBULdiSUo1yPP+f8=;
 b=VwUUTzM+8uF9EJTim660dOWCt1jlemDHdSdSiLu2CA1NS2zz0qoHG7gPldrwyIkQGK1/ts
 Fm8Dxw0srxnKui5R8Y3GQcifkidjTX3vyEXhDcA4IB1US47Sh7noBDceHhZGGZdeziH+AG
 6LJ26FXea6ejaFhqvcoQhpCOdN+BtFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-x5IXJUQqNVSEKOJJQpdtpQ-1; Wed, 15 Jan 2020 09:35:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 558C48C4A6A;
 Wed, 15 Jan 2020 14:35:05 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05A6B842AB;
 Wed, 15 Jan 2020 14:34:58 +0000 (UTC)
Date: Wed, 15 Jan 2020 14:34:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH 051/104] virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
Message-ID: <20200115143456.GD3811@work-vm>
References: <20191212163904.159893-52-dgilbert@redhat.com>
 <20200115120603.3191-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200115120603.3191-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: x5IXJUQqNVSEKOJJQpdtpQ-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: Vivek Goyal <vgoyal@redhat.com>
> >=20
> > Caller can set FUSE_WRITE_KILL_PRIV in write_flags. Parse it and pass i=
t
> > to the filesystem.
> >=20
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_common.h   | 6 +++++-
> >  tools/virtiofsd/fuse_lowlevel.c | 4 +++-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_commo=
n.h
> > index 147c043bd9..1e8191b7a6 100644
> > --- a/tools/virtiofsd/fuse_common.h
> > +++ b/tools/virtiofsd/fuse_common.h
> > @@ -93,8 +93,12 @@ struct fuse_file_info {
> >       */
> >      unsigned int cache_readdir:1;
> > =20
> > +    /* Indicates that suid/sgid bits should be removed upon write */
> > +    unsigned int kill_priv:1;
> > +
> > +
> >      /** Padding.  Reserved for future use*/
> > -    unsigned int padding:25;
> > +    unsigned int padding:24;
> >      unsigned int padding2:32;
> > =20
> >      /*
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index bd5ca2f157..c8a3b1597a 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -1144,6 +1144,7 @@ static void do_write(fuse_req_t req, fuse_ino_t n=
odeid,
> >      memset(&fi, 0, sizeof(fi));
> >      fi.fh =3D arg->fh;
> >      fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
> > +    fi.kill_priv =3D !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
> > =20
> >      fi.lock_owner =3D arg->lock_owner;
> >      fi.flags =3D arg->flags;
> > @@ -1179,7 +1180,8 @@ static void do_write_buf(fuse_req_t req, fuse_ino=
_t nodeid,
> >      fi.lock_owner =3D arg->lock_owner;
> >      fi.flags =3D arg->flags;
> >      fi.fh =3D arg->fh;
> > -    fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
> > +    fi.writepage =3D !!(arg->write_flags & FUSE_WRITE_CACHE);
> > +    fi.kill_priv =3D !!(arg->write_flags & FUSE_WRITE_KILL_PRIV);
> > =20
> >      if (ibufv->count =3D=3D 1) {
> >          assert(!(tmpbufv.buf[0].flags & FUSE_BUF_IS_FD));
> > --=20
> > 2.23.0
>=20
> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Thank you.

> side-note: virtiofs uses write_buf() and therefore do_write() is never ca=
lled.
> How about cleanup the function?

Yes I think you're right; I need to go through and check there's no
corner case which can get into the plain do_write.

Dave

>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


