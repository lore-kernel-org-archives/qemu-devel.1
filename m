Received: from eggs.gnu.org ([2001:4830:134:3::10]:32838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cr8tH-0005ae-LV
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cr8tE-0001Ay-KJ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:59:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cr8tE-0001Ae-BR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:59:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2NJwicc110126
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 15:59:18 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29cffkauc4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 15:59:17 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 23 Mar 2017 13:59:16 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <CAFEAcA8EgBp8=xjyfR+nuYw5KvdptNC++o39nAJiwu-SWWM+yw@mail.gmail.com>
In-Reply-To: <CAFEAcA8EgBp8=xjyfR+nuYw5KvdptNC++o39nAJiwu-SWWM+yw@mail.gmail.com>
Date: Thu, 23 Mar 2017 14:59:09 -0500
Message-Id: <149029914932.3910.14105127854664571409@loki>
Subject: Re: [Qemu-devel] qga-test failure on Linux/sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Quoting Peter Maydell (2017-03-23 10:13:13)
> Hi; I find that qga-test fails on Linux/sparc host:
> =

> test-qga.c:286:test_qga_get_fsinfo: assertion failed
> ret: GenericError opendir("/sys/devices/virtual/block/md0/md0p1/slaves")
> =

> On this box /sys/devices/virtual/block/md0/md0p1/ does indeed
> not have a slaves/ subdirectory. There is a slaves/ subdirectory
> in the md0/ directory one level up, though.
> =

> Looking at the code in qga/commands-posix.c it seems to just assume
> that slaves/ exists and throws an error otherwise. Should this
> code be coping with the missing directory more gracefully, or
> does it have a bug where it's looking for slaves/ in the wrong
> place in the tree?

I think the code is assuming that it'll be the virtual block device
itself that's mounted, rather than a partition within it. This is
certainly a false assumption, so we shouldn't be making this a
fatal error.

It does make me wonder if we *should* be looking at the parent to
get the slave/device information though, which in turn means we
might want logic to traverse up the whole tree for nested cases.
But the GuestDiskAddress field of GuestFilesystemInfo is documented
as possibly being empty for certain disk types, so I think for now
we can simply relax the error. Will send a patch for 2.9.

> =

> thanks
> -- PMM
>=20
