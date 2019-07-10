Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304F5C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF50208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NnVMfFyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF50208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJHW-0005Iz-8i
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7S-0001cg-01
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7Q-0002XR-7s
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:13 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7Q-0002MZ-0B
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgwBKSesx8nNb/GpifaMtqM9wXT9opm01pUp8M3qvcY=;
 b=NnVMfFyr0QIjLH7h1BjFw5sFuUO0OkkFf5yR0iGZC8ImdZhDmUD5csyvPj2f8z/w1gJmsOMQK1JvgdP50L7mYVRob3g141LXTJi/NHgOdZkeZm2wxEPn/wEvuwoWHcmTbip0dw6kdjCxeSLG7TsLP4sUAhvZSvsZi2Xp9AbWeMU=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:09 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:09 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 10/13] target/i386: sev: add support to load incoming
 encrypted page
Thread-Index: AQHVN11Ji+wliLaTF0elg6lb5gX0sg==
Date: Wed, 10 Jul 2019 20:23:07 +0000
Message-ID: <20190710202219.25939-11-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 32fd1439-a55b-404f-c238-08d705746bb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB38205F07568D65F383247D81E5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(14444005)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(4326008)(66476007)(66946007)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 08gmRQfJp2ynmBEA8ZmI/1Jq1FWCBQ6PYNeJTEiWJF16b8fO42tOMVX8fKnSp7E8dI7xLx4VW4gkxEnk7medwLzpuAIrZ4moLxSnMsvJK3iKKtqHmfEWykIewLpQHy8m+28fTmzBl4+7Gpa8fs4+yhwxkR2D+kBg2znzvXbefV/Cmg1Cj9ic/phL9iNfEdx4L0cTv2fbDRHaQLplTfUgO3oTaUclDXymd5PFWzJ3nBgMJDyykNcwX1PsuilBX7ROD9VhO1besqtuh6ojKBLyTNw3rBDHYiJ9j5nHvrvGA2xIZ9u+1NheNGtA2yM1CF5ZDKc/BOSRIA8e2/pJzYBX4DL2XEjLLzvF6d2y2Zv5KHoixaF1VnQEWjIaeukD4AtnS0djoUsMbMkgbaabxAZa75Sx4iJmNzXzevRac1uZpWM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd1439-a55b-404f-c238-08d705746bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:07.9127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 10/13] target/i386: sev: add support to load
 incoming encrypted page
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

The sev_load_incoming_page() provide the implementation to read the
incoming guest private pages from the socket and load it into the guest
memory. The routines uses the RECEIVE_START command to create the
incoming encryption context on the first call then uses the
RECEIEVE_UPDATE_DATA command to load the encrypted pages into the guest
memory. After migration is completed, we issue the RECEIVE_FINISH command
to transition the SEV guest to the runnable state so that it can be
executed.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |   1 +
 target/i386/sev.c        | 126 ++++++++++++++++++++++++++++++++++++++-
 target/i386/trace-events |   3 +
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a9fb447248..7f94dba6f9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1793,6 +1793,7 @@ static int kvm_init(MachineState *ms)
=20
         kvm_state->memcrypt_encrypt_data =3D sev_encrypt_data;
         kvm_state->memcrypt_save_outgoing_page =3D sev_save_outgoing_page;
+        kvm_state->memcrypt_load_incoming_page =3D sev_load_incoming_page;
     }
=20
     ret =3D kvm_arch_init(ms, s);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 28b36c8035..09a62d6f88 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -708,13 +708,34 @@ sev_launch_finish(SEVState *s)
     }
 }
=20
+static int
+sev_receive_finish(SEVState *s)
+{
+    int error, ret =3D 1;
+
+    trace_kvm_sev_receive_finish();
+    ret =3D sev_ioctl(s->sev_fd, KVM_SEV_RECEIVE_FINISH, 0, &error);
+    if (ret) {
+        error_report("%s: RECEIVE_FINISH ret=3D%d fw_error=3D%d '%s'",
+                __func__, ret, error, fw_error_to_str(error));
+        goto err;
+    }
+
+    sev_set_guest_state(SEV_STATE_RUNNING);
+err:
+    return ret;
+}
+
+
 static void
 sev_vm_state_change(void *opaque, int running, RunState state)
 {
     SEVState *s =3D opaque;
=20
     if (running) {
-        if (!sev_check_state(SEV_STATE_RUNNING)) {
+        if (sev_check_state(SEV_STATE_RECEIVE_UPDATE)) {
+            sev_receive_finish(s);
+        } else if (!sev_check_state(SEV_STATE_RUNNING)) {
             sev_launch_finish(s);
         }
     }
@@ -1065,6 +1086,109 @@ int sev_save_outgoing_page(void *handle, QEMUFile *=
f, uint8_t *ptr,
     return sev_send_update_data(s, f, ptr, sz, bytes_sent);
 }
=20
+static int
+sev_receive_start(QSevGuestInfo *sev, QEMUFile *f)
+{
+    int ret =3D 1;
+    int fw_error;
+    struct kvm_sev_receive_start *start;
+    gchar *session =3D NULL, *pdh_cert =3D NULL;
+
+    start =3D g_new0(struct kvm_sev_receive_start, 1);
+
+    /* get SEV guest handle */
+    start->handle =3D object_property_get_int(OBJECT(sev), "handle",
+            &error_abort);
+
+    /* get the source policy */
+    start->policy =3D qemu_get_be32(f);
+
+    /* get source PDH key */
+    start->pdh_len =3D qemu_get_be32(f);
+    pdh_cert =3D g_new(gchar, start->pdh_len);
+    qemu_get_buffer(f, (uint8_t *)pdh_cert, start->pdh_len);
+    start->pdh_uaddr =3D (unsigned long)pdh_cert;
+
+    /* get source session data */
+    start->session_len =3D qemu_get_be32(f);
+    session =3D g_new(gchar, start->session_len);
+    qemu_get_buffer(f, (uint8_t *)session, start->session_len);
+    start->session_uaddr =3D (unsigned long)session;
+
+    trace_kvm_sev_receive_start(start->policy, session, pdh_cert);
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_RECEIVE_START, start, &fw=
_error);
+    if (ret < 0) {
+        error_report("Error RECEIVE_START ret=3D%d fw_error=3D%d '%s'",
+                ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    object_property_set_int(OBJECT(sev), start->handle, "handle", &error_a=
bort);
+    sev_set_guest_state(SEV_STATE_RECEIVE_UPDATE);
+err:
+    g_free(start);
+    g_free(session);
+    g_free(pdh_cert);
+
+    return ret;
+}
+
+static int sev_receive_update_data(QEMUFile *f, uint8_t *ptr)
+{
+    int ret =3D 1, fw_error =3D 0;
+    gchar *hdr =3D NULL, *trans =3D NULL;
+    struct kvm_sev_receive_update_data *update;
+
+    update =3D g_new0(struct kvm_sev_receive_update_data, 1);
+
+    /* get packet header */
+    update->hdr_len =3D qemu_get_be32(f);
+    hdr =3D g_new(gchar, update->hdr_len);
+    qemu_get_buffer(f, (uint8_t *)hdr, update->hdr_len);
+    update->hdr_uaddr =3D (unsigned long)hdr;
+
+    /* get transport buffer */
+    update->trans_len =3D qemu_get_be32(f);
+    trans =3D g_new(gchar, update->trans_len);
+    update->trans_uaddr =3D (unsigned long)trans;
+    qemu_get_buffer(f, (uint8_t *)update->trans_uaddr, update->trans_len);
+
+    update->guest_uaddr =3D (unsigned long) ptr;
+    update->guest_len =3D update->trans_len;
+
+    trace_kvm_sev_receive_update_data(trans, ptr, update->guest_len,
+            hdr, update->hdr_len);
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_RECEIVE_UPDATE_DATA,
+                    update, &fw_error);
+    if (ret) {
+        error_report("Error RECEIVE_UPDATE_DATA ret=3D%d fw_error=3D%d '%s=
'",
+                ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+err:
+    g_free(trans);
+    g_free(update);
+    g_free(hdr);
+    return ret;
+}
+
+int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
+{
+    SEVState *s =3D (SEVState *)handle;
+
+    /* If this is first buffer and SEV is not in recieiving state then
+     * use RECEIVE_START command to create a encryption context.
+     */
+    if (!sev_check_state(SEV_STATE_RECEIVE_UPDATE) &&
+        sev_receive_start(s->sev_info, f)) {
+        return 1;
+    }
+
+    return sev_receive_update_data(f, ptr);
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/trace-events b/target/i386/trace-events
index b41516cf9f..609752cca7 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -18,3 +18,6 @@ kvm_sev_launch_finish(void) ""
 kvm_sev_send_start(uint64_t pdh, int l1, uint64_t plat, int l2, uint64_t a=
md, int l3) "pdh 0x%" PRIx64 " len %d plat 0x%" PRIx64 " len %d amd 0x%" PR=
Ix64 " len %d"
 kvm_sev_send_update_data(void *src, void *dst, int len) "guest %p trans %p=
 len %d"
 kvm_sev_send_finish(void) ""
+kvm_sev_receive_start(int policy, void *session, void *pdh) "policy 0x%x s=
ession %p pdh %p"
+kvm_sev_receive_update_data(void *src, void *dst, int len, void *hdr, int =
hdr_len) "guest %p trans %p len %d hdr %p hdr_len %d"
+kvm_sev_receive_finish(void) ""
--=20
2.17.1


