Received: from eggs.gnu.org ([2001:4830:134:3::10]:39650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3RhY-0006xW-6b
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 15:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3RhV-0002by-3J
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 15:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3RhU-0002bt-Ve
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 15:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9034F8151D46
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 19:34:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Apr 2018 14:34:20 -0500
Message-Id: <20180403193420.2065215-4-eblake@redhat.com>
In-Reply-To: <20180403193420.2065215-1-eblake@redhat.com>
References: <20180403193420.2065215-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] dump: Fix build with newer gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

gcc 8 on rawhide is picky enough to complain:

/home/dummy/qemu/dump.c: In function 'create_header32':
/home/dummy/qemu/dump.c:817:5: error: 'strncpy' output truncated before t=
erminating nul copying 8 bytes from a string of the same length [-Werror=3D=
stringop-truncation]
     strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

But we already have SIG_LEN defined as the right length without needing
to do a strlen(), and memcpy() is better than strncpy() when we know
we do not want a trailing NUL byte.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180327202152.1799131-1-eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dump.c b/dump.c
index 669f715274d..b54cd42b217 100644
--- a/dump.c
+++ b/dump.c
@@ -814,7 +814,7 @@ static void create_header32(DumpState *s, Error **err=
p)
     size =3D sizeof(DiskDumpHeader32);
     dh =3D g_malloc0(size);

-    strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
+    memcpy(dh->signature, KDUMP_SIGNATURE, SIG_LEN);
     dh->header_version =3D cpu_to_dump32(s, 6);
     block_size =3D s->dump_info.page_size;
     dh->block_size =3D cpu_to_dump32(s, block_size);
@@ -926,7 +926,7 @@ static void create_header64(DumpState *s, Error **err=
p)
     size =3D sizeof(DiskDumpHeader64);
     dh =3D g_malloc0(size);

-    strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
+    memcpy(dh->signature, KDUMP_SIGNATURE, SIG_LEN);
     dh->header_version =3D cpu_to_dump32(s, 6);
     block_size =3D s->dump_info.page_size;
     dh->block_size =3D cpu_to_dump32(s, block_size);
--=20
2.14.3
