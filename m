Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F5AC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3426021835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOcYSjzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3426021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inO5j-0000NU-AH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 09:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inO53-0008Ow-93
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inO50-0007Ur-JK
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:37:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56342
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inO50-0007Dd-2w
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578062251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PceL88x42foHbtQHJap7oG1GS72PFKjurWfC7XDT8zo=;
 b=TOcYSjzMMnIb5o3C1RWPOeA4+RaLCIx8R44jVbpUumsLdvnBq924h1ZkMI23FaytcmXrSc
 YrY1NuhawwdqYgue88yxk459Vf5gU2LY2t8Jq0a5m7WPlz9Xqri+xXHav2p+2S+cEwwQ/p
 mFBoyPucjYmnvPwDw0Zfy5ftsXNDXBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-5DcMdDihO1ynQUztIECHUg-1; Fri, 03 Jan 2020 09:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AC508024CC
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 14:37:28 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BECC27BA28;
 Fri,  3 Jan 2020 14:37:24 +0000 (UTC)
Date: Fri, 3 Jan 2020 14:37:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 005/104] virtiofsd: Add passthrough_ll
Message-ID: <20200103143722.GH3804@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-6-dgilbert@redhat.com>
 <20200103120109.GK2753983@redhat.com>
 <20200103121535.GE3804@work-vm>
 <20200103123303.GS2753983@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200103123303.GS2753983@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5DcMdDihO1ynQUztIECHUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Jan 03, 2020 at 12:15:35PM +0000, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Thu, Dec 12, 2019 at 04:37:25PM +0000, Dr. David Alan Gilbert (git=
) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >=20
> > > > passthrough_ll is one of the examples in the upstream fuse project
> > > > and is the main part of our daemon here.  It passes through request=
s
> > > > from fuse to the underlying filesystem, using syscalls as directly
> > > > as possible.
> > > >=20
> > > > From libfuse fuse-3.8.0
> > > >=20
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > >  tools/virtiofsd/passthrough_ll.c | 1338 ++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 1338 insertions(+)
> > > >  create mode 100644 tools/virtiofsd/passthrough_ll.c
> > > >=20
> > > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/pas=
sthrough_ll.c
> > > > new file mode 100644
> > > > index 0000000000..5372d02934
> > > > --- /dev/null
> > > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > > @@ -0,0 +1,1338 @@
> > > > +/*
> > > > +  FUSE: Filesystem in Userspace
> > > > +  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> > > > +
> > > > +  This program can be distributed under the terms of the GNU GPL.
> > >=20
> > > I presume this mistake exists in upstream fuse GIT - missing GPL vers=
ion
> > > number info here.
> >=20
> > Yes it is, see:
> > https://github.com/libfuse/libfuse/blob/d735af94fa54a5555ce725f1d4e6b97=
b812b6603/example/passthrough_ll.c
> >=20
> > And at the time that was added their COPYING file was GPL v2.
> >=20
> > although they've since renamed COPYING to GPL2.txt but not updated
> > the comments; but they added a LICENSE file.
> > https://github.com/libfuse/libfuse/commit/e8bcd8461ce7dfdc7366f44bad8d8=
55696e73c3b
> >=20
> > > This is important to correct since we're moving code
> > > from another repo and thus the COPYING file it is referring to on the
> > > next line is ambiguous to the casual reader.
> > >=20
> > > > +  See the file COPYING.
> > > > +*/
> > >=20
> > > With the GPL version info added:
> >=20
> > So just change 'GNU GPL' to 'GNU GPL version 2' during the import?
>=20
> Yes, or just  "GPLv2" is fine too. Ideally submit a patch to libfuse
> upstream & then just copy the result.

libfuse pull request created:
  https://github.com/libfuse/libfuse/pull/485

> >=20
> > >   Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> >=20
>=20
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


