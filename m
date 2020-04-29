Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFAC83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043662085B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hE/1qmle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043662085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTj0V-0006gx-7H
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTizi-0005Vb-Gt
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTizi-0004ql-1J
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:27:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jTizh-0004qZ-Kq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588152423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgFcQ+SdEUEIQ0E6LSiXls7KMMBT4VUoZSxga9J06so=;
 b=hE/1qmleccF3j2mwXXpX3qaLhCtYL9MRl6sgz48Hm4jx6OuHxYH25VCF56Lz+dxtewzXNU
 ClkSAxwKaN8mVXkWwS318KSiXCB9s0h0Zcv/pMydZ33HSvqmoevJCCqWS0f/IIa0mHYAYR
 RCoIb+JjGIRpEetpt8N4OFxiGRB+4HU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-K_Eq6c0AOquwSR2LPPHaKw-1; Wed, 29 Apr 2020 05:27:02 -0400
X-MC-Unique: K_Eq6c0AOquwSR2LPPHaKw-1
Received: by mail-qk1-f199.google.com with SMTP id d15so1934769qkl.10
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rgFcQ+SdEUEIQ0E6LSiXls7KMMBT4VUoZSxga9J06so=;
 b=oeXqZ0gDK/fvf0WWdIphzTXopFQsSijfDrYc/Hn0N6fqhKhZmMo0XBdFjanN8NjuDk
 EjdC2ykIRNEOhA9pdGAwLckhHcIQzQ1kV/KShgr/EgblAhA5pZjO7OL9Oi0xErRCHXhm
 SNa9wg1pvF3EGNSgvpIZLO1GzXg2G0bDJvwCaIYK10072LYASKgo+F7WkzA7K5oAXgXQ
 ARpsl/adr2mVLLEzNwtN0IAQ0L2pAOSG5g0wl+neOalrHSfiGonKmBu0wtfpBSCV4HBd
 /5hXr3XIuvqrLwfGLhcXXWDD8V7KH1ZCmoQYTcRRG767Y1S4x7NPRqeDwZNZWnodlki4
 nMmg==
X-Gm-Message-State: AGi0PuaSDA9AYVtJgAYSvMXYek/syeR9NlGJHXovoYR4c3ZKKymlBAuI
 Mt+9XRBromG1ocPGkYT/FYD9KPoB4ogUkVgJ1OyjsBMpypU8Uc3bxdI1+KeKOgN1noz8hsECskY
 tTmWdhap89uQSNlctkf4LL6XnBO169u4=
X-Received: by 2002:a37:a102:: with SMTP id k2mr10990270qke.199.1588152421236; 
 Wed, 29 Apr 2020 02:27:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2Av0qC0C38eEYHZ/IbWoXVo9nP0JwgNm2hQ9Ew9hN3L0dPmE2fJvi+4Em9sC/avlQzlJff/Uvm3TP89ThE+s=
X-Received: by 2002:a37:a102:: with SMTP id k2mr10990249qke.199.1588152421001; 
 Wed, 29 Apr 2020 02:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
 <20200428191523.GU2794@work-vm>
 <CAOssrKcsVvMok6i+vAm1KJaq07Ep9JLcMiB1nWhsNU2n1m-Fmw@mail.gmail.com>
In-Reply-To: <CAOssrKcsVvMok6i+vAm1KJaq07Ep9JLcMiB1nWhsNU2n1m-Fmw@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 29 Apr 2020 11:26:49 +0200
Message-ID: <CAOssrKcZr4QXV1qLO7wmvdutkPKm59nSquPisEApBCWGx-c-uA@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mszeredi@redhat.com;
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 9:59 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Tue, Apr 28, 2020 at 9:15 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
>
> > So our current sequence is:
> >
> >    (new namespace)
> >  1)    if (mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0) {
> >  2)   if (mount("proc", "/proc", "proc",
> >            ....
> >  3)   if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> >  4)  (chdir newroot, pivot, chdir oldroot)
> >  5)   if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
> >  6)   if (umount2(".", MNT_DETACH) < 0) {
> >
> > So are you saying we need a:
> >        if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {
> >
> >   and can this go straight after (1) ?
>
> Or right before (3).   Important thing is that that new mount will
> only receive propagation if the type of the mount at source (before
> (3) is performed) is shared.

And seems I was wrong.  Bind mounting clones the slave property, hence
no need to set MS_SHARED.  I.e. if the source was a slave, the bind
mount will be a slave to the same master as well; the two slaves won't
receive propagation between each other, but both will receive
propagation from the master.

The only reason to set MS_SHARED would be if the bind mount wanted to
receive propagation from within the cloned namespace.   Which is not
the case.

Didn't I tell ya it was complicated ;)

Thanks,
Miklos


