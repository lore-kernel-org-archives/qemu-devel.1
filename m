Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278972054F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="atjhxozF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278972054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Vkb-00047m-FV
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swapnil.ingle@nutanix.com>)
 id 1k6Vjj-0003bo-Pt; Fri, 14 Aug 2020 05:10:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:25868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swapnil.ingle@nutanix.com>)
 id 1k6Vjh-0002Xw-FG; Fri, 14 Aug 2020 05:10:55 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07E94MWN022580; Fri, 14 Aug 2020 02:10:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=BkNcENA2XpIjIue9M8QaF/+vBfWtR8JN7luWlxUjF7g=;
 b=atjhxozF6cWXeLWO8SGuN6r/A7KwtlfxXm+mg/MddaBMFVmhpkv9q5KIq6pEzrda+WAG
 hBL/O9py6njbx3YSFk0YQCj8j17IpRX+hEq5ykBmz5lfaknXPT//aw2j37H8waw3xGcX
 mDFjsde18vCm5GW9a/Y0UGbdPok7cLADplZ/Muczt2RjvPKsRncvuvRKJcN84rYTeBla
 tsVEa+BLQatnKajkgwRtXZJ2SDnAa+cdJ5XT2ACnHKqZlv7TFqcA9GvtteD/JK4m0cPD
 NKQgYkY3DFY0jIRYk5Zl0YIA/ZAP3ute7qZ6ndiuOvC7+nl/FSfqgYRupPPO6M5iHZCP Pw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0b-002c1b01.pphosted.com with ESMTP id 32wgv88qva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2020 02:10:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNTPulv3UZXVGI1X5XXHcmh9w70zlPc+nmnD6Ke4iR/ChbEvmlyOK/6rwaYzC9DSwvTCPk0B+CxHwDRFzc6pXqV0PnjbBtwLil4tZkcdru3Qp/NNYoSzmELJSZJ7VkXVJifBPQ7szLFsGaMv/Wj2AKaVBYfbfyYBtRAHbKxcMDiePLG6j+//H31qcal60XAasoaeYlcYBk5JTjQD+aMPWku+oJLIdxrTDbtz0qk+uvVz7E2Ns899a5x2iexgZYeaXRe1u441LNYIyhaYrn2EPMf2fupSrMf007T2+clvzoJALV8flRFaGaLbeI38o3cyCSKOXRpMJKLiXTeS1G+iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkNcENA2XpIjIue9M8QaF/+vBfWtR8JN7luWlxUjF7g=;
 b=HkBESzeTdNQw4W8/2nsx54TDckC1+afcMILFZ2O1XCol1OR390awF2aThG2/1zQDACa5OhpbGKf46+tS2KJI8Agq5AXUYt7SkR5HPGpRon4cNabNgXdQIovIhVYC+/QuzM79YWRcV4RQaTKxlQHLoUV+/saqp8CavEw7zD3qz6soShx7N8EMu7NJ/zp9R2FhFCU74i7p4Vj0m7zQycIRNFEjZuwQKiSf2GIAh0cJlcpuL00emulqgcuqqW0nsClVuCDYAOWbldqBuI3mxBqlRfpH0uclq9+3X5miNHmpkaDSJzT8pGBfrxmLuXk4/oX87szJdUScJRWL5lj5mc4/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB3958.namprd02.prod.outlook.com (2603:10b6:a02:fc::21)
 by BYAPR02MB4040.namprd02.prod.outlook.com (2603:10b6:a02:f8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 09:10:46 +0000
Received: from BYAPR02MB3958.namprd02.prod.outlook.com
 ([fe80::a1e2:236f:77aa:a3ff]) by BYAPR02MB3958.namprd02.prod.outlook.com
 ([fe80::a1e2:236f:77aa:a3ff%5]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 09:10:46 +0000
From: Swapnil Ingle <swapnil.ingle@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] block/vhdx: Support vhdx image only with 512 bytes
 logical sector size
Thread-Topic: [PATCH v2] block/vhdx: Support vhdx image only with 512 bytes
 logical sector size
Thread-Index: AQHWbKH+ANdQONG3D0S7i6q5o9DtZKk3fdiA
Date: Fri, 14 Aug 2020 09:10:46 +0000
Message-ID: <AAB55E95-BEF4-4403-8F94-334B9AE19C5F@nutanix.com>
References: <1596794594-44531-1-git-send-email-swapnil.ingle@nutanix.com>
In-Reply-To: <1596794594-44531-1-git-send-email-swapnil.ingle@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [37.235.116.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e821ffd-611d-4def-caf7-08d84031ee1b
x-ms-traffictypediagnostic: BYAPR02MB4040:
x-microsoft-antispam-prvs: <BYAPR02MB4040FA8198B24DBAE17149ECFD400@BYAPR02MB4040.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB3958.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(83380400001)(8936002)(91956017)(36756003)(6486002)(5660300002)(86362001)(33656002)(54906003)(26005)(44832011)(8676002)(6506007)(186003)(478600001)(6512007)(6916009)(316002)(2616005)(64756008)(66946007)(4326008)(66476007)(66556008)(66446008)(76116006)(2906002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <06A76CCD705B2046B66854B3383C0066@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e821ffd-611d-4def-caf7-08d84031ee1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 09:10:46.3610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaQqcM4xiSrKareiwaoJ/tvV10Me6fJA6oyd1r0yhhwk4WTz0DT4s2C1KqiqVGFcKISNSMctEUnQh6xvfaM5bzBTsasVf6LmHHbLfz743UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4040
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-14_04:2020-08-14,
 2020-08-14 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=swapnil.ingle@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:10:49
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Jeff Cody <codyprime@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>, "open
 list:VHDX" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZw0KDQrvu79PbiAwNy4wOC4yMCwgMTI6MDMsICJTd2FwbmlsIEluZ2xlIiA8c3dhcG5pbC5p
bmdsZUBudXRhbml4LmNvbT4gd3JvdGU6DQoNCiAgICBibG9jay92aGR4IHVzZXMgcWVtdSBibG9j
ayBsYXllciB3aGVyZSBzZWN0b3Igc2l6ZSBpcyBhbHdheXMgNTEyIGJ5dGVzLg0KICAgIFRoaXMg
bWF5IGhhdmUgaXNzdWVzICB3aXRoIDRLIGxvZ2ljYWwgc2VjdG9yIHNpemVkIHZoZHggaW1hZ2Uu
DQoNCiAgICBGb3IgZS5nIHFlbXUtaW1nIGNvbnZlcnQgb24gc3VjaCBpbWFnZXMgZmFpbHMgd2l0
aCBmb2xsb3dpbmcgYXNzZXJ0Og0KDQogICAgJHFlbXUtaW1nIGNvbnZlcnQgLWYgdmhkeCAtTyBy
YXcgNEtUZXN0MS52aGR4IHRlc3QucmF3DQogICAgcWVtdS1pbWc6IHV0aWwvaW92LmM6Mzg4OiBx
aW92X3NsaWNlOiBBc3NlcnRpb24gYG9mZnNldCArIGxlbiA8PQ0KICAgIHFpb3YtPnNpemUnIGZh
aWxlZC4NCiAgICBBYm9ydGVkDQoNCiAgICBUaGlzIHBhdGNoIGFkZHMgYW4gY2hlY2sgdG8gcmV0
dXJuIEVOT1RTVVAgZm9yIHZoZHggaW1hZ2VzIHdoaWNoDQogICAgaGF2ZSBsb2dpY2FsIHNlY3Rv
ciBzaXplIG90aGVyIHRoYW4gNTEyIGJ5dGVzLg0KDQogICAgU2lnbmVkLW9mZi1ieTogU3dhcG5p
bCBJbmdsZSA8c3dhcG5pbC5pbmdsZUBudXRhbml4LmNvbT4NCiAgICAtLS0NCiAgICB2MjogRml4
ZWQgY29tbWl0IG1lc3NhZ2UsIHN1Z2dlc3RlZCBieSBQaGlsaXBwZSBNYXRoaWV1LURhdWRlDQog
ICAgLS0tDQogICAgIGJsb2NrL3ZoZHguYyB8IDYgKysrLS0tDQogICAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCiAgICBkaWZmIC0tZ2l0IGEvYmxv
Y2svdmhkeC5jIGIvYmxvY2svdmhkeC5jDQogICAgaW5kZXggNzkxZWI5MC4uMzU2ZWM0YyAxMDA2
NDQNCiAgICAtLS0gYS9ibG9jay92aGR4LmMNCiAgICArKysgYi9ibG9jay92aGR4LmMNCiAgICBA
QCAtODE2LDkgKzgxNiw5IEBAIHN0YXRpYyBpbnQgdmhkeF9wYXJzZV9tZXRhZGF0YShCbG9ja0Ry
aXZlclN0YXRlICpicywgQkRSVlZIRFhTdGF0ZSAqcykNCiAgICAgICAgICAgICBnb3RvIGV4aXQ7
DQogICAgICAgICB9DQoNCiAgICAtICAgIC8qIG9ubHkgMiBzdXBwb3J0ZWQgc2VjdG9yIHNpemVz
ICovDQogICAgLSAgICBpZiAocy0+bG9naWNhbF9zZWN0b3Jfc2l6ZSAhPSA1MTIgJiYgcy0+bG9n
aWNhbF9zZWN0b3Jfc2l6ZSAhPSA0MDk2KSB7DQogICAgLSAgICAgICAgcmV0ID0gLUVJTlZBTDsN
CiAgICArICAgIC8qIEN1cnJlbnRseSB3ZSBvbmx5IHN1cHBvcnQgNTEyICovDQogICAgKyAgICBp
ZiAocy0+bG9naWNhbF9zZWN0b3Jfc2l6ZSAhPSA1MTIpIHsNCiAgICArICAgICAgICByZXQgPSAt
RU5PVFNVUDsNCiAgICAgICAgICAgICBnb3RvIGV4aXQ7DQogICAgICAgICB9DQoNCiAgICAtLSAN
CiAgICAyLjkuMw0KDQoNCg==

