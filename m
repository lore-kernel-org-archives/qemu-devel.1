Received: from eggs.gnu.org ([2001:4830:134:3::10]:36616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duf20-00036f-L5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duf1h-0004EC-19
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duf1g-0004Dn-QR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:52 -0400
Date: Wed, 20 Sep 2017 17:51:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170920095114.GA9135@lemon.lan>
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
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, 09/20 11:26, Christian Ehrhardt wrote:
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

The --no-lock option was later revised into --force-share, so...

> 
> Repro of the case is rather simple:
> $ qemu-img create -f qcow2 /tmp/test.qcow2 1M
> $ qemu-system-x86_64 -hda /tmp/test.qcow2 -enable-kvm -nodefaults
> -nographic &
> $ qemu-img info /tmp/test.qcow2
> qemu-img: Could not open '/tmp/test.qcow2': Failed to get shared "write"
> lock
> Is another process using the image?

... you can do this:

$ qemu-img info --force-share /tmp/test.qcow2
image: /tmp/test.qcow2
file format: qcow2
virtual size: 1.0M (1048576 bytes)
disk size: 196K
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

Fam
