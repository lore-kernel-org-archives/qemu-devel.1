Received: from eggs.gnu.org ([2001:4830:134:3::10]:54644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cqkS4-0004K0-Tl
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cqkS1-0003Nr-RE
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:53:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:26059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cqkS1-0003My-I1
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:53:37 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 22 Mar 2017 17:53:35 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A2E3D5@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] clear pending status before calling memory
 commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>

clear pending status before calling memory commit.
Otherwise when memory_region_finalize is called,=20
memory_region_transaction_depth is 0 and=20
memory_region_update_pending is true.=20
That's wrong.


Signed-off -by: Anthony Xu <anthony.xu@intel.com>



diff --git a/memory.c b/memory.c
index 64b0a60..4c95aaf 100644
--- a/memory.c
+++ b/memory.c
@@ -906,12 +906,6 @@ void memory_region_transaction_begin(void)
     ++memory_region_transaction_depth;
 }

-static void memory_region_clear_pending(void)
-{
-    memory_region_update_pending =3D false;
-    ioeventfd_update_pending =3D false;
-}
-
 void memory_region_transaction_commit(void)
 {
     AddressSpace *as;
@@ -927,14 +921,14 @@ void memory_region_transaction_commit(void)
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_topology(as);
             }
-
+            memory_region_update_pending =3D false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
         } else if (ioeventfd_update_pending) {
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_ioeventfds(as);
             }
+            ioeventfd_update_pending =3D false;
         }
-        memory_region_clear_pending();
    }
 }
