Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F21C38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC112082E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UxT4P3VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC112082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTlK-0001Gt-ND
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQTkT-0000qf-HG
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:33:58 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQTkS-0008MN-8d
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:33:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:18946)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jQTkR-0008Du-Fu
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:33:55 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03KAXJUr006641; Mon, 20 Apr 2020 03:33:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=GcgH1rggOCMHmeWRZmbvffzfS/8NHJ0+1zMHqzgxAkU=;
 b=UxT4P3VZsFmsZjdLWcsvD86kvFQsolBODjUS1zEgWgcSLl9F3HNGFDYfPuYoualU1+3A
 hA/D0ioCfp7dxRIvaPeIVv2ylzriE0Ct96SBwwNe4BCgHQ7Gsk9sSe2ZbeZu8jZMXULV
 /45DbvO3DLleqFs1pIXQwZKIhPAPxwhMhXDWnySL8+GACtC3JHJ7CAwvZj0g/0Y7pjvQ
 l8QBIFW2wagiMrPcR+LhUjZTWz9zhKRMJEhcvRw8mzI6JS5f4/N3x77Es0IB4vvAHTZ/
 zeKdaYGXH9BRikPegWMIw7xLRzlHc78EJcO1a7hBRGMPQoAghC3yvvqAoB8Uwr8QgLqs 1w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30g0vg341y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 03:33:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRzsNN/gAd+wFO2vTaO0oYunr4FYBHwhQA9mTFbxAjph8x1aaUmXX6UmKteCRPGU3g9PvehsUC+27RftC7zvB6pWWnAbvhUf55CaAj9YOJRfDh47MoExCdlQd8etvbvWHbcPwYaY0G/aUi9YLj15MGlkDUBKX43bR+3+TsIQePRza0uXRU17ZtXu7LmqrxX//LaOSERssCb4liLr0N2UBLb6BCwVTY3vF47tJLfBVljBu5u8zqDKGBtwxyUex3VP6I05uyKu4H5YbYG+z50YQxcnOEQZYEE4yTdFaWlTLu5Ymp/9ZT+w1wgiqRJxVXH+n+kJGjQUfeyWd2HN6fNe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcgH1rggOCMHmeWRZmbvffzfS/8NHJ0+1zMHqzgxAkU=;
 b=gNDOGZpFsiRyHQnWWerlZ5DpQJvWqiq26HeQp5/rbia82NMc5xGcxVkk+jrlIbJMIlQJh9PQl8m6CK6I4VTZ+XAL+X4klADHGJW1BGcqenAYXwkXOb3edjZtAhosUXtJYIreKjXPBYV+Pe8evNu44Qty2mTyt8QqtWZyZsTjNn5XEiFvVDh5rbRnGy3kskAE//YspoCf2P+cW6hzLVnqT6mKc8d3jwCimpkOHe3rsBgCcUpZ+lIkWPgfYbRgQ7hr/zKKYPvRpb+/+c0APc6DH/FgH7dRBYVCOH1Eotnfb0qxvrctwJyocnxdax37rrS1x0Fk+iz4ahZGpkwMHx9N5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5904.namprd02.prod.outlook.com (2603:10b6:208:113::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 10:33:49 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 10:33:49 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAERh2AgAATKQA=
Date: Mon, 20 Apr 2020 10:33:49 +0000
Message-ID: <E2078F88-AF75-4D85-B677-C090FA0FD88B@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
In-Reply-To: <20200420092459.GF346737@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.110.205.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2006b651-6938-4ae8-1102-08d7e5165039
x-ms-traffictypediagnostic: MN2PR02MB5904:
x-microsoft-antispam-prvs: <MN2PR02MB590417061F9A0ECC69AC09F5F1D40@MN2PR02MB5904.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(39860400002)(346002)(376002)(136003)(366004)(396003)(71200400001)(2906002)(81156014)(8676002)(8936002)(44832011)(33656002)(66946007)(26005)(76116006)(6506007)(53546011)(66476007)(66556008)(64756008)(5660300002)(66446008)(2616005)(4326008)(4744005)(91956017)(6916009)(36756003)(6512007)(6486002)(86362001)(54906003)(478600001)(186003)(316002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+7B12EBQ2xGz207ZNNTpJiUHPqfZ6L8Gjjc9zzcaMjkhfTqj9LJuY0peI0IA1SKuQkFqi2eAkDZqOQXLrea90lK2UEZiELwA2jNx700CAVq9CD+uQhMvsQrKvcZkr4jup8dAYQI5Tfi3W+Z29KHjn3XdEPWnKf685UNulj+KOz2L+Brpk5mNEM5EE2ivR1uCyX2MnS6ANCGdERfI1f2ejo5hg/nJCzuQT6eYO6RsJjyehFIPP4zHK/6UmU6vXWAXXNSYz2t1FQ3776BWqZer2+KTUq4fEK69wccdgJ0DQRY+VPfZh1XmDCHCUBaLHQov0+OgPt7CKchXbVfxQUonzgEmQTs9K9AHs6/aikykjNqEtvBZA9Mh1A4/20HM8XkycauIdj/nN/U1DJ1xl8zjNZ47E8yF1X+f4g/tI/ey/hOTofzgQtI9h+bfkLcU2VP
x-ms-exchange-antispam-messagedata: qUIk23MRj522hgx2/kwbaL7IJXf0obGnH7MKxFvybmi0e3N7aL6BJ6MagFnKwNb4+nfLOvnpBzVHboXR6PF/OFPGl49CKoKpQHa5FTMM509k9xHmgC/u505Bf+zpz+jLVll6x/Y43B8bZKq6lO7aQw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4CE4CC1489D404E891BE558305CCF88@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2006b651-6938-4ae8-1102-08d7e5165039
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 10:33:49.3323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAcwFfOQUjsJ3LWh1t2Uud4i26QHrjoQu1hzL+jhiFWGkJoJkUb7Br1zYqTQjKJJQtlEmVe5pNFcRhUX7VOjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5904
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-20_03:2020-04-20,
 2020-04-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 06:33:52
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDIwLCAyMDIwLCBhdCAyOjU0IFBNLCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxi
ZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IEZyb20gdGhlIHVwc3RyZWFtIFBPViwg
dGhlcmUncyBiZWVuIG5vIGRlY2lzaW9uIC8gYWdyZWVtZW50IHRvIHBoYXNlDQo+IG91dCBQSUlY
LCB0aGlzIGlzIHB1cmVseSBhIFJIRUwgZG93bnN0cmVhbSBkZWNpc2lvbiAmIHBsYW4uIElmIG90
aGVyDQo+IGRpc3Ryb3MgLyB1c2VycyBoYXZlIGEgZGlmZmVyZW50IFBPViwgYW5kIGZpbmQgdGhl
IGZlYXR1cmUgdXNlZnVsLCB3ZQ0KPiBzaG91bGQgYWNjZXB0IHRoZSBwYXRjaCBpZiBpdCBtZWV0
cyB0aGUgbm9ybWFsIFFFTVUgcGF0Y2ggcmVxdWlyZW1lbnRzLg0KDQpFeGNlbGxlbnQuIEkgd2ls
bCB3b3JrIHdpdGggYW55b25lIHdobyB3b3VsZCB3YW50IHRvIHJldmlldyB0aGlzIHBhdGNoLiBB
bHNvIEkganVzdCByZWFsaXplZCB0aGlzIHBhdGNoIGlzIGJhc2VkIG9mZiBRZW11IDIuMTIuIFNv
IEkgd2lsbCBzZW5kIGFub3RoZXIgcGF0Y2ggYWZ0ZXIgcmViYXNpbmcgaXQgd2l0aCB0aGUgbGF0
ZXN0IG1hc3Rlci4gTWVhbndoaWxlLCBsZXQgdGhlIGZlZWRiYWNrcyBrZWVwIGZsb3dpbmcg4oCm
DQoNCmFuaQ0KDQoNCg==

