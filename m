Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766BBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3647206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ut3sJNOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3647206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOI6K-0008Mb-CD
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 06:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kOI5H-0007p4-2O
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:14:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:38240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1kOI5E-0006Vp-BU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:14:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 092ACCJ7003298; Fri, 2 Oct 2020 03:14:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Ar1FLcgVDDa0BxadK/ElBY6WQjbItiJBXuIniPnr1DQ=;
 b=ut3sJNOp2sYCNs4usHIkIMXaOHYuYUuLRJbTklMhkgrbZYgI9QvA5uqIaEN+wyP3itgG
 jYhHy+eWg5jFuTumm6a+SBNustCEvClMXB9uwtjlFptRwcQE/eRtosHedGAgM1QVeYJK
 mMr0VG0mU9LKxQRkvL80EaMmZ8JGBaIHuuj0V/DQHRlDxl/1ss8dw+L8/fVspwxOO6rL
 7WFyZlDqNQK+XaNGDedDFFssCGG03ph7IqcMEmyrVjOxCOCYnrkSFdbX+UwNt9A/Exot
 PuOHSI9QOTvUd7hbo9BRotkJ2Y3f5LLmmKWwOS9Dua/APcRcdv/47QJKSPhCWhFwZuJi 9w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-002c1b01.pphosted.com with ESMTP id 33t1jadtws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2020 03:14:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQE05h+JLHQrqjs1Li+/BPee4OA9cOXEeih4hG0icVH+iUeGK1wb7dkegSW++IT6KaimbBlOR9FBvKTkFdtXoCLxAqtpTafgYogeoQO/cojIBebN5y9guWLngmTr3F5S/A/aZPhFEiwSPjr6iVKK1Y+uziM5PIusmYWTVH1nmOxclscKtQrr84bXYwAFqTlXVL+8w4xQbAq4PXC5AEhuQXGoaG1E75n9yqKyZhb/but6jLVsM3ms4rQCNdJXWZ3GmwNfcv4mmgrnPlgG/PIi74e6tNkWCwMeMwbpm4koWOdT36jTiSczkiIeuoyg6DbXk7x9Qj0TZYAVDN8ywvl5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar1FLcgVDDa0BxadK/ElBY6WQjbItiJBXuIniPnr1DQ=;
 b=Ke6fCK7gSpfVMjumB7s1pohpLAuDgwCCqNPvYedrpFyK8QNYuEZLaRv56AipPrSe+X+ofw2hXdOJSVhFhtgzbvGYzGaSaMoDxNdQJ74EHKGV8GqBdmMjS57cC6lFWFNdOnugTXBvPcoTT5ZdGjXjPnYyiqn3FL3Iv+57xF3rp3eRVbDmWtihPWiAsgavSRreGRNFgXME/SIWx6MITmXy/kwyP9Yh31DkpwbGIpAVsip+cy9BM7vHOnu+3M6IWhVnLAuN7M8b0H9Ufp8C9ZsZwdv3EQ7TknTqC87Re05qZWHGBCVAA3vJbFitQAYW9jryP1rWDScuVzCjr7NWp51hkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4358.namprd02.prod.outlook.com (2603:10b6:a03:11::17)
 by BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Fri, 2 Oct
 2020 10:14:23 +0000
Received: from BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::d83e:86dc:3af9:fd95]) by BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::d83e:86dc:3af9:fd95%7]) with mapi id 15.20.3433.037; Fri, 2 Oct 2020
 10:14:23 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Thread-Topic: [PATCH v4] introduce vfio-user protocol specification
Thread-Index: AQHWi2yod8zgm1HwkEWWpH+OZU5qy6l3gJEAgAZkdICAAZ1BgIAAYCoAgAFxbQCAAt7hAA==
Date: Fri, 2 Oct 2020 10:14:23 +0000
Message-ID: <E0C4979F-157D-4ADC-9FCF-23A70FB6C931@nutanix.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200929103743.GB181609@stefanha-x1.localdomain>
 <2E6DF2C2-A3C3-404D-BB2E-B53B3555EB66@oracle.com>
 <20200930142408.GA320669@stefanha-x1.localdomain>
In-Reply-To: <20200930142408.GA320669@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa60a767-b569-4594-ce02-08d866bbefa4
x-ms-traffictypediagnostic: BYAPR02MB4488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4488241B0775744EE9345554D7310@BYAPR02MB4488.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzfqN9WBOxnrs6VavXMWUD2AdiED3SuOQtPF7m67GTfVmGfK3Fmd8MIHmQR3Q/Q4R5b9l3ZOHY3RmtRubBttBJalBluuLfB63C2rNpmFVkhKeVBEjG9Vk5AQnJiPvQjybFiquKBjYRKH8K2ERvx96pPGIJqI573aOgAUlAqgiNmCAP5O8uOU7thZnR10mOxDrGyW4qL69IcqYIlnXPsy3lwtI25ZOx3NBxTnLxo54a9VWYLZfhhSH189HazPTel3VCaBQ8bfXLEkjoO7S1fvy8j8+HYUdwAZZgGJH3eIbSu1pL4E/6ktqU8DsVSIk5bMtIeGTJcNXG+Fqj83D3Pesg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4358.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(8936002)(6486002)(4326008)(33656002)(478600001)(6916009)(83380400001)(71200400001)(2906002)(86362001)(316002)(8676002)(186003)(5660300002)(7416002)(2616005)(76116006)(6512007)(66946007)(53546011)(66446008)(66556008)(66476007)(36756003)(6506007)(64756008)(26005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8dHUk4iT16tFB6YP9nnBA+ZwtEJVsJLq8+sBPwXflFP2QVbY2U+KHc/5JZXBP9q7pJG/WWULElqX3ZxD6AU/zs6lbhUWSVeVGijLBMlBvdpuMo0LThDBKWBqX2QVxcBFzUpdh+5VbVKRhXn7oJXBiHZsmO46rJnhn+4tQXMvECEUY9ergJpbN3OCq3doAO3BJnDH46DtcASsb51twK6UXp6vfq4v1eLnIANstHOdmpf7vWvGHwVO172U/vNuusZTDu1Cl5zJ/UKnksFpi78/clpSpyofgGho02p8rEeoKXJQZ/A66ZCl9hxvuRsXD2Dv2EzBsUzl5lQTN1LugJNM1uTGYZ+9U3loAbIGDsJuNnxtzjNmVD4IjlxCB8S58VNt25yCBbFc2Y3+Ru5D8e+nsOx/2td+kj6dJ2rF5N1KhdIt630cMRxAnhB8wWi9oO4sWzg5DW/lJ2poiirhqFMH5YihdDAJTqGtRtybniGkc4/41KicdyL6UyPxXNGs59isgVxkq1LEiEPwCa4nUM7rsfMUxqIQUyzsjeAE9Kn/yiJ+nuP+15D/ul/gMVAlFihpuyboyJmvtMUFF9HXDOKMmpLZmByJXktmoyXchEq+qWibUbfxaIRZUX+dkQEMOhGj/YLIfYoYEI/E+DWRVyA57w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3F629C5A41C3F44941CA927FDD08BE3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4358.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa60a767-b569-4594-ce02-08d866bbefa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 10:14:23.7058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSHNMz6yHu944N2igY8NWDZuOwHYQ5O9Fwrmpuw2p602JLwbcHSsY8WkgeinIHpzeHVeHKHUg9SBdaliF+C7ykCkNKzopzfO3osotwq9BWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4488
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-02_05:2020-10-02,
 2020-10-02 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=felipe@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 06:14:32
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 John G Johnson <john.g.johnson@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Sep 30, 2020, at 3:24 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> On Tue, Sep 29, 2020 at 09:21:54AM -0700, John G Johnson wrote:
>>> On Sep 29, 2020, at 3:37 AM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>>>=20
>>> On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
>>>>> It should be accompanied by a test in tests/. PCI-level testing APIS =
for
>>>>> BARs, configuration space, interrupts, etc are available in
>>>>> tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
>>>>> device backend interact with QEMU's vfio-user-pci implementation.
>>>>=20
>>>> We plan to use a libmuser-based backend for testing. This, I suppose, =
will
>>>> make libmuser a dependency of QEMU (either as a submodule or as a libr=
ary),
>>>> which for now can be disabled in the default configuration. Is this ac=
ceptable?
>>>=20
>>> If there are no other dependencies and libmuser supports all host
>>> operating systems that QEMU's -device vfio-user supports, then I think
>>> it's a good idea to use libmuser for at least one in-tree test in QEMU.
>>>=20
>>>>> Also please let us know who is working on what so additional people c=
an
>>>>> get involved in areas that need work!
>>>>=20
>>>> Swapnil and I will be working on libmuser and the test in QEMU, John a=
nd
>>>> the mp-qemu folks will be working on the patches for implementing
>>>> --device vfio-user-pci.
>>>=20
>>> Great!
>>>=20
>>> John: Will mpqemu use libmuser to implement the remote PCI host
>>> controller?
>>>=20
>>=20
>>=20
>> 	The vfio-user-pci plan is to use libmuser on the server side.
>=20
> Okay. Using libmuser in tests seems like a good choice in that case.
>=20
> We'll need to figure out the details of how to do it because the
> traditional shared library dependency approach is not well-suited to
> in-development code. It would involve shipping libmuser distro packages
> so QEMU's build system can declare a library dependency (with details
> provided in a pkg-config file).
>=20
> Here are approaches that are better for in-development libraries:
> 1. Keep the libmuser code in qemu.git.
> 2. A copy of libmuser in qemu.git with changes being sent upstream
>   (allows more flexibility in case QEMU-specific issues require
>   experimentation).
> 3. Git submodules.
>=20
> #1 if you're happy to use the QEMU development process for merging
> libmuser code then it's easiest to officially host the code in qemu.git.
> libmuser gets a subdirectory in the qemu.git tree and you (the
> maintainers) send pull requests. A libmuser library build target
> provides installable static and shared libraries so external
> applications can link against libmuser too. The big advantage here is
> that QEMU can instantly use the latest libmuser code changes.

I think there's a couple of limitations here which we should keep in mind.

1. Does putting it in qemu.git precludes it being BSD-3?
There's been evidence of people using (or at least trying out) muser
from where it currently lives. That doesn't mean we can't move it, but
I'm wondering if it means we have to make it GPL.

2. What about other projects that need libmuser code?
What worries me more is projects like SPDK/DPDK wanting to link
against the library and having to clone the entire QEMU repo as a
submodule. That sounds a lot more expensive than option 3 and probably
have further complications if they aren't GPL.

>=20
> #2 works best if the library is a small (just a few source files) with
> no fancy build system requirements.

The risk here is that they go out of sync. There's the same (or even
more) maintenance burden as point 3 below, with the added risk that
someone could patch the files and make cherry-picks non-trivial.

>=20
> #3 is used in QEMU for several other components. Submodules are a pain
> to sync (requires sending a qemu.git patch to move to a new commit ID),
> so this isn't good for a dependency that moves quickly.

I argue this is no worse than option 2. It's what I think aligns best,
but let's keep weighing pros/cons and come to a conclusion together.
The list of maintainers for muser.git should be extended to include
more QEMU stakeholders and probably other projects that will use it
(as) heavily. The topic has been raised in SPDK's Slack team on
whether the client library should live in a repo of its own (eg.
libvfio-user.git). Given the reference implementation is in libmuser,
I still think muser.git is accurate (but can easily be persuaded
otherwise).

Cheers,
Felipe

>=20
> Stefan


