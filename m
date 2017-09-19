Received: from eggs.gnu.org ([2001:4830:134:3::10]:38627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdC-0005qH-Qg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdB-0002bB-Rx
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdB-0002aL-Lu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:17 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:05 +0200
Message-Id: <20170919164337.18555-7-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 06/38] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The "slow" ivshmem-tests currently fail when they are running on a
big endian host:

$ uname -m
ppc64
$ V=3D1 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/ivshm=
em-test -m slow
/x86_64/ivshmem/single: OK
/x86_64/ivshmem/hotplug: OK
/x86_64/ivshmem/memdev: OK
/x86_64/ivshmem/pair: OK
/x86_64/ivshmem/server-msi: qemu-system-x86_64:
 -device ivshmem-doorbell,chardev=3Dchr0,vectors=3D2: server sent invalid=
 ID message
Broken pipe

The problem is that the server side code in ivshmem_server_send_one_msg()
correctly translates all messages IDs into little endian 64-bit values,
but the client side code in the ivshmem_recv_msg() function does not swap
the byte order back. Fix it by passing the value through le64_to_cpu().

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1504100343-26607-1-git-send-email-thuth@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/misc/ivshmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 47a015f072..b3ef3ec1e3 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -653,7 +653,7 @@ static int64_t ivshmem_recv_msg(IVShmemState *s, int =
*pfd, Error **errp)
     } while (n < sizeof(msg));
=20
     *pfd =3D qemu_chr_fe_get_msgfd(&s->server_chr);
-    return msg;
+    return le64_to_cpu(msg);
 }
=20
 static void ivshmem_recv_setup(IVShmemState *s, Error **errp)
--=20
2.13.5
