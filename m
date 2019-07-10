Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A6C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04DE20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WVVnzjFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04DE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJ8Y-0002uR-3M
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7I-0001UK-Ng
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7H-0002Hq-FG
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:04 -0400
Received: from mail-eopbgr710059.outbound.protection.outlook.com
 ([40.107.71.59]:24298 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7H-0002Ap-6x
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS+ovNKVJ/7a5sXKjQgKLa3nZqVtaXZaMEwfSfzlysc=;
 b=WVVnzjFVI56JO2+mw6Hj/opuHt9tKijwcjCox5daQHDmWufTTalPsDOgEab0GYV2ZOKFl6mUmu6yT2s2LbGf0fUdv6PiJjj4I2PgyrGDDQGAbnqDOkp3x0P03Q2EvwYyuGqdGQ9MsdALm5m82ODlu4MIJ8oqIt9REQAr4nxRmf4=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2618.namprd12.prod.outlook.com (20.176.116.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 20:23:00 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:00 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 02/13] kvm: introduce high-level API to support
 encrypted page migration
Thread-Index: AQHVN11E6BDm0AOVHUu1X3S27NYERQ==
Date: Wed, 10 Jul 2019 20:23:00 +0000
Message-ID: <20190710202219.25939-3-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: e2a40572-4b62-43ec-8a71-08d7057466ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2618; 
x-ms-traffictypediagnostic: DM6PR12MB2618:
x-microsoft-antispam-prvs: <DM6PR12MB261890FAF90FA6B6269A5403E5F00@DM6PR12MB2618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(5640700003)(14444005)(8676002)(99286004)(66066001)(53936002)(2351001)(6116002)(3846002)(6436002)(6486002)(305945005)(7736002)(76176011)(52116002)(6916009)(6512007)(81166006)(5660300002)(8936002)(66946007)(66476007)(81156014)(386003)(6506007)(2501003)(2906002)(486006)(476003)(50226002)(68736007)(2616005)(446003)(86362001)(478600001)(25786009)(316002)(11346002)(54906003)(66446008)(64756008)(256004)(71200400001)(71190400001)(66556008)(14454004)(102836004)(1076003)(26005)(36756003)(4326008)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2618;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TjDGzPu45zlUEtp/p0IqtkGy3txcsrYg21CEydL0NIeQ3iB6ORNmVBRAPzMksugdJDwiEuOnUBmcxGQp8ztVyxu+MtNH1ogaXgBkVHf99XeJBz6FWEGNXWrbSkZMvZdhiNxfj9Havq4+HNp6IBCp1gSkHJ3Ndm40jYq/CACY/4rNBml8sqITctvDocj9tyIca892Z+dswxPjv5xFCf369VpeKfxIpaQpq6b+d+in80+nFCilDyc+11T3CZLBeQ43/KExVNHLJyr9ljYANJNWJ+B0OzW/0csRDXdB5F0YyqsuHcOF7WUyAKtXAih0j64BItZ5TB9Op07D8Sjdpm1+Z9wvdCsjZWa7HZ+LZ7F662pus5ZD4Anc+BkcZbVbyRGJ+3RoK2omxbSpKkmYynmSim50zNkh+PpVf3WJOeokQ6I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a40572-4b62-43ec-8a71-08d7057466ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:00.0731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.59
Subject: [Qemu-devel] [PATCH v2 02/13] kvm: introduce high-level API to
 support encrypted page migration
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

When memory encryption is enabled in VM, the guest pages will be
encrypted with the guest-specific key, to protect the confidentiality
of data in transit. To support the live migration we need to use
platform specific hooks to access the guest memory.

The kvm_memcrypt_save_outgoing_page() can be used by the sender to write
the encrypted pages and metadata associated with it on the socket.

The kvm_memcrypt_load_incoming_page() can be used by receiver to read the
incoming encrypted pages from the socket and load into the guest memory.

Signed-off-by: Brijesh Singh <<brijesh.singh@amd.com>>
---
 accel/kvm/kvm-all.c    | 27 +++++++++++++++++++++++++++
 accel/kvm/sev-stub.c   | 11 +++++++++++
 accel/stubs/kvm-stub.c | 12 ++++++++++++
 include/sysemu/kvm.h   | 12 ++++++++++++
 include/sysemu/sev.h   |  3 +++
 5 files changed, 65 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3d86ae5052..162a2d5085 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -110,6 +110,10 @@ struct KVMState
     /* memory encryption */
     void *memcrypt_handle;
     int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len)=
;
+    int (*memcrypt_save_outgoing_page)(void *ehandle, QEMUFile *f,
+            uint8_t *ptr, uint32_t sz, uint64_t *bytes_sent);
+    int (*memcrypt_load_incoming_page)(void *ehandle, QEMUFile *f,
+            uint8_t *ptr);
 };
=20
 KVMState *kvm_state;
@@ -165,6 +169,29 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t l=
en)
     return 1;
 }
=20
+int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr,
+                                    uint32_t size, uint64_t *bytes_sent)
+{
+    if (kvm_state->memcrypt_handle &&
+        kvm_state->memcrypt_save_outgoing_page) {
+        return kvm_state->memcrypt_save_outgoing_page(kvm_state->memcrypt_=
handle,
+                    f, ptr, size, bytes_sent);
+    }
+
+    return 1;
+}
+
+int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr)
+{
+    if (kvm_state->memcrypt_handle &&
+        kvm_state->memcrypt_load_incoming_page) {
+        return kvm_state->memcrypt_load_incoming_page(kvm_state->memcrypt_=
handle,
+                    f, ptr);
+    }
+
+    return 1;
+}
+
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
     KVMState *s =3D kvm_state;
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index 4f97452585..c12a8e005e 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -24,3 +24,14 @@ void *sev_guest_init(const char *id)
 {
     return NULL;
 }
+
+int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
+                           uint32_t size, uint64_t *bytes_sent)
+{
+    return 1;
+}
+
+int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
+{
+    return 1;
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 6feb66ed80..e14b879531 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -114,6 +114,18 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t l=
en)
   return 1;
 }
=20
+int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr,
+                                    uint32_t size, uint64_t *bytes_sent)
+{
+    return 1;
+}
+
+int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr)
+{
+    return 1;
+}
+
+
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index acd90aebb6..bb6bcc143c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -247,6 +247,18 @@ bool kvm_memcrypt_enabled(void);
  */
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
=20
+/**
+ * kvm_memcrypt_save_outgoing_buffer - encrypt the outgoing buffer
+ * and write to the wire.
+ */
+int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr, uint32_t si=
ze,
+                                    uint64_t *bytes_sent);
+
+/**
+ * kvm_memcrypt_load_incoming_buffer - read the encrypt incoming buffer an=
d copy
+ * the buffer into the guest memory space.
+ */
+int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr);
=20
 #ifdef NEED_CPU_H
 #include "cpu.h"
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 98c1ec8d38..752a71b1c0 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -18,4 +18,7 @@
=20
 void *sev_guest_init(const char *id);
 int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
+int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
+                           uint32_t size, uint64_t *bytes_sent);
+int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr);
 #endif
--=20
2.17.1


