Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0166207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="HfPlILp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0166207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpxW-00065z-Qi
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kMpvn-00057B-5F
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:58:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:32654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kMpvk-00083Y-Tp
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:58:50 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 08S9h82X023494; Mon, 28 Sep 2020 02:58:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=gSDgL6Xodion8JxjB8ESrr5BdqArjavfOwPLFlTWPa8=;
 b=HfPlILp59czGVxl56+f7sas5Fm5FI4hBFV11N00S5MbS//i8nKwfZFWUfjM55rhQKLoO
 VaN+H0Vs4D7eE8FiARRPuSfrGmfax2vlY1SWyswP8iKR7o0CitW2OllfJutEH+J6IzKr
 Zz9f+GKNq/RpBSJEnx3IIerdAurSCzjuO0pDcnu431l/GQmC/t/0F0bbHIDRjUEFMbeb
 tU0mpAGYerhohYQqNbQbRnuB275qGuBFLyG+did7EoJtW91vw21Uv9wtyRjaSDPIw9LF
 SZ1Av84rILrNtCrfqDWUQ+DiQvVqNq/HR7AUIrwpxY0aKYJmeI/3aSk0Hf0eOZTW6T3q Wg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by mx0b-002c1b01.pphosted.com with ESMTP id 33t561k3ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2020 02:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9ei/q1s/8jhJr34k7TcHIf7P9uCm3BYHxgWpqgTDNIrL0U/lZeHKTmVOXDsvFSfYc6de+6viS/MLcwo5rtWbfhgswEbTvTcUk6mGJL6sTAy7k7RWJo0xm6Xw4ggH5hEFWrIt+ZvbGrNtUKLGAuC1WIFmNphLTW5z1mpAqVMQvXObMDI6OrK10+vNc7fJxhfbjSgjLTVHxtxQva2uOTOPPGEu/gzehJTtZ6d1lHwugrCGCivyFVji/myRbojD6BGaiq7Xo4cTOia//wYS+DUQJweVZ1P2Uw7/yu1cGAjBmpGP8d6LQS5lVs4tPNPdJI8iBVVjFUleSuRojQKXdeylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSDgL6Xodion8JxjB8ESrr5BdqArjavfOwPLFlTWPa8=;
 b=aN3+uFWFsJ0zA2WKxlPJ/wuyMXj8N//+SfCff/91/v7g+raePplPpi5pHwM/r9f2tP5vn/VTVGF4ZC14H7c9jmzIwPyMhivV6NaqPXzgFYMInyZICgcG8qpqruMRehfCZXg+FEWs1m4wCH6sK1q0V7RYfi8gn9tb6fGuQzw3eRul68QcXKYivVabxg7qJXLXL7XlVabAD7ZGcjLiZ9tgiBBOZ9MGGExPizoQ7/83YENV1CLQxsg+c++KKp0Ik7/Jg3p86oa6zcP/Ib52xBf1qnPq0FdKxs2s1tOzMAOOhjDjZuM/zk/qYPPvU7/T+txE/J1ZTf0jSNqlfqntPLn+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MWHPR0201MB3402.namprd02.prod.outlook.com (2603:10b6:301:7f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 09:58:38 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b4db:8d86:582:424b]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::b4db:8d86:582:424b%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 09:58:38 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: RE: [PATCH v4] introduce vfio-user protocol specification
Thread-Topic: [PATCH v4] introduce vfio-user protocol specification
Thread-Index: AQHWi2yrZ53jmE0ggUygdWhRZAQxtKl3gJEAgAZhhlA=
Date: Mon, 28 Sep 2020 09:58:37 +0000
Message-ID: <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
In-Reply-To: <20200924082132.GJ62770@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [78.149.9.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 693542eb-fe34-4c9e-e8a8-08d86395123c
x-ms-traffictypediagnostic: MWHPR0201MB3402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB340252836D9F23641584E8108B350@MWHPR0201MB3402.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vo7xBCjNSYUZsXCzii9CvJ5bHjozrxE7/s8jAIzHoiM8K0PaKFo+j3fMqQyosQUOs4ly0Nh/Tt09byJVlIEkL7EPS/wv/QpxkKZ+A3ZuUdjyMQSzssKTZxi6iffxJ3Gff+fhlZ0pKchmm/sQrpRFqEjlxvoPV5yiK0cHjgNNvmj7+EZJ5FjAstehjSo1fi53PNZ9DjFFxhm57C653bLgUW+LUhf1f8m9QmMu8N04Qas6+T0uRSkTiDnVyoixJC/e2rwXvahLCAqrZ6I2NyS6WqMwmiYoGbcnHnFYm78mavaq/whMd/PtdlwxAe9dXIqUXEvPALCqqx566DRlkhlYRJxwOP/eLsgFHwakrFcAa1U5lTNr09T6FLD9kRZcLJS1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(5660300002)(6916009)(478600001)(8936002)(33656002)(8676002)(83380400001)(76116006)(86362001)(66946007)(64756008)(66446008)(52536014)(66476007)(66556008)(9686003)(2906002)(4326008)(7696005)(7416002)(54906003)(55016002)(44832011)(316002)(186003)(26005)(55236004)(6506007)(53546011)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yefMCQiAFtpT9ks0Snyy/3+Wxk8Gtz0sakmjM+rdZa/3FD6n+yiICgrsRcVjZhJfvTR5aUT6UgK4jHn+T3B5lkD+7ywJvPg/VqcxVZihJ8XbvysrerpMChfX4uxiqlbslxR1b64GJsW6GB4HWEDmFEvA7gkd9OYcPvYgG7oQCT6Na4qRv3KW1s7aGdJsRQNVMcrrb896lv9Yues33QKA7x0eLXfyVuW+WRSWAJvg+g3fCuVifS9CMr/miwLFNFAM01/TsGgBvdlKqMQD04A6grs791d376Sr8ZfxpssuyQ1a1+G6h/cov/zJJMDn8YQiHek7QXWbdAXWngOb93nmsK4ejE7rYfMMczwrB717zhcH1p3x73CcqxpzdVlWB0pX4t6gnwQfx04FGnPX5HJBjb5bLpJk7ScLJgb9WpWtVGJX10VNP8yGpYBLUMQgkYwNd+7G3ZMYk1K6O8KfwIZ8x0lCKjGLFQEY6fYuUnlmjtIJiigogvbNwsfb4zCw8ib7MlmUKDMLz02xrmJLnYPaiFT/xYvuI56FY92rqlKPlThpTGGCQnzuDxJ26XRiODWFHHN+UbDZyOgrV2oZkkDfr9RNPWnKP3yTP7aRMUmnj8RwnY7qPFHPo1vJn2khbPytNoK6OlpWW6xnm48WOti25Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3723.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693542eb-fe34-4c9e-e8a8-08d86395123c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 09:58:37.7835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jfx2Mabm/1BtvyiUlw/U6DNoBIFpRV01UMpEbujov9qdZqpyIPe+Ik/imvPqFfBdV2hkZ9CVEiSqsMOYlaGJJo4ARHsMzoToD4tUe5X1Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3402
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-28_07:2020-09-24,
 2020-09-28 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:58:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: 24 September 2020 09:22
> To: Thanos Makatos <thanos.makatos@nutanix.com>
> Cc: qemu-devel@nongnu.org; Michael S. Tsirkin <mst@redhat.com>;
> alex.williamson@redhat.com; benjamin.walker@intel.com;
> elena.ufimtseva@oracle.com; jag.raman@oracle.com; Swapnil Ingle
> <swapnil.ingle@nutanix.com>; james.r.harris@intel.com;
> konrad.wilk@oracle.com; Raphael Norwitz <raphael.norwitz@nutanix.com>;
> marcandre.lureau@redhat.com; Kanth.Ghatraju@oracle.com; Felipe
> Franciosi <felipe@nutanix.com>; tina.zhang@intel.com;
> changpeng.liu@intel.com; dgilbert@redhat.com;
> tomassetti.andrea@gmail.com; yuvalkashtan@gmail.com;
> ismael@linux.com; xiuchun.lu@intel.com; John G Johnson
> <john.g.johnson@oracle.com>
> Subject: Re: [PATCH v4] introduce vfio-user protocol specification
>=20
> On Tue, Sep 15, 2020 at 07:29:17AM -0700, Thanos Makatos wrote:
> > This patch introduces the vfio-user protocol specification (formerly
> > known as VFIO-over-socket), which is designed to allow devices to be
> > emulated outside QEMU, in a separate process. vfio-user reuses the
> > existing VFIO defines, structs and concepts.
> >
> > It has been earlier discussed as an RFC in:
> > "RFC: use VFIO over a UNIX domain socket to implement device offloading=
"
> >
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
>=20
> The approach looks promising. It's hard to know what changes will be
> required when this is implemented, so let's not worry about getting
> every detail of the spec right.
>=20
> Now that there is a spec to start from, the next step is patches
> implementing --device vfio-user-pci,chardev=3D<chardev> in
> hw/vfio-user/pci.c (mirroring hw/vfio/).
>=20
> It should be accompanied by a test in tests/. PCI-level testing APIS for
> BARs, configuration space, interrupts, etc are available in
> tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
> device backend interact with QEMU's vfio-user-pci implementation.

We plan to use a libmuser-based backend for testing. This, I suppose, will
make libmuser a dependency of QEMU (either as a submodule or as a library),
which for now can be disabled in the default configuration. Is this accepta=
ble?

>=20
> I think this spec can be merged in docs/devel/ now and marked as
> "subject to change (not a stable public interface

Great!

>=20
> After the details have been proven and any necessary changes have been
> made the spec can be promoted to docs/interop/ as a stable public
> interface. This gives the freedom to make changes discovered when
> figuring out issues like disconnect/reconnect, live migration, etc that
> can be hard to get right without a working implementation.
>=20
> Does this approach sound good?

Yes.

>=20
> Also please let us know who is working on what so additional people can
> get involved in areas that need work!

Swapnil and I will be working on libmuser and the test in QEMU, John and
the mp-qemu folks will be working on the patches for implementing
--device vfio-user-pci.

>=20
> Stefan

