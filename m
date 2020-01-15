Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F96C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1372F2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9npnkLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1372F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irme5-0003Fg-1x
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irmd0-0001t6-4O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irmct-0005uz-UX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:38:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irmct-0005uf-QG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579109923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jszmmH8WGuDDFODptRiSB0KPf99etqHiQ38LP58KeqI=;
 b=D9npnkLg+UP8kKJxSgl5d35X759w5yp++9lI6c9LoiEVu3XYyFf2h7J18/OJYY367rAEjw
 xLwHJilnZLCXFjCanlX7je0qSmuJAt0QO9qk2MTXRPwGOIFF22lxe3euoEdKAOu2B982th
 Q1Ntt755v0UJeKth8Wv9tx9+mgmyLjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-0r1R_ac2MAuj__Fe8ENKVQ-1; Wed, 15 Jan 2020 12:38:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F0BFFAE4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 17:38:40 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CD83620D8;
 Wed, 15 Jan 2020 17:38:34 +0000 (UTC)
Date: Wed, 15 Jan 2020 17:38:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 054/104] virtiofsd: set maximum RLIMIT_NOFILE limit
Message-ID: <20200115173832.GF3811@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-55-dgilbert@redhat.com>
 <774ea513-c0ea-4dec-fcec-e867dec2f06f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <774ea513-c0ea-4dec-fcec-e867dec2f06f@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0r1R_ac2MAuj__Fe8ENKVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 12/12/19 5:38 PM, Dr. David Alan Gilbert (git) wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > virtiofsd can exceed the default open file descriptor limit easily on
> > most systems.  Take advantage of the fact that it runs as root to raise
> > the limit.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   tools/virtiofsd/passthrough_ll.c | 32 +++++++++++++++++++++++++++++++=
+
> >   1 file changed, 32 insertions(+)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index ab318a6f36..139bf08f4c 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -52,6 +52,7 @@
> >   #include <sys/file.h>
> >   #include <sys/mount.h>
> >   #include <sys/prctl.h>
> > +#include <sys/resource.h>
> >   #include <sys/syscall.h>
> >   #include <sys/types.h>
> >   #include <sys/wait.h>
> > @@ -2250,6 +2251,35 @@ static void setup_sandbox(struct lo_data *lo, st=
ruct fuse_session *se)
> >       setup_seccomp();
> >   }
> > +/* Raise the maximum number of open file descriptors */
> > +static void setup_nofile_rlimit(void)
> > +{
> > +    const rlim_t max_fds =3D 1000000;
>=20
> 'static const'?

Why?

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
Thanks!

> > +    struct rlimit rlim;
> > +
> > +    if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
> > +        fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
> > +        exit(1);
> > +    }
> > +
> > +    if (rlim.rlim_cur >=3D max_fds) {
> > +        return; /* nothing to do */
> > +    }
> > +
> > +    rlim.rlim_cur =3D max_fds;
> > +    rlim.rlim_max =3D max_fds;
> > +
> > +    if (setrlimit(RLIMIT_NOFILE, &rlim) < 0) {
> > +        /* Ignore SELinux denials */
> > +        if (errno =3D=3D EPERM) {
> > +            return;
> > +        }
> > +
> > +        fuse_log(FUSE_LOG_ERR, "setrlimit(RLIMIT_NOFILE): %m\n");
> > +        exit(1);
> > +    }
> > +}
> > +
> >   int main(int argc, char *argv[])
> >   {
> >       struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
> > @@ -2371,6 +2401,8 @@ int main(int argc, char *argv[])
> >       fuse_daemonize(opts.foreground);
> > +    setup_nofile_rlimit();
> > +
> >       /* Must be before sandbox since it wants /proc */
> >       setup_capng();
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


