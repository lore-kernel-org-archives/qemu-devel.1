Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F152C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B79420657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="69mm2tqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B79420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huX9t-0004rh-AF
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX99-0003A0-3g
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX98-0001rp-5T
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:07 -0400
Received: from mail-eopbgr790111.outbound.protection.outlook.com
 ([40.107.79.111]:12064 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX97-0001qn-Vu
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npcgJ/RUhm93i56DHKA9/hUWTzxxgw/iBxk/aYEFc7RD+zX1dkiddddwHKTq0LBchNJNLC/2mcISz94O1zC+RbKU6HwikTKVQse9kDPDWH3RxdXo5zNl4i1h+bxiiSmaXzGEq81cEV24tNCFLYG+q4aPxUyvgegCR+zWKXITGP1yGojQtuuTdo1wTY00xSCXBmuHI4rzKn3IXz5LFdx/N5dwc3OcTqxMEGDv/1toy+rXEyWktRmrCtOI+Rj9KYq23eBdj6dDxpFSARCsJ0Nf4ydQGgXLQ2PLHidluEFBIgb2nhdn5OiwZdqpmifnH6TB/iA0iqg3H+8ruul0xy+wBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl80RK++ZNz2YyjVZRBEFHcmfv5GNUSbqDdbZzanf7I=;
 b=nMMfG+Hp6XrKqtptRgYCVikAz/zKbtLb+DkQAr3DYX/GLgzuKLMVwSmVvT1oiFaYZb3bGjO67VadUzMhBwLNBkflUQYX9L3hf0mquEjduJ4CBJPA6NRin80Ld4v+K80gY7uw/lffsES+qF3JY+2tiOq1f0lcdlMBK1/4wdP2yyhZQnsrx4e8ErcnSxsHgq+iSWjtKi32MX/pUAnujiyxrIQ7FsRKn+v6IyZ3pFzi8a5EzUVsSLymKH37CqZ6DjYOJ4iq7iIO4mjmK2QK5dv2oqLL6rkJBtLkiPN9gvK/X0slxtb0ggXdGSZcGYHHIMzavyLr6MduN0/UCA64utfZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl80RK++ZNz2YyjVZRBEFHcmfv5GNUSbqDdbZzanf7I=;
 b=69mm2tqwovisUS2Hcg0BjuJ3df9/o8fWPD2Z96YA8HfrJFBL/GHEkN0YePAl5QpFsnZHvXI4AlXoRpUuH+g0YU7eVxAvhBAFII8pGAXxLEQiw0qHNPpE60A4KIB+EjZz3d4oS33ng8XTOZS0hJrpFFBrGBgFCisOAPmeHuJP/Sw=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:04 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:04 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 03/17] fuzz: Keep memory mapped for fork-based
 fuzzer
Thread-Index: AQHVS1zypOwjbwYDXESTHEIrQsuo4A==
Date: Mon, 5 Aug 2019 07:11:04 +0000
Message-ID: <20190805071038.32146-4-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78941f5a-0413-4c3b-805d-08d719741465
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646C8BDDF52210F0D99ADB6BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(4744005)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lUz8TeIxi1tmbCMd9FnwcKd67YycGYL3ygt7/0zUmmlvQI0r4S8AS43pGVLqxcf3mXV5/so1R9lfz6PKA+uRVGspoLp4WF1kxj/fHyNuDWc6kJ2Kux3mXMgwUXuBB1KpxXSJt4j1JBHnQhRFyD7WQ0wz2sF32QXEF8+8/k2Vh0pXvOxcAUEjKR1+kCJIEyyVx5FinNZYe2rLYYeDXyAVUNVulZSwNFOg4jEFenrxtJSGhMM65QIN4pFeaJQJF3u+Ztn1lilIb2rOqm/71JBZwUdyYjcbzXn+sRbG5J8tUsxaHL0fY5tHGNWw/UJ5WmQCxUz277cyAx6DuhU5h4qYhTEx2FjLPZY9iGvlxtGXX2oeH3qu8yl5g9sZ3sPb/sbYDCSeRvq9Diho0nQ9SV84xJjbwr2+iUIlu/9GCOtpxNs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78941f5a-0413-4c3b-805d-08d719741465
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:04.8230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.111
Subject: [Qemu-devel] [RFC PATCH v2 03/17] fuzz: Keep memory mapped for
 fork-based fuzzer
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
 "bsd@redhat.com" <bsd@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise, the RAM is unmapped from the child-processes, which breaks
any fuzz tests relying on DMA.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/exec.c b/exec.c
index 3e78de3b8f..b3b56db8f0 100644
--- a/exec.c
+++ b/exec.c
@@ -2317,7 +2317,9 @@ static void ram_block_add(RAMBlock *new_block, Error =
**errp, bool shared)
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
         /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
+#ifndef CONFIG_FUZZ /* This conflicts with fork-based fuzzing */
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+#endif
         ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
--=20
2.20.1


