Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBCEC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C832F206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvWoasIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C832F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVes-0001tV-MZ
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTVc2-0000eJ-8T
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTVbC-00016y-Bq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:09:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jTVbB-00016n-SK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588100932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WFtAH0PVrJkzatNRof21ewdSAVhY2/9ROXai+QnpcA=;
 b=QvWoasIsi7bv3dRsqXYKyNpz9ODEB5KD6J7stuZGmsqLFuF0+kJ5Ic7gp+tRcVxgrqglZC
 EodFv9OHW4CWMUWMwWhKL0n1uS8jAN2R6vqwWy/Tl0RscNG7efkFmMcgGCbXmD5qSbY+KC
 CtMBJDlyardFqHox5G5Zcd0kELFj1/8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-o7N-7SqGP-2oPakywCM3Eg-1; Tue, 28 Apr 2020 15:07:38 -0400
X-MC-Unique: o7N-7SqGP-2oPakywCM3Eg-1
Received: by mail-qk1-f197.google.com with SMTP id i2so24471397qkl.5
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uu1GG4Tsyvb94SYiL59L5/m97A0MYcLQViHtstMRThM=;
 b=EHmo59TmIGtXkDK5ql4iL0G0H5unUiBjVVv5n1YFVPqpmyUkaXVUXJRs1cyGvch6h+
 PqfuTvlEzsnEUKkOVDKwsI9/JFNqe1kbBh7e1AYL6X+mobqVCA12mhNDnKdDiyFgaR+K
 HwzDPlDPS20qk9jEuplc1Hc7zjCM0KMGs3Fro52tunaQQUf8AHsIaNvEX/gb6+oKeD+o
 Rqa59N5lXlRGEnjc2RmIRaug1R5xm28uc5ZlM6JQLIdklMjTN1lepOnYfudi8kZdMMRr
 LFhzn8c+ByJr9Z06FWDutWIZGA6INriDyzkfHTVFPOshlD4jOP/ujC8XcI9KFLuyWM9Q
 s3Mw==
X-Gm-Message-State: AGi0PuayPWz/p/jz3VIYg9LpFtabL2Kj3XuvIyfbK2tL56+cUnBVCAg2
 Zbv9HO98QvksZwHCIDziwIq1NWdiJYUypQMdhNWauSmtBkWHx6kqI8VR9o7JpUFdSI9B4fpsmNd
 dASQxdM2LixMvbJ6aONTcftEu0as99+A=
X-Received: by 2002:ac8:12c2:: with SMTP id b2mr30061110qtj.7.1588100857729;
 Tue, 28 Apr 2020 12:07:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHAwspJ7ShlkxJ9+1GMKTfwbGe0/JNsKbXUylQhRbtwX4N9x23flPqW8X1N++h/5pE0rkt3a4zqYTHJmVz2kE=
X-Received: by 2002:ac8:12c2:: with SMTP id b2mr30061082qtj.7.1588100857431;
 Tue, 28 Apr 2020 12:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
In-Reply-To: <20200428145143.GB107541@stefanha-x1.localdomain>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 28 Apr 2020 21:07:25 +0200
Message-ID: <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mszeredi@redhat.com;
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 4:52 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> On Mon, Apr 27, 2020 at 06:59:02PM +0100, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> > > Currently, setup_mounts() bind-mounts the shared directory without
> > > MS_REC.  This makes all submounts disappear.
> > >
> > > Pass MS_REC so that the guest can see submounts again.
> >
> > Thanks!
> >
> > > Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
> >
> > Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
> >
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tools/virtiofsd/passthrough_ll.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
> > > index 4c35c95b25..9d7f863e66 100644
> > > --- a/tools/virtiofsd/passthrough_ll.c
> > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
> > >      int oldroot;
> > >      int newroot;
> > >
> > > -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> > > +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> > >          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sourc=
e, source);
> > >          exit(1);
> > >      }
> >
> > Do we want MS_SLAVE to pick up future mounts that might happenf rom the
> > host?
>
> There are two separate concepts:
>
> 1. Mount namespaces.  The virtiofsd process is sandboxed and lives in
>    its own mount namespace.  Therefore it does not share the mounts that
>    the rest of the host system sees.
>
> 2. Propagation type.  This is related to bind mounts so that mount
>    operations that happen in one bind-mounted location can also appear
>    in other bind-mounted locations.
>
> Since virtiofsd is in a separate mount namespace, does the propagation
> type even have any effect?

It's a complicated thing.  Current setup results in propagation
happening to the cloned namespace, but not to the bind mounted root.

Why?  Because setting mounts "slave" after unshare, results in the
propagation being stopped at that point.  To make it propagate
further, change it back to "shared".  Note: the result changing to
"slave" and then to "shared" results in breaking the backward
propagation to the original namespace, but allowing propagation
further down the chain.

Thanks,
Miklos


