Received: from eggs.gnu.org ([2001:4830:134:3::10]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1duf5a-0006Fn-ND
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1duf5X-0006lo-Em
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:30:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1duf5X-0006kp-3d
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:30:51 -0400
Received: from mail-yw0-f199.google.com ([209.85.161.199])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dubHH-0001PM-Kl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:43 +0000
Received: by mail-yw0-f199.google.com with SMTP id s62so4105348ywg.3
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:26:43 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 20 Sep 2017 11:26:11 +0200
Message-ID: <CAATJJ0KLaR6VUrPZZSQxwb6niF5YY0UMB5sWDq9b=OeeC5=1Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] need to resurrect no-lock option?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

Hi,
this might have been discussed in the wake of the lock changes that took
place in 2.10 but I can't find anything clear enough to follow in the
current case.
There was an old submission [1] by Fam to make it possible to no-lock
qemu-img and others if needed. But it seems nothing like it made it along
to the locking we have in 2.10.

One (maybe more) case where missing this causes pain is e.g. running an
info check on a running guest.
In general info shouldn't need a write lock anyway, but without --no-lock
that use case is broken.

Repro of the case is rather simple:
$ qemu-img create -f qcow2 /tmp/test.qcow2 1M
$ qemu-system-x86_64 -hda /tmp/test.qcow2 -enable-kvm -nodefaults
-nographic &
$ qemu-img info /tmp/test.qcow2
qemu-img: Could not open '/tmp/test.qcow2': Failed to get shared "write"
lock
Is another process using the image?

[1]: https://lists.gnu.org/archive/html/qemu-block/2016-04/msg00349.html

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
