Received: from eggs.gnu.org ([2001:4830:134:3::10]:39609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RB-0004GR-HS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R9-00029t-3U
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R7-000209-9j
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34353750CB
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:52:43 +0200
Message-Id: <20181015115309.17089-10-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/35] pc: Fix machine property
 nvdimm-persistence error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  pc.c's pc_machine_set_nvdimm_persistence() does that,
and then exit()s.  Wrong.  Attempting to set machine property
nvdimm-persistence to a bad value instantly kills the VM:

    $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 3}, "=
package": "v3.0.0-837-gc5e4e49258"}, "capabilities": []}}
    {"execute": "qmp_capabilities"}
    {"return": {}}
    {"execute": "qom-set", "arguments": {"path": "/machine", "property": =
"nvdimm-persistence", "value": "instadeath"}}
    -machine nvdimm-persistence=3Dinstadeath: unsupported option
    $ echo $?
    1

Broken when commit 11c39b5cd96 (v3.0.0) replaced error_propagate();
return by error_report(); exit() instead of error_setg(); return.  Fix
that.

Fixes: 11c39b5cd966ddc067a1ca0c5392ec9b666c45b7
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cd5029c149..eab8572f2a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2209,8 +2209,9 @@ static void pc_machine_set_nvdimm_persistence(Objec=
t *obj, const char *value,
     else if (strcmp(value, "mem-ctrl") =3D=3D 0)
         nvdimm_state->persistence =3D 2;
     else {
-        error_report("-machine nvdimm-persistence=3D%s: unsupported opti=
on", value);
-        exit(EXIT_FAILURE);
+        error_setg(errp, "-machine nvdimm-persistence=3D%s: unsupported =
option",
+                   value);
+        return;
     }
=20
     g_free(nvdimm_state->persistence_string);
--=20
2.17.1
