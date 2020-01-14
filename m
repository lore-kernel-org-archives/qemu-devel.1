Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F32C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D8C24681
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYTu6lmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D8C24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ72-0008W9-My
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irJ6Q-0007yR-Jx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irJ6P-00011f-7p
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:07:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46909
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irJ6P-00011V-3C
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578996432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stfsFp75i47VJlVqquXOjIbx9Xx8xj92dO692LzjoVE=;
 b=OYTu6lmWq7BXkljrhDLP28vLmB/8acWMlX891LqHPZ3PLYdPprCRjZO0bMFleOsAT4nhk0
 76ikN24MC72Cw0P1HqsZ02GYtWYvh46epx2zqOVf6keIlRy2GRS30X0SkirLkx6o2U3hw8
 GWp2mdA8tT9XL0mL10isBTmo/8SyYFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Vk5_zMxPN1OnpwE8SNlYbg-1; Tue, 14 Jan 2020 05:07:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5B2A18C8C2C
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:07:09 +0000 (UTC)
Received: from work-vm (ovpn-117-209.ams2.redhat.com [10.36.117.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 071485DA70;
 Tue, 14 Jan 2020 10:07:05 +0000 (UTC)
Date: Tue, 14 Jan 2020 10:07:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 066/104] virtiofsd: passthrough_ll: add renameat2 support
Message-ID: <20200114100703.GC2812@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-67-dgilbert@redhat.com>
 <20200107112143.GJ3368802@redhat.com>
 <20200110095228.GC3901@work-vm> <20200113200624.GB87499@work-vm>
 <20200114082949.GB4071034@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114082949.GB4071034@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Vk5_zMxPN1OnpwE8SNlYbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: mszeredi@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Jan 13, 2020 at 08:06:24PM +0000, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > > On Thu, Dec 12, 2019 at 04:38:26PM +0000, Dr. David Alan Gilbert (g=
it) wrote:
> > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > >=20
> > > > > No glibc support yet, so use syscall().
> > > >=20
> > > > It exists in glibc in my Fedora 31 install.
> > > >=20
> > > > Presumably this is related to an older version
> > > >=20
> > > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > > ---
> > > > >  tools/virtiofsd/passthrough_ll.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >=20
> > > > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/p=
assthrough_ll.c
> > > > > index 91d3120033..bed2270141 100644
> > > > > --- a/tools/virtiofsd/passthrough_ll.c
> > > > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > > > @@ -1083,7 +1083,17 @@ static void lo_rename(fuse_req_t req, fuse=
_ino_t parent, const char *name,
> > > > >      }
> > > > > =20
> > > > >      if (flags) {
> > > > > +#ifndef SYS_renameat2
> > > > >          fuse_reply_err(req, EINVAL);
> > > > > +#else
> > > > > +        res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
> > > > > +                      lo_fd(req, newparent), newname, flags);
> > > > > +        if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
> > > > > +            fuse_reply_err(req, EINVAL);
> > > > > +        } else {
> > > > > +            fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> > > > > +        }
> > > > > +#endif
> > > >=20
> > > > We should use the formal API if available as first choice
> > >=20
> > > OK, done - I've kept the 'ifndef SYS_renameat2' that drops back to an
> > > error for truly ancient cases; although I doubt everything else will
> > > build on something that old.
> >=20
> > Hmm, and this breaks on middle age distros;  older distros don't have i=
t
> > at all, new ones have both the syscall and the wrapper; but for the
> > middle age ones they have the syscall but not the wrapper.
> >
> > Dan: What's your preference here; should I add a config fragment to
> > detect the wrapper - it seems overkill rather than just reverting it
> > until it becomes common.
>=20
> What specific middle age distro in particular is affected ? My general
> thought would be to /not/ support such distros. Focus on modern distros
> since this is a brand new feature in QEMU, where we should try to
> minimize support for legacy stuff at the start. But depending on the
> distro impacted, the might be a reason to stay with SYS_..

The report came from Ubuntu 18.04 (which Intel uses on CI); that's not
that old, so I think it sohuld be supported.   I don't really see the
justification for insisting on using the wrapper.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


