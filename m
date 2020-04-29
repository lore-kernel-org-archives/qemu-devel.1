Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD97AC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949CC2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mm15hp7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949CC2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlxP-0000TY-PM
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jTlwF-0007rS-0s
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jTlwC-0000eN-PD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:35:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jTlwB-0000Sc-18
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588163737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DL+VYVbUybI1LB57cWZQrAcmWHqr0Nm79SX0UhM9UQ0=;
 b=Mm15hp7wLhglm2Q0zpdru9EfkkZ2Y3jMEDDYixOexlKkg9/ST1fNEvsEOcOlqNiT2gBnnw
 CxH19vZZSwYIbhbVx+Zj8ww6hzJ1rOPz/G++46hgNP3wOiQeRl4L50TAw58nHvon1As8Pm
 FLf3zNDkkiUJ12fWQ035a+p/3d8+2B8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-zm75pJdIPMiBjvKvf7p5qA-1; Wed, 29 Apr 2020 08:34:30 -0400
X-MC-Unique: zm75pJdIPMiBjvKvf7p5qA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC15108BD16
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 12:34:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-168.rdu2.redhat.com [10.10.114.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95AC250FFB;
 Wed, 29 Apr 2020 12:34:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 0CBD9222EB9; Wed, 29 Apr 2020 08:34:24 -0400 (EDT)
Date: Wed, 29 Apr 2020 08:34:24 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
Message-ID: <20200429123424.GA231284@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
 <20200428191523.GU2794@work-vm>
 <CAOssrKcsVvMok6i+vAm1KJaq07Ep9JLcMiB1nWhsNU2n1m-Fmw@mail.gmail.com>
 <CAOssrKcZr4QXV1qLO7wmvdutkPKm59nSquPisEApBCWGx-c-uA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKcZr4QXV1qLO7wmvdutkPKm59nSquPisEApBCWGx-c-uA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 11:26:49AM +0200, Miklos Szeredi wrote:
> On Wed, Apr 29, 2020 at 9:59 AM Miklos Szeredi <mszeredi@redhat.com> wrot=
e:
> >
> > On Tue, Apr 28, 2020 at 9:15 PM Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> >
> > > So our current sequence is:
> > >
> > >    (new namespace)
> > >  1)    if (mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0) {
> > >  2)   if (mount("proc", "/proc", "proc",
> > >            ....
> > >  3)   if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> > >  4)  (chdir newroot, pivot, chdir oldroot)
> > >  5)   if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
> > >  6)   if (umount2(".", MNT_DETACH) < 0) {
> > >
> > > So are you saying we need a:
> > >        if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {
> > >
> > >   and can this go straight after (1) ?
> >
> > Or right before (3).   Important thing is that that new mount will
> > only receive propagation if the type of the mount at source (before
> > (3) is performed) is shared.
>=20
> And seems I was wrong.  Bind mounting clones the slave property, hence
> no need to set MS_SHARED.  I.e. if the source was a slave, the bind
> mount will be a slave to the same master as well; the two slaves won't
> receive propagation between each other, but both will receive
> propagation from the master.

Agreed. I was playing with it yesterday and noticed the same thing. Wanted
to test more before I said anything

Anyway, I did following.

$ mkdir /tmp/a /tmp/a/c /tmp/b
$ mount --bind /tmp/a /tmp/a

$ findmnt -o +PROPAGATION /tmp/a
TARGET SOURCE    FSTYPE OPTIONS                  PROPAGATION
/tmp/a tmpfs[/a] tmpfs  rw,nosuid,nodev,seclabel shared

$ cat /proc/self/mountifo | grep "/tmp/a"
613 49 0:45 /a /tmp/a rw,nosuid,nodev shared:30 - tmpfs tmpfs rw,seclabel

# Mountpoint /tmp/a is part of peer group "30"
# Create a new mount namespace with slave propagation

$ unshare -m --propagation slave bash

$ findmnt -o +PROPAGATION /tmp/a
TARGET SOURCE    FSTYPE OPTIONS                  PROPAGATION
/tmp/a tmpfs[/a] tmpfs  rw,nosuid,nodev,seclabel private,slave

$ cat /proc/self/mountinfo | grep /tmp/a
666 665 0:45 /a /tmp/a rw,nosuid,nodev master:30 - tmpfs tmpfs rw,seclabel

# /tmp/a in new mount namespace is slave of master "30"

# bind mount /tmp/a to /tmp/b and b should become slave of "30" too.
$ mount --bind /tmp/a /tmp/b

$findmnt -o +PROPAGATION /tmp/b
TARGET SOURCE    FSTYPE OPTIONS                  PROPAGATION
/tmp/b tmpfs[/a] tmpfs  rw,nosuid,nodev,seclabel private,slave

$ cat /proc/self/mountinfo | grep /tmp/b
671 665 0:45 /a /tmp/b rw,nosuid,nodev master:30 - tmpfs tmpfs rw,seclabel

# So /tmp/b is slave of "master:30" too. Say if host mounts something
# under /tmp/a (in init namespace), it should propagate to /tmp/a as
# well as /tmp/b in new mount namespace.

# Do following in init mount namespace
$ mount --bind /tmp/a/c /tmp/a/c

# Check in newly created mount namespace.
# findmnt
=E2=94=9C=E2=94=80/tmp                                tmpfs       tmpfs   r=
w,nosuid,nodev,seclab
=E2=94=82 =E2=94=9C=E2=94=80/tmp/a                            tmpfs[/a]   t=
mpfs   rw,nosuid,nodev,seclab
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80/tmp/a/c                        tmpfs=
[/a/c] tmpfs   rw,nosuid,nodev,seclab
=E2=94=82 =E2=94=9C=E2=94=80/tmp/b                            tmpfs[/a]   t=
mpfs   rw,nosuid,nodev,seclab
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80/tmp/b/c                        tmpfs=
[/a/c] tmpfs   rw,nosuid,nodev,seclab
=E2=94=82 =E2=94=94=E2=94=80/tmp/a/c                          tmpfs[/a/c] t=
mpfs   rw,nosuid,nodev,seclab

Mount of c has propagated into /tmp/b/c as well.

And that's what we want.

Thanks
Vivek


