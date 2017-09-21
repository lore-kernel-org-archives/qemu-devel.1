Received: from eggs.gnu.org ([2001:4830:134:3::10]:45059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv0fX-0005Ty-Q7
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv0fT-0001kg-S3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:33:27 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:52294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dv0fT-0001jQ-KR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:33:23 -0400
Received: by mail-wr0-x22a.google.com with SMTP id c23so4438137wrg.9
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:33:23 -0700 (PDT)
Date: Thu, 21 Sep 2017 13:33:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170921123320.GG32364@stefanha-x1.localdomain>
References: <CAATJJ0KLaR6VUrPZZSQxwb6niF5YY0UMB5sWDq9b=OeeC5=1Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATJJ0KLaR6VUrPZZSQxwb6niF5YY0UMB5sWDq9b=OeeC5=1Xw@mail.gmail.com>
Subject: Re: [Qemu-devel] need to resurrect no-lock option?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On Wed, Sep 20, 2017 at 11:26:11AM +0200, Christian Ehrhardt wrote:
> Hi,
> this might have been discussed in the wake of the lock changes that took
> place in 2.10 but I can't find anything clear enough to follow in the
> current case.
> There was an old submission [1] by Fam to make it possible to no-lock
> qemu-img and others if needed. But it seems nothing like it made it along
> to the locking we have in 2.10.
> 
> One (maybe more) case where missing this causes pain is e.g. running an
> info check on a running guest.
> In general info shouldn't need a write lock anyway, but without --no-lock
> that use case is broken.

It's still an invalid use case.  There is no guarantee that qemu-img
will see a consistent version of the image file.  Metadata could change
underneath qemu-img because QEMU may still write to it.  QEMU may also
have some metadata cached so there's no guarantee that qemu-img sees an
up-to-date image.

Why do you need to run qemu-img on a disk image that is in use?

> Repro of the case is rather simple:
> $ qemu-img create -f qcow2 /tmp/test.qcow2 1M
> $ qemu-system-x86_64 -hda /tmp/test.qcow2 -enable-kvm -nodefaults
> -nographic &
> $ qemu-img info /tmp/test.qcow2
> qemu-img: Could not open '/tmp/test.qcow2': Failed to get shared "write"
> lock
> Is another process using the image?
> 
> [1]: https://lists.gnu.org/archive/html/qemu-block/2016-04/msg00349.html
> 
> -- 
> Christian Ehrhardt
> Software Engineer, Ubuntu Server
> Canonical Ltd
