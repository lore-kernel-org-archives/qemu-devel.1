Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9583C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D312075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHWc2zIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D312075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7S6-0003qS-24
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1is7RC-0002h5-M5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1is7RB-0008Ay-EX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:52:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1is7RB-0008AW-Av
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579189920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7JlB+UfT5e+c+hdD6cdCnc5uml/7jF7vQTJkfPCWWM=;
 b=dHWc2zIJxeQUkpXOHXESIM+q3/0gWUu04AbYuNpGNui2oUBEl0tmf9f/cb5ZWpcI9+dyYx
 TNWOuni8A6Fxh+ha9qfX1pGwa+YDz7LhBLAavX9uV/rP9aGyrol+SHohrp8Pa/MU5jA8yB
 Za9fmIr2VCjdoESIU/I5yrSKSSZoRKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-2V8ysW0SMxmWB7_V2ezE7g-1; Thu, 16 Jan 2020 10:51:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4C62DB21;
 Thu, 16 Jan 2020 15:51:57 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 501F76609E;
 Thu, 16 Jan 2020 15:51:54 +0000 (UTC)
Date: Thu, 16 Jan 2020 15:51:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH 071/104] virtiofsd: extract root inode init into
 setup_root()
Message-ID: <20200116155151.GH3108@work-vm>
References: <20191212163904.159893-72-dgilbert@redhat.com>
 <20200116072037.28976-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200116072037.28976-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 2V8ysW0SMxmWB7_V2ezE7g-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >=20
> > Inititialize the root inode in a single place.
> >=20
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index ef8b88e3d1..0f33c3c5e9 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -2336,6 +2336,29 @@ static void log_func(enum fuse_log_level level, =
const char *_fmt, va_list ap)
> >      }
> >  }
> > =20
> > +static void setup_root(struct lo_data *lo, struct lo_inode *root)
> > +{
> > +    int fd, res;
> > +    struct stat stat;
> > +
> > +    fd =3D open("/", O_PATH);
> > +    if (fd =3D=3D -1) {
> > +        fuse_log(FUSE_LOG_ERR, "open(%s, O_PATH): %m\n", lo->source);
> > +        exit(1);
> > +    }
> > +
> > +    res =3D fstatat(fd, "", &stat, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW=
);
> > +    if (res =3D=3D -1) {
> > +        fuse_log(FUSE_LOG_ERR, "fstatat(%s): %m\n", lo->source);
> > +        exit(1);
> > +    }
> > +
> > +    root->fd =3D fd;
> > +    root->ino =3D stat.st_ino;
> > +    root->dev =3D stat.st_dev;
> > +    root->refcount =3D 2;
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >      struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
> > @@ -2411,8 +2434,6 @@ int main(int argc, char *argv[])
> >      if (lo.debug) {
> >          current_log_level =3D FUSE_LOG_DEBUG;
> >      }
> > -    lo.root.refcount =3D 2;
> > -
> >      if (lo.source) {
> >          struct stat stat;
> >          int res;
> > @@ -2480,6 +2501,7 @@ int main(int argc, char *argv[])
> > =20
> >      setup_sandbox(&lo, se, opts.syslog);
> > =20
> > +    setup_root(&lo, &lo.root);
> >      /* Block until ctrl+c or fusermount -u */
> >      ret =3D virtio_loop(se);
>=20
> Following block still remains in main():
> 2933    lo.root.is_symlink =3D false;
> ...
> 2952    lo.root.fd =3D open(lo.source, O_PATH);
> 2953
> 2954    if (lo.root.fd =3D=3D -1) {
> 2955        fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n", lo.sourc=
e);
> 2956        exit(1);
> 2957    }
>=20
> L.2933 should be included in lo_setup_root() and can we just remove L.295=
2-2957?

Yes agreed; thanks I've fixed that up.

Dave

> Thanks,
> Misono
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


