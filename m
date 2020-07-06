Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEC320715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RMENLqAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEC320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOmt-0005K4-BO
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jsOmF-0004kt-9P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:55:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:29060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jsOmC-0003cv-8P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:55:11 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 066Asgow023532; Mon, 6 Jul 2020 03:55:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=aYCtOPg50lt6i64bB6BvmAjHPr4FDQkGCr4bcyeNEWA=;
 b=RMENLqAGlWYKOx1VCjD38kqm+BssoUROtJK0E6v2dMHP7F9uZ88t815/sju8sIySxXbv
 9h4zxRf2oJ1NjQs5Jh8Lwt/9beAOLE7Q9XPkz4C1Nyykc+ncjhj7jQO2ghoAZMqDHvsC
 FU5W6RzazsFwvWBJ5vA3yD4aLzlvqKjcUAnBWL56UaB2ipkSm9x+Vjmi7op61k1/9RWv
 4aN/B01kn8t/1i2bvwGkjV9FoWAgPX9lN1k7JYVUZaKbJjwfUwGPc6LL5RYbDjmEAiB4
 uWE/WrYLmNj3umUQhIrU4WnCdrCrp776fDXuiUIwX0O591AO6ovNlE7K3O6pDXLiEIeq Uw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by mx0a-002c1b01.pphosted.com with ESMTP id 322ruhaxea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 03:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqGrgncR4G9KYPmkitdxH8u+eqviOj0jamcJWyWRSv2+0o2UP4JyUoP2Ca6EKv4rRX45tQbXcFUL4ATX/fblcADhkikTQavFwNHPDgwvrji2Jp2zJ6+697/uNKf0C8u8h8G9QPpYViCizu9rSFesaU7bfqmejnmL0vRGGlvOrrBBIg/Wbtprxka9QpU7pJySo5B1phkKKjGF3um5jp+FcDoBZkVAOahRNQoiSQXD1e/H7I+Z8j84WoDPMH7BBrEdLe0sFNDQ+VfoxvfXGbGYtgVFRqXvobjaR+Ra1pXkvNYIV8ixoWKofxZOhbF3+NYtIgUBjf6rnqst+0Obh5lz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYCtOPg50lt6i64bB6BvmAjHPr4FDQkGCr4bcyeNEWA=;
 b=V0mdoan6vezSqdAvE7NcLaK7PxcqQeTt5zGyWxMeZUOws8TPcyqQKwnymTR8hBqhujeBDwtutsm1jsTMUAa2x3nVYqD4KUYjQdHGs0h9P0WuOwrGVms6iiL7HmvFGL7xUjON826LbzwNoya//Q9T0KxR743XfWCe8K/c6t2mKfOMDM/kgPNwRurHQcMQYzvcwOVmNFQUCZxl81CleOBcppfoDlOCfqltAy4ChfSK3huOht3HUyr6MHSYBhycNrahsu8RWCZfpxD6oCLTKZcyi6KStgZqQ6Y3xfWHCRnGMB3+lDGUtvF+F3lYvsVy+qiQ5I0emDSwLrwITVLA/6vXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MWHPR02MB3151.namprd02.prod.outlook.com (2603:10b6:301:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 10:55:00 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::accb:7583:c55c:acd2]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::accb:7583:c55c:acd2%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 10:55:00 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: DMA region abruptly removed from PCI device
Thread-Topic: DMA region abruptly removed from PCI device
Thread-Index: AdZTg3uLE9L5RNQrTJ25kTkeyN20cw==
Date: Mon, 6 Jul 2020 10:55:00 +0000
Message-ID: <MW2PR02MB3723509CC4795066274C9D4C8B690@MW2PR02MB3723.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86a552c6-1703-42c7-df11-08d8219b07c3
x-ms-traffictypediagnostic: MWHPR02MB3151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3151A4C235040E4A80B9067C8B690@MWHPR02MB3151.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZeL5okq8Hr2TVmTHdxNM8NjzMuL18A2HMhgMpw15Nh43Hz8qr8LYwYkfpLLI6pyYVn8lj42xJStki+0MZ3iEp91qEU5X3JbbUZ1BeX/DANrWfDGmNF4twAfeyg4jkKd0RZBQcGfaHPRGRQvYce3POqLHZ9PMeNWD80E2/QrgPfn86cpl4o3zM1iHelhfmFhAQm360dlsAUXLLdm5KoEuF0znyD4F+XOz5m18a7kcNLVw17iONlcew3hCM0usnjNGkF9oHUgg5t2U/FcR5HLps+RwYbM8bP82DampsQq/X/Cz5uVWARHaJrU4rhR6dbWcLKn86fBEa5bIFaVo0VTGiSpccGRTaYTh0EhVHeT7orWL/ozJP1MfvdyHdwFkpfeAO4aNOq2dw/YdIyhUiw45g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(478600001)(4326008)(7696005)(83380400001)(6916009)(6506007)(66476007)(5660300002)(186003)(316002)(33656002)(9686003)(55016002)(66446008)(52536014)(44832011)(8676002)(66946007)(86362001)(64756008)(66556008)(54906003)(76116006)(8936002)(2906002)(71200400001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: n9vBhDBB3nlzgPvWrzcg8aNCCEp2S3xbtKBArB+WsBGwNmeNAlbSBR6SkZ8XOM/iDWFMaMhDCsGwEzVMDrf/kExVs49O2NZK11Rj6w3VFbIndK4AOsorTuVqo8GzF2OHAq1HQXS7VYGAvLMJ0Bw+48KEzMA0HfgJJuBhX2UxmXpZFIPxiNXF8iAGNgUUuyk7UNIaxNXtqjQZS0H2a1mTVZROFx/Rrb1vkWfUJgoAYCvYyO/IksxRk+D6BV/rD1sIOt7tFBOZ/u5W9HF+Chech1n3t6bDIvdZhoT5BsWz3hAs36PDgnpGXNqC6nVno2WIWhiYFHeD/GUNTzq5+JZcyzq6TI/iyv3rBPkkl1k/MHqS957cr6pZWnj1QXeugLbh6isLyAEKq+o8WAkNpaIfQElVrZA+vZPeJtxk35rItBhECHf2Dw/LH9/KBSYU/xt6Yy5V6KcrkEPEtyOKAix6QHfGSb9zP6hye5+PG82Z4Rk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3723.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a552c6-1703-42c7-df11-08d8219b07c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 10:55:00.6210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oyf9Tcaky6b092deydFp4l0TpQWGmLpHen0aJQryJqUYsYsco3SpZkHCo2rfh21dVoZ6G2VgEyzvH7Zqket4fl9o3YIEELM2AiWFYjEwpaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-06_08:2020-07-06,
 2020-07-06 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 06:55:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "Liu, Changpeng" <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have an issue when using the VFIO-over-socket libmuser PoC
(https://www.mail-archive.com/qemu-devel@nongnu.org/msg692251.html) instead=
 of
the VFIO kernel module: we notice that DMA regions used by the emulated dev=
ice
can be abruptly removed while the device is still using them.

The PCI device we've implemented is an NVMe controller using SPDK, so it po=
lls
the submission queues for new requests. We use the latest SeaBIOS where it =
tries
to boot from the NVMe controller. Several DMA regions are registered
(VFIO_IOMMU_MAP_DMA) and then the admin and a submission queues are created=
.
From this point SPDK polls both queues. Then, the DMA region where the
submission queue lies is removed (VFIO_IOMMU_UNMAP_DMA) and then re-added a=
t the
same IOVA but at a different offset. SPDK crashes soon after as it accesses
invalid memory. There is no other event (e.g. some PCI config space or NVMe
register write) happening between unmapping and mapping the DMA region. My =
guess
is that this behavior is legitimate and that this is solved in the VFIO ker=
nel
module by releasing the DMA region only after all references to it have bee=
n
released, which is handled by vfio_pin/unpin_pages, correct? If this is the=
 case
then I suppose we need to implement the same logic in libmuser, but I just =
want
to make sure I'm not missing anything as this is a substantial change.

