Received: from eggs.gnu.org ([2001:4830:134:3::10]:34565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJx-000454-8z
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJu-0007TW-UD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1epDJu-0007TH-PC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:26 -0500
From: marcandre.lureau@redhat.com
Date: Fri, 23 Feb 2018 14:23:07 +0100
Message-Id: <20180223132311.26555-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180223132311.26555-1-marcandre.lureau@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/7] HACK: HobLib: workaround infinite loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Without this hack, GetNextHob() loops infinitely with the next patch.
I don't understand the reason.

The loop is triggered by the GetFirstGuidHob (&gTpmErrorHobGuid) call.

CC: Laszlo Ersek <lersek@redhat.com>
CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MdePkg/Library/PeiHobLib/HobLib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MdePkg/Library/PeiHobLib/HobLib.c b/MdePkg/Library/PeiHobLib=
/HobLib.c
index 5c0eeb992f..ed3c5fbd6d 100644
--- a/MdePkg/Library/PeiHobLib/HobLib.c
+++ b/MdePkg/Library/PeiHobLib/HobLib.c
@@ -89,6 +89,10 @@ GetNextHob (
     if (Hob.Header->HobType =3D=3D Type) {
       return Hob.Raw;
     }
+    if (GET_HOB_LENGTH (HobStart) =3D=3D 0) {
+        DEBUG ((DEBUG_INFO, "FIXME: GetNextHob length =3D=3D 0"));
+        return NULL;
+    }
     Hob.Raw =3D GET_NEXT_HOB (Hob);
   }
   return NULL;
--=20
2.16.1.73.g5832b7e9f2
