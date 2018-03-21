Received: from eggs.gnu.org ([2001:4830:134:3::10]:36763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyesU-0003qe-JC
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyesQ-00017x-CW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eyesQ-00017e-6x
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 15:37:53 +0100
Message-Id: <20180321143754.5606-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180321143754.5606-1-marcandre.lureau@redhat.com>
References: <20180321143754.5606-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] dump.c: allow fd_write_vmcore to return
 errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>

fd_write_vmcore can fail to execute for a lot of reasons that can be
retrieved by errno, but it only returns -1. This makes difficult for
the caller to know what happened and only a generic error message is
propagated back to the user. This is an example using dump-guest-memory:

(qemu) dump-guest-memory /home/yasmin/mnt/test.dump
dump: failed to save memory

All callers of fd_write_vmcore of dump.c does error handling via
error_setg(), so at first it seems feasible to add the Error pointer as
an argument of fd_write_vmcore. This proved to be more complex than it
first looked. fd_write_vmcore is used by write_elf64_notes and
write_elf32_notes as a WriteCoreDumpFunction prototype. WriteCoreDumpFunc=
tion
is declared in include/qom/cpu.h and is used all around the code. This
leaves us with few alternatives:

- change the WriteCoreDumpFunction prototype to include an error pointer.
This would require to change all functions that implements this prototype
to also receive an Error pointer;

- change both write_elf64_notes and write_elf32_notes to no use the
WriteCoreDumpFunction. These functions use not only fd_write_vmcore
but also buf_write_note, so this would require to change buf_write_note
to handle an Error pointer. Considerable easier than the alternative
above, but it's still a lot of code just for the benefit of the callers
of fd_write_vmcore.

This patch presents an easier solution that benefits all fd_write_vmcore
callers:

- instead of returning -1 on error, return -errno. All existing callers
already checks for ret < 0 so there is no need to change the caller's
logic too much. This also allows the retrieval of the errno.

- all callers were updated to use error_setg_errno instead of just
errno_setg. Now that fd_write_vmcore can return an errno, let's update
all callers so they can benefit from a more detailed error message.

This is the same dump-guest-memory example with this patch applied:

(qemu) dump-guest-memory /home/yasmin/mnt/test.dump
dump: failed to save memory: No space left on device
(qemu)

This example illustrates an error of fd_write_vmcore when called
from write_data. All other callers will benefit from better
error messages as well.

Reported-by: yilzhang@redhat.com
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Message-Id: <20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 dump.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/dump.c b/dump.c
index 6bdb0dbe23..669f715274 100644
--- a/dump.c
+++ b/dump.c
@@ -107,7 +107,7 @@ static int fd_write_vmcore(const void *buf, size_t si=
ze, void *opaque)
=20
     written_size =3D qemu_write_full(s->fd, buf, size);
     if (written_size !=3D size) {
-        return -1;
+        return -errno;
     }
=20
     return 0;
@@ -140,7 +140,7 @@ static void write_elf64_header(DumpState *s, Error **=
errp)
=20
     ret =3D fd_write_vmcore(&elf_header, sizeof(elf_header), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write elf header");
+        error_setg_errno(errp, -ret, "dump: failed to write elf header")=
;
     }
 }
=20
@@ -171,7 +171,7 @@ static void write_elf32_header(DumpState *s, Error **=
errp)
=20
     ret =3D fd_write_vmcore(&elf_header, sizeof(elf_header), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write elf header");
+        error_setg_errno(errp, -ret, "dump: failed to write elf header")=
;
     }
 }
=20
@@ -194,7 +194,8 @@ static void write_elf64_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
=20
     ret =3D fd_write_vmcore(&phdr, sizeof(Elf64_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, -ret,
+                         "dump: failed to write program header table");
     }
 }
=20
@@ -217,7 +218,8 @@ static void write_elf32_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
=20
     ret =3D fd_write_vmcore(&phdr, sizeof(Elf32_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, -ret,
+                         "dump: failed to write program header table");
     }
 }
=20
@@ -237,7 +239,8 @@ static void write_elf64_note(DumpState *s, Error **er=
rp)
=20
     ret =3D fd_write_vmcore(&phdr, sizeof(Elf64_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, -ret,
+                         "dump: failed to write program header table");
     }
 }
=20
@@ -302,7 +305,8 @@ static void write_elf32_note(DumpState *s, Error **er=
rp)
=20
     ret =3D fd_write_vmcore(&phdr, sizeof(Elf32_Phdr), s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write program header table");
+        error_setg_errno(errp, -ret,
+                         "dump: failed to write program header table");
     }
 }
=20
@@ -355,7 +359,8 @@ static void write_elf_section(DumpState *s, int type,=
 Error **errp)
=20
     ret =3D fd_write_vmcore(&shdr, shdr_size, s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to write section header table");
+        error_setg_errno(errp, -ret,
+                         "dump: failed to write section header table");
     }
 }
=20
@@ -365,7 +370,7 @@ static void write_data(DumpState *s, void *buf, int l=
ength, Error **errp)
=20
     ret =3D fd_write_vmcore(buf, length, s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to save memory");
+        error_setg_errno(errp, -ret, "dump: failed to save memory");
     } else {
         s->written_size +=3D length;
     }
--=20
2.16.2.521.g9aa15f885a
