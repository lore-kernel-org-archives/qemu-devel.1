Received: from eggs.gnu.org ([2001:4830:134:3::10]:60930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09KM-0006dT-U0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09KI-0001lm-0s
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49760
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e09KH-0001lN-Rw
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95Gim1K119865
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 12:48:41 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ddr6w19m5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:48:41 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 12:48:40 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  5 Oct 2017 12:48:23 -0400
In-Reply-To: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507222112-20315-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 01/10] tpm-backend: Remove unneeded member
 variable from backend class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Amarnath Valluri <amarnath.valluri@intel.com>

TPMDriverOps inside TPMBackend is not required, as it is supposed to be a=
 class
member. The only possible reason for keeping in TPMBackend was, to get th=
e
backend type in tpm.c where dedicated backend api, tpm_backend_get_type()=
 is
present.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c     | 4 ----
 include/sysemu/tpm_backend.h | 1 -
 tpm.c                        | 2 +-
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 9234eb3..a0baf5f 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -46,8 +46,6 @@
 #define TPM_PASSTHROUGH(obj) \
     OBJECT_CHECK(TPMPassthruState, (obj), TYPE_TPM_PASSTHROUGH)
=20
-static const TPMDriverOps tpm_passthrough_driver;
-
 /* data structures */
 typedef struct TPMPassthruThreadParams {
     TPMState *tpm_state;
@@ -462,8 +460,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *o=
pts, const char *id)
     /* let frontend set the fe_model to proper value */
     tb->fe_model =3D -1;
=20
-    tb->ops =3D &tpm_passthrough_driver;
-
     if (tpm_passthrough_handle_device_opts(opts, tb)) {
         goto err_exit;
     }
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index b0a9731..3708413 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -50,7 +50,6 @@ struct TPMBackend {
     enum TpmModel fe_model;
     char *path;
     char *cancel_path;
-    const TPMDriverOps *ops;
=20
     QLIST_ENTRY(TPMBackend) list;
 };
diff --git a/tpm.c b/tpm.c
index 2d830d0..abedf3f 100644
--- a/tpm.c
+++ b/tpm.c
@@ -211,7 +211,7 @@ static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
     res->model =3D drv->fe_model;
     res->options =3D g_new0(TpmTypeOptions, 1);
=20
-    switch (drv->ops->type) {
+    switch (tpm_backend_get_type(drv)) {
     case TPM_TYPE_PASSTHROUGH:
         res->options->type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
         tpo =3D g_new0(TPMPassthroughOptions, 1);
--=20
2.5.5
