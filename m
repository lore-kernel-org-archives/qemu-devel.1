Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0645C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A30CC20673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElWYwGOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30CC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwG4-0005hW-Vd
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1ipwEs-00052S-GD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1ipwEp-0000LJ-SU
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:30:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1ipwEp-0000HG-NQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2c6LbQjApY6VL0+tlMmXw5jrzNaTZpp+9SEMsFYzzQ=;
 b=ElWYwGOYXEYtsTeJMxrwnjZ+U78OwidZCmaHT5sdFM4a+eBBuomu32fRUuPpedugs/pPTa
 JJMeP5Bx6fhEchS0YG9DHnkDfqRWDaitk018dGxvDy1z+p99jEV+D8HSBD7Ce7IYcE5qws
 WvHtwKE3KSVMuf4V+VPeMJbhhADPe9c=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-Taz8cpPTOMaphrqZtKvPnA-1; Fri, 10 Jan 2020 10:30:13 -0500
Received: by mail-il1-f197.google.com with SMTP id j21so1733754ilf.16
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 07:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q2c6LbQjApY6VL0+tlMmXw5jrzNaTZpp+9SEMsFYzzQ=;
 b=mNGrYE9hufr+RbZEORtv6B9z0wuIdxfZOTjhA7ZoPUOrab2wsR4SrTyuj5PKOxrb03
 d4hp+WAYLBpQSMfPw59nmWGpepLaEBp3r7h8xXKFCMDXbjiY+nPkY+UEbr4Bi30y6LT6
 zxjpNHmtH++4BErELQ7QhDDh532l56K4aOKVdt4ttko1YJdKgfWzPpIxzN5LYYQyNRRc
 CiyvIbJK7N6HN5rzaZYPTAFNTlfPQl26sw5yscMpYokQSrG97GQ5ZnEQoljEWShbTPgi
 fcF8h8vDPYj88DLkaVdsvAwxt2gvW386gogDrgNyiNustD4Bpx2TgzFU12lP5YlrYSCO
 b+KA==
X-Gm-Message-State: APjAAAXzCAeDhnsw9lFbh4yUl12/RqoL8yFNIzOLQLD+YFZ9wxsf9WEv
 kdJNumt/cjxLTKb2tOHMdV6poymlWMrruJV4uKHVYB8zaC/1klFas8dxFp0MAkuQxjpwADvwaek
 rJPfsVcfSMXXrKQVE3xZ2BYsFTXKaIo8=
X-Received: by 2002:a05:6602:24c6:: with SMTP id
 h6mr2966374ioe.273.1578670212865; 
 Fri, 10 Jan 2020 07:30:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxynYpUDBGmU14s2G9rcYzsvZSfuMk8ZMlCPN6SUeDJQRS5y2Iz0+Ha6ZEMXs3X4ajueWT5hlsCw5SxxGuuSp8=
X-Received: by 2002:a05:6602:24c6:: with SMTP id
 h6mr2966354ioe.273.1578670212589; 
 Fri, 10 Jan 2020 07:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-69-dgilbert@redhat.com>
 <20200107112316.GL3368802@redhat.com> <20200110150447.GH3901@work-vm>
 <CAOssrKdRn9NGV9TuvCkRRXEwZep6B-R2598iYLY4-9d6zkPUXg@mail.gmail.com>
 <20200110151808.GT3423494@redhat.com>
In-Reply-To: <20200110151808.GT3423494@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 10 Jan 2020 16:30:01 +0100
Message-ID: <CAOssrKf0ohB66yUpH38jH-dvOCs1zS5zfa5KL9g+0ZCAcMXs4w@mail.gmail.com>
Subject: Re: [PATCH 068/104] virtiofsd: passthrough_ll: control readdirplus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-MC-Unique: Taz8cpPTOMaphrqZtKvPnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Vivek Goyal <vgoyal@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 4:18 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Jan 10, 2020 at 04:13:08PM +0100, Miklos Szeredi wrote:
> > On Fri, Jan 10, 2020 at 4:04 PM Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > On Thu, Dec 12, 2019 at 04:38:28PM +0000, Dr. David Alan Gilbert (g=
it) wrote:
> > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > >
> > > >
> > > > What is readdirplus and what do we need a command line option to
> > > > control it ? What's the user benefit of changing the setting ?
> > >
> > > cc'ing Miklos who understands this better than me.
> > >
> > > My understanding is that readdirplus is a heuristic inherited from NF=
S
> > > where when you iterate over the directory you also pick up stat() dat=
a
> > > for each entry in the directory.  You then cache that stat data
> > > somewhere.
> > > The Plus-ness is that a lot of directory operations involve you stati=
ng
> > > each entry (e.g. to figure out if you can access it etc) so rolling i=
t
> > > into one op avoids the separate stat.  The unplus-ness is that it's a=
n
> > > overhead and I think changes some of the caching behaviour.
> >
> > Yeah, so either may give better performance and it's hard to pick a
> > clear winner.  NFS also has an option to control this.
>
> IIUC from the man page, the NFS option for controlling this is a client
> side mount option. This makes sense as only the client really has knowled=
ge
> of whether its workload will benefit.
>
> With this in mind, should the readdirplus control for virtio-fs also be a
> guest mount option instead of a host virtiofsd CLI option ? The guest adm=
in
> seems best placed to know whether their workload will benefit or not.

Definitely.   In fact other options, e.g. ones that control caching,
should probably also be client side (cache=3DXXX, writeback,
timeout=3DXXX, etc).

This needs an extension of the INIT message, so options can be passed
to the server.   Added this to our TODO list.

Thanks,
Miklos


