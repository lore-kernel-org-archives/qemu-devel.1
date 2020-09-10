Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20915C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8159220855
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="P0ABytRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8159220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNjZ-0006Hj-Fp
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swapnil.ingle@nutanix.com>)
 id 1kGNit-0005WP-ET; Thu, 10 Sep 2020 10:38:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:27368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swapnil.ingle@nutanix.com>)
 id 1kGNir-0000kL-0S; Thu, 10 Sep 2020 10:38:50 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 08AEbWJO000938; Thu, 10 Sep 2020 07:38:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=PzWkjjY3qQxafZSOzL8pPVeZiCuVuG0WiILtyWBBsyY=;
 b=P0ABytRA5EA2udS3q2FWIvY3BRvhYqZ5LEX+Gc/4HDx6z2JCkWoM3r7Kc3fv+QkxWrsy
 of9nXRIpBh3gCaF4NrsOaxtJ48CyvTR32Eu9S3Wl02iczwwCZYdzLXwwxN9tJpnnpdgk
 c4SEN4cfJAGQhLPdMGB2L5dJhEDjHYGp+L9Dlh+IeLO0uHpmXKjktqmKZlRpNJtwRRZx
 r3gsHYT8WEEzeepy+THuf+2Mu7aoiQ5C0wmLsGZxEItaIdFsLJ2ERZIiqw0YQtrUqsBE
 L7MAo85RSCGBzbtko8gI2BDIx40xQVs9xGRqN2JXArXQ0AR89mUp5Pz8DHTDl3osV9kA tA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by mx0b-002c1b01.pphosted.com with ESMTP id 33euw8kjmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 07:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP9qliALjs8Nl3aA45FXiUwBid8k0yNa6P4A1pPymgdSnm/ITJQ+Qk8kLutJGunLVY5EFlxp0COva6kYzJqDqFftXLnoQt6dSfhrkhiD6FE6HCUaMBxIjrXBrUfuQQS8QK5AzfKdCWTYIKQZuYXAOaTtAx2gWFotxYLa/AlPyu5Vhdu77+KEEhnsSJdmQqx3Ku9gTSM/J11OKofuBfSR6jD04cfABayDdvuf31iQwnrjYXrI3NXM+FtPwzjz+XMemxiSXqEwRkYNLbNkNVkK3vqBQqy0p5xO4wIvD7U13qdmJ97DTwXY34foyQdCpSO95S+Jm8eQPYY2IfuU8U53qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzWkjjY3qQxafZSOzL8pPVeZiCuVuG0WiILtyWBBsyY=;
 b=lKh8pvftz3XplEHKhhHHdR4xoavGzkENnJ9J0F6p5WpGpdKKRX3atC7OSn2dk82brRQ2ekS5v5uleRZXo8Y2siCbMnwhjEUrj70PXzSnwDYjYMsr9RQ/1Vh5RxC/FKHRl6lxXw8O+DlL4A/pKDqQBzmkiY/0V/zQ0CvCJmQ2ajWkbYC/Uywl7ncd52XWbt+VuzSw2Uzwenr9lWlhz6JkJqZwkb7Rj+UaIsSDJ1WHcrMoZV9lTTh3fUljqU3ETeSqGhjCWGdm8gQbRmJvQ9OMqh/UKxpbap0P0ahq+8uqoF0YcJNbl0NE3lDkXMgCPnhIUkysOf/tXMTFg6eFV08cLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB3958.namprd02.prod.outlook.com (2603:10b6:a02:fc::21)
 by BYAPR02MB4695.namprd02.prod.outlook.com (2603:10b6:a03:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 14:38:44 +0000
Received: from BYAPR02MB3958.namprd02.prod.outlook.com
 ([fe80::a1e2:236f:77aa:a3ff]) by BYAPR02MB3958.namprd02.prod.outlook.com
 ([fe80::a1e2:236f:77aa:a3ff%5]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 14:38:44 +0000
From: Swapnil Ingle <swapnil.ingle@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] block/vhdx: Support vhdx image only with 512 bytes
 logical sector size
Thread-Topic: [PATCH v2] block/vhdx: Support vhdx image only with 512 bytes
 logical sector size
Thread-Index: AQHWbKH+ANdQONG3D0S7i6q5o9DtZKk3fdiAgCrKlIA=
Date: Thu, 10 Sep 2020 14:38:43 +0000
Message-ID: <780E4D6D-A022-4C6C-AE4E-EC44160560E2@nutanix.com>
References: <1596794594-44531-1-git-send-email-swapnil.ingle@nutanix.com>
 <AAB55E95-BEF4-4403-8F94-334B9AE19C5F@nutanix.com>
In-Reply-To: <AAB55E95-BEF4-4403-8F94-334B9AE19C5F@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [37.235.116.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d4b1063-a1ec-4bf6-b5f3-08d855973812
x-ms-traffictypediagnostic: BYAPR02MB4695:
x-microsoft-antispam-prvs: <BYAPR02MB4695AB9DB9A0EA30EC23D45FFD270@BYAPR02MB4695.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hRaOua2oeDZvTs0fdOB2YJj6zJlUwLz9gYgqlYNACdqdT3NIATnzSOqJF+R2P8ga06MT4BPGlpDtVNyFP9PivrT3M/84I28DldPpB85eZfsQKFhyXnf2U+LNzY1ZVqVHhsXOA8gyb/XsQEiYJJjtRfABA+/ewNGE26GcaquAIvDUh2tOqyYnvBPHeatt9BRz+16RRfQj00hkvuwfGPtZjSmfhIxsmN8xPF4kzPnxYsQD+EJXDoVe3O4EXr3Vh4Qsb+axMh/CvmM8dFpGzPiX7Qz8yeuFZt3AFQFS1vezF/G6Ypks/H5mJ0g7fu9+LaPY+GqfHYmrwmaA2Y4FJQjTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB3958.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(396003)(366004)(136003)(346002)(39860400002)(66556008)(76116006)(91956017)(64756008)(66946007)(2906002)(6506007)(36756003)(83380400001)(4326008)(186003)(2616005)(44832011)(53546011)(8676002)(6512007)(316002)(54906003)(8936002)(26005)(66446008)(5660300002)(6486002)(33656002)(71200400001)(478600001)(86362001)(6916009)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: GwAECklUFJxQK/aoG5f+NU6nNgYw6MgLEzlM5jI7I0YACjPSfK5wHNMuCchpzwfwurYXZJg9t5/CruFn4OjbM2v3vvaZLbkio0WChjF+a953AIuVUI//FOlJKaeAu73beyPBVvuibv+8fHyPmbMqP6MvuQHe5QXGzW77WRsdv+A4QC3Qte6t/C3Pijk6yfssC86BlyilqS8M5a9w+Q8+uB729c03S6bhJIj3uKultQMwBWG+CETJZ207Qo07GNRqr2/NGZF027tqgxJgkwolThrEvil1qP6XjdoyKQ9LvQU5GVsm1XeQEeCF8MaFab7LP3jheYkkD0nHyoWuvCTp5Bjsdhw7UHTe9X36a4DyEff1Wp0pKnY1VXEWSVAtfNVXXYIlPbbjXAnbI632J34cBk2VIfnSNeOSz9vzO9IwxtqakYO1heWvgHnoVPeC6XTKuEsz1ZhBiVp22K9tt4j9r+rafvRIOdK1H8GcLvhXId1vnyx5PbP+dtgyw/H3lVJq4EU+3s1PLQTvVyGy6BIkc4FzgRH8wNqxrh/WLUqZPhxryjZtWRL180E7tVpW4qjlh/f7zuqtsHXmRL5mvGEAaxLsUQ35QW3gnnab7gsvnyDYX0qWAD/sx2H5rG0Kw2JJZFOzeLwUn2HY8eta9H2zfQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D63B86AC4252B7468E636C487E1EF8B9@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4b1063-a1ec-4bf6-b5f3-08d855973812
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 14:38:44.0449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iLW9+VAzK9i4QJjQ1iaTgIHh78ttnXuprdfPARvGV9NYoh3BqD0HELTILvKTRwzW2BCBSbtxhcp6buY10nreAlbyCtlg0oSsWLekl3tbVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4695
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_04:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=swapnil.ingle@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 10:38:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

UGluZw0KDQrvu79PbiAxNC4wOC4yMCwgMTE6MTAsICJTd2FwbmlsIEluZ2xlIiA8c3dhcG5pbC5p
bmdsZUBudXRhbml4LmNvbT4gd3JvdGU6DQoNCiAgICBQaW5nDQoNCiAgICBPbiAwNy4wOC4yMCwg
MTI6MDMsICJTd2FwbmlsIEluZ2xlIiA8c3dhcG5pbC5pbmdsZUBudXRhbml4LmNvbT4gd3JvdGU6
DQoNCiAgICAgICAgYmxvY2svdmhkeCB1c2VzIHFlbXUgYmxvY2sgbGF5ZXIgd2hlcmUgc2VjdG9y
IHNpemUgaXMgYWx3YXlzIDUxMiBieXRlcy4NCiAgICAgICAgVGhpcyBtYXkgaGF2ZSBpc3N1ZXMg
IHdpdGggNEsgbG9naWNhbCBzZWN0b3Igc2l6ZWQgdmhkeCBpbWFnZS4NCg0KICAgICAgICBGb3Ig
ZS5nIHFlbXUtaW1nIGNvbnZlcnQgb24gc3VjaCBpbWFnZXMgZmFpbHMgd2l0aCBmb2xsb3dpbmcg
YXNzZXJ0Og0KDQogICAgICAgICRxZW11LWltZyBjb252ZXJ0IC1mIHZoZHggLU8gcmF3IDRLVGVz
dDEudmhkeCB0ZXN0LnJhdw0KICAgICAgICBxZW11LWltZzogdXRpbC9pb3YuYzozODg6IHFpb3Zf
c2xpY2U6IEFzc2VydGlvbiBgb2Zmc2V0ICsgbGVuIDw9DQogICAgICAgIHFpb3YtPnNpemUnIGZh
aWxlZC4NCiAgICAgICAgQWJvcnRlZA0KDQogICAgICAgIFRoaXMgcGF0Y2ggYWRkcyBhbiBjaGVj
ayB0byByZXR1cm4gRU5PVFNVUCBmb3IgdmhkeCBpbWFnZXMgd2hpY2gNCiAgICAgICAgaGF2ZSBs
b2dpY2FsIHNlY3RvciBzaXplIG90aGVyIHRoYW4gNTEyIGJ5dGVzLg0KDQogICAgICAgIFNpZ25l
ZC1vZmYtYnk6IFN3YXBuaWwgSW5nbGUgPHN3YXBuaWwuaW5nbGVAbnV0YW5peC5jb20+DQogICAg
ICAgIC0tLQ0KICAgICAgICB2MjogRml4ZWQgY29tbWl0IG1lc3NhZ2UsIHN1Z2dlc3RlZCBieSBQ
aGlsaXBwZSBNYXRoaWV1LURhdWRlDQogICAgICAgIC0tLQ0KICAgICAgICAgYmxvY2svdmhkeC5j
IHwgNiArKystLS0NCiAgICAgICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQoNCiAgICAgICAgZGlmZiAtLWdpdCBhL2Jsb2NrL3ZoZHguYyBiL2Jsb2Nr
L3ZoZHguYw0KICAgICAgICBpbmRleCA3OTFlYjkwLi4zNTZlYzRjIDEwMDY0NA0KICAgICAgICAt
LS0gYS9ibG9jay92aGR4LmMNCiAgICAgICAgKysrIGIvYmxvY2svdmhkeC5jDQogICAgICAgIEBA
IC04MTYsOSArODE2LDkgQEAgc3RhdGljIGludCB2aGR4X3BhcnNlX21ldGFkYXRhKEJsb2NrRHJp
dmVyU3RhdGUgKmJzLCBCRFJWVkhEWFN0YXRlICpzKQ0KICAgICAgICAgICAgICAgICBnb3RvIGV4
aXQ7DQogICAgICAgICAgICAgfQ0KDQogICAgICAgIC0gICAgLyogb25seSAyIHN1cHBvcnRlZCBz
ZWN0b3Igc2l6ZXMgKi8NCiAgICAgICAgLSAgICBpZiAocy0+bG9naWNhbF9zZWN0b3Jfc2l6ZSAh
PSA1MTIgJiYgcy0+bG9naWNhbF9zZWN0b3Jfc2l6ZSAhPSA0MDk2KSB7DQogICAgICAgIC0gICAg
ICAgIHJldCA9IC1FSU5WQUw7DQogICAgICAgICsgICAgLyogQ3VycmVudGx5IHdlIG9ubHkgc3Vw
cG9ydCA1MTIgKi8NCiAgICAgICAgKyAgICBpZiAocy0+bG9naWNhbF9zZWN0b3Jfc2l6ZSAhPSA1
MTIpIHsNCiAgICAgICAgKyAgICAgICAgcmV0ID0gLUVOT1RTVVA7DQogICAgICAgICAgICAgICAg
IGdvdG8gZXhpdDsNCiAgICAgICAgICAgICB9DQoNCiAgICAgICAgLS0gDQogICAgICAgIDIuOS4z
DQoNCg0KDQo=

