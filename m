Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855BC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD88B206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JjdEvddH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD88B206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkhE-0005Xr-K8
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prerna.saxena@nutanix.com>)
 id 1kPkgT-00055l-Lv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:59:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:4098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prerna.saxena@nutanix.com>)
 id 1kPkgQ-0003YK-TV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:59:05 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 096Avv7H031740; Tue, 6 Oct 2020 03:58:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=vf7mA5lOHzKQhFaC5Syhcx5JWebhb7z+OdGthBiH5hk=;
 b=JjdEvddHs2nH4VtI6OtXsoldDu1wMwTHzObeZhtjxMZlfC38BOMxb6tmZjkZa7U5XpYc
 cVCz0lCqxP1pIlZzbWNalIzvIhq1GXMDFI9CtVJZ+uZOjztELY+YAhYqiWRbUQ5wNTM+
 Ejn9McBpl3YDfeBG+RrKMdUbW3XO4CHv5754r9LEvAkWK0cCKxGcLXf3t/VjmfaW5l6b
 8XJNc/db5ZDyKtD7DrAvzapWlq5bqPPcH4Zg5oX2afZXwkBcD/5YO1rWZg6GLYEPFvFJ
 iXyOZOu39ZjOf/2z7on3gg8dUGHU90mSOevQv7mKm7WzC7UNpY6SBOqkUxLiw0GLPpIe Lg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0b-002c1b01.pphosted.com with ESMTP id 33xqdk5tva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 03:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMX6gP3F8lv2IqypH6eh+u70E3lortHy1SD5GEeHt1cuVUzXdfM2J8/4wnO89pEL6SdSpAb+1TGausbb1sqLrEFqICg/Cghn/10xngma8tK7tCN9evQpG8FtglqZ8pp11hroM9CDXxgZXwv/zOG5Twx/BjIx6kuXauxGcvtWSl94RRLlFVZSHW/qT6fpBsZXuCQ1Njmn1QXR885XrXE3mrVEcMvjd8e4b0bJjtaenSkufZZAjWOFTWgJWMOZviOYW/e/BHEVujx0UPGx/pzO/Nf1QoLWD+tf1JBr086h9sV/kA4Hjy9w68/aQ+s6x1PjO7qj1YFyNEXSmNWA3GSfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf7mA5lOHzKQhFaC5Syhcx5JWebhb7z+OdGthBiH5hk=;
 b=nUjCkRU4k/WbGOFGloHonHMPw9rU965ax5h52ubrE4eAyoxpWjcPWjiaQdsDI/TxTRFp/nZrIFDjYDPcI2Dbb/foZhOCzii4zM6qhXZHN7MjldVcuehTcA+5xmXj0Ddhwg10h8+wJUDQNOwVfb0c6NvF8gglcvJdHh7NsNoocxMPzUoClEtfNQGsc7c9VukC7jVfYJdUUUluePc1R7lbf1RZsbqN1yVCFUf0pUrsf/AT1oAsAcWxxo/hTDDWLTK8Pw2tq56slFppf0UnDrwLY/HgwyDe4x8AVbCzzcKg06BykvsUCJRdqbakTGgPxZ6/NPPUpI9vEEvTAlZQ3A6CLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BY5PR02MB6833.namprd02.prod.outlook.com (2603:10b6:a03:206::7)
 by BY5PR02MB6067.namprd02.prod.outlook.com (2603:10b6:a03:1b2::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 6 Oct
 2020 10:58:54 +0000
Received: from BY5PR02MB6833.namprd02.prod.outlook.com
 ([fe80::d160:2f48:6ca:bf79]) by BY5PR02MB6833.namprd02.prod.outlook.com
 ([fe80::d160:2f48:6ca:bf79%6]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 10:58:53 +0000
From: Prerna Saxena <prerna.saxena@nutanix.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
Thread-Topic: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
Thread-Index: AQHWmnjjSe++FIvqx0eZ9r/9MLs9xamKxp+A
Date: Tue, 6 Oct 2020 10:58:53 +0000
Message-ID: <623FB9A5-9A36-4231-BA92-8744A8934B3B@nutanix.com>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-10-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-10-f4bug@amsat.org>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.40.20081000
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [106.201.124.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af2ff3aa-0b24-4daf-aa7b-08d869e6d0c9
x-ms-traffictypediagnostic: BY5PR02MB6067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB60675E93845FD0DCCFE227D9F00D0@BY5PR02MB6067.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+NuxytzBbyYwAWqyBKHvhKM7ETPyU9hcu3lhvzGjlejOqBMpResgCl9S3hwUhQBEHSWtneCQ4VOvMBFN9APKdd8t7ZhwNVX387yta5TzWhP6Z10ZlslwjrkO2mokjCj4k5pTOJ10cs1YGV0rPOiRHqA7UdZcN34Qd5d0if8ANXxl95eWdH51BqJuEal7v5ChKkdp3tQOTqiIllSXh6RSI6gsZQ7aZMpw7AdDWlUuIUwmprF6/dlWgNkxRjoHs/KMN+u4fN91aayixiCurdMrf1+41xPE4I3PdORC/uohKbenWxsx8+iNSdQRLcL35K61eT+IPMNfk80ZpcXpN40ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6833.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(83380400001)(45080400002)(33656002)(5660300002)(2906002)(4326008)(6512007)(8676002)(478600001)(8936002)(66946007)(110136005)(86362001)(316002)(71200400001)(54906003)(26005)(6506007)(91956017)(36756003)(66446008)(64756008)(66556008)(66476007)(76116006)(55236004)(186003)(6486002)(2616005)(44832011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hi5821gR9MO9Mc6KbgRn0NVI29qaakhq2ekvfykM3UFH71NSQPkxKh45iB+0i4jr8IQfeeLrgx88qbzn8SxcRs0DFhxpOtLQ9sz9ngZ4DPLdFHqIItX/YRUNUFE+6enbnrzaQnFhzAPzje+VL+QnzZ9ArmCnYwhtKXOlzhpGiKJYoepXksmqRJQ4lHUyNLTEWlcrlNptCYLlx0BSQ7+lf7Yy7uiBj/skAK9zujf3Q702dXtoP1pQqOMFz20rYmPOPJWo8fqSscKA8xNEH6+Qmii77+fwW6kd6a05O6NnsS8PT/MlkJG64iNQCz7cKM2ZsQ96y2IXBG/NeO1oPR4A2jFgoTdzFeFblaadYZtITl00b36T6KcEPLEKy2VdRuZJoKF219SBnVJX60nnRpus3FdZm3zfuiAYHF9DrQ/pfyq1tPRgbqt0dx0glBukL6fngXd+89et8NatnrmkaRZjj4Q7w+UcJn+jrTRQZnfguz9g2xmpSTb1zZn8EubDtuDZ+i1V1qPO/7D3oK7rpizu0svCX27hC2qdzpyyjavuvJllOaXenA2Z17Lh7blaB1w5sug3/IbIdd8YInKiO8EKkfMyyNan7bZwdrP53lM3arsAiFs0Dk7vK/M2esEtAhNFSdEPagcZlbqROK2g9L/c0Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <637669322EEFCA478BC5C9C7490B9E22@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6833.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2ff3aa-0b24-4daf-aa7b-08d869e6d0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 10:58:53.6160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qsv7kR5xXdwN10z/Z9fIsUeu9ApR+64TmTwH5kgG33EdClj0Z7GGzLKFR35cVUpWRzLi2SJ6a8MpqYan/KKSVnPyX6Tr3mg55tLpGrRwQgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6067
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-06_03:2020-10-06,
 2020-10-06 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=prerna.saxena@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 06:58:59
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, Jonathan Davies <jond@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>, Ani Sinha <ani@anisinha.ca>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCu+7v09uIDA0LzEwLzIwLCAxMTozNSBQTSwgIlBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIiA8
ZjRidWdAYW1zYXQub3JnPiB3cm90ZToNCg0KICAgIFRoZXJlIGlzIGEgbnVtYmVyIG9mIGNvbnRy
aWJ1dG9ycyBmcm9tIHRoaXMgZG9tYWluLA0KICAgIGFkZCBpdHMgb3duIGVudHJ5IHRvIHRoZSBn
aXRkbSBkb21haW4gbWFwLg0KDQogICAgQ2M6IEFuaSBTaW5oYSA8YW5pLnNpbmhhQG51dGFuaXgu
Y29tPg0KICAgIENjOiBEYXZpZCBWcmFiZWwgPGRhdmlkLnZyYWJlbEBudXRhbml4LmNvbT4NCiAg
ICBDYzogRmVsaXBlIEZyYW5jaW9zaSA8ZmVsaXBlQG51dGFuaXguY29tPg0KICAgIENjOiBKb25h
dGhhbiBEYXZpZXMgPGpvbmF0aGFuLmRhdmllc0BudXRhbml4LmNvbT4NCiAgICBDYzogTWFsY29s
bSBDcm9zc2xleSA8bWFsY29sbUBudXRhbml4LmNvbT4NCiAgICBDYzogTWlrZSBDdWkgPGN1aUBu
dXRhbml4LmNvbT4NCiAgICBDYzogUGV0ZXIgVHVyc2NobWlkIDxwZXRlci50dXJzY2htQG51dGFu
aXguY29tPg0KICAgIENjOiBQcmVybmEgU2F4ZW5hIDxwcmVybmEuc2F4ZW5hQG51dGFuaXguY29t
Pg0KICAgIENjOiBSYXBoYWVsIE5vcndpdHogPHJhcGhhZWwubm9yd2l0ekBudXRhbml4LmNvbT4N
CiAgICBDYzogU3dhcG5pbCBJbmdsZSA8c3dhcG5pbC5pbmdsZUBudXRhbml4LmNvbT4NCiAgICBD
YzogQW5pIFNpbmhhIDxhbmlAYW5pc2luaGEuY2E+DQogICAgU2lnbmVkLW9mZi1ieTogUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0Lm9yZz4NCiAgICAtLS0NCiAgICBPbmUgUmV2
aWV3ZWQtYnkvQWNrLWJ5IGZyb20gc29tZW9uZSBmcm9tIHRoaXMgZG9tYWluDQogICAgc2hvdWxk
IGJlIHN1ZmZpY2llbnQgdG8gZ2V0IHRoaXMgcGF0Y2ggbWVyZ2VkLg0KDQogICAgQW5pLCBjYW4g
eW91IGNvbmZpcm0gdGhlIGFuaUBhbmlzaW5oYS5jYSBlbWFpbD8NCiAgICBTaG91bGQgaXQgZ28g
aW50byAnaW5kaXZpZHVhbCBjb250cmlidXRvcnMnIGluc3RlYWQ/DQogICAgLS0tDQogICAgIGNv
bnRyaWIvZ2l0ZG0vZG9tYWluLW1hcCAgICAgICAgfCAxICsNCiAgICAgY29udHJpYi9naXRkbS9n
cm91cC1tYXAtbnV0YW5peCB8IDIgKysNCiAgICAgZ2l0ZG0uY29uZmlnICAgICAgICAgICAgICAg
ICAgICB8IDEgKw0KICAgICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KICAgICBj
cmVhdGUgbW9kZSAxMDA2NDQgY29udHJpYi9naXRkbS9ncm91cC1tYXAtbnV0YW5peA0KDQogICAg
ZGlmZiAtLWdpdCBhL2NvbnRyaWIvZ2l0ZG0vZG9tYWluLW1hcCBiL2NvbnRyaWIvZ2l0ZG0vZG9t
YWluLW1hcA0KICAgIGluZGV4IDQ4NTBlYWI0YzQuLjM5MjUxZmQ5N2MgMTAwNjQ0DQogICAgLS0t
IGEvY29udHJpYi9naXRkbS9kb21haW4tbWFwDQogICAgKysrIGIvY29udHJpYi9naXRkbS9kb21h
aW4tbWFwDQogICAgQEAgLTI0LDYgKzI0LDcgQEAgbGluYXJvLm9yZyAgICAgIExpbmFybw0KICAg
ICBjb2Rlc291cmNlcnkuY29tIE1lbnRvciBHcmFwaGljcw0KICAgICBtaWNyb3NvZnQuY29tICAg
TWljcm9zb2Z0DQogICAgIG5va2lhLmNvbSAgICAgICBOb2tpYQ0KICAgICtudXRhbml4LmNvbSAg
ICAgTnV0YW5peA0KICAgICBvcmFjbGUuY29tICAgICAgT3JhY2xlDQogICAgIHByb3htb3guY29t
ICAgICBQcm94bW94DQogICAgIHJlZGhhdC5jb20gICAgICBSZWQgSGF0DQogICAgZGlmZiAtLWdp
dCBhL2NvbnRyaWIvZ2l0ZG0vZ3JvdXAtbWFwLW51dGFuaXggYi9jb250cmliL2dpdGRtL2dyb3Vw
LW1hcC1udXRhbml4DQogICAgbmV3IGZpbGUgbW9kZSAxMDA2NDQNCiAgICBpbmRleCAwMDAwMDAw
MDAwLi5hM2YxMTQyNWIzDQogICAgLS0tIC9kZXYvbnVsbA0KICAgICsrKyBiL2NvbnRyaWIvZ2l0
ZG0vZ3JvdXAtbWFwLW51dGFuaXgNCiAgICBAQCAtMCwwICsxLDIgQEANCiAgICArcmFwaGFlbC5z
Lm5vcndpdHpAZ21haWwuY29tDQogICAgK2FuaUBhbmlzaW5oYS5jYQ0KICAgIGRpZmYgLS1naXQg
YS9naXRkbS5jb25maWcgYi9naXRkbS5jb25maWcNCiAgICBpbmRleCBjMDFjMjE5MDc4Li40Zjgy
MWFiOGJhIDEwMDY0NA0KICAgIC0tLSBhL2dpdGRtLmNvbmZpZw0KICAgICsrKyBiL2dpdGRtLmNv
bmZpZw0KICAgIEBAIC0zNyw2ICszNyw3IEBAIEdyb3VwTWFwIGNvbnRyaWIvZ2l0ZG0vZ3JvdXAt
bWFwLWNhZGVuY2UgQ2FkZW5jZSBEZXNpZ24gU3lzdGVtcw0KICAgICBHcm91cE1hcCBjb250cmli
L2dpdGRtL2dyb3VwLW1hcC1jb2Rld2VhdmVycyBDb2RlV2VhdmVycw0KICAgICBHcm91cE1hcCBj
b250cmliL2dpdGRtL2dyb3VwLW1hcC1pYm0gSUJNDQogICAgIEdyb3VwTWFwIGNvbnRyaWIvZ2l0
ZG0vZ3JvdXAtbWFwLWphbnVzdGVjaCBKYW51cyBUZWNobm9sb2dpZXMNCiAgICArR3JvdXBNYXAg
Y29udHJpYi9naXRkbS9ncm91cC1tYXAtbnV0YW5peCBOdXRhbml4DQoNCiAgICAtLSANCiAgICAy
LjI2LjINCg0KTEdUTS4gUmFwaGFlbCBpcyBzdGlsbCBhIHBhcnQgb2YgTnV0YW5peC4gSSBzZWUg
QW5pIGhhcyBhbHJlYWR5IHJlc3BvbmRlZCBhYm91dCBoaW0gbm90IGJlaW5nIHdpdGggdGhlIGNv
bXBhbnkgYW55bW9yZSwgc28geW91IG1pZ2h0IHdhbnQgdG8gYWRkIGhpbSB0byB0aGUgaW5kaXZp
ZHVhbCBjb250cmlidXRvcnMnIGxpc3QuDQoNClJlZ2FyZHMsDQpQcmVybmENCg0K

