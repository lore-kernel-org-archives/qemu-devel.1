Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E059C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF8220693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BXXiFggY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF8220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJAs-0005vg-73
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7S-0001ci-03
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7P-0002Wv-Pp
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:13 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7P-0002MZ-GP
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBRuuIDMFB8q3Dva7DMtm5N6syGItNt052ObYFIMgV4=;
 b=BXXiFggYdHNWF6/aHVavehXBPVUrlIh24+U05CZNL3G8bMDXYaSg7Tpp+UvNSq/6WtE4RaFLfkkI5VDmqiNcDw2bGGdyC7St45L7O2z7LexzxfyP0LUTR1KoiULJdOr/obFaB7FASI/4CbfEDpaJ7xOGHZcvBbCzgAQWCInLcRU=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:08 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:08 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 09/13] target/i386: sev: add support to encrypt the
 outgoing page
Thread-Index: AQHVN11IaqK7FcbkLkWZ1Xb4sWP7gA==
Date: Wed, 10 Jul 2019 20:23:07 +0000
Message-ID: <20190710202219.25939-10-brijesh.singh@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
In-Reply-To: <20190710202219.25939-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:0:54::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce43dbf9-d231-4d43-f3ed-08d705746b58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB382023666FBA922CE8FA1F34E5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:214;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(14444005)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(4326008)(66476007)(66946007)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D50bmLQtV3ASBpsX78JDbXgwbNSA6g9pQj7Y/+quu43XheXZl0wdxHDkQpfx2JejJYLB6fcRvpG7NMkTmJNI/My/gNl8lp9XdYOpzkVC8F1QvKYw+Vy/CDwY5IZah3j/2vOL/jrjd3vLBLSi97RcVcUt2JGYHQzIV1o+GxtQFazMZluuvCPowxOJ3eBBxXCP/0X6iaE696TzNgd4WMT40yhc70H2Arw+mQDU16tIUTBNc3chUV2fIthlfDRqfnxQDBLoqoat7mMPXpeXvSHMeCidD2oHtGeeQGyrhelF1r1ZUIVlwpFxs6UdNl0iipW0fGl3oux0RfMA252mr0ybs+e4416eeGZjXJUbe12h2Mt/VNeg1mPvcIGPGiRe2ggbGin7OQyIwjk+4l0TemoqcBdm5GGe1fDtHyETGTOEONo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce43dbf9-d231-4d43-f3ed-08d705746b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:07.2980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 09/13] target/i386: sev: add support to
 encrypt the outgoing page
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sev_save_outgoing_page() provide the implementation to encrypt the
guest private pages during the transit. The routines uses the SEND_START
command to create the outgoing encryption context on the first call then
uses the SEND_UPDATE_DATA command to encrypt the data before writing it
to the socket. While encrypting the data SEND_UPDATE_DATA produces some
metadata (e.g MAC, IV). The metadata is also sent to the target machine.
After migration is completed, we issue the SEND_FINISH command to transitio=
n
the SEV guest state from sending to unrunnable state.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |   1 +
 target/i386/sev.c        | 229 +++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h   |   2 +
 target/i386/trace-events |   3 +
 4 files changed, 235 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c935e9366c..a9fb447248 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1792,6 +1792,7 @@ static int kvm_init(MachineState *ms)
         }
=20
         kvm_state->memcrypt_encrypt_data =3D sev_encrypt_data;
+        kvm_state->memcrypt_save_outgoing_page =3D sev_save_outgoing_page;
     }
=20
     ret =3D kvm_arch_init(ms, s);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6c902d0be8..28b36c8035 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -27,6 +27,8 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file.h"
+#include "migration/misc.h"
=20
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
@@ -718,6 +720,39 @@ sev_vm_state_change(void *opaque, int running, RunStat=
e state)
     }
 }
=20
+static void
+sev_send_finish(void)
+{
+    int ret, error;
+
+    trace_kvm_sev_send_finish();
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_FINISH, 0, &error);
+    if (ret) {
+        error_report("%s: LAUNCH_FINISH ret=3D%d fw_error=3D%d '%s'",
+                     __func__, ret, error, fw_error_to_str(error));
+    }
+
+    sev_set_guest_state(SEV_STATE_RUNNING);
+}
+
+static void
+sev_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s =3D data;
+
+    if (migration_has_finished(s) ||
+        migration_in_postcopy_after_devices(s) ||
+        migration_has_failed(s)) {
+        if (sev_check_state(SEV_STATE_SEND_UPDATE)) {
+            sev_send_finish();
+        }
+    }
+}
+
+static Notifier sev_migration_state_notify =3D {
+    .notify =3D sev_migration_state_notifier,
+};
+
 void *
 sev_guest_init(const char *id)
 {
@@ -804,6 +839,7 @@ sev_guest_init(const char *id)
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     qemu_add_vm_change_state_handler(sev_vm_state_change, s);
+    add_migration_state_change_notifier(&sev_migration_state_notify);
=20
     return s;
 err:
@@ -836,6 +872,199 @@ void sev_set_migrate_info(const char *pdh, const char=
 *plat_cert,
     s->amd_cert =3D g_base64_decode(amd_cert, &s->amd_cert_len);
 }
=20
+static int
+sev_get_send_session_length(void)
+{
+    int ret, fw_err =3D 0;
+    struct kvm_sev_send_start *start;
+
+    start =3D g_new0(struct kvm_sev_send_start, 1);
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_START, start, &fw_er=
r);
+    if (fw_err !=3D SEV_RET_INVALID_LEN) {
+        ret =3D -1;
+        error_report("%s: failed to get session length ret=3D%d fw_error=
=3D%d '%s'",
+                     __func__, ret, fw_err, fw_error_to_str(fw_err));
+        goto err;
+    }
+
+    ret =3D start->session_len;
+err:
+    g_free(start);
+    return ret;
+}
+
+static int
+sev_send_start(SEVState *s, QEMUFile *f, uint64_t *bytes_sent)
+{
+    gsize pdh_len =3D 0, plat_cert_len;
+    int session_len, ret, fw_error;
+    struct kvm_sev_send_start *start;
+    guchar *pdh =3D NULL, *plat_cert =3D NULL, *session =3D NULL;
+
+    if (!s->remote_pdh || !s->remote_plat_cert) {
+        error_report("%s: missing remote PDH or PLAT_CERT", __func__);
+        return 1;
+    }
+
+    start =3D g_new0(struct kvm_sev_send_start, 1);
+
+    start->pdh_cert_uaddr =3D (unsigned long) s->remote_pdh;
+    start->pdh_cert_len =3D s->remote_pdh_len;
+
+    start->plat_cert_uaddr =3D (unsigned long)s->remote_plat_cert;
+    start->plat_cert_len =3D s->remote_plat_cert_len;
+
+    start->amd_cert_uaddr =3D (unsigned long)s->amd_cert;
+    start->amd_cert_len =3D s->amd_cert_len;
+
+    /* get the session length */
+    session_len =3D sev_get_send_session_length();
+    if (session_len < 0) {
+        ret =3D 1;
+        goto err;
+    }
+
+    session =3D g_new0(guchar, session_len);
+    start->session_uaddr =3D (unsigned long)session;
+    start->session_len =3D session_len;
+
+    /* Get our PDH certificate */
+    ret =3D sev_get_pdh_info(s->sev_fd, &pdh, &pdh_len,
+                           &plat_cert, &plat_cert_len);
+    if (ret) {
+        error_report("Failed to get our PDH cert");
+        goto err;
+    }
+
+    trace_kvm_sev_send_start(start->pdh_cert_uaddr, start->pdh_cert_len,
+                             start->plat_cert_uaddr, start->plat_cert_len,
+                             start->amd_cert_uaddr, start->amd_cert_len);
+
+    ret =3D sev_ioctl(s->sev_fd, KVM_SEV_SEND_START, start, &fw_error);
+    if (ret < 0) {
+        error_report("%s: SEND_START ret=3D%d fw_error=3D%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    qemu_put_be32(f, start->policy);
+    qemu_put_be32(f, pdh_len);
+    qemu_put_buffer(f, (uint8_t *)pdh, pdh_len);
+    qemu_put_be32(f, start->session_len);
+    qemu_put_buffer(f, (uint8_t *)start->session_uaddr, start->session_len=
);
+    *bytes_sent =3D 12 + pdh_len + start->session_len;
+
+    sev_set_guest_state(SEV_STATE_SEND_UPDATE);
+
+err:
+    g_free(start);
+    g_free(pdh);
+    g_free(plat_cert);
+    return ret;
+}
+
+static int
+sev_send_get_packet_len(int *fw_err)
+{
+    int ret;
+    struct kvm_sev_send_update_data *update;
+
+    update =3D g_malloc0(sizeof(*update));
+    if (!update) {
+        return -1;
+    }
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_UPDATE_DATA, update,=
 fw_err);
+    if (*fw_err !=3D SEV_RET_INVALID_LEN) {
+        ret =3D -1;
+        error_report("%s: failed to get session length ret=3D%d fw_error=
=3D%d '%s'",
+                    __func__, ret, *fw_err, fw_error_to_str(*fw_err));
+        goto err;
+    }
+
+    ret =3D update->hdr_len;
+
+err:
+    g_free(update);
+    return ret;
+}
+
+static int
+sev_send_update_data(SEVState *s, QEMUFile *f, uint8_t *ptr, uint32_t size=
,
+                     uint64_t *bytes_sent)
+{
+    int ret, fw_error;
+    guchar *trans;
+    struct kvm_sev_send_update_data *update;
+
+    /* If this is first call then query the packet header bytes and alloca=
te
+     * the packet buffer.
+     */
+    if (!s->send_packet_hdr) {
+        s->send_packet_hdr_len =3D sev_send_get_packet_len(&fw_error);
+        if (s->send_packet_hdr_len < 1) {
+            error_report("%s: SEND_UPDATE fw_error=3D%d '%s'",
+                    __func__, fw_error, fw_error_to_str(fw_error));
+            return 1;
+        }
+
+        s->send_packet_hdr =3D g_new(gchar, s->send_packet_hdr_len);
+    }
+
+    update =3D g_new0(struct kvm_sev_send_update_data, 1);
+
+    /* allocate transport buffer */
+    trans =3D g_new(guchar, size);
+
+    update->hdr_uaddr =3D (unsigned long)s->send_packet_hdr;
+    update->hdr_len =3D s->send_packet_hdr_len;
+    update->guest_uaddr =3D (unsigned long)ptr;
+    update->guest_len =3D size;
+    update->trans_uaddr =3D (unsigned long)trans;
+    update->trans_len =3D size;
+
+    trace_kvm_sev_send_update_data(ptr, trans, size);
+
+    ret =3D sev_ioctl(s->sev_fd, KVM_SEV_SEND_UPDATE_DATA, update, &fw_err=
or);
+    if (ret) {
+        error_report("%s: SEND_UPDATE_DATA ret=3D%d fw_error=3D%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    qemu_put_be32(f, update->hdr_len);
+    qemu_put_buffer(f, (uint8_t *)update->hdr_uaddr, update->hdr_len);
+    *bytes_sent =3D 4 + update->hdr_len;
+
+    qemu_put_be32(f, update->trans_len);
+    qemu_put_buffer(f, (uint8_t *)update->trans_uaddr, update->trans_len);
+    *bytes_sent +=3D (4 + update->trans_len);
+
+err:
+    g_free(trans);
+    g_free(update);
+    return ret;
+}
+
+int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
+                           uint32_t sz, uint64_t *bytes_sent)
+{
+    SEVState *s =3D sev_state;
+
+    /*
+     * If this is a first buffer then create outgoing encryption context
+     * and write our PDH, policy and session data.
+     */
+    if (!sev_check_state(SEV_STATE_SEND_UPDATE) &&
+        sev_send_start(s, f, bytes_sent)) {
+        error_report("Failed to create outgoing context");
+        return 1;
+    }
+
+    return sev_send_update_data(s, f, ptr, sz, bytes_sent);
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 3f3449b346..2fdca5190d 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -88,6 +88,8 @@ struct SEVState {
     size_t remote_plat_cert_len;
     guchar *amd_cert;
     size_t amd_cert_len;
+    gchar *send_packet_hdr;
+    size_t send_packet_hdr_len;
 };
=20
 typedef struct SEVState SEVState;
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 789c700d4a..b41516cf9f 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -15,3 +15,6 @@ kvm_sev_launch_start(int policy, void *session, void *pdh=
) "policy 0x%x session
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRI=
u64
 kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
+kvm_sev_send_start(uint64_t pdh, int l1, uint64_t plat, int l2, uint64_t a=
md, int l3) "pdh 0x%" PRIx64 " len %d plat 0x%" PRIx64 " len %d amd 0x%" PR=
Ix64 " len %d"
+kvm_sev_send_update_data(void *src, void *dst, int len) "guest %p trans %p=
 len %d"
+kvm_sev_send_finish(void) ""
--=20
2.17.1


