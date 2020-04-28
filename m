Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C7C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B422070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jzogm7SK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B422070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVjF-00069w-FN
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTVhj-0004vc-W3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTVhi-0004ch-UQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:15:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTVhi-0004MQ-BV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588101336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w45CXWOTVbJws1/xzycA0jUV1Ro/d7ndQ2I11pBXodQ=;
 b=Jzogm7SK6ZOBq6wbCj0fJAxQGWzNfCoy0/0mrnJX3LcIWA7cMFZf8HZ8axpd0PB34+d9WT
 XuRbDC/QlsHxWdyla3V2VLHlnUtyiG6d2rcece1jq6hlsLVYNVRGYnHQM03ERVQEgp97CE
 WZD4ADOb2Q+sF3icGM9PCRGzZ0KUzNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-Ic-TEe9ZMDiy2HkU-OHXrQ-1; Tue, 28 Apr 2020 15:15:34 -0400
X-MC-Unique: Ic-TEe9ZMDiy2HkU-OHXrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 987F653
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 19:15:33 +0000 (UTC)
Received: from work-vm (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B767282CA;
 Tue, 28 Apr 2020 19:15:25 +0000 (UTC)
Date: Tue, 28 Apr 2020 20:15:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
Message-ID: <20200428191523.GU2794@work-vm>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Miklos Szeredi (mszeredi@redhat.com) wrote:
> On Tue, Apr 28, 2020 at 4:52 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Mon, Apr 27, 2020 at 06:59:02PM +0100, Dr. David Alan Gilbert wrote:
> > > * Max Reitz (mreitz@redhat.com) wrote:
> > > > Currently, setup_mounts() bind-mounts the shared directory without
> > > > MS_REC.  This makes all submounts disappear.
> > > >
> > > > Pass MS_REC so that the guest can see submounts again.
> > >
> > > Thanks!
> > >
> > > > Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
> > >
> > > Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
> > >
> > > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > > ---
> > > >  tools/virtiofsd/passthrough_ll.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/pas=
sthrough_ll.c
> > > > index 4c35c95b25..9d7f863e66 100644
> > > > --- a/tools/virtiofsd/passthrough_ll.c
> > > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > > @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
> > > >      int oldroot;
> > > >      int newroot;
> > > >
> > > > -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> > > > +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> > > >          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sou=
rce, source);
> > > >          exit(1);
> > > >      }
> > >
> > > Do we want MS_SLAVE to pick up future mounts that might happenf rom t=
he
> > > host?
> >
> > There are two separate concepts:
> >
> > 1. Mount namespaces.  The virtiofsd process is sandboxed and lives in
> >    its own mount namespace.  Therefore it does not share the mounts tha=
t
> >    the rest of the host system sees.
> >
> > 2. Propagation type.  This is related to bind mounts so that mount
> >    operations that happen in one bind-mounted location can also appear
> >    in other bind-mounted locations.
> >
> > Since virtiofsd is in a separate mount namespace, does the propagation
> > type even have any effect?
>=20
> It's a complicated thing.  Current setup results in propagation
> happening to the cloned namespace, but not to the bind mounted root.
>=20
> Why?  Because setting mounts "slave" after unshare, results in the
> propagation being stopped at that point.  To make it propagate
> further, change it back to "shared".  Note: the result changing to
> "slave" and then to "shared" results in breaking the backward
> propagation to the original namespace, but allowing propagation
> further down the chain.

Do you mean on the "/" ?

So our current sequence is:

   (new namespace)
 1)    if (mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0) {
 2)   if (mount("proc", "/proc", "proc",
           ....
 3)   if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
 4)  (chdir newroot, pivot, chdir oldroot)
 5)   if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
 6)   if (umount2(".", MNT_DETACH) < 0) {

So are you saying we need a:
       if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {

  and can this go straight after (1) ?

Dave

> Thanks,
> Miklos
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


