Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4862FC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB1A2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkqGDYt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB1A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir5zh-00012u-19
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 15:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ir5yt-0000EF-Oy
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ir5ys-0002OJ-IA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:06:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ir5ys-0002No-EN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578945993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0PaQ+hTGrXzl55joErWIQzAPN0s0UDX+KfRigOtj9o=;
 b=SkqGDYt0+QZzusbx5nAPRAR7nEej5TtUT6UTenKHslZtuCWcOpKGfXRTJeQXCNvmLhbpW2
 BMyHuKp/iC9sftmp4GIiGJDOm5CrP37WSMXx36YKYL65rSgyI+bY8wVczw/AS7rzi0pEtR
 Fr+2Fdd+mfy4b8a2iseBAJi2e4SF/hQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-823whArRPCO8kS3cSrhIQg-1; Mon, 13 Jan 2020 15:06:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F518024FB
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 20:06:30 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D676782478;
 Mon, 13 Jan 2020 20:06:26 +0000 (UTC)
Date: Mon, 13 Jan 2020 20:06:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 mszeredi@redhat.com
Subject: Re: [PATCH 066/104] virtiofsd: passthrough_ll: add renameat2 support
Message-ID: <20200113200624.GB87499@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-67-dgilbert@redhat.com>
 <20200107112143.GJ3368802@redhat.com>
 <20200110095228.GC3901@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200110095228.GC3901@work-vm>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 823whArRPCO8kS3cSrhIQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > On Thu, Dec 12, 2019 at 04:38:26PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > From: Miklos Szeredi <mszeredi@redhat.com>
> > >=20
> > > No glibc support yet, so use syscall().
> >=20
> > It exists in glibc in my Fedora 31 install.
> >=20
> > Presumably this is related to an older version
> >=20
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  tools/virtiofsd/passthrough_ll.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
> > > index 91d3120033..bed2270141 100644
> > > --- a/tools/virtiofsd/passthrough_ll.c
> > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > @@ -1083,7 +1083,17 @@ static void lo_rename(fuse_req_t req, fuse_ino=
_t parent, const char *name,
> > >      }
> > > =20
> > >      if (flags) {
> > > +#ifndef SYS_renameat2
> > >          fuse_reply_err(req, EINVAL);
> > > +#else
> > > +        res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
> > > +                      lo_fd(req, newparent), newname, flags);
> > > +        if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
> > > +            fuse_reply_err(req, EINVAL);
> > > +        } else {
> > > +            fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> > > +        }
> > > +#endif
> >=20
> > We should use the formal API if available as first choice
>=20
> OK, done - I've kept the 'ifndef SYS_renameat2' that drops back to an
> error for truly ancient cases; although I doubt everything else will
> build on something that old.

Hmm, and this breaks on middle age distros;  older distros don't have it
at all, new ones have both the syscall and the wrapper; but for the
middle age ones they have the syscall but not the wrapper.

Dan: What's your preference here; should I add a config fragment to
detect the wrapper - it seems overkill rather than just reverting it
until it becomes common.

Dave

> Dave
>=20
> >=20
> > Regards,
> > Daniel
> > --=20
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


