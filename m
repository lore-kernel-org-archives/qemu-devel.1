Received: from eggs.gnu.org ([208.118.235.92]:60467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ee89Q-00016Q-01
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ee89L-0005ec-Ok
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:38:47 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ee89L-0005cT-Bt
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:38:43 -0500
Received: from player698.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B89E5B7B1D
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 00:38:41 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 24 Jan 2018 00:38:30 +0100
Message-ID: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/7] tests: virtio-9p: test request cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

This series does several changes to virtio-9p-test in order to be able
to test request cancellation (flush in 9p wording):

patches 1-2: preparatory work, basically doing things in the test code,
             rather that in the common code for flexibility and clarity

patch 3: the cornerstone of the series, switch to using the synth fsdev
         backend, which allows to associate specific write/read ops to
         a given file. Since this backend never got used since it was
         merged, it looks like an ideal vehicle to add QTEST aware code
         in QEMU

patches 4-5: trivial open & write tests, since the flush test will need
             to open a file and write to it

patch 6: another important patch that allows to know the length written
         by the guest into a used buffer 

patch 7: the goal of this series, two request cancellation tests

This series depends on the following patch:

https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05604.html

Please comment.

Cheers,

--
Greg

---

Greg Kurz (7):
      tests: virtio-9p: move request tag to the test functions
      tests: virtio-9p: wait for completion in the test code
      tests: virtio-9p: use the synth backend
      tests: virtio-9p: add LOPEN operation test
      tests: virtio-9p: add WRITE operation test
      libqos/virtio: return length written into used descriptor
      tests: virtio-9p: add FLUSH operation test


 hw/9pfs/9p-synth.c       |   56 ++++++++++
 hw/9pfs/9p-synth.h       |   11 ++
 hw/9pfs/9p.c             |    1 
 tests/libqos/virtio.c    |   25 +++-
 tests/libqos/virtio.h    |    3 -
 tests/virtio-9p-test.c   |  263 ++++++++++++++++++++++++++++++++++++++++------
 tests/virtio-blk-test.c  |   24 ++--
 tests/virtio-net-test.c  |    6 +
 tests/virtio-scsi-test.c |    3 -
 9 files changed, 335 insertions(+), 57 deletions(-)
