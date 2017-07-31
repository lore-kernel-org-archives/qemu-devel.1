Received: from eggs.gnu.org ([2001:4830:134:3::10]:53102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7ur-0007q5-2H
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7uo-0001zl-Gz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:27:13 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:35 +0300
Message-Id: <6860710cc3864382a898c847d722f950b5e01a6e.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/25] syscall: fix use of uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

linux-user/syscall.c:1627:35: warning: 1st function call argument is an u=
ninitialized value
        target_saddr->sa_family =3D tswap16(addr->sa_family);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~
linux-user/syscall.c:1629:25: warning: The left operand of '=3D=3D' is a =
garbage value
    if (addr->sa_family =3D=3D AF_NETLINK && len >=3D sizeof(struct socka=
ddr_nl)) {
        ~~~~~~~~~~~~~~~ ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 71d45a9963..81f52f7483 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1622,6 +1622,7 @@ static inline abi_long host_to_target_sockaddr(abi_=
ulong target_addr,
     if (len =3D=3D 0) {
         return 0;
     }
+    assert(addr);
=20
     target_saddr =3D lock_user(VERIFY_WRITE, target_addr, len, 0);
     if (!target_saddr)
--=20
2.11.0
