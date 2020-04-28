Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F48FC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5852E206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPdVa3YQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5852E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRhp-00032A-Ds
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTRgu-0001p5-Th
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTRgt-0005Is-EL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:58:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29124
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTRgs-0005Ik-RK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588085909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f5oekzb/cpxr4kyQF3ubQavvanfiue50uBnql4okS8=;
 b=QPdVa3YQ7uXtEiOJR0dGI1DUKD2j9uPZ9FuX5KiXrrLKmRhvP9qVjnnXr24p64y7SNg6aJ
 iIirK/8cCleGYFPG+J2JMrqWy1YvYscotOJVXrFZOgR2FfWuFnpLP/dPvNv4C9tsO2nBeY
 s0oC1LJ72XwmInZq2xWGNoKSDvq5/AI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-yqHBbrGRNYCHQQwqgxG8_Q-1; Tue, 28 Apr 2020 10:58:21 -0400
X-MC-Unique: yqHBbrGRNYCHQQwqgxG8_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEA231895A29
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 14:58:20 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E7F05C220;
 Tue, 28 Apr 2020 14:58:07 +0000 (UTC)
Date: Tue, 28 Apr 2020 15:58:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200428145804.GC1374620@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200428145143.GB107541@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: virtio-fs@redhat.com, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 03:51:43PM +0100, Stefan Hajnoczi wrote:
> On Mon, Apr 27, 2020 at 06:59:02PM +0100, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> > > Currently, setup_mounts() bind-mounts the shared directory without
> > > MS_REC.  This makes all submounts disappear.
> > >=20
> > > Pass MS_REC so that the guest can see submounts again.
> >=20
> > Thanks!
> >=20
> > > Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
> >=20
> > Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
> >=20
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tools/virtiofsd/passthrough_ll.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
> > > index 4c35c95b25..9d7f863e66 100644
> > > --- a/tools/virtiofsd/passthrough_ll.c
> > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
> > >      int oldroot;
> > >      int newroot;
> > > =20
> > > -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> > > +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> > >          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sourc=
e, source);
> > >          exit(1);
> > >      }
> >=20
> > Do we want MS_SLAVE to pick up future mounts that might happenf rom the
> > host?
>=20
> There are two separate concepts:
>=20
> 1. Mount namespaces.  The virtiofsd process is sandboxed and lives in
>    its own mount namespace.  Therefore it does not share the mounts that
>    the rest of the host system sees.
>=20
> 2. Propagation type.  This is related to bind mounts so that mount
>    operations that happen in one bind-mounted location can also appear
>    in other bind-mounted locations.
>=20
> Since virtiofsd is in a separate mount namespace, does the propagation
> type even have any effect?

Yes, propagation should work across mount namespaces if you get the mount
flags right.  You can try it out using  unshare + mount commands
to debug different scenarios.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


