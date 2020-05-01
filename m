Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959FEC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A6C2166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DFH8XhbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A6C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXH4-0005S3-Gu
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1jUXCt-0005vh-5D
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1jUXAB-0003aX-5R
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:04:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:4764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1jUXAA-0003XB-H3
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:01:14 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 041F01d4030455; Fri, 1 May 2020 08:01:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=cbUasJg7Iujy16Xd6Oc4ModPv1kYTElL54kGqErjcHs=;
 b=DFH8XhbA/OaYi8KIMtXV3AdoVcFiJntfgSwWizgBKNlhxnwkJthd1mIYYEGadrFwxlaq
 +Xmtl8bO08rGZuu9XmqbyZ2MyThz5Cw4nrT45M9Mz/SMS9AS6sTOywlF8h+DJWbgrT6L
 WWAf9wTPE52mVVjXzkD/nmMZeStQSBpfOo7suy8cTq1mqu5TkJJv/CzcrumCtHnjLzO1
 iljWMY9XGVqW4BIPsX4iB6KqLyJOodDvpKzUwEChpgmxYwLf6FQ7xhD8WyviQ06MNjCe
 4AHR7Dm8CqxDWvcUBdgMYRAcPHvZG9AbIm1dEbJ7J3xhT0uDZg1SwigKFL0Pbh9dcrQr xA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30r7jdsd86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2020 08:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/74xW9xMSAXhwK4F1o/XlZr7Y+Rg0lDPkoSthFO/fNjyNCAeuOdSKA4u5XvPFcCLsKLWY3aRZhXDuhKSHbQBt323PoQdQDG951/0901DcTpUUSJYY1rRgtiYOEXCDNZcvG4Zc1oGn5RrRSShA5ze06TiuBl7UiRwvyDwm1zdxvYaRnia4cj2cJS+6JWNxWOkAiZpsJvk5lYBlQ34sjzOB6UskWcGSFRN5DlpynhABrRXodXpeNchGcGyu4tXeeKVhsQhWb44ZNfK3yGMZ0tWmF1kRv1MEQc7UbFeKgoJiFk6UkOUut6tzAiht1B75yTV7NSFpe7isPSCjLEA5emAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbUasJg7Iujy16Xd6Oc4ModPv1kYTElL54kGqErjcHs=;
 b=iiCBICVbgj1d2YamVLnN/adcXzZhFkm6wUOMzdgw3iUDLHPPYwmh1MPvCiwYbiHtJacJ0Oc0wlHGt+M3eUyczn3v7zf+vtbtIoOHOxOWYDA1iREkvCro5VmYzEqja7kUfcueLB81QvPV8oE5nlL3NvIv48FTplQmxdtMi61Svs1Z3oSYt0ZHuBSnv6hiYVEzfvAshaT6vkP/hDGU/pay3hUtQRQqjKTkaC6XOdAfkxMJqvpX7crce3WGnLk3ImVDyWMpHIL9MWtAWzRNfBDIcWWr09keseiLgX7PSymfMOobczYuZHzq9PF6/xyyMis3wtKRgZTNgWiMlN1oY3YOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4358.namprd02.prod.outlook.com (2603:10b6:a03:11::17)
 by BYAPR02MB5512.namprd02.prod.outlook.com (2603:10b6:a03:9a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 1 May
 2020 15:01:01 +0000
Received: from BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::78ae:73d2:c58c:78f7]) by BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::78ae:73d2:c58c:78f7%7]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 15:01:01 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Stefan
 Hajnoczi <stefanha@gmail.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9QEsuagAA77zu+AAbiuPAADxCFGgAJikHLAAAKqfgAAHJa0QADIjmQA=
Date: Fri, 1 May 2020 15:01:01 +0000
Message-ID: <F64E2C4A-ED0D-43AE-8A34-C6693DDFF93A@nutanix.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200430114041.GN2084570@redhat.com>
 <MW2PR02MB37238FD8B5930EB45B533BFF8BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
In-Reply-To: <MW2PR02MB37238FD8B5930EB45B533BFF8BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c5e5a35-19fe-4a1b-b9ae-08d7ede07672
x-ms-traffictypediagnostic: BYAPR02MB5512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB551234D1B0BC8BF5A72DF035D7AB0@BYAPR02MB5512.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0390DB4BDA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4358.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(136003)(396003)(366004)(39860400002)(376002)(110136005)(316002)(4326008)(66946007)(6506007)(6486002)(66556008)(64756008)(66446008)(66476007)(6512007)(186003)(8676002)(33656002)(36756003)(71200400001)(8936002)(54906003)(26005)(2616005)(7416002)(5660300002)(2906002)(86362001)(76116006)(966005)(19627235002)(53546011)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kjJtjLB0xyGlueg9VfMD4CKoId5SpzRIW+NBgNO4BZZMvpypxbdJVOOYBdEMXEPNpYIIf/BVcF28OLLDrRsRLh65WX/NGbgnUxKP+l1SM8d1xNtTvTxqLw1ref1pWH8impRnCsG4iD7lor9AR+vZEQDG+mZJv3Wz5YkYCRWb2WRN9miNOi+VaTFemVtiRAJsHs+3bgk9y4phD5I+biUVDCRr2fVi/Kd8loyM/j0Unpf6FjEtWyHeRuUZEuJZLg5sKIcz/+3Pnpj+dBJURUnfMoV7L+0JXAhFfWyOhT4SWRvq0jmfgdpJk1KaUA//nq5eEZKCc8J8adTK7x8avkeIO4ovUAjywgJ3+oGvMey+eGwIqY9UZCkd6VliHayswG+Y+0JPkITV4cf/JM5uvxx1CNNqCsd2KPj7tCUOlQtWSt4rtPWcb1Kk2G3tFIToRl1pTgDQ1ozBONO5B+36Yshz0kGGfnGSxuDFF0C4bDnFk7Ul+HEuWowLJVsqFfX4Cu2ztInBfrqaTpCn1hY/dnJ7w==
x-ms-exchange-antispam-messagedata: X+imaiAhokJg5EIRNFktnJ6rDL3k0JFP8WbAEHhM0mtygU7PZsbpJ8TMbbLGHmxUz0WUR1Yz7mGwUTeBaoplsXDzpmiJAZxVFiBpvcChREbh8lF9kq/HsTImZ91pZoQZKy8XqQYJ1zpjka9FyvWIeJdRo17VmYjpo6MYCKa+clbFNH7rIEKscWp/ZxuGvhZJR2efpRevD7nQEL/Z25KuF2t2QRfmwiGLp/PGMuvimTyjM0gJRiAIxOm7udub6GAqFNgHIMeNOExBjhiv8JXRnKrjQ+wCyoPQx21onoalbcXgbIzP4d3tzgc3+savoq7gQZ3pvfRH4x+GZ96LCXLpap5/I3IgLttRRyFkjiYLwcDcFkUGn61B+W5bdODalMRwC9Fo/EpWPTuC+n7YXEA24aQnazwzVUwHwAjknjUMut3VGuwY00ROoExKUJxvz8FO7cWzwBzjWlGKpQz+x3RyNgs5fwl9EF9CJi74KtWWUdOJZ+O2PiawafDmu8RQBc+lMM+VHlz4tWtjRAHxTC8Lel5ItmRoTkkzVKEVzI4X91PjQ57rZSgrm7C5bgXXVpjIFEd0zxqh0aEfP/9oWwCKdPR/C/YJsLlH1nF/rjKUsEjyOR9wTx3T6nfShB3clXOMEGgZaP06D1PuzSiAw5MIN1JnnCkbbCog3klKUbmDwB6oNYNSS1fCpKJ49j40+UTaOfbUvcnctJglMJcifm1tIaTImTsc9NJZ4b+AW8LcRzSmIHN64E4lPbaWgBcmP5/i1caekosd+LIMbK+t/4zUIc0MMdjauMn17W6t84NELiU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBC68484CF28A54D9C6C12EE5A41554F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5e5a35-19fe-4a1b-b9ae-08d7ede07672
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 15:01:01.0152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpZLmeOU/m9J9eQHBdNRtw+EDjAoKITS78200W2GBjN6YEmHK3bEJGCGnaP5Zl2sag0upVsMsCs0WHz4nxxaIzKhGj7DihxkQ11bk/ORcWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-01_08:2020-05-01,
 2020-05-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=felipe@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 11:01:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNCj4gT24gQXByIDMwLCAyMDIwLCBhdCA0OjIwIFBNLCBUaGFub3MgTWFrYXRvcyA8dGhh
bm9zLm1ha2F0b3NAbnV0YW5peC5jb20+IHdyb3RlOg0KPiANCj4+Pj4gTW9yZSBpbXBvcnRhbnRs
eSwgY29uc2lkZXJpbmc6DQo+Pj4+IGEpIE1hcmMtQW5kcsOpJ3MgY29tbWVudHMgYWJvdXQgZGF0
YSBhbGlnbm1lbnQgZXRjLiwgYW5kDQo+Pj4+IGIpIHRoZSBwb3NzaWJpbGl0eSB0byBydW4gdGhl
IHNlcnZlciBvbiBhbm90aGVyIGd1ZXN0IG9yIGhvc3QsDQo+Pj4+IHdlIHdvbid0IGJlIGFibGUg
dG8gdXNlIG5hdGl2ZSBWRklPIHR5cGVzLiBJZiB3ZSBkbyB3YW50IHRvIHN1cHBvcnQgdGhhdA0K
Pj4+PiB0aGVuDQo+Pj4+IHdlJ2xsIGhhdmUgdG8gcmVkZWZpbmUgYWxsIGRhdGEgZm9ybWF0cywg
c2ltaWxhciB0bw0KPj4+PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJs
P3U9aHR0cHMtDQo+Pj4+IDNBX19naXRodWIuY29tX3FlbXVfcWVtdV9ibG9iX21hc3Rlcl9kb2Nz
X2ludGVyb3Bfdmhvc3QtDQo+Pj4+IA0KPj4gMkR1c2VyLnJzdCZkPUR3SUZBdyZjPXM4ODNHcFVD
T0NoS09IaW9jWXRHY2cmcj1YVHBZc2g1UHMyekp2dHc2DQo+Pj4+IA0KPj4gb2d0dGk0NmF0azcz
NlNJNHZnc0ppVUtJeURFJm09bEpDN1llTU1zQWFWc3I5OXRtVFluY1FkakVmT1hpSlFrUmtKDQo+
Pj4+IFc3Tk1nUmcmcz0xZF9rQjdWV1EtDQo+PiA4ZDR0NklrZ2E1S1NWd3dzNHZ3aVZNdlR5V1Zh
UzZQUlUmZT0gLg0KPj4+PiANCj4+Pj4gU28gdGhlIHByb3RvY29sIHdpbGwgYmUgbW9yZSBsaWtl
IGFuIGVuaGFuY2VkIHZlcnNpb24gb2YgdGhlIFZob3N0LXVzZXINCj4+Pj4gcHJvdG9jb2wNCj4+
Pj4gdGhhbiBWRklPLiBJJ20gZmluZSB3aXRoIGVpdGhlciBkaXJlY3Rpb24gKFZGSU8gdnMuIGVu
aGFuY2VkIFZob3N0LXVzZXIpLA0KPj4+PiBzbyB3ZSBuZWVkIHRvIGRlY2lkZSBiZWZvcmUgcHJv
Y2VlZGluZyBhcyB0aGUgcmVxdWVzdCBmb3JtYXQgaXMNCj4+Pj4gc3Vic3RhbnRpYWxseQ0KPj4+
PiBkaWZmZXJlbnQuDQo+Pj4gDQo+Pj4gUmVnYXJkaW5nIHRoZSBhYmlsaXR5IHRvIHVzZSB0aGUg
cHJvdG9jb2wgb24gbm9uLUFGX1VOSVggc29ja2V0cywgd2UgY2FuDQo+Pj4gc3VwcG9ydCB0aGlz
IGZ1dHVyZSB1c2UgY2FzZSB3aXRob3V0IHVubmVjZXNzYXJpbHkgY29tcGxpY2F0aW5nIHRoZQ0K
Pj4gcHJvdG9jb2wgYnkNCj4+PiBkZWZpbmluZyB0aGUgQyBzdHJ1Y3RzIGFuZCBzdGF0aW5nIHRo
YXQgZGF0YSBhbGlnbm1lbnQgYW5kIGVuZGlhbm5lc3MgZm9yDQo+PiB0aGUNCj4+PiBub24gQUZf
VU5JWCBjYXNlIG11c3QgYmUgdGhlIG9uZSB1c2VkIGJ5IEdDQyBvbiBhIHg4Nl82NCBiaXQgbWFj
aGluZSwNCj4+IG9yIGNhbg0KPj4+IGJlIG92ZXJyaWRkZW4gYXMgcmVxdWlyZWQuDQo+PiANCj4+
IERlZmluaW5nIGl0IHRvIGJlIHg4Nl82NCBzZW1hbnRpY3MgaXMgZWZmZWN0aXZlbHkgc2F5aW5n
ICJ3ZSdyZSBub3QgZ29pbmcNCj4+IHRvIGRvIGFueXRoaW5nIGFuZCBpdCBpcyB1cCB0byBvdGhl
ciBhcmNoIG1haW50YWluZXJzIHRvIGZpeCB0aGUgaW5ldml0YWJsZQ0KPj4gcG9ydGFiaWxpdHkg
cHJvYmxlbXMgdGhhdCBhcmlzZSIuDQo+IA0KPiBQcmV0dHkgbXVjaC4NCj4gDQo+PiBTaW5jZSB0
aGlzIGlzIGEgbmV3IHByb3RvY29sIHNob3VsZCB3ZSB0YWtlIHRoZSBvcHBvcnR1bml0eSB0byBt
b2RlbCBpdA0KPj4gZXhwbGljaXRseSBpbiBzb21lIGNvbW1vbiBzdGFuZGFyZCBSUEMgcHJvdG9j
b2wgbGFuZ3VhZ2UuIFRoaXMgd291bGQgaGF2ZQ0KPj4gdGhlIGJlbmVmaXQgb2YgYWxsb3dpbmcg
aW1wbGVtZW50b3JzIHRvIHVzZSBvZmYgdGhlIHNoZWxmIEFQSXMgZm9yIHRoZWlyDQo+PiB3aXJl
IHByb3RvY29sIG1hcnNoYWxsaW5nLCBhbmQgZWxpbWluYXRlIHF1ZXN0aW9ucyBhYm91dCBlbmRp
YW5uZXNzIGFuZA0KPj4gYWxpZ25tZW50IGFjcm9zcyBhcmNoaXRlY3R1cmVzLg0KPiANCj4gVGhl
IHByb2JsZW0gaXMgdGhhdCB3ZSBoYXZlbid0IGRlZmluZWQgdGhlIHNjb3BlIHZlcnkgd2VsbC4g
TXkgaW5pdGlhbCBpbXByZXNzaW9uIA0KPiB3YXMgdGhhdCB3ZSBzaG91bGQgdXNlIHRoZSBleGlz
dGluZyBWRklPIHN0cnVjdHMgYW5kIGNvbnN0YW50cywgaG93ZXZlciB0aGF0J3MgDQo+IGltcG9z
c2libGUgaWYgd2UncmUgdG8gc3VwcG9ydCBub24gQUZfVU5JWC4gV2UgbmVlZCBjb25zZW5zdXMg
b24gdGhpcywgd2UncmUgDQo+IG9wZW4gdG8gaWRlYXMgaG93IHRvIGRvIHRoaXMuDQoNClRoYW5v
cyBoYXMgYSBwb2ludC4NCg0KRnJvbSBodHRwczovL3dpa2kucWVtdS5vcmcvRmVhdHVyZXMvTXVs
dGlQcm9jZXNzUUVNVSwgd2hpY2ggSSBiZWxpZXZlDQp3YXMgd3JpdHRlbiBieSBTdGVmYW4sIEkg
cmVhZDoNCg0KPiBJbnZlbnRpbmcgYSBuZXcgZGV2aWNlIGVtdWxhdGlvbiBwcm90b2NvbCBmcm9t
IHNjcmF0Y2ggaGFzIG1hbnkNCj4gZGlzYWR2YW50YWdlcy4gVkZJTyBjb3VsZCBiZSB1c2VkIGFz
IHRoZSBwcm90b2NvbCB0byBhdm9pZCByZWludmVudGluZw0KPiB0aGUgd2hlZWwgLi4uDQoNCkF0
IHRoZSBzYW1lIHRpbWUsIHRoaXMgYXBwZWFycyB0byBiZSBpbmNvbXBhdGlibGUgd2l0aCB0aGUg
KG5ldz8pDQpyZXF1aXJlbWVudCBvZiBzdXBwb3J0aW5nIGRldmljZSBlbXVsYXRpb24gd2hpY2gg
bWF5IHJ1biBpbiBub24tVkZJTw0KY29tcGxpYW50IE9TcyBvciBldmVuIGFjcm9zcyBPU3MgKGll
LiB2aWEgVENQIG9yIHNpbWlsYXIpLg0KDQpXZSBhcmUgaGFwcHkgdG8gc3VwcG9ydCB3aGF0IHRo
ZSBjb21tdW5pdHkgYWdyZWVzIG9uLCBidXQgaXQgc2VlbXMNCmxpa2UgdGhlcmUgaXNuJ3QgYW4g
YWdyZWVtZW50LiBJcyBpdCB3b3J0aCBhbGwgb2YgdXMganVtcGluZyBpbnRvDQphbm90aGVyIGNh
bGwgdG8gcmVhbGlnbj8NCg0KQ2hlZXJzLA0KRi4NCg0K

