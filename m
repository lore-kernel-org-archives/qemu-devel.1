Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F53C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C7B20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cXzPnJBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C7B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJ8b-000323-8Q
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7L-0001VQ-4x
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7K-0002Lv-1u
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:07 -0400
Received: from mail-eopbgr710085.outbound.protection.outlook.com
 ([40.107.71.85]:55454 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7J-0002KJ-Oq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7f0U8yyQZeeDC6NdaZzAq3WQnoSQ3/6zyYS1SxqRdQ=;
 b=cXzPnJBXwIDv8mQi6s2FAxZrSKkjkpX77x9TsTcFAIbX0VXN3x9zWeHOQU7ON0t0XUZRNVGqSFKbJ3Crjt3M0e49zvF7vD0kwe3ASoYmGJbUz1GyZ+BqOL2wvIygCwHGnArVtooplfU+AYMknngLdlE0L3MtjsG8TU1X/2tkApc=
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
Thread-Topic: [PATCH v2 03/13] migration/ram: add support to send encrypted
 pages
Thread-Index: AQHVN11E5yX2Qel2IUGBE0XocGCcPw==
Date: Wed, 10 Jul 2019 20:23:00 +0000
Message-ID: <20190710202219.25939-4-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 318875e0-9f7c-4ed2-910b-08d70574675c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2618; 
x-ms-traffictypediagnostic: DM6PR12MB2618:
x-microsoft-antispam-prvs: <DM6PR12MB26187B2819C1FEFEDE91D42BE5F00@DM6PR12MB2618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(43544003)(5640700003)(14444005)(8676002)(99286004)(66066001)(53936002)(2351001)(6116002)(3846002)(6436002)(6486002)(305945005)(7736002)(76176011)(52116002)(6916009)(6512007)(81166006)(5660300002)(8936002)(66946007)(66476007)(81156014)(386003)(6506007)(2501003)(2906002)(486006)(476003)(50226002)(68736007)(2616005)(446003)(86362001)(478600001)(25786009)(316002)(11346002)(54906003)(66446008)(64756008)(256004)(71200400001)(71190400001)(66556008)(14454004)(102836004)(1076003)(26005)(36756003)(4326008)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2618;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d4IoCi04P8duoXK700VPH2o/b2pvep07HL72gWSkMjpxQxEkqJzOX4QniWsOJtlembvKvGxP5rynzgXFIR2me7gVkILtv0mPqlIvmdCdnvx6SO4V0UJc0xJ0J7AaU7DjnwKRjRVS+r5fgZnn2vpRlVH9bd/wrQz0tetxnKrwrVffV8uVjiybwiQMvyfPY8yB2rtmXZ4wEtSu9kszpj6i19IpXh/fKXMkOBaj+ZePWJkIpxH6TesQE30PuKsY+sGHEL959sQCEEshjiYTd7vHG+fUBZXl5PJfrNm0eoJAARmNLuhzdnKg+QKjHtWig97mI451anP2zRWYi820bjZkfg52V8uu4FbaTNMcXZlFPBiVW0qFgSzgrKFMSZIpKQHrZS49YBWJgrYIfIHn0BAiQi2bepAlgEqbxUZmVG1eKWk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318875e0-9f7c-4ed2-910b-08d70574675c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:00.6528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.85
Subject: [Qemu-devel] [PATCH v2 03/13] migration/ram: add support to send
 encrypted pages
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

When memory encryption is enabled, the guest memory will be encrypted with
the guest specific key. The patch introduces RAM_SAVE_FLAG_ENCRYPTED_PAGE
flag to distinguish the encrypted data from plaintext. Encrypted pages
may need special handling. The kvm_memcrypt_save_outgoing_page() is used
by the sender to write the encrypted pages onto the socket, similarly the
kvm_memcrypt_load_incoming_page() is used by the target to read the
encrypted pages from the socket and load into the guest memory.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 migration/ram.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 908517fc2b..3c8977d508 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -57,6 +57,7 @@
 #include "qemu/uuid.h"
 #include "savevm.h"
 #include "qemu/iov.h"
+#include "sysemu/kvm.h"
=20
 /***********************************************************/
 /* ram save/restore */
@@ -76,6 +77,7 @@
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
+#define RAM_SAVE_FLAG_ENCRYPTED_PAGE   0x200
=20
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
@@ -460,6 +462,9 @@ static QemuCond decomp_done_cond;
 static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *=
block,
                                  ram_addr_t offset, uint8_t *source_buf);
=20
+static int ram_save_encrypted_page(RAMState *rs, PageSearchStatus *pss,
+                                   bool last_stage);
+
 static void *do_data_compress(void *opaque)
 {
     CompressParam *param =3D opaque;
@@ -2006,6 +2011,36 @@ static int ram_save_multifd_page(RAMState *rs, RAMBl=
ock *block,
     return 1;
 }
=20
+/**
+ * ram_save_encrypted_page - send the given encrypted page to the stream
+ */
+static int ram_save_encrypted_page(RAMState *rs, PageSearchStatus *pss,
+                                   bool last_stage)
+{
+    int ret;
+    uint8_t *p;
+    RAMBlock *block =3D pss->block;
+    ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
+    uint64_t bytes_xmit;
+
+    p =3D block->host + offset;
+
+    ram_counters.transferred +=3D
+        save_page_header(rs, rs->f, block,
+                    offset | RAM_SAVE_FLAG_ENCRYPTED_PAGE);
+
+    ret =3D kvm_memcrypt_save_outgoing_page(rs->f, p,
+                        TARGET_PAGE_SIZE, &bytes_xmit);
+    if (ret) {
+        return -1;
+    }
+
+    ram_counters.transferred +=3D bytes_xmit;
+    ram_counters.normal++;
+
+    return 1;
+}
+
 static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *=
block,
                                  ram_addr_t offset, uint8_t *source_buf)
 {
@@ -2450,6 +2485,16 @@ static int ram_save_target_page(RAMState *rs, PageSe=
archStatus *pss,
         return res;
     }
=20
+    /*
+     * If memory encryption is enabled then use memory encryption APIs
+     * to write the outgoing buffer to the wire. The encryption APIs
+     * will take care of accessing the guest memory and re-encrypt it
+     * for the transport purposes.
+     */
+     if (kvm_memcrypt_enabled()) {
+        return ram_save_encrypted_page(rs, pss, last_stage);
+     }
+
     if (save_compress_page(rs, block, offset)) {
         return 1;
     }
@@ -4271,7 +4316,8 @@ static int ram_load(QEMUFile *f, void *opaque, int ve=
rsion_id)
         }
=20
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
-                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) =
{
+                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
+                     RAM_SAVE_FLAG_ENCRYPTED_PAGE)) {
             RAMBlock *block =3D ram_block_from_stream(f, flags);
=20
             /*
@@ -4391,6 +4437,12 @@ static int ram_load(QEMUFile *f, void *opaque, int v=
ersion_id)
                 break;
             }
             break;
+        case RAM_SAVE_FLAG_ENCRYPTED_PAGE:
+            if (kvm_memcrypt_load_incoming_page(f, host)) {
+                    error_report("Failed to encrypted incoming data");
+                    ret =3D -EINVAL;
+            }
+            break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             multifd_recv_sync_main();
--=20
2.17.1


