Received: from eggs.gnu.org ([2001:4830:134:3::10]:59604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ehBIm-0001DM-Dl
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ehBIc-0003MR-Qp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:37:04 -0500
Received: from ozlabs.ru ([107.173.13.209]:48826)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ehBIc-0003Ly-IM
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:36:54 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  1 Feb 2018 20:36:51 +1100
Message-Id: <20180201093651.33801-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu] slirp: Update forwarding IP address
 if guest receiver non-default IP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

If we run QEMU with -netdev user,id=USER0,hostfwd=tcp::2222-:22, it starts
a DHCP server and starts allocating client IPs from 10.0.2.15 so
this is what the guest normally receives. Since QEMU automatically adds
the DHCP starting address into the forwarding table, everything works.
This is the table before guest started:

(qemu) info usernet
VLAN -1 (USER0):
  Protocol[State]    FD  Source Address  Port   Dest. Address  Port RecvQ SendQ
  TCP[HOST_FORWARD]  11               *  2222       10.0.2.15    22     0     0

However if the guest happens to have DHCP lease (for example, 10.0.2.16),
the forwarding stops working. The guest can still reach the outer world
(which is expected).

This updates the forwarding table when QEMU confirms the requested IP
to the guest.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Does this look any useful?

Sure I can remove /var/lib/dhcp/dhclient.enp0s1.leases in the guest or
start QEMU with the DHCP start address equal to what the guest wants to
reserve but it is quite confusing why such a simple config just does not
work.

Found this with the brand new Ubuntu 17.10 which runs dhcp and something
called "netplan" and the guest ends up with 2 IPs from 10.0.2.x network.
After disabling netplan, the lease remains and it is not 10.0.2.15 but
rather .16 or .17.

Comments? Thanks.

---
 slirp/libslirp.h |  2 ++
 slirp/bootp.c    |  2 ++
 slirp/slirp.c    | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 540b3e5..6779081 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -33,6 +33,8 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp,
                       struct in_addr guest_addr, int guest_port);
 int slirp_remove_hostfwd(Slirp *slirp, int is_udp,
                          struct in_addr host_addr, int host_port);
+void slirp_update_hostfwd(Slirp *slirp, struct in_addr old_guest_addr,
+                          struct in_addr new_guest_addr);
 int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
                    struct in_addr *guest_addr, int guest_port);
 
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 5dd1a41..5876004 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -225,6 +225,8 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
     /* Update ARP table for this IP address */
     arp_table_add(slirp, daddr.sin_addr.s_addr, client_ethaddr);
 
+    slirp_update_hostfwd(slirp, slirp->vdhcp_startaddr, daddr.sin_addr);
+
     saddr.sin_addr = slirp->vhost_addr;
     saddr.sin_port = htons(BOOTP_SERVER);
 
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 1cb6b07..a9d8a16 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1061,6 +1061,33 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp, struct in_addr host_addr,
     return 0;
 }
 
+static void slirp_do_update_hostfwd(Slirp *slirp, struct socket *head,
+                                    struct in_addr old_guest_addr,
+                                    struct in_addr new_guest_addr)
+{
+    struct socket *so;
+    char oldaddr[17], newaddr[17];
+
+    for (so = head->so_next; so != head; so = so->so_next) {
+        if ((so->so_state & SS_HOSTFWD) &&
+            so->lhost.sin.sin_addr.s_addr == old_guest_addr.s_addr) {
+            strncpy(oldaddr, inet_ntoa(old_guest_addr), sizeof(oldaddr) - 1);
+            strncpy(newaddr, inet_ntoa(new_guest_addr), sizeof(newaddr) - 1);
+            DEBUG_ARGS((dfd, "Updating forwarding from %s:%d to %s:%d\n",
+                       oldaddr, ntohs(so->lhost.sin.sin_port),
+                       newaddr, ntohs(so->lhost.sin.sin_port)));
+            so->lhost.sin.sin_addr = new_guest_addr;
+        }
+    }
+}
+
+void slirp_update_hostfwd(Slirp *slirp, struct in_addr old_guest_addr,
+                          struct in_addr new_guest_addr)
+{
+    slirp_do_update_hostfwd(slirp, &slirp->udb, old_guest_addr, new_guest_addr);
+    slirp_do_update_hostfwd(slirp, &slirp->tcb, old_guest_addr, new_guest_addr);
+}
+
 int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
                    struct in_addr *guest_addr, int guest_port)
 {
-- 
2.11.0
