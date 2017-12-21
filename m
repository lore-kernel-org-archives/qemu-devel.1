Received: from eggs.gnu.org ([2001:4830:134:3::10]:47661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1sZ-0001GA-VB
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1sV-0007RH-Tw
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1sV-0007Pj-KK
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:19 -0500
Date: Thu, 21 Dec 2017 16:31:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-25-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/25] dump-guest-memory.py: fix "You can't do
 that without a process to debug"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

If the script is run with a core (no running process), it produces an
error:

(gdb)  dump-guest-memory /tmp/vmcore X86_64
guest RAM blocks:
target_start     target_end       host_addr        message count
---------------- ---------------- ---------------- ------- -----
0000000000000000 00000000000a0000 00007f7935800000 added       1
00000000000a0000 00000000000b0000 00007f7934200000 added       2
00000000000c0000 00000000000ca000 00007f79358c0000 added       3
00000000000ca000 00000000000cd000 00007f79358ca000 joined      3
00000000000cd000 00000000000e8000 00007f79358cd000 joined      3
00000000000e8000 00000000000f0000 00007f79358e8000 joined      3
00000000000f0000 0000000000100000 00007f79358f0000 joined      3
0000000000100000 0000000080000000 00007f7935900000 joined      3
00000000fd000000 00000000fe000000 00007f7934200000 added       4
00000000fffc0000 0000000100000000 00007f7935600000 added       5
Python Exception <class 'gdb.error'> You can't do that without a process =
to debug.:
Error occurred in Python command: You can't do that without a process
to debug.

Replace the object_resolve_path_type() function call call with a
local volatile variable.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/misc/vmcoreinfo.c         | 3 +++
 scripts/dump-guest-memory.py | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 31db57a..a280552 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -35,6 +35,8 @@ static void vmcoreinfo_realize(DeviceState *dev, Error =
**errp)
 {
     VMCoreInfoState *s =3D VMCOREINFO(dev);
     FWCfgState *fw_cfg =3D fw_cfg_find();
+    /* for gdb script dump-guest-memory.py */
+    static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
=20
     /* Given that this function is executing, there is at least one VMCO=
REINFO
      * device. Check if there are several.
@@ -56,6 +58,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Error =
**errp)
                              &s->vmcoreinfo, sizeof(s->vmcoreinfo), fals=
e);
=20
     qemu_register_reset(vmcoreinfo_reset, dev);
+    vmcoreinfo_state =3D s;
 }
=20
 static const VMStateDescription vmstate_vmcoreinfo =3D {
diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 1af26c1..09bec92 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -546,8 +546,7 @@ shape and this command should mostly work."""
         return None
=20
     def add_vmcoreinfo(self):
-        vmci =3D '(VMCoreInfoState *)' + \
-               'object_resolve_path_type("", "vmcoreinfo", 0)'
+        vmci =3D 'vmcoreinfo_realize::vmcoreinfo_state'
         if not gdb.parse_and_eval("%s" % vmci) \
            or not gdb.parse_and_eval("(%s)->has_vmcoreinfo" % vmci):
             return
--=20
MST
