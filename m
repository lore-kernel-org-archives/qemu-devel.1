Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C4C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CDB20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLB47DLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CDB20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipqze-00015A-Mn
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipqy7-0007pJ-NF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipqy5-00052l-OC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:52:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipqy5-0004yx-Hl
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578649956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UWPpEck3ZmDBtj2ZpZeyCti65+1QI3VhxHLYW9D4B0=;
 b=BLB47DLqVvKpqdKaYz110GmzNszmp716FCDtH0QDDEEo3rXtcBgbo/cvmsxUMkxKPQzdod
 umNhKnU7iBHeMi/nqycHPniGhoQbsVD7x9IakRI6MxXTOBgchT/QDLX+s63nAbMyWj+NhT
 3+LdkrhD1pHEP9FqXRxCpHvVh5NsPPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-9VsIyrhpM4C2c2MDyby0Mw-1; Fri, 10 Jan 2020 04:52:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96E5A1883536
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 09:52:34 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA6541001B03;
 Fri, 10 Jan 2020 09:52:30 +0000 (UTC)
Date: Fri, 10 Jan 2020 09:52:28 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 mszeredi@redhat.com
Subject: Re: [PATCH 066/104] virtiofsd: passthrough_ll: add renameat2 support
Message-ID: <20200110095228.GC3901@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-67-dgilbert@redhat.com>
 <20200107112143.GJ3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107112143.GJ3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 9VsIyrhpM4C2c2MDyby0Mw-1
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

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:26PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >=20
> > No glibc support yet, so use syscall().
>=20
> It exists in glibc in my Fedora 31 install.
>=20
> Presumably this is related to an older version
>=20
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 91d3120033..bed2270141 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -1083,7 +1083,17 @@ static void lo_rename(fuse_req_t req, fuse_ino_t=
 parent, const char *name,
> >      }
> > =20
> >      if (flags) {
> > +#ifndef SYS_renameat2
> >          fuse_reply_err(req, EINVAL);
> > +#else
> > +        res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
> > +                      lo_fd(req, newparent), newname, flags);
> > +        if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
> > +            fuse_reply_err(req, EINVAL);
> > +        } else {
> > +            fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
> > +        }
> > +#endif
>=20
> We should use the formal API if available as first choice

OK, done - I've kept the 'ifndef SYS_renameat2' that drops back to an
error for truly ancient cases; although I doubt everything else will
build on something that old.

Dave

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


