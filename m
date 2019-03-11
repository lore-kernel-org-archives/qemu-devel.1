Received: from eggs.gnu.org ([209.51.188.92]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6X-0000GP-Kq
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6V-0004hw-N0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6T-0004gJ-MB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CF7381F33
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:09:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B7EC60A9A
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:38 +0100
Message-Id: <20190311220843.4026-23-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/27] vl: Create block backends before setting
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qemu-system-FOO's main() acts on command line arguments in its own
idiosyncratic order.  There's not much method to its madness.
Whenever we find a case where one kind of command line argument needs
to refer to something created for another kind later, we rejigger the
order.

Block devices get created long after machine properties get processed.
Therefore, block device machine properties can be created, but not
set.  No such properties exist.  But the next commit will create some.
Time to rejigger again: create block devices earlier.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190308131445.17502-8-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 vl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index c22ca447fa..e9239d55ad 100644
--- a/vl.c
+++ b/vl.c
@@ -4274,6 +4274,13 @@ int main(int argc, char **argv, char **envp)
         exit(0);
     }
=20
+    /*
+     * Note: we need to create block backends before
+     * machine_set_property(), so machine properties can refer to
+     * them.
+     */
+    configure_blockdev(&bdo_queue, machine_class, snapshot);
+
     machine_opts =3D qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine=
,
                      &error_fatal);
@@ -4400,8 +4407,6 @@ int main(int argc, char **argv, char **envp)
     ram_mig_init();
     dirty_bitmap_mig_init();
=20
-    configure_blockdev(&bdo_queue, machine_class, snapshot);
-
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
=20
--=20
2.17.2
