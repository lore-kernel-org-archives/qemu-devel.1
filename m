Received: from eggs.gnu.org ([2001:4830:134:3::10]:53295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTH-00007R-7C
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTD-0002GJ-8r
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTC-0002G2-UP
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AESkoP041632
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:13 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vvby5a6j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:13 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 07:32:12 -0700
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 0/7] fix potential hangs in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The 9P open and create operations cause QEMU to call the open(2) syscall on
the backend. Unfortunately, it doesn't check if the given pathname already
exists and points to something that could cause open(2) to hang (like a named
pipe for example).

This series fixes the issues for open (only allow directories and regular
files) and create (enforce O_EXCL). It also adds the corresponding tests in
virtio-9p-test.

---

Greg Kurz (7):
      9pfs: restrict open to regular files and directories
      tests: virtio-9p: improve error reporting
      tests: virtio-9p: add LOPEN operation test
      tests: virtio-9p: TLOPEN should fail to open a FIFO
      9pfs: don't create files if pathname already exists
      tests: virtio-9p: add LCREATE operation test
      tests: virtio-9p: TLCREATE should fail if pathname exists


 hw/9pfs/9p.c           |   10 ++
 tests/virtio-9p-test.c |  197 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 199 insertions(+), 8 deletions(-)

--
Greg
