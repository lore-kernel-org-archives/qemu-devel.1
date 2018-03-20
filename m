Received: from eggs.gnu.org ([2001:4830:134:3::10]:51334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7ml-00073c-K0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mk-0008R1-JI
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mk-0008Qj-E1
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:02 -0400
Date: Tue, 20 Mar 2018 05:18:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-51-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 50/50] postcopy shared docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add some notes to the migration documentation for shared memory
postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/devel/migration.rst | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 9d1b765..e32b087 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -577,3 +577,44 @@ Postcopy now works with hugetlbfs backed memory:
      hugepages works well, however 1GB hugepages are likely to be proble=
matic
      since it takes ~1 second to transfer a 1GB hugepage across a 10Gbps=
 link,
      and until the full page is transferred the destination thread is bl=
ocked.
+
+Postcopy with shared memory
+---------------------------
+
+Postcopy migration with shared memory needs explicit support from the ot=
her
+processes that share memory and from QEMU. There are restrictions on the=
 type of
+memory that userfault can support shared.
+
+The Linux kernel userfault support works on `/dev/shm` memory and on `hu=
getlbfs`
+(although the kernel doesn't provide an equivalent to `madvise(MADV_DONT=
NEED)`
+for hugetlbfs which may be a problem in some configurations).
+
+The vhost-user code in QEMU supports clients that have Postcopy support,
+and the `vhost-user-bridge` (in `tests/`) and the DPDK package have chan=
ges
+to support postcopy.
+
+The client needs to open a userfaultfd and register the areas
+of memory that it maps with userfault.  The client must then pass the
+userfaultfd back to QEMU together with a mapping table that allows
+fault addresses in the clients address space to be converted back to
+RAMBlock/offsets.  The client's userfaultfd is added to the postcopy
+fault-thread and page requests are made on behalf of the client by QEMU.
+QEMU performs 'wake' operations on the client's userfaultfd to allow it
+to continue after a page has arrived.
+
+.. note::
+  There are two future improvements that would be nice:
+    a) Some way to make QEMU ignorant of the addresses in the clients
+       address space
+    b) Avoiding the need for QEMU to perform ufd-wake calls after the
+       pages have arrived
+
+Retro-fitting postcopy to existing clients is possible:
+  a) A mechanism is needed for the registration with userfault as above,
+     and the registration needs to be coordinated with the phases of
+     postcopy.  In vhost-user extra messages are added to the existing
+     control channel.
+  b) Any thread that can block due to guest memory accesses must be
+     identified and the implication understood; for example if the
+     guest memory access is made while holding a lock then all other
+     threads waiting for that lock will also be blocked.
--=20
MST
