Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45781C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F97D218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="z5NZaE43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F97D218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjTZ-00084o-Eh
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEl-0000cj-4L
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEj-0002jg-N2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:51 -0400
Received: from mail-eopbgr700101.outbound.protection.outlook.com
 ([40.107.70.101]:46848 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEj-0002jO-Gj
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVxBvzw1CFXugJwvoby/fjVvJjt8kKENGixGkl4jooolO//bNNay6qrqSSqfjuS85X1wTADOYiAeM/gY+K5xASbLzLo4seXhVheNNDOzILPgDGzXvNNaD53AUIiLJJVsfkmgd9nwG61NOwKRnWp1JwVPwisZ7FGDKiVYGPCqlI5OFiU7ba7NtfHqRAbKFjNSTFenbLCA8LIxfdYq+7YWap8fhIABcNFuFK3V9hJlHBb15NvTlDdGE6jbmF9GKzBRjF6EdgkdBT7A4SKZBD2QVgLlLBPS6w5HGgwq9d9KW793VnPENbuxkPlipfuSNzz2Qh/uzKGSvq8GK45L1UqQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaAtYseh65x/d3UGsiucJwoWC+0RpGRuZP8OwLHMaOo=;
 b=RV92n9MHI4BgrHD8zmPdKy0sdW2K8mKTauLpJHsXyhQqjZr9L20BE9z4UfR6q/yDN/PGi0mIGas9BG57wLnxVhDn8uizsqUPSkJelMEuJR1O5MrVrLi+m7fyzQ6U3GnjcvajWmIqjHmBNE+/qe4N+1fZ5e0AIU5WpR0mPp80cy+h4W3JzTEs13ej7LInUUifsNETiEwStHnpWlB5utMZqJ8w/a0FqMbi/HZiO2xGmGKKATB2Yayugvwu3fh1x25r6f5UTtIGZjPePmKw/ROeQffL4+Hn1jUMrNNz70XFvmZfZwswhnCz9aiZFFLiQJ1kfTqcfVnC4qDeT1k92lw+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaAtYseh65x/d3UGsiucJwoWC+0RpGRuZP8OwLHMaOo=;
 b=z5NZaE43DUYGLysH1BdSROYQ5PNOtzIO6ETx8jT8W6IGb4vmFMPkaYOMqlcaw2w3KboChUkTSyBgEUdk3eb3n1IA/twczsFN4wAUF08MAhl8Mdepx+d8VBNkxnQk0scXomj3ZTP5WliHA/zjT9vzBQ0bAsYO7a1dQHJ+BFmzpUM=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:48 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:48 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 21/22] fuzz: add virtio-net fuzz target
Thread-Index: AQHVbneQEdirmkkfcka7ttB8S+fEzw==
Date: Wed, 18 Sep 2019 23:19:47 +0000
Message-ID: <20190918231846.22538-22-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46c9f0af-c71f-4fc5-428f-08d73c8eb2b8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016B879979FDF9C5A1AE0F5BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:216;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(1496009)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IeeJr64xWsQNtzLTIcmVxYdomAv2rwgKm6CqI44IB8ynuQqJUMh1L0oKM0a4QnESD5FwQXk08ApOOKyDX55wqyztX1E1OYliMRafGUFpJsbiYOvQEHluP5c2fLiZ1oHnPR5/w707pFTPPAhScvYQiOQaCkB0Q0LCYfyymjmcPrumWv3hy4fj5vgtLsohsDkoYSDuQKnvZUR5HUzJFD94YhIBR0QAD+lCieGw5u+Xh5SXy1BAcp79A/kDIOA673xdIO428mq69aCRJyqQV9ochVV8ePYzyeRD8fBRY6F6geuey+NF8cwVT2AeHkZRzED50nzlF/Ke7I8kty/OmZIjcGdEOmuaNNS7yhAiYeuQNSAGmagvWBlN9ErCDQJ6X3SxYbRNlTDO7rak/A8gl1FILBgxhvW0obcf1V4OE3i0g1U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c9f0af-c71f-4fc5-428f-08d73c8eb2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:47.9236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahqQ96lOMiWjXGaBG+jerGEw8C4m23TxWBYOwK1SjSOKV6TZIBfzF8joCfsI5NzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.101
Subject: [Qemu-devel] [PATCH v3 21/22] fuzz: add virtio-net fuzz target
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-net fuzz target feeds inputs to all three virtio-net
virtqueues, and uses forking to avoid leaking state between fuzz runs.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include  |   1 +
 tests/fuzz/virtio_net_fuzz.c | 120 +++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 tests/fuzz/virtio_net_fuzz.c

diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
index 37d6821bee..f1d9b46b1c 100644
--- a/tests/fuzz/Makefile.include
+++ b/tests/fuzz/Makefile.include
@@ -6,5 +6,6 @@ fuzz-obj-y +=3D tests/fuzz/fork_fuzz.o
 fuzz-obj-y +=3D tests/fuzz/qos_fuzz.o
=20
 fuzz-obj-y +=3D tests/fuzz/i440fx_fuzz.o
+fuzz-obj-y +=3D tests/fuzz/virtio_net_fuzz.o
=20
 FUZZ_LDFLAGS +=3D -Xlinker -T$(SRC_PATH)/tests/fuzz/fork_fuzz.ld
diff --git a/tests/fuzz/virtio_net_fuzz.c b/tests/fuzz/virtio_net_fuzz.c
new file mode 100644
index 0000000000..2f6e14b06d
--- /dev/null
+++ b/tests/fuzz/virtio_net_fuzz.c
@@ -0,0 +1,120 @@
+#include "qemu/osdep.h"
+
+#include "qemu/main-loop.h"
+
+#include "fuzz.h"
+#include "fork_fuzz.h"
+#include "qos_fuzz.h"
+#include "tests/libqtest.h"
+#include "tests/libqos/virtio-net.h"
+
+
+
+static void virtio_net_ctrl_fuzz_multi(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    typedef struct vq_action {
+        uint8_t queue;
+        uint8_t length;
+        uint8_t write;
+        uint8_t next;
+        bool kick;
+    } vq_action;
+
+    uint64_t req_addr[10];
+    int reqi =3D 0;
+    uint32_t free_head =3D 0;
+
+    QGuestAllocator *t_alloc =3D fuzz_qos_alloc;
+
+    QVirtioNet *net_if =3D fuzz_qos_obj;
+    QVirtioDevice *dev =3D net_if->vdev;
+    QVirtQueue *q;
+    vq_action vqa;
+    int iters =3D 0;
+    while (true) {
+        if (Size < sizeof(vqa)) {
+            break;
+        }
+        vqa =3D *((vq_action *)Data);
+        Data +=3D sizeof(vqa);
+        Size -=3D sizeof(vqa);
+
+        q =3D net_if->queues[vqa.queue % 3];
+
+        vqa.length =3D vqa.length >=3D Size ? Size :  vqa.length;
+
+        req_addr[reqi] =3D guest_alloc(t_alloc, vqa.length);
+        qtest_memwrite(s, req_addr[reqi], Data, vqa.length);
+        if (iters =3D=3D 0) {
+            free_head =3D qvirtqueue_add(s, q, req_addr[reqi], vqa.length,
+                    vqa.write, vqa.next);
+        } else {
+            qvirtqueue_add(s, q,
+                    req_addr[reqi], vqa.length, vqa.write , vqa.next);
+        }
+        iters++;
+        reqi++;
+        if (iters =3D=3D 10) {
+            break;
+        }
+        Data +=3D vqa.length;
+        Size -=3D vqa.length;
+    }
+    if (iters) {
+        qvirtqueue_kick(s, dev, q, free_head);
+        qtest_clock_step_next(s);
+        main_loop_wait(false);
+        for (int i =3D 0; i < reqi; i++) {
+            guest_free(t_alloc, req_addr[i]);
+        }
+    }
+}
+
+static int *sv;
+
+static void *virtio_net_test_setup_socket(GString *cmd_line, void *arg)
+{
+    if (!sv) {
+        sv =3D g_new(int, 2);
+        int ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
+        fcntl(sv[0], F_SETFL, O_NONBLOCK);
+        g_assert_cmpint(ret, !=3D, -1);
+    }
+    g_string_append_printf(cmd_line, " -netdev socket,fd=3D%d,id=3Dhs0 ", =
sv[1]);
+    return arg;
+}
+
+static void virtio_net_fork_fuzz(QTestState *s,
+        const unsigned char *Data, size_t Size)
+{
+    if (fork() =3D=3D 0) {
+        virtio_net_ctrl_fuzz_multi(s, Data, Size);
+        counter_shm_store();
+        _Exit(0);
+    } else {
+        wait(NULL);
+        counter_shm_load();
+    }
+}
+
+static void fork_init(QTestState *s)
+{
+    qos_init_path(s);
+    counter_shm_init();
+}
+
+static void register_virtio_net_fuzz_targets(void)
+{
+    fuzz_add_qos_target("virtio-net-fork-fuzz",
+            "Fuzz the virtio-net virtual queues, forking for each fuzz run=
",
+            "virtio-net",
+            &(QOSGraphTestOptions){.before =3D virtio_net_test_setup_socke=
t},
+            &(FuzzTarget){
+            .pre_main =3D &qos_setup,
+            .pre_fuzz =3D &fork_init,
+            .fuzz =3D &virtio_net_fork_fuzz
+            });
+}
+
+fuzz_target_init(register_virtio_net_fuzz_targets);
--=20
2.23.0


