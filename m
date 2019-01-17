Received: from eggs.gnu.org ([209.51.188.92]:38701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9fr-00015a-0z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9fp-0005M9-Ks
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gk9fo-0004h3-7z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:41 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 09:33:18 -0600
Message-Id: <20190117153321.29749-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/3] Expand 'qemu-img info' to show
 protocol details
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com

Posting this now to get feedback on the general idea; it would still
need to be polished into a form I'd feel happy committing, including
reworking 'qemu-nbd --list' to reuse the new NBD-specific QAPI type.

Based-on: <20190112175812.27068-1-eblake@redhat.com>
[0/19 nbd: add qemu-nbd --list]

Examples with this applied:
$ ./qemu-img info file
image: file
file format: qcow2
virtual size: 1.0M (1048576 bytes)
disk size: 672K
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
Protocol specific information:
    write zero: true
    discard zero: true
    discard: true
    align: 1
$ qemu-nbd file &
$ ./qemu-img info nbd://localhost:10809
image: nbd://localhost:10809
file format: raw
virtual size: 1.0M (1048576 bytes)
disk size: unavailable
Protocol specific information:
    flags:
    active contexts:
        [0]:
            name: base:allocation
            id: 0
    unknown flags: 1260

Eric Blake (3):
  block: Expose protocol-specific data to 'qemu-img info'
  file: Expose some protocol-specific information
  RFC: nbd: Expose protocol-specific information

 qapi/block-core.json | 87 +++++++++++++++++++++++++++++++++++++++++++-
 block/nbd-client.h   |  1 +
 block/file-posix.c   | 21 +++++++++++
 block/nbd-client.c   | 39 ++++++++++++++++++++
 block/nbd.c          |  3 ++
 block/qapi.c         |  7 ++++
 6 files changed, 156 insertions(+), 2 deletions(-)

--=20
2.20.1
