Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A87C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718092085B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WELeYbT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718092085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTm5D-00089r-IX
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jTm4L-0007QT-2d
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jTm4J-0003bK-JV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:44:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jTm4I-0003LI-UO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588164241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0y3+NL/UAPHYWlFqtNifANPUqq5VsbO46n9visYoirE=;
 b=WELeYbT0VSTv4D0+2MEViklEOIRCbvsJpeJo3xM3QQrPQLYPV6Sck0TEOhZste+Bpq/Gtq
 FLt8rPeOG0hNILfWkbstNm0gjAEM5EAOzkB6L4dukepKizDE2wxFt+aLFaeYKsO/dTWIl0
 IkpXkJccXf6S1QXrD9/qcv32htsCYx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-wvSBhUv9PcSrpZjU3TU4hQ-1; Wed, 29 Apr 2020 08:41:38 -0400
X-MC-Unique: wvSBhUv9PcSrpZjU3TU4hQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CE0B805726
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 12:41:30 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-168.rdu2.redhat.com [10.10.114.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01C1028544;
 Wed, 29 Apr 2020 12:41:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 5FB14222EB9; Wed, 29 Apr 2020 08:41:29 -0400 (EDT)
Date: Wed, 29 Apr 2020 08:41:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
Message-ID: <20200429124129.GB231284@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
 <20200428191523.GU2794@work-vm>
 <CAOssrKcsVvMok6i+vAm1KJaq07Ep9JLcMiB1nWhsNU2n1m-Fmw@mail.gmail.com>
 <CAOssrKcZr4QXV1qLO7wmvdutkPKm59nSquPisEApBCWGx-c-uA@mail.gmail.com>
 <20200429123424.GA231284@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200429123424.GA231284@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
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

On Wed, Apr 29, 2020 at 08:34:24AM -0400, Vivek Goyal wrote:
> On Wed, Apr 29, 2020 at 11:26:49AM +0200, Miklos Szeredi wrote:
> > On Wed, Apr 29, 2020 at 9:59 AM Miklos Szeredi <mszeredi@redhat.com> wr=
ote:
> > >
> > > On Tue, Apr 28, 2020 at 9:15 PM Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > >
> > > > So our current sequence is:
> > > >
> > > >    (new namespace)
> > > >  1)    if (mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0) {
> > > >  2)   if (mount("proc", "/proc", "proc",
> > > >            ....
> > > >  3)   if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) =
{
> > > >  4)  (chdir newroot, pivot, chdir oldroot)
> > > >  5)   if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
> > > >  6)   if (umount2(".", MNT_DETACH) < 0) {
> > > >
> > > > So are you saying we need a:
> > > >        if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {
> > > >
> > > >   and can this go straight after (1) ?
> > >
> > > Or right before (3).   Important thing is that that new mount will
> > > only receive propagation if the type of the mount at source (before
> > > (3) is performed) is shared.
> >=20
> > And seems I was wrong.  Bind mounting clones the slave property, hence
> > no need to set MS_SHARED.  I.e. if the source was a slave, the bind
> > mount will be a slave to the same master as well; the two slaves won't
> > receive propagation between each other, but both will receive
> > propagation from the master.
>=20
> Agreed. I was playing with it yesterday and noticed the same thing. Wante=
d
> to test more before I said anything
>=20
> Anyway, I did following.
>=20
> $ mkdir /tmp/a /tmp/a/c /tmp/b
> $ mount --bind /tmp/a /tmp/a
>=20
> $ findmnt -o +PROPAGATION /tmp/a
> TARGET SOURCE    FSTYPE OPTIONS                  PROPAGATION
> /tmp/a tmpfs[/a] tmpfs  rw,nosuid,nodev,seclabel shared

A note, this is "shared" by default becase parent mount ("/") is "shared"
by default due to systemd settings. Some distributions make "/" private
instead and in that case, new mount namespace will not be "slave" and
will not receive propagation events.

In that case we will have to document to bind mount source directory
with "shared" propagation so that mounts done later on host can=20
propagate into virtiofsd namespace.

Thanks
Vivek


