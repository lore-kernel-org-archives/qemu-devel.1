Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E62C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB54B24676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/kwSNVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB54B24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJD3-0005OO-UY
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irJCF-0004y5-Nk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irJCB-0002ip-4B
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:13:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irJCA-0002hR-Fu
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578996789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjPAv+wZSf0ikoCuGvmNvWMxW1Bm+35vGHKO1uSbDB4=;
 b=D/kwSNVnDCThVHgRAr1+GUQ/CCLS9AjGTsEQtT20jTClAqp9pu+XIL7IuiN1c4OngBx9Ri
 4HQuclrhzBfMvj7oRvHoC5knsITl3mT7zxefXRa+HbVknQ51MFRi0qge0r8Mjme78+XVja
 Mu6VWEXIMUCWJ+N/sCtre+EXEsuu73U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-2z98DDhwM1ius3Jn97Pcuw-1; Tue, 14 Jan 2020 05:13:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B918810054E3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:13:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E331460BF1;
 Tue, 14 Jan 2020 10:13:00 +0000 (UTC)
Date: Tue, 14 Jan 2020 10:12:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 066/104] virtiofsd: passthrough_ll: add renameat2 support
Message-ID: <20200114101257.GD4071034@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-67-dgilbert@redhat.com>
 <20200107112143.GJ3368802@redhat.com>
 <20200110095228.GC3901@work-vm> <20200113200624.GB87499@work-vm>
 <20200114082949.GB4071034@redhat.com>
 <20200114100703.GC2812@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200114100703.GC2812@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2z98DDhwM1ius3Jn97Pcuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mszeredi@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 10:07:03AM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Mon, Jan 13, 2020 at 08:06:24PM +0000, Dr. David Alan Gilbert wrote:
> > > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > > On Thu, Dec 12, 2019 at 04:38:26PM +0000, Dr. David Alan Gilbert =
(git) wrote:
> > > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > > >=20
> > > > > > No glibc support yet, so use syscall().
> > > > >=20
> > > > > It exists in glibc in my Fedora 31 install.
> > > > >=20
> > > > > Presumably this is related to an older version
> > > > >=20
> > > > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > > > ---
> > > > > >  tools/virtiofsd/passthrough_ll.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > >=20
> > > > > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd=
/passthrough_ll.c
> > > > > > index 91d3120033..bed2270141 100644
> > > > > > --- a/tools/virtiofsd/passthrough_ll.c
> > > > > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > > > > @@ -1083,7 +1083,17 @@ static void lo_rename(fuse_req_t req, fu=
se_ino_t parent, const char *name,
> > > > > >      }
> > > > > > =20
> > > > > >      if (flags) {
> > > > > > +#ifndef SYS_renameat2
> > > > > >          fuse_reply_err(req, EINVAL);
> > > > > > +#else
> > > > > > +        res =3D syscall(SYS_renameat2, lo_fd(req, parent), nam=
e,
> > > > > > +                      lo_fd(req, newparent), newname, flags);
> > > > > > +        if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
> > > > > > +            fuse_reply_err(req, EINVAL);
> > > > > > +        } else {
> > > > > > +            fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> > > > > > +        }
> > > > > > +#endif
> > > > >=20
> > > > > We should use the formal API if available as first choice
> > > >=20
> > > > OK, done - I've kept the 'ifndef SYS_renameat2' that drops back to =
an
> > > > error for truly ancient cases; although I doubt everything else wil=
l
> > > > build on something that old.
> > >=20
> > > Hmm, and this breaks on middle age distros;  older distros don't have=
 it
> > > at all, new ones have both the syscall and the wrapper; but for the
> > > middle age ones they have the syscall but not the wrapper.
> > >
> > > Dan: What's your preference here; should I add a config fragment to
> > > detect the wrapper - it seems overkill rather than just reverting it
> > > until it becomes common.
> >=20
> > What specific middle age distro in particular is affected ? My general
> > thought would be to /not/ support such distros. Focus on modern distros
> > since this is a brand new feature in QEMU, where we should try to
> > minimize support for legacy stuff at the start. But depending on the
> > distro impacted, the might be a reason to stay with SYS_..
>=20
> The report came from Ubuntu 18.04 (which Intel uses on CI); that's not
> that old, so I think it sohuld be supported.   I don't really see the
> justification for insisting on using the wrapper.

Yeah, ok that's pretty new & will be around for a while yet.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


