Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXS7w-0003Np-1c
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXS7r-0004wY-3d
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:33:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45642
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eXS7q-0004vb-Ub
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:33:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w05DSbAN081328
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 08:33:33 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fa8da4r9r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 08:33:32 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 08:33:32 -0500
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Fri,  5 Jan 2018 11:32:40 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] qemu/nbd: fix segmentation fault when
 .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-ppc@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>, Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>

Hello, QEMU community.

The following patch is to fix a segmentation fault when nbd_runtime_opts.desc is
not null-terminated.

This issue emerged when building QEMU with --enable-gcov, as described by
https://bugs.launchpad.net/qemu/+bug/1727259.

To reproduce on ppc64le, run the following commands on QEMU git tree:

mkdir build
mkdir -p tests/qemu-iotests/scratch
cd build
../configure --target-list=ppc64-softmmu --enable-gcov
make -j$(nproc)

./qemu-img create -f qcow2 -o compat=1.1 ./tests/qemu-iotests/scratch/t.qcow2 64M
./qemu-io --cache writeback -f qcow2 -c "write -P 0xa 0x1000 0x1000" ./tests/qemu-iotests/scratch/t.qcow2
./qemu-io --cache writeback -f qcow2 -c "write -P 0xb 0x2000 0x1000" ./tests/qemu-iotests/scratch/t.qcow2
./qemu-img snapshot -c sn1 ./tests/qemu-iotests/scratch/t.qcow2
./qemu-io --cache writeback -f qcow2 -c "write -P 0xc 0x1000 0x1000" ./tests/qemu-iotests/scratch/t.qcow2
./qemu-io --cache writeback -f qcow2 -c "write -P 0xd 0x2000 0x1000" ./tests/qemu-iotests/scratch/t.qcow2
./qemu-img check -f qcow2 ./tests/qemu-iotests/scratch/t.qcow2
./qemu-io --cache writeback -f qcow2 -c "read -P 0xc 0x1000 0x1000" ./tests/qemu-iotests/scratch/t.qcow2
./qemu-io --cache writeback -f qcow2 -c "read -P 0xd 0x2000 0x1000" ./tests/qemu-iotests/scratch/t.qcow2

# run in background, wait some seconds until it starts
./qemu-nbd -v -t -k ${PWD}/tests/qemu-iotests/scratch/test_qemu_nbd_socket ./tests/qemu-iotests/scratch/t.qcow2 -l sn1 &
sleep 5

# this will cause qemu-io to segfault
./qemu-io --cache writeback -f qcow2 -f raw --cache=writeback -r -c "read -P 0xa 0x1000 0x1000" nbd:unix:${PWD}/tests/qemu-iotests/scratch/test_qemu_nbd_socket

# kill qemu-nbd
kill $(pidof qemu-nbd)

Cheers
Murilo

Murilo Opsfelder Araujo (1):
  block/nbd: fix segmentation fault when .desc is not null-terminated

 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.14.3
