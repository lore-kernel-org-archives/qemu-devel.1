Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47506C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1031A206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TLlakkQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1031A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igmkG-0002By-6f
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 04:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1igmjW-0001h1-LT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1igmjU-0007ZU-M4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:32:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:52300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1igmjU-0007Yf-Es
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:32:04 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBG9VuY8019144
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 01:32:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 mime-version; s=proofpoint20171006;
 bh=nymh/VplcwGukp4WI+oVIs717kq17XAfmlcZEzWdCcA=;
 b=TLlakkQKclVEyORU712/k1BafOwouhuBhv+EWbdQ9qWvOIDgH+zmu5fKDDXHO133wBRj
 7LGO6aCstZYqVFyBuqKoK6TTTylyAW94dwI9ChMPUk4K87hQkGXNme+Au1v+ZyJccSpQ
 leHp42RdjUvNt+ordy4UvGUJU35Kir2qkNdvC94kM1fUSi6LgLKaSHya0mh1wwhrWqJ9
 08stY+Hv9cQjHfAoK8INlZ3epIEzL9aOZ2r0TQ7lnKERTdwtut0TPCsQUtkcAsEZwFmm
 PNUFgHL3uxLjbSBr9H4ZptVMNMNnvh1/mRUnrT128WEkFf3cHNhXWTsGZ3kOwjmgUU+m +g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2wvxqq2s06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 01:32:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeS2oN7lQDUI2uMpQYrHYlHzDAcoqg/8Q0id6Sie4hHui1LjGD9VO7AxZQ+Gf9lTT+2ktwX7MQeAz1W+Klzgrs6cEkKZNi8zSZHJt0vb6dfiCqv3GdF1U65wI9pKHXqTk2LH0w6tlCWCitufqScxybi2MVsTZ6pQXnxELhh1c0M4ipcqSHbE2uykbrNcsUw9PKydJgPq2/2b1oWhOoIlQEtalNQhGM1xSe8x5/fodt/3/KjPG6w+YkPbBYachiREuOgqOGNheeTyk2EFug+1aclKMT8/Z/PeZ4UAjoxxwe0cVim3rEhKNV6j6t1uiAp0QvtFjgLmPXH7qAECFFpbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nymh/VplcwGukp4WI+oVIs717kq17XAfmlcZEzWdCcA=;
 b=BAWZp0KpXfK2itcX4PC0N0Lqco+c4zwzXbtGP9l4vZAdtva3CozHFOTXfTz0/v3rrghq7i408aVqJAs3Z3QFNqfwxNkaPEK9YSwrwUsNmetR7ZZ7unI8+AoyNMHh/Gd4KcIngkMoWeOIVD49VyhNEKp2oGKGel0gZJcmtklLahUaQAJ762XnP5HGvxzgKuTqjAhvYt2QoseCcoTn/kOARU6jZPEN/mOf4DFki7WiNry6wexKYHCbdnjplPoyVZsW/tvjVI179ZfcHz97HhGgRRsSpDxnGSnR7LA2Qs+T2ObtiQ6H1CdV7fZNYmjF1FnQ7OnaOSzGXRhMh2vENepUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (52.132.175.28) by
 MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Mon, 16 Dec 2019 09:32:00 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 09:32:00 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHVqoZOjSXv+iujokWqHdP8EVn9wqe8kjwA
Date: Mon, 16 Dec 2019 09:31:59 +0000
Message-ID: <03e35f65-8631-40f9-b168-233b9eb47179@Spark>
References: <yes> <1575452190-105002-1-git-send-email-ani.sinha@nutanix.com>
In-Reply-To: <1575452190-105002-1-git-send-email-ani.sinha@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [103.68.105.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c07549b1-0449-4e9c-326a-08d7820acd5f
x-ms-traffictypediagnostic: MN2PR02MB5727:
x-microsoft-antispam-prvs: <MN2PR02MB5727DBE58974DA5AAC21FA35F1510@MN2PR02MB5727.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(8936002)(316002)(6916009)(81156014)(33716001)(81166006)(478600001)(8676002)(76116006)(91956017)(26005)(53546011)(86362001)(71200400001)(44832011)(6512007)(186003)(66946007)(31696002)(5660300002)(9686003)(2906002)(6506007)(6486002)(66556008)(66446008)(66476007)(64756008)(31686004)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB5727;
 H:MN2PR02MB6303.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6AjngRfROIWPHZfVGYb+YlvvaNrkEzkSgqk1byLKuV8sKLz3ZfO0JSeJjf1HGk9Zho/WbQ2GHTYtZkywM7KbauZL0+mlnJaqs9vTeX2uwtwweLfze61a5dffVtZhX+VZ4YHjnDwARemYr8uckrKFhiU1C+Xf1eIKPEwg3XsceX5TKo21SlOm8N+kse+sQ5qIi1ZTw5kpOd9LsE8ZnqG1TxK18ClC5UQzOVkof3yuk4yWt+5SSP2QaZ1GTiehy4NCp2cui1hBS7bMdOCCTo3IBVVKA0X1NFu+r02U3W0romlgm8PS66gKMJT17Q7EafvEgzJI8fSzHjg+3+lqp1WWZPqC8K41hSaU9fFrdNCE4980pmNyWsTsieS5tVCNjnkObcqlPa14pbUQZ+3MO6Huz09IO18jK+uMzAdcIDjpkpz8HNGP5YgG4Ou/usPD0ZiX5AeMFW5jdEs1hmRzVAvrkRuXXmBCqU3z5FAj4m1E3BOHqixmYplFF9rrSFENyBY7
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_03e35f65863140f9b168233b9eb47179Spark_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07549b1-0449-4e9c-326a-08d7820acd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 09:32:00.0088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uz/La4MAkGnN/cmK5garRzEdhkIP+uATOylxBO7tpfQw6qlj3MOQ9ZuP7BYiuB4zlWWnHc/Rmucra3X0kl0/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5727
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_02:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
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

--_000_03e35f65863140f9b168233b9eb47179Spark_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgOg0KDQpDYW4gSSBnZXQgc29tZSBsb3ZlIGZvciB0aGlzIHBhdGNoPw0KDQp0aGFua3MNCmFu
aQ0KDQpPbiBEZWMgNCwgMjAxOSwgMzowNiBQTSArMDUzMCwgQW5pIFNpbmhhIDxhbmkuc2luaGFA
bnV0YW5peC5jb20+LCB3cm90ZToNCkNMWkVSTyBDUFVJRCBzaG91bGQgYmUgcGFzc2VkIG9uIHRv
IHRoZSBndWVzdHMgdGhhdCB1c2UgRVBZQyBvciBFUFlDLUlCUEIgQ1BVDQptb2RlbCB3aGVuIHRo
ZSBBTUQgWkVOIGJhc2VkIGhvc3Qgc3VwcG9ydHMgaXQuIFRoaXMgY2hhbmdlIG1ha2VzIGl0IHJl
Y29nbml6ZQ0KdGhpcyBDUFVJRCBmb3IgZ3Vlc3RzIHdoaWNoIHVzZSBFUFlDIG9yIEVQWUMtSUJQ
QiBDUFUgbW9kZWwuDQoNClNpZ25lZC1vZmYtYnk6IEFuaSBTaW5oYSA8YW5pLnNpbmhhQG51dGFu
aXguY29tPg0KLS0tDQp0YXJnZXQvaTM4Ni9jcHUuYyB8IDIgKysNCjEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFyZ2V0
L2kzODYvY3B1LmMNCmluZGV4IDY5ZjUxOGEuLjU1ZjA2OTEgMTAwNjQ0DQotLS0gYS90YXJnZXQv
aTM4Ni9jcHUuYw0KKysrIGIvdGFyZ2V0L2kzODYvY3B1LmMNCkBAIC0zODEzLDYgKzM4MTMsOCBA
QCBzdGF0aWMgWDg2Q1BVRGVmaW5pdGlvbiBidWlsdGluX3g4Nl9kZWZzW10gPSB7DQpDUFVJRF9F
WFQzX01JU0FMSUdOU1NFIHwgQ1BVSURfRVhUM19TU0U0QSB8IENQVUlEX0VYVDNfQUJNIHwNCkNQ
VUlEX0VYVDNfQ1I4TEVHIHwgQ1BVSURfRVhUM19TVk0gfCBDUFVJRF9FWFQzX0xBSEZfTE0gfA0K
Q1BVSURfRVhUM19UT1BPRVhULA0KKyAuZmVhdHVyZXNbRkVBVF84MDAwXzAwMDhfRUJYXSA9DQor
IENQVUlEXzgwMDBfMDAwOF9FQlhfQ0xaRVJPLA0KLmZlYXR1cmVzW0ZFQVRfN18wX0VCWF0gPQ0K
Q1BVSURfN18wX0VCWF9GU0dTQkFTRSB8IENQVUlEXzdfMF9FQlhfQk1JMSB8IENQVUlEXzdfMF9F
QlhfQVZYMiB8DQpDUFVJRF83XzBfRUJYX1NNRVAgfCBDUFVJRF83XzBfRUJYX0JNSTIgfCBDUFVJ
RF83XzBfRUJYX1JEU0VFRCB8DQotLQ0KMS45LjQNCg0K

--_000_03e35f65863140f9b168233b9eb47179Spark_
Content-Type: text/html; charset="utf-8"
Content-ID: <4C358D47C31D7448970DF326BB829D7A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWwiPg0KPGhlYWQ+DQo8bWV0
YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11
dGYtOCI+DQo8dGl0bGU+PC90aXRsZT4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBuYW1lPSJtZXNz
YWdlQm9keVNlY3Rpb24iIHN0eWxlPSJmb250LXNpemU6IDE0cHg7IGZvbnQtZmFtaWx5OiAtYXBw
bGUtc3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsIHNhbnMtc2VyaWY7Ij4NCkhpIDoNCjxkaXY+
PGJyPg0KPC9kaXY+DQo8ZGl2PkNhbiBJIGdldCBzb21lIGxvdmUgZm9yIHRoaXMgcGF0Y2g/PC9k
aXY+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj50aGFua3M8L2Rpdj4NCjxkaXY+YW5pPC9kaXY+
DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2IG5hbWU9Im1lc3NhZ2VSZXBseVNlY3Rp
b24iIHN0eWxlPSJmb250LXNpemU6IDE0cHg7IGZvbnQtZmFtaWx5OiAtYXBwbGUtc3lzdGVtLCBC
bGlua01hY1N5c3RlbUZvbnQsIHNhbnMtc2VyaWY7Ij4NCk9uIERlYyA0LCAyMDE5LCAzOjA2IFBN
ICYjNDM7MDUzMCwgQW5pIFNpbmhhICZsdDthbmkuc2luaGFAbnV0YW5peC5jb20mZ3Q7LCB3cm90
ZTo8YnI+DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOiA1cHggNXB4OyBw
YWRkaW5nLWxlZnQ6IDEwcHg7IGJvcmRlci1sZWZ0OiB0aGluIHNvbGlkICMxYWJjOWM7Ij4NCkNM
WkVSTyBDUFVJRCBzaG91bGQgYmUgcGFzc2VkIG9uIHRvIHRoZSBndWVzdHMgdGhhdCB1c2UgRVBZ
QyBvciBFUFlDLUlCUEIgQ1BVPGJyPg0KbW9kZWwgd2hlbiB0aGUgQU1EIFpFTiBiYXNlZCBob3N0
IHN1cHBvcnRzIGl0LiBUaGlzIGNoYW5nZSBtYWtlcyBpdCByZWNvZ25pemU8YnI+DQp0aGlzIENQ
VUlEIGZvciBndWVzdHMgd2hpY2ggdXNlIEVQWUMgb3IgRVBZQy1JQlBCIENQVSBtb2RlbC48YnI+
DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBBbmkgU2luaGEgJmx0O2FuaS5zaW5oYUBudXRhbml4LmNv
bSZndDs8YnI+DQotLS08YnI+DQp0YXJnZXQvaTM4Ni9jcHUuYyB8IDIgJiM0MzsmIzQzOzxicj4N
CjEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoJiM0MzspPGJyPg0KPGJyPg0KZGlmZiAtLWdp
dCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFyZ2V0L2kzODYvY3B1LmM8YnI+DQppbmRleCA2OWY1
MThhLi41NWYwNjkxIDEwMDY0NDxicj4NCi0tLSBhL3RhcmdldC9pMzg2L2NwdS5jPGJyPg0KJiM0
MzsmIzQzOyYjNDM7IGIvdGFyZ2V0L2kzODYvY3B1LmM8YnI+DQpAQCAtMzgxMyw2ICYjNDM7Mzgx
Myw4IEBAIHN0YXRpYyBYODZDUFVEZWZpbml0aW9uIGJ1aWx0aW5feDg2X2RlZnNbXSA9IHs8YnI+
DQpDUFVJRF9FWFQzX01JU0FMSUdOU1NFIHwgQ1BVSURfRVhUM19TU0U0QSB8IENQVUlEX0VYVDNf
QUJNIHw8YnI+DQpDUFVJRF9FWFQzX0NSOExFRyB8IENQVUlEX0VYVDNfU1ZNIHwgQ1BVSURfRVhU
M19MQUhGX0xNIHw8YnI+DQpDUFVJRF9FWFQzX1RPUE9FWFQsPGJyPg0KJiM0MzsgLmZlYXR1cmVz
W0ZFQVRfODAwMF8wMDA4X0VCWF0gPTxicj4NCiYjNDM7IENQVUlEXzgwMDBfMDAwOF9FQlhfQ0xa
RVJPLDxicj4NCi5mZWF0dXJlc1tGRUFUXzdfMF9FQlhdID08YnI+DQpDUFVJRF83XzBfRUJYX0ZT
R1NCQVNFIHwgQ1BVSURfN18wX0VCWF9CTUkxIHwgQ1BVSURfN18wX0VCWF9BVlgyIHw8YnI+DQpD
UFVJRF83XzBfRUJYX1NNRVAgfCBDUFVJRF83XzBfRUJYX0JNSTIgfCBDUFVJRF83XzBfRUJYX1JE
U0VFRCB8PGJyPg0KLS08YnI+DQoxLjkuNDxicj4NCjxicj4NCjwvYmxvY2txdW90ZT4NCjxkaXY+
PC9kaXY+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_03e35f65863140f9b168233b9eb47179Spark_--

