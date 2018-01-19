Received: from eggs.gnu.org ([2001:4830:134:3::10]:56676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXOK-0008Hn-CN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXOH-0004sz-Ad
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ecXOH-0004sb-5S
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Jan 2018 15:11:04 +0100
Message-Id: <20180119141105.29095-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180119141105.29095-1-marcandre.lureau@redhat.com>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/5] tpm: extend TPM CRB with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

We need to synchronize with the backend thread to make sure that a comman=
d
being processed by the external TPM emulator has completed and its
response been received. In case the bottom half did not run, we run the
function it is supposed to run.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
[ Marc-Andr=C3=A9 - drop memory_region_get_ram_ptr(cmdmem) copy as it
  should be migrated already ]
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 908ca18d92..63d53384c5 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -257,9 +257,39 @@ static enum TPMVersion tpm_crb_get_version(TPMIf *ti=
)
     return tpm_backend_get_tpm_version(s->tpmbe);
 }
=20
+/* persistent state handling */
+
+static int tpm_crb_pre_save(void *opaque)
+{
+    CRBState *s =3D opaque;
+
+    tpm_backend_finish_sync(s->tpmbe);
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_tpm_crb =3D {
     .name =3D "tpm-crb",
-    .unmigratable =3D 1,
+    .pre_save  =3D tpm_crb_pre_save,
+    .fields      =3D (VMStateField[]) {
+        VMSTATE_UINT32(regs.loc_state.reg, CRBState),
+        VMSTATE_UINT32(regs.loc_ctrl, CRBState),
+        VMSTATE_UINT32(regs.loc_sts.reg, CRBState),
+        VMSTATE_UINT64(regs.intf_id.reg, CRBState),
+        VMSTATE_UINT64(regs.ctrl_ext, CRBState),
+        VMSTATE_UINT32(regs.ctrl_req, CRBState),
+        VMSTATE_UINT32(regs.ctrl_sts.reg, CRBState),
+        VMSTATE_UINT32(regs.ctrl_cancel, CRBState),
+        VMSTATE_UINT32(regs.ctrl_start, CRBState),
+        VMSTATE_UINT32(regs.ctrl_int_enable, CRBState),
+        VMSTATE_UINT32(regs.ctrl_int_sts, CRBState),
+        VMSTATE_UINT32(regs.ctrl_cmd_size, CRBState),
+        VMSTATE_UINT32(regs.ctrl_cmd_pa_low, CRBState),
+        VMSTATE_UINT32(regs.ctrl_rsp_size, CRBState),
+        VMSTATE_UINT64(regs.ctrl_rsp_pa, CRBState),
+
+        VMSTATE_END_OF_LIST(),
+    }
 };
=20
 static Property tpm_crb_properties[] =3D {
--=20
2.16.0.rc1.1.gef27df75a1
