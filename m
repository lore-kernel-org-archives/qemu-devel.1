Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB00C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F8E2065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h38y2hRC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="D93+md/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F8E2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kORyn-0005rx-41
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 16:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=75442a8a1b=jordanfrank@fb.com>)
 id 1kOPf6-0001N0-GC; Fri, 02 Oct 2020 14:20:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=75442a8a1b=jordanfrank@fb.com>)
 id 1kOPf1-000849-4k; Fri, 02 Oct 2020 14:20:08 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 092IJ3JX023567; Fri, 2 Oct 2020 11:19:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WdmFFmDeqzltDJonXiKtRcJbbFAdaAfe0ezJIkJ58Oc=;
 b=h38y2hRCk9O8+fPH76+fkvJQWYwe+8BjhtUJ+THCugnLQy9NrFgbYxbNwWds5utlwYmh
 H+SYFrSGgrjgnxeapeE7yFMfLA9FTulYjObX5edayQsx/8qDk/Ons/qaKg0PAD+IETb5
 3T5Or77MyuWscIA2WWXDxbl7WGQu/jGHsKI= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com with ESMTP id 33vpwcxu19-15
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 02 Oct 2020 11:19:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 11:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfvDDjnRMg6SSHtMbF97hj2s8VBAGNozCCiys6/tjrFcCc3TFha9E/VKSCaktZDaqvhvp/1H8IkoeQRvqpBUVOzSCYewvX35+WK972p1irU+zhWBLD/6BccCUYr8TEg4Egl9eIdbx/kw49m38dga8drj7NyGAkRQK+rC3QfDx6rOX+Jpx8Tl3RPfotf0LWYnwRCtg0gQo/XFtrU0E2LuBpK+s2tDDxRTNwurR/FEP/MFfYvaAcqSca92gI3QNbYcd2kXPzMLgv78j+yDiKCQuj+nHM5/pc7ZI/O045f0fclW9kysLUfkV4/MkuV5IkVBlTxgtRfEICDMmQrIHWjJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdmFFmDeqzltDJonXiKtRcJbbFAdaAfe0ezJIkJ58Oc=;
 b=g4m2CJBhfKHK8NcmlMXfJtsX6YsuC9BPpnNzcSlzagqd7CMS8WinXwbHmwjQ9tKnHbzROEfKl01fmit5yvfjdy+IqJVOE/0rXS572Gs9HuElB0uk63rwIcoNxN1YON24BTLmt4e/SMVr/JRPioEarqcO2gntqRdxj8NvYCGmbtywbGHjJ6yLxZfyzBwSMshl9tpoDbU350ATt2JuDY+MWg/e/hAhRsCjfPAwSEHRtQH3DPb8AkUEY4i91ACrIjyJrcXZpXH3wYAbKigxesTP99ButRPwI4k4usDGMSxYrcMXN+uZzMQ2sg2QYr+rrDOuBjozooDYG4+hj4D5+xUHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdmFFmDeqzltDJonXiKtRcJbbFAdaAfe0ezJIkJ58Oc=;
 b=D93+md/nuJmewovCp+D4GT34QKgFTLYlsURy/ToKlSwn5eUOiU8EaP8NBYFdtOtYRfHGKi9EZSaef0fz75tXWq/8CPMlUVK/Qt2ZnVHxCt5N7GOWvLYtU+J7RtVYk/VUWjD2www61jm8KEnA8x6GrNyB3n95APlBi/BN91+X+J8=
Received: from MW3PR15MB4060.namprd15.prod.outlook.com (2603:10b6:303:4e::13)
 by MWHPR15MB1789.namprd15.prod.outlook.com (2603:10b6:301:50::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 18:19:41 +0000
Received: from MW3PR15MB4060.namprd15.prod.outlook.com
 ([fe80::5908:16e5:168f:d684]) by MW3PR15MB4060.namprd15.prod.outlook.com
 ([fe80::5908:16e5:168f:d684%7]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 18:19:41 +0000
From: Jordan Frank <jordanfrank@fb.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 0/2] target/arm: Fix tlb flush page vs tbi
Thread-Topic: [RFC PATCH 0/2] target/arm: Fix tlb flush page vs tbi
Thread-Index: AQHWmBVx/AmHgQcE8kiPxcHFSeitXKmEK6sA
Date: Fri, 2 Oct 2020 18:19:41 +0000
Message-ID: <9EC8E1F7-994D-4A92-B50E-F6A118043D5F@fb.com>
References: <20201001170752.82063-1-richard.henderson@linaro.org>
In-Reply-To: <20201001170752.82063-1-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.41.20091302
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:aa2c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2449041f-2007-4a35-deed-08d866ffbb60
x-ms-traffictypediagnostic: MWHPR15MB1789:
x-microsoft-antispam-prvs: <MWHPR15MB1789226B5518C4D768558725DD310@MWHPR15MB1789.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PREJfa/luMKHL43po09jho0HI6/W/w6q2YhTA8Q0L7faearhSEB9xtPFE01+ZVlFVV1LfFD4SWWau7+v36qghbdlElgnN5uXnlFasQkBRPnX0XLMOB2Q+harzARwgcdHXgsW7RU5ugAhxRwIIYRd4xEcPmtlnP0+KFAIxqQKir1VaC69rOaEf5KkWDE9HM4x5D5N/YdlpbJZDDKJUmXDT8SamLZgGoiS3TckFMbZvI94ctSaVJWQzEl/ROmQ3kuvsNCjZBxq55+iPaL4pPIsEcF6ISX9boPVjlhAvMYte5WsrRGZbDpZqCD/omUuW5sw9Y8w3ePyS4zd951iUCOb/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR15MB4060.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(396003)(346002)(366004)(376002)(33656002)(6506007)(83380400001)(2616005)(71200400001)(5660300002)(36756003)(76116006)(6486002)(186003)(8676002)(316002)(110136005)(66476007)(6512007)(66946007)(64756008)(478600001)(66446008)(66556008)(8936002)(2906002)(4326008)(54906003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZcMdKWtYH/P8sg2P35PJLlFWscUCLt61nrUmnkLZEL1Cy41IKN13lItSc0m1ON2eXAkwyGvIjp93yiwNm8PdG6Q4YqMde+2fAS2HVHuidb3Ba+oX36VjjnK/4KE8NN0aGyS64K0/02DIb/Qvo/I6Q80w3m7UaySvxamM/h9aP2UAbXkVCCd9FM13kO5CIo+XMe9pPHsFADZ7rgEAMM/mhdgKGKhVLt70wqwcko5hUn1GDEwWgT2IYwcywsOvLIYnPLzOQ0Ym19eOlFvlOUN4ncMv0ClOL1HdcvCcFXT09pZW8ttAnxKHMTJ8JzYYTqtHErfSpo0WeeQCefWtLYvHBmEM1uwkj1pMpBOotc67a5PvxLv3vxM6REZCnuR60ywMkLJdpSyo+McAbZecS4e9Hg5dqi4LTDol6wZbB2A6e8+FbSwoQoH/q8TC0CFZyeZDPTu/p/iFZ9F4+TLMeNJETmmWc96ZOyNEhSWpeDgY0aDFCHJo4p0iw2oz2cS+4oAg1Ho0aDtRv1djJ9KH2XEr9rCyx7PgsKVbaNlRrMW5Kun9RbyLcnTOFLWtCJ1iTAHIj8MRKLLIs7XP+HQhZlfr0PgGGKgbymENjq3vqB1pXl7spkx+q2A5C+ntYD1E47GpdlPgG1nYgfCWH1p9yWl9E7/OUTI1t+QGDIeMSpQgF8kDUFprAwMkQ4jIyRSg9zX3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <310B83843C55F5469B567FFD7D26EFD2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB4060.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2449041f-2007-4a35-deed-08d866ffbb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 18:19:41.7564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxLj64SRXZ2aCkD7gASfndzNiXPl7MxZZzLhLC6Faj8T60oQDryQv6u6VOpoAd0jZ+Yt8DCYqdAzVjtI1Tdm6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1789
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-02_11:2020-10-02,
 2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020133
X-FB-Internal: deliver
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=75442a8a1b=jordanfrank@fb.com;
 helo=mx0b-00082601.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 14:19:59
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 02 Oct 2020 16:47:13 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBjYW4gY29uZmlybSB0aGlzIHJlc29sdmVzIHRoZSBpc3N1ZSB3ZSB3ZXJlIHNlZWluZy4gVGhh
bmsgeW91IFJpY2hhcmQhDQoNCkJlc3QsDQpKb3JkYW4NCg0K77u/T24gMTAvMS8yMCwgMTA6MDgg
QU0sICJSaWNoYXJkIEhlbmRlcnNvbiIgPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+IHdy
b3RlOg0KDQogICAgU2luY2UgdGhlIEZBUl9FTHggZml4IGF0IDM4ZDkzMTY4N2ZhMSwgaXQgaXMg
cmVwb3J0ZWQgdGhhdA0KICAgIHBhZ2UgZ3JhbnVsYXJpdHkgZmx1c2hpbmcgaXMgYnJva2VuLg0K
DQogICAgVGhpcyBtYWtlcyBzZW5zZSwgc2luY2UgVENHIHdpbGwgcmVjb3JkIHRoZSBlbnRpcmUg
dmlydHVhbA0KICAgIGFkZHJlc3MgaW4gaXRzIFRMQiwgbm90IHNpbXBseSB0aGUgNTYgc2lnbmlm
aWNhbnQgYml0cy4NCiAgICBXaXRoIG5vIG90aGVyIFRDRyBzdXBwb3J0LCB0aGUgQVJNIGJhY2tl
bmQgc2hvdWxkIHJlcXVpcmUNCiAgICAyNTYgZGlmZmVyZW50IHBhZ2UgZmx1c2hlcyB0byBjbGVh
ciB0aGUgdmlydHVhbCBhZGRyZXNzIG9mDQogICAgYW55IHBvc3NpYmxlIHRhZy4NCg0KICAgIFNv
IEkgYWRkZWQgYSBuZXcgdGNnIGludGVyZmFjZSB0aGF0IGFsbG93cyBwYXNzaW5nIHRoZSBzaXpl
DQogICAgb2YgdGhlIHZpcnR1YWwgYWRkcmVzcy4gIEkgdGhvdWdodCBhIHNpbXBsZSBiaXQtY291
bnQgd2FzIGEgDQogICAgY2xlYW5lciBpbnRlcmZhY2UgdGhhbiBwYXNzaW5nIGluIGEgbWFzaywg
c2luY2UgaXQgbWVhbnMgdGhhdA0KICAgIHdlIGNvdWxkbid0IGJlIHBhc3NlZCBub25zZW5zaWNh
bCBtYXNrcyBsaWtlIDB4ZGVhZGJlZWYuICBJdA0KICAgIGFsc28gbWFrZXMgaXQgZWFzeSB0byBy
ZS1kaXJlY3Qgc3BlY2lhbCBjYXNlcy4NCg0KICAgIEkgZG9uJ3QgaGF2ZSBhIHRlc3QgY2FzZSB0
aGF0IHRyaWdnZXJzIHRoZSBidWcuICBBbGwgSSBjYW4gc2F5DQogICAgaXMgdGhhdCAoMSkgdGhp
cyBzdGlsbCBib290cyBhIG5vcm1hbCBrZXJuZWwgYW5kICgyKSB0aGUgY29kZQ0KICAgIHBhdGhz
IGFyZSB0cmlnZ2VyZWQgc2luY2UgdGhlIGtlcm5lbCBlbmFibGVzIHRiaSBmb3IgRUwwLg0KDQog
ICAgSm9yZGFuLCBjYW4geW91IHRlc3QgdGhpcyBwbGVhc2U/DQoNCg0KICAgIHJ+DQoNCg0KICAg
IFJpY2hhcmQgSGVuZGVyc29uICgyKToNCiAgICAgIGFjY2VsL3RjZzogQWRkIHRsYl9mbHVzaF9w
YWdlX2JpdHNfYnlfbW11aWR4Kg0KICAgICAgdGFyZ2V0L2FybTogVXNlIHRsYl9mbHVzaF9wYWdl
X2JpdHNfYnlfbW11aWR4Kg0KDQogICAgIGluY2x1ZGUvZXhlYy9leGVjLWFsbC5oIHwgIDM2ICsr
KysrKw0KICAgICBhY2NlbC90Y2cvY3B1dGxiLmMgICAgICB8IDI1OSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQogICAgIHRhcmdldC9hcm0vaGVscGVyLmMgICAgIHwg
IDQ2ICsrKysrLS0NCiAgICAgMyBmaWxlcyBjaGFuZ2VkLCAzMjUgaW5zZXJ0aW9ucygrKSwgMTYg
ZGVsZXRpb25zKC0pDQoNCiAgICAtLSANCiAgICAyLjI1LjENCg0KDQo=

