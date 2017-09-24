Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbE-0002pM-0K
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbA-00082j-3D
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:40 +0300
Message-Id: <42c74252d68714894de4ba6d9c257dcd919e30b0.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/31] chardev/baum: fix baum that releases
 brlapi twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Liang Yan <lyan@suse.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Liang Yan <lyan@suse.com>

Error process of baum_chr_open needs to set brlapi null, so it won't
get released twice in char_braille_finalize, which will cause
"/usr/bin/qemu-system-x86_64: double free or corruption (!prev)"

Signed-off-by: Liang Yan <lyan@suse.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 chardev/baum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/baum.c b/chardev/baum.c
index 302dd9666c..67fd783a59 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -643,6 +643,7 @@ static void baum_chr_open(Chardev *chr,
         error_setg(errp, "brlapi__openConnection: %s",
                    brlapi_strerror(brlapi_error_location()));
         g_free(handle);
+        baum->brlapi =3D NULL;
         return;
     }
     baum->deferred_init =3D 0;
--=20
2.11.0
