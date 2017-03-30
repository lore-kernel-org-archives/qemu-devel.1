Received: from eggs.gnu.org ([2001:4830:134:3::10]:35458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cte6Z-0004RH-Kj
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cte6Y-00032D-PU
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:43:27 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 19:43:10 +0200
Message-Id: <1490895797-29094-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490895797-29094-1-git-send-email-armbru@redhat.com>
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 for-2.9 2/9] char: Fix socket with "type":
 "vsock" address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Watch this:

    $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 91, "minor": 8, "major": 2}, "=
package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
    { "execute": "qmp_capabilities" }
    {"return": {}}
    { "execute": "chardev-add", "arguments": { "id": "chr0", "backend": {=
 "type": "socket", "data": { "addr": { "type": "vsock", "data": { "cid": =
"CID", "port": "P" }}}}}}
    Aborted (core dumped)

Crashes because SocketAddress_to_str() is blissfully unaware of
SOCKET_ADDRESS_KIND_VSOCK.  Fix that.  Pick the output format to match
socket_parse(), just like the existing formats.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 chardev/char-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6344b07..36ab0d6 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -357,6 +357,10 @@ static char *SocketAddress_to_str(const char *prefix=
, SocketAddress *addr,
         return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->str=
,
                                is_listen ? ",server" : "");
         break;
+    case SOCKET_ADDRESS_KIND_VSOCK:
+        return g_strdup_printf("%svsock:%s:%s", prefix,
+                               addr->u.vsock.data->cid,
+                               addr->u.vsock.data->port);
     default:
         abort();
     }
--=20
2.7.4
