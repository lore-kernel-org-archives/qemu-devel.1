Received: from eggs.gnu.org ([2001:4830:134:3::10]:41082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9DA-0003Gl-Gz
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93T-0001EW-PY
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93S-0008UA-On
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:35 -0500
Received: by mail-wr1-x42c.google.com with SMTP id r10-v6so15200648wrv.6
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:50 +0100
Message-Id: <1541540283-45699-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/17] ivshmem: fix memory backend leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

object_new() returns a new backend with refcount == 1 and
then later object_property_add_child() increases refcount to 2
So when ivshmem is destroyed, the backend it has created isn't
destroyed along with it as children cleanup will bring
backend's refcount only to 1, which leaks backend including
resources it is using.

Drop the original reference from object_new() once backend
is attached to its parent.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Fixes: 5503e285041979dd29698ecb41729b3b22622e8d
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index f88910e..ecfd10a 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1279,6 +1279,7 @@ static void desugar_shm(IVShmemState *s)
     object_property_set_bool(obj, true, "share", &error_abort);
     object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
                               &error_abort);
+    object_unref(obj);
     user_creatable_complete(obj, &error_abort);
     s->hostmem = MEMORY_BACKEND(obj);
 }
-- 
1.8.3.1
