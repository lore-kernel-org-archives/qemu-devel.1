Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CBC83007
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A55206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRk+X0CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A55206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTM1A-00068q-CU
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTLvI-0001PI-Jk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTLtg-0003H1-0g
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:48:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTLtf-0003Fb-E6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588063638;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdtSg4sFElGKRHB93bsvKygAyZunxV2v1pnxI4HTBJU=;
 b=SRk+X0CLj5NdufiNWN/VKd1DlD0+JWtJQLkxYXkhhU94gV/yqhMy740qyYxbHulnR1w9EW
 9maahhupH8TawnF565i2GS5ZWlS6+M1ZkSzVjkJ9D2oFFVZ1xel3X6gafe5qL1nFhNOM/X
 9/GS8e8cBJgGLkxIzQhF58AImwZR+N4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Gs5ZvrnTMBq6VXyprtVkYw-1; Tue, 28 Apr 2020 04:47:10 -0400
X-MC-Unique: Gs5ZvrnTMBq6VXyprtVkYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF628AB3AB
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 08:47:09 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D81F5D9E2;
 Tue, 28 Apr 2020 08:47:02 +0000 (UTC)
Date: Tue, 28 Apr 2020 09:46:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200428084658.GA1374620@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200427175902.GM2923@work-vm>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 06:59:02PM +0100, Dr. David Alan Gilbert wrote:
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

I think that probably makes sense to have MS_SLAVE by default, as that
means the set of files exposed to the guest is consistent across a QEMU
restart. Without MS_SLAVE new mounts aren't visible until after QEMU
is restarted which is likely surprising/undesirable to admins.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


