Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7DDC74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0801F208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gQ+Am1nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0801F208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJHY-0005NH-9Y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7U-0001e1-27
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7S-0002Zr-07
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:15 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7Q-0002MZ-Fs
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q2hxSWpVoaLTRFkzr1vcjcXO2ngxQ2qbpLwULgbziU=;
 b=gQ+Am1nlas6JAnKsyWXz6Hv9I14tjusa+yqSIMbYNTyyQgI0iiHBi24mrwoj6euaZMXCyvkBaajKCtMzMZxYAuHxFwg6bRWWOydGnuuY/o9EJ7X9VAcY+VUALssXYnZ/9+SfLx/lFzOw2TN/auaNi8EPiwG7Mml/fdmQtMPIcjo=
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
Thread-Topic: [PATCH v2 11/13] kvm: introduce high-level API to migrate the
 page encryption bitmap
Thread-Index: AQHVN11Jxe+loFjtdk2DhA2ugTPBnA==
Date: Wed, 10 Jul 2019 20:23:08 +0000
Message-ID: <20190710202219.25939-12-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 552597ba-3914-4d1f-0aba-08d705746c06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB382094DBEDBD78A1CEF4EB3EE5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(4326008)(66476007)(66946007)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2NCqnSq8pjrIQ9bdnpJCbi8pBIn0rwfKI4THljc7KsFOdPImMGGycUTshOsOGv57+H1x/ciVOhNcS/EcPUgIumMFS/7RazPsyrVL+Pe8a7CXnjlwoS0ti/gYFtBy1YcjjkYzFV8wKwQ2cZFuxMMwfDDDrkoydlBDgiD2aS3lLqr08WHbYd1my87JRy8atEnwqIGemF8wMks0c4TkFxFpP6aotnSlMzX0EuYkhJSoAwuH0A119SZSck7MrXAZmx74Ko884rAZuKfGSzqcEGDs/RD9apPiYgVPbPsCq7y+teokX2KlMudFqnPaG5OdR1+6JbOpvwejBjfMlaxcNzz3VQ3aHqU1NEJDqQI6LJtupaYrl9ygFTQTpP+i3DGhbAbJ5+ICaUFp5UXbsJWHsuxft33+y9qL3dLsO/hFiLBdLxI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552597ba-3914-4d1f-0aba-08d705746c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:08.4014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 11/13] kvm: introduce high-level API to
 migrate the page encryption bitmap
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

Encrypted VMs have concept of private and shared memory. The private
memory is encrypted with the guest-specific key, while shared memory
may be encrypted with hyperivosr key. The guest OS uses a hypercall
to notify the page encryption state to the hypervisor. The hypervisor
maintain a bitmap of page encryption state. This bitmap should be
migrated to ensure that target machine can function correctly.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c    | 37 +++++++++++++++++++++++++++++++++++++
 accel/kvm/sev-stub.c   | 11 +++++++++++
 accel/stubs/kvm-stub.c | 10 ++++++++++
 include/sysemu/kvm.h   | 13 +++++++++++++
 include/sysemu/sev.h   |  3 +++
 5 files changed, 74 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7f94dba6f9..442b1af36e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -114,6 +114,9 @@ struct KVMState
             uint8_t *ptr, uint32_t sz, uint64_t *bytes_sent);
     int (*memcrypt_load_incoming_page)(void *ehandle, QEMUFile *f,
             uint8_t *ptr);
+    int (*memcrypt_load_incoming_page_enc_bitmap)(void *ehandle, QEMUFile =
*f);
+    int (*memcrypt_save_outgoing_page_enc_bitmap)(void *ehandle, QEMUFile =
*f,
+            uint64_t start, uint64_t length);
 };
=20
 KVMState *kvm_state;
@@ -192,6 +195,40 @@ int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8=
_t *ptr)
     return 1;
 }
=20
+int kvm_memcrypt_load_incoming_page_enc_bitmap(QEMUFile *f)
+{
+    if (kvm_state->memcrypt_handle &&
+        kvm_state->memcrypt_load_incoming_page_enc_bitmap) {
+        return kvm_state->memcrypt_load_incoming_page_enc_bitmap(
+                kvm_state->memcrypt_handle, f);
+    }
+
+    return 1;
+}
+
+int kvm_memcrypt_save_outgoing_page_enc_bitmap(QEMUFile *f)
+{
+    KVMMemoryListener *kml =3D &kvm_state->memory_listener;
+    KVMState *s =3D kvm_state;
+    int ret =3D 1, i;
+
+    if (s->memcrypt_handle &&
+        s->memcrypt_save_outgoing_page_enc_bitmap) {
+
+        /* iterate through all the registered slots and send the bitmap */
+        for (i =3D 0; i < s->nr_slots; i++) {
+            KVMSlot *mem =3D &kml->slots[i];
+            ret =3D s->memcrypt_save_outgoing_page_enc_bitmap(s->memcrypt_=
handle,
+                        f, mem->start_addr, mem->memory_size);
+            if (ret) {
+                return 1;
+            }
+        }
+    }
+
+    return ret;
+}
+
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
     KVMState *s =3D kvm_state;
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index c12a8e005e..7acd7211e6 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -35,3 +35,14 @@ int sev_load_incoming_page(void *handle, QEMUFile *f, ui=
nt8_t *ptr)
 {
     return 1;
 }
+
+int sev_load_incoming_page_enc_bitmap(void *handle, QEMUFile *f)
+{
+    return 1;
+}
+
+int sev_save_outgoing_page_enc_bitmap(void *handle, QEMUFile *f,
+                                      uint64_t start, uint64_t length)
+{
+    return 1;
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index e14b879531..ae607787e7 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -125,6 +125,16 @@ int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8=
_t *ptr)
     return 1;
 }
=20
+int kvm_memcrypt_load_incoming_page_enc_bitmap(QEMUFile *f)
+{
+    return 1;
+}
+
+int kvm_memcrypt_save_outgoing_page_enc_bitmap(QEMUFile *f)
+{
+    return 1;
+}
+
=20
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index bb6bcc143c..8aa06b4462 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -260,6 +260,19 @@ int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8=
_t *ptr, uint32_t size,
  */
 int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr);
=20
+/**
+ * kvm_memcrypt_load_incoming_page_enc_bitmap: read the page encryption bi=
tmap
+ * from the socket and pass it to the hypervisor.
+ */
+int kvm_memcrypt_load_incoming_page_enc_bitmap(QEMUFile *f);
+
+/**
+ * kvm_memcrypt_save_outgoing_page_enc_bitmap: write the page encryption b=
itmap
+ * on socket.
+ */
+int kvm_memcrypt_save_outgoing_page_enc_bitmap(QEMUFile *f);
+
+
 #ifdef NEED_CPU_H
 #include "cpu.h"
=20
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 752a71b1c0..e08886ca33 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -21,4 +21,7 @@ int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t=
 len);
 int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
                            uint32_t size, uint64_t *bytes_sent);
 int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr);
+int sev_load_incoming_page_enc_bitmap(void *handle, QEMUFile *f);
+int sev_save_outgoing_page_enc_bitmap(void *handle, QEMUFile *f,
+                                      uint64_t start, uint64_t length);
 #endif
--=20
2.17.1


