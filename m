Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462ECC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B112063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B112063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyVI-00013G-BY
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jyyUS-0000DC-LK
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:16:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10548
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jyyUQ-0002AB-Pk
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:16:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06OE2RZk012496
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 10:15:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32fae1uxe4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 10:15:57 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06OE2gcn014066
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 10:15:57 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32fae1uxdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 10:15:57 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OEASCb001629;
 Fri, 24 Jul 2020 14:15:56 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02dal.us.ibm.com with ESMTP id 32brqaa5uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 14:15:55 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06OEFsF760817740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 14:15:54 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86A99136059;
 Fri, 24 Jul 2020 14:15:54 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2264E136051;
 Fri, 24 Jul 2020 14:15:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2020 14:15:53 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, philmd@redhat.com
Subject: [PATCH V2] tpm_emulator: Report an error if chardev is missing
Date: Fri, 24 Jul 2020 10:15:52 -0400
Message-Id: <20200724141552.2505990-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-24_04:2020-07-24,
 2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240105
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 10:11:31
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 armbru@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes the odd error reporting when trying to send a file
descriptor to the TPM emulator if one has not passed a valid chardev.

$ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=tpm0
qemu-system-x86_64: -tpmdev emulator,id=tpm0: tpm-emulator: Failed to send CMD_SET_DATAFD: Success
qemu-system-x86_64: -tpmdev emulator,id=tpm0: tpm-emulator: Could not cleanly shutdown the TPM: Success

This is the new error report:

$ x86_64-softmmu/qemu-system-x86_64 -tpmdev emulator,id=tpm0
qemu-system-x86_64: -tpmdev emulator,id=tpm0: tpm-emulator: parameter 'chardev' is missing

This change does not hide the display of supported TPM types if a non-existent type is passed:

$ x86_64-softmmu/qemu-system-x86_64 -tpmdev nonexistent,id=tpm0
qemu-system-x86_64: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
Supported TPM types (choose only one):
 passthrough   Passthrough TPM backend driver
    emulator   TPM emulator backend driver

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 9605339f93..a9b0f55e67 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -549,27 +549,30 @@ err_exit:
 static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
 {
     const char *value;
+    Error *err = NULL;
+    Chardev *dev;
 
     value = qemu_opt_get(opts, "chardev");
-    if (value) {
-        Error *err = NULL;
-        Chardev *dev = qemu_chr_find(value);
-
-        if (!dev) {
-            error_report("tpm-emulator: tpm chardev '%s' not found.", value);
-            goto err;
-        }
+    if (!value) {
+        error_report("tpm-emulator: parameter 'chardev' is missing");
+        goto err;
+    }
 
-        if (!qemu_chr_fe_init(&tpm_emu->ctrl_chr, dev, &err)) {
-            error_prepend(&err, "tpm-emulator: No valid chardev found at '%s':",
-                          value);
-            error_report_err(err);
-            goto err;
-        }
+    dev = qemu_chr_find(value);
+    if (!dev) {
+        error_report("tpm-emulator: tpm chardev '%s' not found", value);
+        goto err;
+    }
 
-        tpm_emu->options->chardev = g_strdup(value);
+    if (!qemu_chr_fe_init(&tpm_emu->ctrl_chr, dev, &err)) {
+        error_prepend(&err, "tpm-emulator: No valid chardev found at '%s':",
+                      value);
+        error_report_err(err);
+        goto err;
     }
 
+    tpm_emu->options->chardev = g_strdup(value);
+
     if (tpm_emulator_prepare_data_fd(tpm_emu) < 0) {
         goto err;
     }
@@ -925,6 +928,11 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
 {
     ptm_res res;
 
+    if (!tpm_emu->options->chardev) {
+        /* was never properly initialized */
+        return;
+    }
+
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0, sizeof(res)) < 0) {
         error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
                      strerror(errno));
-- 
2.24.1


