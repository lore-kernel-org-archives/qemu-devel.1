Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA0FC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B7E2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="EphPKEmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B7E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP9Yj-0004bI-89
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 14:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <osandov@osandov.com>) id 1jP9Xi-0003u9-WD
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <osandov@osandov.com>) id 1jP9Xh-0002BU-Hx
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:47:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <osandov@osandov.com>) id 1jP9Xf-00029t-8V
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:47:16 -0400
Received: by mail-pg1-x544.google.com with SMTP id 2so2034855pgp.11
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HUEWLw1uSNp6AdHrBcWiKo2O097La11hzrAKh3eSUAQ=;
 b=EphPKEmqsYEdeU9gEfJTnwRPkxGbuidllQk8BI+JrIe4gr5wnIhPgdsl3dSBWKrcBA
 k4zpo2efxMciKP3+4bGt4Y6SkT3nDMXjPz0+ftGmovt3NzdJdxuCscBGa7Z8068y/p/y
 ugwFKnO3q7tYfKPcd6N6JRg88SUEaedfO0DqnC69jWN39yHfEkhYwB22E3EZcDKxs0/S
 hTohJISWq57Ir5MDWbn7lQlIP2O82Ze6NaareWj7AcyJ1P/WKiAp+9GhzzrhDFLz/xou
 SCpFB92JGMINe7ZlT9r4GrkSwM1GVe/Pdf28trcBx4LsJySzSMhwU6XuG7fXLIHC2v+8
 hqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HUEWLw1uSNp6AdHrBcWiKo2O097La11hzrAKh3eSUAQ=;
 b=Gj4mprWf7xzxPrH3jHvgdg9CPyRP7d2lEHvesP9/LhAXYb19LxHbc6iVQluXXOf/Oi
 d34/JRK8M3jcl6U4vp8tjvJ6nhve9mZqi6WXw2/8gvH2IQXBvEB8rysr9KQFdVuQGtQf
 hbS0a5L0Z3i/OZ8dej7BEI+PRGCh2iEC9FbUXKeke2tvBMoQSvWB/7HoYuXtTKn9vTKn
 Kuz35un6NaCRqwn8JkR1pbmjStRkj6UbNX00Y5vK6TzmBx8P0WhNOEw+AqTr61E8pntP
 NyRXlp6vomlSMe81FcXY8CY5fH0xFcQZ0A8atrFLp6o8lDy/jeLtYeNWEr8+cnHXsU2d
 DsVA==
X-Gm-Message-State: AGi0PuY27yXU418EaA4YzqW7mxhrhdriuMv4FUeLpHPR7o2htSwvbYla
 hUbLY08wxtGuFXqXWX4PsqYmP4A+hSk=
X-Google-Smtp-Source: APiQypK/JJIEhXqpB4feFloVLDhyEAOXV0A18rxvpjte3JqZ77C1U4F6D3slUUrJT7OVt9uF+8aT9Q==
X-Received: by 2002:a62:6dc1:: with SMTP id i184mr33871419pfc.25.1587062833042; 
 Thu, 16 Apr 2020 11:47:13 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::7584])
 by smtp.gmail.com with ESMTPSA id c80sm3447258pfb.82.2020.04.16.11.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 11:47:12 -0700 (PDT)
Date: Thu, 16 Apr 2020 11:47:11 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: local: ignore O_NOATIME if we don't have permissions
Message-ID: <20200416184711.GB696015@vader>
References: <1e65cffe9778857735e7ae6066d6f0df0b0e2db3.1586997767.git.osandov@fb.com>
 <2496702.lrWaslOkEp@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2496702.lrWaslOkEp@silver>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 04:58:31PM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 16. April 2020 02:44:33 CEST Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > QEMU's local 9pfs server passes through O_NOATIME from the client. If
> > the QEMU process doesn't have permissions to use O_NOATIME (namely, it
> > does not own the file nor have the CAP_FOWNER capability), the open will
> > fail. This causes issues when from the client's point of view, it
> > believes it has permissions to use O_NOATIME (e.g., a process running as
> > root in the virtual machine). Additionally, overlayfs on Linux opens
> > files on the lower layer using O_NOATIME, so in this case a 9pfs mount
> > can't be used as a lower layer for overlayfs (cf.
> > https://github.com/osandov/drgn/blob/dabfe1971951701da13863dbe6d8a1d172ad965
> > 0/vmtest/onoatimehack.c and https://github.com/NixOS/nixpkgs/issues/54509).
> > 
> > Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
> > network filesystems. open(2) notes that O_NOATIME "may not be effective
> > on all filesystems. One example is NFS, where the server maintains the
> > access time." This means that we can honor it when possible but fall
> > back to ignoring it.
> 
> I am not sure whether NFS would simply silently ignore O_NOATIME i.e. without 
> returning EPERM. I don't read it that way.

As far as I can tell, the NFS protocol has nothing equivalent to
O_NOATIME and thus can't honor it. Feel free to test it:

  # mount -t nfs -o vers=4,rw 10.0.2.2:/ /mnt
  # echo foo > /mnt/foo
  # touch -d "1 hour ago" /mnt/foo
  # stat /mnt/foo | grep 'Access: [0-9]'
  Access: 2020-04-16 10:43:36.838952593 -0700
  # # Drop caches so we have to go to the NFS server.
  # echo 3 > /proc/sys/vm/drop_caches
  # strace -e openat dd if=/mnt/foo of=/dev/null iflag=noatime |& grep /mnt/foo
  openat(AT_FDCWD, "/mnt/foo", O_RDONLY|O_NOATIME) = 3
  # stat /mnt/foo | grep 'Access: [0-9]'
  Access: 2020-04-16 11:43:36.906462928 -0700

> Fact is on Linux the expected 
> behaviour is returning EPERM if O_NOATIME cannot be satisfied, consistent 
> since its introduction 22 years ago:
> http://lkml.iu.edu/hypermail/linux/kernel/9811.2/0118.html

The exact phrasing in the man-page is: "EPERM  The O_NOATIME flag was
specified, but the effective user ID of the caller did not match the
owner of the file and the caller was not privileged." IMO, it's about
whether the (guest) process has permission from the (guest) kernel's
point of view, not whether the filesystem could satisfy it.

> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  hw/9pfs/9p-util.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > index 79ed6b233e..50842d540f 100644
> > --- a/hw/9pfs/9p-util.h
> > +++ b/hw/9pfs/9p-util.h
> > @@ -37,9 +37,14 @@ static inline int openat_file(int dirfd, const char
> > *name, int flags, {
> >      int fd, serrno, ret;
> > 
> > +again:
> >      fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
> >                  mode);
> >      if (fd == -1) {
> > +        if (errno == EPERM && (flags & O_NOATIME)) {
> > +            flags &= ~O_NOATIME;
> > +            goto again;
> > +        }
> >          return -1;
> >      }
> 
> It would certainly fix the problem in your use case. But it would also unmask 
> O_NOATIME for all other ones (i.e. regular users on guest).

The guest kernel will still check whether processes on the guest have
permission to use O_NOATIME. This only changes the behavior when the
guest kernel believes that the process has permission even though the
host QEMU process doesn't.

> I mean I understand your point, but I also have to take other use cases into 
> account which might expect to receive EPERM if O_NOATIME cannot be granted.

If you'd still like to preserve this behavior, would it be acceptable to
make this a QEMU option? Maybe something like "-virtfs
honor_noatime=no": the default would be "yes", which is the current
behavior, and "no" would always mask out NOATIME.

> May I ask how come that file/dir in question does not share the same uid in 
> your specific use case? Are the file(s) created outside of QEMU, i.e. directly 
> by some app on host?

My use case is running tests on different versions of the Linux kernel
while reusing the host's userspace environment. I export the host's root
filesystem read-only to the guest via 9pfs, and the guest sets up
overlayfs on top of it (to allow certain modifications) and chroots into
that. Without a workaround like the LD_PRELOAD one I mentioned in the
commit message, any (read) accesses to files owned by root on the host
(like /bin/sh) will fail.

