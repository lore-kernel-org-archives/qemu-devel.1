Received: from eggs.gnu.org ([2001:4830:134:3::10]:45548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zl-000689-53
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zk-0007Ho-B3
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:17 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:44 +0200
Message-Id: <20170403153355.19722-5-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] io vnc sockets: Clean up
 SocketAddressKind switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Markus Armbruster <armbru@redhat.com>

We have quite a few switches over SocketAddressKind.  Some have case
labels for all enumeration values, others rely on a default label.
Some abort when the value isn't a valid SocketAddressKind, others
report an error then.

Unify as follows.  Always provide case labels for all enumeration
values, to clarify intent.  Abort when the value isn't a valid
SocketAddressKind, because the program state is messed up then.

Improve a few error messages while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 1490895797-29094-4-git-send-email-armbru@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 io/dns-resolver.c   |  7 +++++--
 ui/vnc.c            | 18 ++++++++++++------
 util/qemu-sockets.c |  4 +---
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 0ac6b23c02..a407075934 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -164,9 +164,12 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
                                                 addrs,
                                                 errp);
 
-    default:
-        error_setg(errp, "Unknown socket address kind");
+    case SOCKET_ADDRESS_KIND_FD:
+        error_setg(errp, "Unsupported socket address type 'fd'");
         return -1;
+
+    default:
+        abort();
     }
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 1095f9de68..349cfc9d86 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -129,10 +129,13 @@ static void vnc_init_basic_info(SocketAddress *addr,
         info->family = NETWORK_ADDRESS_FAMILY_UNIX;
         break;
 
-    default:
-        error_setg(errp, "Unsupported socket kind %d",
-                   addr->type);
+    case SOCKET_ADDRESS_KIND_VSOCK:
+    case SOCKET_ADDRESS_KIND_FD:
+        error_setg(errp, "Unsupported socket address type %s",
+                   SocketAddressKind_lookup[addr->type]);
         break;
+    default:
+        abort();
     }
 
     return;
@@ -411,10 +414,13 @@ VncInfo *qmp_query_vnc(Error **errp)
             info->family = NETWORK_ADDRESS_FAMILY_UNIX;
             break;
 
-        default:
-            error_setg(errp, "Unsupported socket kind %d",
-                       addr->type);
+        case SOCKET_ADDRESS_KIND_VSOCK:
+        case SOCKET_ADDRESS_KIND_FD:
+            error_setg(errp, "Unsupported socket address type %s",
+                       SocketAddressKind_lookup[addr->type]);
             goto out_error;
+        default:
+            abort();
         }
 
         info->has_host = true;
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 9b7368113c..4ae37bd2a2 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1337,9 +1337,7 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
         break;
 
     default:
-        error_setg(errp, "socket family %d unsupported",
-                   addr->type);
-        return NULL;
+        abort();
     }
     return buf;
 }
-- 
2.12.1
