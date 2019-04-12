Received: from eggs.gnu.org ([209.51.188.92]:36176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6j-0002h9-0m
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6i-0004Va-63
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEv6h-0004VM-W2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:36 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 12 Apr 2019 13:16:22 +0100
Message-Id: <20190412121626.19829-2-berrange@redhat.com>
In-Reply-To: <20190412121626.19829-1-berrange@redhat.com>
References: <20190412121626.19829-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/5] linux-user: avoid string truncation
 warnings in uname field copying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from linux-user/uname.c:20:
In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98sys_uname=E2=80=99 at linux-user/uname.c:94:3:
/usr/include/bits/string_fortified.h:106:10: warning: =E2=80=98__builtin_=
strncpy=E2=80=99 output may be truncated copying 64 bytes from a string o=
f length 64 [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~

We don't care where the NUL terminator in the original uname
field was. It suffices to copy the entire original field and
simply force a NUL terminator at the end of the new field.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 linux-user/uname.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/uname.c b/linux-user/uname.c
index 313b79dbad..3dff33effe 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
 #define COPY_UTSNAME_FIELD(dest, src) \
   do { \
       /* __NEW_UTS_LEN doesn't include terminating null */ \
-      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
+      memcpy((dest), (src), MIN(sizeof(src), __NEW_UTS_LEN));   \
       (dest)[__NEW_UTS_LEN] =3D '\0'; \
   } while (0)
=20
--=20
2.20.1
