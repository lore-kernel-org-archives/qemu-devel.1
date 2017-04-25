Received: from eggs.gnu.org ([2001:4830:134:3::10]:41405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1d2ytW-0002OL-RF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1d2ytW-0002UR-0R
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53373 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1d2ytV-0002TV-QQ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:44:33 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 25 Apr 2017 13:44:54 +0200
Message-Id: <1493120694-120464-1-git-send-email-agraf@suse.de>
In-Reply-To: <1493120560-117434-1-git-send-email-agraf@suse.de>
References: <1493120560-117434-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] s390x/misc_helper.c: wrap
 s390_virtio_hypercall in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

s390_virtio_hypercall can trigger IO events and interrupts, most notably
when using virtio-ccw devices.

Reviewed-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Fixes: 278f5e98c647 ("s390x/misc_helper.c: wrap IO instructions in BQL")
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 target/s390x/misc_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 83d3894..eca8244 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -288,7 +288,9 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, ui=
nt32_t r3, uint32_t num)
     switch (num) {
     case 0x500:
         /* KVM hypercall */
+        qemu_mutex_lock_iothread();
         r =3D s390_virtio_hypercall(env);
+        qemu_mutex_unlock_iothread();
         break;
     case 0x44:
         /* yield */
--=20
1.8.5.6
