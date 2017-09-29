Received: from eggs.gnu.org ([2001:4830:134:3::10]:39462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dxsGe-0000K0-Ql
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dxsGZ-0008E4-5L
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:11:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dxsGY-0008DQ-VM
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:11:31 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 29 Sep 2017 13:11:13 +0300
Message-id: <1506679874-22284-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170929101124eucas1p25695c76db8f17ef8181ee2b3051bba98@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH] fix tests/migration/stress build
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, heetae82.ahn@samsung.com, Alexey Perevalov <a.perevalov@samsung.com>, berrange@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
List-ID: <qemu-devel.nongnu.org>

This small commit fixes build of tests/migration/stress on Ubuntu16.04
(on RHEL7.4 the same situation, after typical configure with following options
--target-list=x86_64-linux-user,i386-linux-user,x86_64-softmmu,i386-softmmu \
--enable-numa --enable-kvm --enable-vhost-net --enable-tpm --enable-debug \
 --disable-gtk )
PTHREAD_LIB is empty after successfully compiled pthread sample in configure.
tests/migration/stress relay on it, but -pthread is not there
and linker fails trying to resolve pthread symbols.

I still have a questions:
1. Is there a better way to obtain -thread option from QEMU_CFLAGS
2. Is linker options really necessary for stress application, because only -O3
is used, so w/o linker options in Makefile there is no need in PTHREAD_LIB
at all, I mean in whole project.
3. LINKPROG will be expanded into c++ firstly, and -static in
tests/Makefile.include will require static libstdc++, but configure doesn't
check it and in case of missing libstdc++-static.x86_64 (RHEL package name),
build will fail with the following message: "ld: cannot find -lstdc++",
I think here reasonably to use just $(CC) instead of LINKPROG, stress.c is on C.

Also ./tests/migration/guestperf.py can not be started w/o
super user privileges, and reports in this case something useless like this:
Error: [Errno 104] Connection reset by peer

This patch is based on commit 4a0d8b34e8ccf5ababdd11b29ce954aa9a5da365

Alexey Perevalov (1):
  configure: correctly define PTHREAD_LIB

 configure | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.4
