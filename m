Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95227C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20595206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="rYWsO+Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20595206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZFN-00071e-2y
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jZZED-00068N-EZ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:14:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:47898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jZZEB-0007TC-Eu
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:14:12 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04FCBxSk025937; Fri, 15 May 2020 05:13:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=nkxhmCrd/iyHtKmoxeyMpKvF4yeDU1w3kIgLteXU100=;
 b=rYWsO+Kpt7a6RhWC6z0RVvfWaBmVn1bsOgHCu2mVhu0r52qz0TGhHCN2hJeXp1YfAC6F
 sgdc2wyxLsmlnNfpdk4xpNPJUbGiX7/++CD9YtTHjqk5R2fJq+HrgaiGzhdLwAv1M4VE
 yiZc2CGbUUuYK3oJAEvyW5iNk9jZc1Pd3gPbsqTX5BngkJqTDiy05SH/PaX1vGI5f2mU
 EjBAKHmae8mA3qVsDIwMekOXTR2UWeljuq/5cnZFLVPVmvDliBrTAj8fxJ0zDqSBKP5M
 2DXIpy0/1gsT3l6vbxhn7iVOR7da6pxYWDX+FiJf4Mkr9gocf1zSdAdjg2n9hJUStbK/ pg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-002c1b01.pphosted.com with ESMTP id 3100ybf4sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 May 2020 05:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEgUg1his4Ej0CtstJDTdhBaZo41g7PTL/ngLTF3fvO77ZDMOyfXx2OTu9FpqHYOI472boD60vs5O67DUzFl/y51uYkfjeKuvQb46TpvdOd2hq6lxPBVVYHVpWG8ct+Y7JdkTWYvaLRfshxO3vh/MPw6Ym1WxnkM4iIYqNjT2DJu7bOe7nUcnJnXaISerSgK8zNkG4pMktQom25ClE7B6jN3Z5q5IYSuG5rrIUTrLeq9MgYbEvdlAtZlQl8jLXn+1fmWQFP9LxB0R/5LKGYeBfkJ6/OuWxSgtxv+8uzk19EQ6v5bAfExZxfDu71Ie64SCwi6qGcQPVb2Z2kOg7hp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkxhmCrd/iyHtKmoxeyMpKvF4yeDU1w3kIgLteXU100=;
 b=DBkw1KApvakDkIvB3FL+V3ppOPRa4wvTi2Yz2LCY49bwC/QVAC5IidrLHMcXsUUBcu7bBnxFftVAE+TkHiowaelirEHqHBdVHuLk6WSee1USK0K5/9DNJyes5O4ko2weTDPdEOFGdJ20JjQUjcpA0JbPlmGiWEreYl12GNUBeH6Ih+M0RGnfdXYCHMHQXA/kDUctK18W8/BQqafTVFo9/gkkYhWvPLQYAG9CNRe2yDlD0dAObe5JkGmuFSRF7hEGV/FENhSXFED1lNEgmoXbs6dTTI3ul/WZwGzMDYJG829JRZPiYE1M2/O6Txnz7xfj68ynsWKuFI/utEclFIn/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6256.namprd02.prod.outlook.com (2603:10b6:208:180::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:13:53 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 12:13:53 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6ijUHoAgACw0gCAAoGgAIACpx8A
Date: Fri, 15 May 2020 12:13:53 +0000
Message-ID: <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200511205352.05ff541a@redhat.com>
 <9941B800-BBEF-4DF8-BEE0-EC39D2A20D98@nutanix.com>
 <20200513214312.0dfa4752@redhat.com>
In-Reply-To: <20200513214312.0dfa4752@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b070531b-b6b5-4670-b14e-08d7f8c96f3e
x-ms-traffictypediagnostic: MN2PR02MB6256:
x-microsoft-antispam-prvs: <MN2PR02MB625688D540ED54B75AEB1272F1BD0@MN2PR02MB6256.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fkaw97PKz1K3YHytSg/+nHW021d79+yOZLN4gduRyxDW89+uFFfanoNOT+BzIWDkczYygYFcRXZ8bjcDB3SlC6YlWgYOgn3HqprPnBhxJtQ7nLtOCTW7uDPgZpBDX1Cq8f5edJCBwV3Sfyr7ofw0jPkD8v14eUuYfLzwuGyKvT7y1ukWTDKJvxlFZE21o3fQEu+QHc4YfRfkJK1oQKkIv5T1zjieDxotqT1gdIWd/B7er61kKTM8ILZdFnOJkvptyYWtvKQRp9dVrsXQh50zRnEH+e9cGMMp/664YcEVYorPWk3T+DhEasX3d+bvG558pi6dxjavNFvXrYdWCsQ1tPwTRTdqjeFTa1llHgjpQtpLgfEq1YYPiZdJo92LX6FilTi5wLcunvw2sS2fks+9vl271nYGBUU9L+GohUWrGC9lAMHjUhs0s2EvRf6iWpIt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(396003)(376002)(39860400002)(136003)(366004)(44832011)(8676002)(6486002)(91956017)(26005)(66476007)(2616005)(66556008)(66446008)(66946007)(64756008)(6512007)(76116006)(316002)(4326008)(6916009)(2906002)(54906003)(478600001)(8936002)(7416002)(5660300002)(33656002)(86362001)(186003)(71200400001)(36756003)(53546011)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bHpBa9xw+uPx9+SZKMD9YbwTeb8DWcKyI/DLK7tsjIOmwkEx5Q3nsCczbjJg0COcblOAViuLgfJnhXBf6xT5drEPU+wqEpz073/lwKy4LyjuXPPn8Dn7jJFYA5VJH6nLBGvyOWKh00RkmxLIbRq6pk6WL2YheDElHuGRT9Urne5xRbeXMEb1Mb5jDZHjRTGXAf88Z984NfawoZ6pQwtzXu/PpsJ+1sSRnYoS4ZaqaZW/fet+3RanI62SZgCNueEPKUH9KblVlcOuxdoKlZy8zlSY/ckDKGEnhgxySPadmhi8A6bE/1TFUMdlOT6bOWleolaA6ZQ9CcT2HVySLeO6VLqUmXXNM0uT6sixs37PCoWuvXHlyGOVGhtiPfISooTIKPF6tJ2/dPI2jX/rFFOIH36RlAjci+UfVXIlgDMKHPOtb/3vv/hujfcAdPlfMB3oITdLGwAvPeE/4xiRrMEAYZSWc+D60H5uS4Z7KWVetN8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCAA235C30E72C419014F6ED03AB4961@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b070531b-b6b5-4670-b14e-08d7f8c96f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 12:13:53.3409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REy6W0akDN6rGZhhKkSVAaCBkUPQCCYckJu0kcFsf8Z1w1LK7HnxeRxu+hw+GCuBfmAs/nbBRN2vgOM7w/sRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6256
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-15_04:2020-05-15,
 2020-05-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:14:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gTWF5IDE0LCAyMDIwLCBhdCAxOjEzIEFNLCBJZ29yIE1hbW1lZG92IDxpbWFtbWVk
b0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+PiANCj4+IA0KPj4+IFdpbGwgZm9sbG93aW5nIGhh
Y2sgd29yayBmb3IgeW91Pw0KPj4+IHBvc3NpYmxlIHBlcm11dGF0aW9ucw0KPj4+IDEpIEFDUEkg
aG90cGx1ZyBldmVyeXdoZXJlDQo+Pj4gLWdsb2JhbCBQSUlYNF9QTS5hY3BpLXBjaS1ob3RwbHVn
PW9uIC1nbG9iYWwgUElJWDRfUE0uYWNwaS1wY2ktaG90cGx1Zy13aXRoLWJyaWRnZS1zdXBwb3J0
PW9uIC1kZXZpY2UgcGNpLWJyaWRnZSxjaGFzc2lzX25yPTEsc2hwYz1kb2VzbnRfbWF0dGVyIC1k
ZXZpY2UgZTEwMDAsYnVzPXBjaS4xLGFkZHI9MDEsaWQ9bmV0ZGV2MSANCj4+PiANCj4+PiAyKSBO
byBob3RwbHVnIGF0IGFsbA0KPj4+IC1nbG9iYWwgUElJWDRfUE0uYWNwaS1wY2ktaG90cGx1Zz1v
ZmYgLWdsb2JhbCBQSUlYNF9QTS5hY3BpLXBjaS1ob3RwbHVnLXdpdGgtYnJpZGdlLXN1cHBvcnQ9
b24gLWRldmljZSBwY2ktYnJpZGdlLGNoYXNzaXNfbnI9MSxzaHBjPW9mZiAtZGV2aWNlIGUxMDAw
LGJ1cz1wY2kuMSxhZGRyPTAxLGlkPW5ldGRldjENCj4+PiANCj4+PiAtZ2xvYmFsIFBJSVg0X1BN
LmFjcGktcGNpLWhvdHBsdWc9b2ZmIC1nbG9iYWwgUElJWDRfUE0uYWNwaS1wY2ktaG90cGx1Zy13
aXRoLWJyaWRnZS1zdXBwb3J0PW9mZiAtZGV2aWNlIHBjaS1icmlkZ2UsY2hhc3Npc19ucj0xLHNo
cGM9ZG9lc250X21hdHRlciAgLWRldmljZSBlMTAwMCxidXM9cGNpLjEsYWRkcj0wMSxpZD1uZXRk
ZXYxICANCj4+IA0KPj4gR2l2ZW4gdGhhdCBteSBwYXRjaCBpcyBub3QgYWNjZXB0YWJsZSwgSeKA
mWQgcHJlZmVyIHRoZSBmb2xsb3dpbmcgaW4gdGhlIG9yZGVyIG9mIHByZWZlcmVuY2U6DQo+PiAN
Cj4+IChhKSBIYXZlIGFuIG9wdGlvbiB0byBkaXNhYmxlIGhvdCBlamVjdGlvbiBvZiBQQ0ktUENJ
IGJyaWRnZSBzbyB0aGF0IFdpbmRvd3MgZG9lcyBub3QgZXZlbiBzaG93IHRoaXMgSFcgaW4gdGhl
IOKAnHNhZmVseSByZW1vdmUgSFfigJ0gb3B0aW9uLiBJZiB3ZSBjYW4gZG8gdGhpcyB0aGVuIGZy
b20gT1MgcGVyc3BlY3RpdmUgdGhlIEdVSSBvcHRpb25zIHdpbGwgYmUgc2FtZSBhcyB3aGF0IGlz
IGF2YWlsYWJsZSB3aXRoIFBDSUUvcTM1IC0gbm9uZSBvZiB0aGUgZGV2aWNlcyB3aWxsIGJlIGhv
dCBlamVjdGFibGUgaWYgdGhlIGhvdCBwbHVnIG9wdGlvbiBpcyB0dXJuZWQgb2ZmIGZyb20gdGhl
IFBDSUUgc2xvdHMgd2hlcmUgZGV2aWNlcyBhcmUgcGx1Z2dlZCBpbnRvLg0KPj4gSSBsb29rZWQg
YXQgdGhlIGNvZGUuIEl0IHNlZW1zIHRvIG1hbmlwdWxhdGUgQUNQSSB0YWJsZXMgb2YgdGhlIGVt
cHR5IHNsb3RzIG9mIHRoZSByb290IGJ1cyB3aGVyZSBubyBkZXZpY2VzIGFyZSBhdHRhY2hlZCAo
c2VlIGNvbW1lbnQgIi8qIGFkZCBob3RwbHVnIHNsb3RzIGZvciBub24gcHJlc2VudCBkZXZpY2Vz
ICovIOKAnCkuIEZvciBjb2xkIHBsdWdnZWQgYnJpZGdlcywgaXQgcmVjdXJzZXMgZG93biB0byBz
Y2FuIHRoZSBzbG90cyBvZiB0aGUgYnJpZGdlLiBJcyBpdCBwb3NzaWJsZSB0byBkaXNhYmxlIGhv
dCBwbHVnIGZvciB0aGUgc2xvdCB0byB3aGljaCB0aGUgYnJpZGdlIGlzIGF0dGFjaGVkPw0KPiAN
Cj4gSSBkb24ndCB0aGluayBpdCdzIHBvc3NpYmxlIHRvIGhhdmUgcGVyIHNsb3QgaG90cGx1ZyBv
biBjb252ZW50aW9uYWwgUENJIGhhcmR3YXJlLg0KPiBpdCdzIHBlciBicmlkZ2UgcHJvcGVydHku
DQoNCldlIGFkZCB0aGUgQU1McyBwZXIgZW1wdHkgc2xvdCB0aG91Z2guIFdoZW4gdGhlIHBpYyBi
cmlkZ2UgaXMgYXR0YWNoZWQsIHdlIGRvIG5vdGhpbmcsIGp1c3QgcmVjdXJzZSBpbnRvIHRoZSBi
cmlkZ2Ugc2xvdHMuIFRoYXQgaXMgd2hhdCBJIHdhcyBhc2tpbmcsIGlmIGl0IHdhcyBwb3NzaWJs
ZSB0byBqdXN0IGRpc2FibGUgdGhlIEFNTHMgb3IgdXNlIHNvbWUgdHJpY2tzIHRvIHNheSB0aGF0
IHRoaXMgcGFydGljdWxhciBzbG90IGlzIG5vdCBob3RwbHVnZ2FibGUuIEkgYW0gbm90IHN1cmUg
d2h5IFdpbmRvd3MgaXMgdHJ5aW5nIHRvIGVqZWN0IHRoZSBQQ0kgYnJpZGdlIGFuZCBmYWlsaW5n
LiBNYXliZSBzb21ldGhpbmcgcmVsYXRlZCB0byB0aGlzIGNvbW1lbnQ/DQoNCg0KLyogV2hlbiBo
b3RwbHVnIGZvciBicmlkZ2VzIGlzIGVuYWJsZWQsIGJyaWRnZXMgYXJlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgKiBkZXNjcmliZWQg
aW4gQUNQSSBzZXBhcmF0ZWx5IChzZWUgYnVpbGRfcGNpX2J1c19lbmQpLiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAqIEluIHRoaXMgY2FzZSB0
aGV5IGFyZW4ndCB0aGVtc2VsdmVzIGhvdC1wbHVnZ2FibGUuICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICogSG90cGx1Z2dlZCBicmlkZ2Vz
ICphcmUqIGhvdC1wbHVnZ2FibGUuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgKi8NCg0KDQoNCj4gDQo+IA0KPj4gKGIp
IEZhaWxpbmcgYWJvdmUsIGhhdmluZyBhIGdsb2JhbCBvcHRpb24gdG8gZGlzYWJsZSBhbGwgaG90
IHBsdWcsIGluY2x1ZGluZyB0aGUgMzIgc2xvdHMgb2YgdGhlIHJvb3QgYnVzIHdvdWxkIGJlIGdv
b2QuIEhvd2V2ZXIsIHRoaXMgZG9lcyBub3QgZ2l2ZSB1cyB0aGUgZmxleGliaWxpdHkgd2UgaGF2
ZSB3aXRoIFBDSUUgKHRoYXQgaXMsIHRvIGhvdCBwbHVnIGEgIGRldmljZSwgd2UgY2FuIGFsd2F5
cyBwbHVnIGl0IHRvIGEgc2xvdCB3aXRoIGhvdCBwbHVnIGVuYWJsZWQpLg0KPiANCj4gc291bmRz
IGZpbmUgdG8gbWUsIGF0IGxlYXN0IGl0IHdpbGwgYWRkcmVzcyBwcm9ibGVtLg0KPiBDYW4geW91
IHBvc3QgYSBwYXRjaCB0byB0aGF0IGVmZmVjdCBwbGVhc2U/DQo+IC9JdCBzaG91bGQgZGlzYWJs
ZSBhbGwgQU1MIHJlbGF0ZWQgdG8gaG90cGx1ZyBhbmQgcmVsYXRlZCBoYWR3YXJlIGNvZGUvDQoN
CkkgaGF2ZSB0cmllZCBhIHBhdGNoIGFuZCBzZW50IGl0Lg0KDQo=

