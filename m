Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE27C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2B320815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2B320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTkh-0001zz-4B
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsd-000232-An
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0002ZW-Lv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12646
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsE-0001im-E6; Tue, 01 Oct 2019 19:48:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlUAk179530; Tue, 1 Oct 2019 19:47:44 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpncx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:44 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlKq027161;
 Tue, 1 Oct 2019 23:47:43 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:43 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlggO45023722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:43 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2E6228059;
 Tue,  1 Oct 2019 23:47:42 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C695C2805A;
 Tue,  1 Oct 2019 23:47:42 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:42 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 57/97] tpm_emulator: Translate TPM error codes to strings
Date: Tue,  1 Oct 2019 18:45:36 -0500
Message-Id: <20191001234616.7825-58-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x91NlUAk179530
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-stable@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Implement a function to translate TPM error codes to strings so that
at least the most common error codes can be translated to human
readable strings.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 7e095e84ba0b7c0a1ac45bc6824dace2fd352e56)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c | 60 +++++++++++++++++++++++++++++++++++--------
 hw/tpm/tpm_int.h      | 13 ++++++++++
 2 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 70f4b10284..58894dc320 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -81,6 +81,40 @@ typedef struct TPMEmulator {
     TPMBlobBuffers state_blobs;
 } TPMEmulator;
=20
+struct tpm_error {
+    uint32_t tpm_result;
+    const char *string;
+};
+
+static const struct tpm_error tpm_errors[] =3D {
+    /* TPM 1.2 error codes */
+    { TPM_BAD_PARAMETER   , "a parameter is bad" },
+    { TPM_FAIL            , "operation failed" },
+    { TPM_KEYNOTFOUND     , "key could not be found" },
+    { TPM_BAD_PARAM_SIZE  , "bad parameter size"},
+    { TPM_ENCRYPT_ERROR   , "encryption error" },
+    { TPM_DECRYPT_ERROR   , "decryption error" },
+    { TPM_BAD_KEY_PROPERTY, "bad key property" },
+    { TPM_BAD_MODE        , "bad (encryption) mode" },
+    { TPM_BAD_VERSION     , "bad version identifier" },
+    { TPM_BAD_LOCALITY    , "bad locality" },
+    /* TPM 2 error codes */
+    { TPM_RC_FAILURE     , "operation failed" },
+    { TPM_RC_LOCALITY    , "bad locality"     },
+    { TPM_RC_INSUFFICIENT, "insufficient amount of data" },
+};
+
+static const char *tpm_emulator_strerror(uint32_t tpm_result)
+{
+    size_t i;
+
+    for (i =3D 0; i < ARRAY_SIZE(tpm_errors); i++) {
+        if (tpm_errors[i].tpm_result =3D=3D tpm_result) {
+            return tpm_errors[i].string;
+        }
+    }
+    return "";
+}
=20
 static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, voi=
d *msg,
                                 size_t msg_len_in, size_t msg_len_out)
@@ -263,7 +297,8 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb)
=20
     res =3D be32_to_cpu(res);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x", res)=
;
+        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", r=
es,
+                     tpm_emulator_strerror(res));
         return -1;
     }
=20
@@ -292,8 +327,9 @@ static int tpm_emulator_set_buffer_size(TPMBackend *t=
b,
=20
     psbs.u.resp.tpm_result =3D be32_to_cpu(psbs.u.resp.tpm_result);
     if (psbs.u.resp.tpm_result !=3D 0) {
-        error_report("tpm-emulator: TPM result for set buffer size : 0x%=
x",
-                     psbs.u.resp.tpm_result);
+        error_report("tpm-emulator: TPM result for set buffer size : 0x%=
x %s",
+                     psbs.u.resp.tpm_result,
+                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
         return -1;
     }
=20
@@ -338,7 +374,8 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend=
 *tb, size_t buffersize,
=20
     res =3D be32_to_cpu(init.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res)=
;
+        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", r=
es,
+                     tpm_emulator_strerror(res));
         goto err_exit;
     }
     return 0;
@@ -398,8 +435,9 @@ static int tpm_emulator_reset_tpm_established_flag(TP=
MBackend *tb,
=20
     res =3D be32_to_cpu(reset_est.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for rest establixhed flag=
: 0x%x",
-                     res);
+        error_report(
+            "tpm-emulator: TPM result for rest established flag: 0x%x %s=
",
+            res, tpm_emulator_strerror(res));
         return -1;
     }
=20
@@ -637,7 +675,8 @@ static int tpm_emulator_get_state_blob(TPMEmulator *t=
pm_emu,
     res =3D be32_to_cpu(pgs.u.resp.tpm_result);
     if (res !=3D 0 && (res & 0x800) =3D=3D 0) {
         error_report("tpm-emulator: Getting the stateblob (type %d) fail=
ed "
-                     "with a TPM error 0x%x", type, res);
+                     "with a TPM error 0x%x %s", type, res,
+                     tpm_emulator_strerror(res));
         return -1;
     }
=20
@@ -757,7 +796,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *t=
pm_emu,
     tpm_result =3D be32_to_cpu(pss.u.resp.tpm_result);
     if (tpm_result !=3D 0) {
         error_report("tpm-emulator: Setting the stateblob (type %d) fail=
ed "
-                     "with a TPM error 0x%x", type, tpm_result);
+                     "with a TPM error 0x%x %s", type, tpm_result,
+                     tpm_emulator_strerror(tpm_result));
         return -1;
     }
=20
@@ -887,8 +927,8 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_em=
u)
         error_report("tpm-emulator: Could not cleanly shutdown the TPM: =
%s",
                      strerror(errno));
     } else if (res !=3D 0) {
-        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
-                     be32_to_cpu(res));
+        error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
+                     be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu=
(res)));
     }
 }
=20
diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index a4c77fbd7e..3fb28a9d6c 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -39,7 +39,16 @@ struct tpm_resp_hdr {
 #define TPM_TAG_RSP_AUTH1_COMMAND 0xc5
 #define TPM_TAG_RSP_AUTH2_COMMAND 0xc6
=20
+#define TPM_BAD_PARAMETER         3
 #define TPM_FAIL                  9
+#define TPM_KEYNOTFOUND           13
+#define TPM_BAD_PARAM_SIZE        25
+#define TPM_ENCRYPT_ERROR         32
+#define TPM_DECRYPT_ERROR         33
+#define TPM_BAD_KEY_PROPERTY      40
+#define TPM_BAD_MODE              44
+#define TPM_BAD_VERSION           46
+#define TPM_BAD_LOCALITY          61
=20
 #define TPM_ORD_ContinueSelfTest  0x53
 #define TPM_ORD_GetTicks          0xf1
@@ -59,4 +68,8 @@ struct tpm_resp_hdr {
=20
 #define TPM2_PT_MAX_COMMAND_SIZE  0x11e
=20
+#define TPM_RC_INSUFFICIENT       0x9a
+#define TPM_RC_FAILURE            0x101
+#define TPM_RC_LOCALITY           0x907
+
 #endif /* TPM_TPM_INT_H */
--=20
2.17.1


