Received: from eggs.gnu.org ([2001:4830:134:3::10]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWPo-0000AX-C6
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWPk-0006cv-Db
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:17:52 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52710)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWPk-0006cN-6L
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:17:48 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 14 Nov 2017 11:17:55 +0300
Message-ID: <20171114081755.27640.21686.stgit@pasha-VirtualBox>
In-Reply-To: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 15/26] replay/replay-internal.c: track
 holding of replay_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This is modelled after the iothread mutex lock. We keep a TLS flag to
indicate when that thread has acquired the lock and assert we don't
double-lock or release when we shouldn't have.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 replay/replay-internal.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index fca8514..157c863 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -179,13 +179,24 @@ void replay_mutex_destroy(void)
     qemu_mutex_destroy(&lock);
 }
=20
+static __thread bool replay_locked;
+
+static bool replay_mutex_locked(void)
+{
+    return replay_locked;
+}
+
 void replay_mutex_lock(void)
 {
+    g_assert(!replay_mutex_locked());
     qemu_mutex_lock(&lock);
+    replay_locked =3D true;
 }
=20
 void replay_mutex_unlock(void)
 {
+    g_assert(replay_mutex_locked());
+    replay_locked =3D false;
     qemu_mutex_unlock(&lock);
 }
=20
