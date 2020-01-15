Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93947C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6018324679
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 10:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="HUdWcq9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6018324679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irgOY-0007gL-OB
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 05:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1irgNs-0007E2-7n
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1irgNo-0002Do-6P
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:58:47 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:55070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1irgNn-0002CR-RQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 05:58:44 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00FAwXk5020132; Wed, 15 Jan 2020 02:58:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=AxXe5iuX2KzKJCeO5khmjHCM1OZ4FBXb3PGo4S0ZUuU=;
 b=HUdWcq9vehWkyH1k9x+BwhIIQSMzCa+wmQRFIZSG+5whViKaHAvRDSLu6C/N9oFO0/6m
 iKNM/zb6pUnarFUBnRWBx+iX5Mxq4qj52Q8/ASD8LhBX6i8LPCGEYb+Zp1xVHjwdbSi/
 B55En8V6LGEDN16K3t4D+lSFjH+moKQr2ZXYos6xf57GIXul8cOHglKyG9TydfCTqcMk
 GIyJ3rrKfqWpvXQb3Fr4GrAnCulN+c0b7M/THGRm/1FGeGE5YHMs9j4jX0DQcoDrNQbQ
 04u9kLmUlvvBUFtm8dbulJKgAQXBN5jNmgMfxzO+kUvCLjOETvn0BMJeCkAvdh5o4icu yQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xg01pptq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2020 02:58:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTar0NXO4UxjWrVVhHoiaRn6WiuZRkmiRLtRgVgCtHeqrU1RyTAXHLevEtLNNgxXBCNF3ZiMbqxNEju6NpvS+TGvzbCpIpx/WqtWDXXZ1i1ttrrBq/rR34MSncjVolGAZrPdibRytUfo1TYS2sCbRlin0/kcZz7gDOAgbfPxEcLB4zxTBe3aHwAyxOLMJN5NogB0wLKm4Xbw4mciZD2CwqA9GyEH+afqMtf09xfld5xIn7ayqYbnVOPlY5eksbGMAKFNq9NAJUV8LKOQ3E+hYKFnOO1FnreJS4LPS3ETuat7Fj4R43BUwyRIKi91gvYium/TcSbaP6O3NCvQ8+uuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxXe5iuX2KzKJCeO5khmjHCM1OZ4FBXb3PGo4S0ZUuU=;
 b=Q9pPYHLwphiZnavvgF2bZIKi0Z0wwUvXyVcONzxlFqu4QDqHPJP353Oq5jl83HLZZNIggQn6wjgLXLH7kn4Ad4RoQyzoQfZgHLP12PxpAqiJYehV1vGt4xb38frr5FL/LUPyYmN9zKEta0KgQu/2bbJhnFX5h4KYHXzj4FyaJYSRJYp8N0R+7pDvV/DQpH1/Pg9h2z5+z/0sB9M14KQsbAY3KK5nPpodvVTr08KaO1WlODy1ZsTzzwEb1BAvAlXyBW/jHiFuVz9eKHn/N6VIlFx/5x2S+gBAQ4hXU2xf2AaJdk7RC1NekLQh5Z6WY9rqrzV8pSC1iyRlTIVFEEInBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2415.namprd02.prod.outlook.com (10.168.243.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 10:58:39 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2623.017; Wed, 15 Jan
 2020 10:58:39 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Feedback on multi-process QEMU muser prototype
Thread-Topic: Feedback on multi-process QEMU muser prototype
Thread-Index: AQHVyu567uh7TaRsOke3v0Y4ka1oDafrj50A
Date: Wed, 15 Jan 2020 10:58:38 +0000
Message-ID: <75F8F7A2-0925-4010-97EA-F135C873087F@nutanix.com>
References: <CAJSP0QWUfHyAk-xLFA1-sWSU7CvB4yKu0=Okoc7wcv7TinmXWg@mail.gmail.com>
In-Reply-To: <CAJSP0QWUfHyAk-xLFA1-sWSU7CvB4yKu0=Okoc7wcv7TinmXWg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43830fe9-4f8e-4bb4-bcab-08d799a9e078
x-ms-traffictypediagnostic: MWHPR02MB2415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2415C7A9428FBC0980846571D7370@MWHPR02MB2415.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(64756008)(76116006)(81166006)(91956017)(186003)(66946007)(8936002)(26005)(71200400001)(33656002)(6512007)(66556008)(4326008)(66476007)(81156014)(5660300002)(8676002)(2906002)(107886003)(6916009)(66446008)(54906003)(86362001)(7416002)(316002)(6506007)(53546011)(478600001)(36756003)(2616005)(6486002)(966005)(64030200002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2415;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wHCL16e5Z5B6TWxmYbHGEDh1KGOgdSD0uh2cnK6h2fIOnlb8M7oIzBcjIbjpAS191CdIc6JPVfnnmtQIGrcTK2+Vnk4YLWaPPg4mpNj3hshruYhg/JB8T9GE9CnuSTCIQ9vQuKjUPe+Fm8WwCAUMaPBWajHOyDnEU4FuscD+DgjAh/BA/ouwTSlzJ9O7X5z12BDP1pPupm5YsqUdhh3112DG4iHOUqEstbvRayODVe0NvtaSTxNnXtmLm7aFSwwef/dOg5ysTt8biOS8NDGnDJw6nIvYD7wEpI7EdcjfcqkPWWUlNUew+WE7bH1mBiSu21QvwqFPjKnZWfxkqznqbuZAexTJhgo86dtBtD8IRgXOfJ5Z2QtRYM9e0poGIPYLVC4lyOFMYzuU6Y00o3eK9KF0pfg7COjQTSmVjZi/ea/9gbcsmw97CSohDpf3yEtdg/+FpGD05vDSSNyFqxu2p9wIaxvFP69IZA0X4k6Z4KlP+WuXdhF8/AjVPROt3XbkL1gJFK2riDHzWXcgjIDUrgylkXzj+IBCk/4NhbAcFU=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C3C51934B1EB6D4984531DF2E034588B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43830fe9-4f8e-4bb4-bcab-08d799a9e078
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 10:58:38.8187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcJyMLzARUzxugHhF3z2wcrxhhmMsHaYnJGBCh/1Q6fss2ktf809hCIVNz0QxZ01foMjjkBbzIaI+HMzfPVVq/lzmd88Vt2BkeuC76joNOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2415
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-15_01:2020-01-15,
 2020-01-14 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.151.68
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

> On Jan 14, 2020, at 3:22 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> I haven't seen the link to the muser prototype shared on the list yet,
> so I'm taking the liberty of posting it for discussion:
> https://github.com/oracle/qemu/tree/multi-process-qemu-v0.4.1-muser
>=20
> Great that a lot of the multi-process patch series is no longer
> necessary.  The muser approach requires less code in QEMU.
>=20
> The following points came to mind:
>=20
> 1. Configure PCI configuration space, BARs, and MSI/IRQs based on the PCI=
Device
>   instead of hard-coding the LSI SCSI controller's specifics.  That way a=
ny
>   PCIDevice can run as an muser device.
>=20
> 2. Integrate with QEMU's event loop instead of spawning threads and calli=
ng
>   lm_ctx_run().  The event loop should monitor the muser fd for activity =
using
>   aio_set_fd_handler() and then call into libmuser to handle the event.  =
This
>   will avoid thread model problems in the future and also allow true
>   multi-threading (IOThreads).

Allowing muser to be used like that is in our to-do list.

(+ Thanos / Swapnil).

We have to extend muser.ko to allow the device file descriptor to be
"pollable".  Let me know how soon you want to see that so we can
prioritise accordingly or assist someone in doing the work.

F.

>=20
> 3. Drop previous multi-process QEMU commits if they are not needed.
>=20
> Stefan


