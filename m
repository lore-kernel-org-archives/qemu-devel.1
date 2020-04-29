Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F9C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DC6206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POtbjOF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DC6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jToAS-0001iU-LP
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTo9V-000129-GH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTo9U-0006uM-V6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:57:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28697
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTo9U-0006u4-Gi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588172251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZswhJ/wiiKsOvTd0MExAb3VdGk9/QVTGcCvRjWARzU=;
 b=POtbjOF/9MV8MO1QCq+6lKyAcxO08QeE3D4qawLHhpYYCgLP+xW3VvRJMH5qNBCNLZM/Fp
 GpJB0d+v4m9vomiNwZxKIx1QMIAd+qwZH0v5kEfWIEmdB1dbkW5DN2CH0NS75yhwU2dfrO
 UwRwzCaWdqRe0i9rVcF8Bs79fDMhDZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-wQMrNZxaNYqEoAA52xe2gQ-1; Wed, 29 Apr 2020 10:57:30 -0400
X-MC-Unique: wQMrNZxaNYqEoAA52xe2gQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8B11895917
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 14:57:29 +0000 (UTC)
Received: from work-vm (ovpn-114-192.ams2.redhat.com [10.36.114.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B65565D781;
 Wed, 29 Apr 2020 14:57:22 +0000 (UTC)
Date: Wed, 29 Apr 2020 15:57:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>, vgoyal@redhat.com
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200429145720.GA2835@work-vm>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200427175902.GM2923@work-vm>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
> > Currently, setup_mounts() bind-mounts the shared directory without
> > MS_REC.  This makes all submounts disappear.
> >=20
> > Pass MS_REC so that the guest can see submounts again.
>=20
> Thanks!
>=20
> > Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
>=20
> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
>=20
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 4c35c95b25..9d7f863e66 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
> >      int oldroot;
> >      int newroot;
> > =20
> > -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> > +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> >          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source,=
 source);
> >          exit(1);
> >      }
>=20
> Do we want MS_SLAVE to pick up future mounts that might happenf rom the
> host?
> What's the interaction between this and the MS_REC|MS_SLAVE that we have
> a few lines above for / ?

Just to confirm something from vgoyal, and what had confused me about
why we hadn't spotted this earlier.

Even without this patch, the SLAVE stuff worked so if you start the
daemon and *then* mount under the shared directory, the guest sees it
with or without this patch.

However, without this patch you don't see a mount that was already there
before you start the daemon.

Dave

> Dave
>=20
> > --=20
> > 2.25.3
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


