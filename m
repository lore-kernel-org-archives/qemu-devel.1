Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D7C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F28020700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="zFi1gurs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F28020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS0CF-0002hj-DK
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jS0BQ-00028n-IX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jS0BP-0007Jz-6P
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:24:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:60862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jS0BO-0007BA-Iz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:24:02 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03OFF9Bw009458; Fri, 24 Apr 2020 08:23:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=dNdetQaFW2bdQXWz2cuT5MN7pzESoas2wADiYgLIgbo=;
 b=zFi1gursBN+XnDqmsEyJQny6d49uE264XYjdlgDoVXCIrh18IotpNJLJ/tOgHht03ug6
 yCs1cXURN9OFMaNjKZpIVXQcedmx+YhIyp4aHdcEYuY9+Cea76oiZ4jbQ16Qithl1Lnx
 TaObSZUtCf9bd8jQreh6BcNO9GfW83Bek8fWtHoi0Gd8ih37EmmfmUy9vwJ2ctMAJfaD
 aRxf1IcGaKfApmW2TysWydcpczxszrykoCtH79JmB3qEN7LGTnsB3T8v65vEy1dPTUsZ
 T6vBVj6rm1eZ1+6Bmkn8RaMGK+7U622Wf/voQQkUYBNPPjkRjLTbZEE3MnlwLIlsRLz+ QA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30fy3a6spn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2020 08:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edN7wS0RvNKpuslQuBffVkXRDpfeVVkKzzNQdcCVuK7+JOcH4EUbsxhGmKR0kDo+3M8WmtCL5Pdoh8kg+icV767qyao4sqfN1T5W1w+9ZUE5+gUJsQ3u2yuNHxKhecwqfaY/chpdST1+pZ+x3Ukl7rVMp5gbnNvjiywTjnfqzf9csZtHOiQCM21VfdWjn88u4pEZBsAQX6gNYCs6EzDx9afyXBTKjPS/FhXxvzwuD4CbbhQNGfxAoCIPx6A1hwohbbbj0cJR6AYDsny6omSFQZ3xurnn049prY05cMJNVnVcYCk2vxWvpslYQsGEJuz1xImQBdApaaeSGFypp+/D8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNdetQaFW2bdQXWz2cuT5MN7pzESoas2wADiYgLIgbo=;
 b=lCuAdkduwfZjzVef6yXwI9Kn+D4tyM+BLP22bQ2x7qy++wMkuysoEBmRNy4BkxIcISCOfo4THFJiBOCj01TVR3tWx/5klSmVkk4kXoFSEJ1l4pNaPmpgpEKSnHkHNewM2Mi5d2zHJfBo0y5TFITV/9KuEVPgQyUXddp8YHArjuKWNBAGOye2KXju9QdUUAbqAmw4/XrwWTI+EvlMvku45E3Sx4iFgpnvCIJ56318cpNvi/tO77U5cFzQWNJzluajsH77fD8Fcf4hdXz2BaaMjLQMlRJzrNb2DJkeRyCQXVL5NQHHKyyxJFgDCuvP0LP6p7xVL3RRdijPuAKni6zpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB7085.namprd02.prod.outlook.com (2603:10b6:208:20b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 15:23:57 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 15:23:57 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAERh2AgABeQwCAAY19AIAABL+AgAFKiACAA3KSgA==
Date: Fri, 24 Apr 2020 15:23:56 +0000
Message-ID: <819DA747-F897-44A4-A238-B6F20C4C8B08@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
 <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
 <20200421150201.GI479771@redhat.com>
 <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
In-Reply-To: <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.96.151.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e99d1d5-fc66-4684-5c10-08d7e86381ce
x-ms-traffictypediagnostic: MN2PR02MB7085:
x-microsoft-antispam-prvs: <MN2PR02MB70851FC6DF72CFEF4CE7047BF1D00@MN2PR02MB7085.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(136003)(376002)(366004)(346002)(396003)(26005)(53546011)(6506007)(71200400001)(6916009)(54906003)(33656002)(2906002)(8676002)(81156014)(316002)(8936002)(36756003)(2616005)(6486002)(44832011)(478600001)(66946007)(186003)(5660300002)(86362001)(6512007)(66446008)(66476007)(91956017)(76116006)(64756008)(66556008)(4326008);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4vjjxoIFytSIkpcfgzPfKpSr4laFOKEJnsSxx1HNeKXQdLHwZFPX4mJzwhd+ZioSiD4JLKOWAR4RVhURs2Z+vhFMhJvW6ztet99lHimNJxJDt8JTH3b3IDLW2w+0+0XV8YbJK53acvqeCcXKhbeDaG6OIKK9KP5O71EjV3ymaEX1x50ugNxjsK3reoW2IH5uv4Jrb9unGiBQpWs4+I/m9vjgzVzf3b531Sl65rPh7qVcAfBo33H95jRS2T1NPpizw6hrUPh7lyVOhcY/SjXwd172j84nARFsG1luTMCRL79yAKo/csufXOs1ba8KkY3V9uyEzE+QrNWKkFMIkFGHJ80EetFuQdkbWTzEVVAEnsuGwm0BLbyiXkKKsaugL8L0u/xWE+AwUEuf0dwZmKaLorHR8GSegKNKEGLHzQqHG5tvYNOGanLQXUW/qANDxVrE
x-ms-exchange-antispam-messagedata: D3FoC8Rx5E3E7h0fkHC4ERCvB//mx7nuzUupttF3teVbmCDXHoxI3ZFJ33D2aOPT1z9Vi8vT7NZ7Yi2b041fRGaAqNoT4/CehqihuBY4SRldGoHWHJgL6naJlXBGQbY/pS3TmgSxHtoIWjJtyn1ROQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B1868A76A4E1447812B7C7A39F6FB53@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e99d1d5-fc66-4684-5c10-08d7e86381ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 15:23:57.2166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AM7ipLOqFVa0Lmw7DdiH4/abWh/rc99BZOPqJbJuijAocaAj2Y2Rtg/mV+RPw3Yov0X4oYWBXKeMu1F8RCoKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-24_08:2020-04-24,
 2020-04-24 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 11:23:59
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
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDIyLCAyMDIwLCBhdCA0OjE1IFBNLCBBbmkgU2luaGEgPGFuaS5zaW5oYUBu
dXRhbml4LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBBcHIgMjEsIDIwMjAsIGF0IDg6
MzIgUE0sIERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0K
Pj4gDQo+PiBPbiBUdWUsIEFwciAyMSwgMjAyMCBhdCAwMjo0NTowNFBNICswMDAwLCBBbmkgU2lu
aGEgd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIEFwciAyMCwgMjAyMCwgYXQgODozMiBQTSwg
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBC
dXQgSSBmb3Igb25lIHdvdWxkIGxpa2UgdG8gZm9jdXMgb24ga2VlcGluZyBQSUlYIHN0YWJsZQ0K
Pj4+PiBhbmQgZm9jdXMgZGV2ZWxvcG1lbnQgb24gcTM1LiAgTm90IGJsb2F0aW5nIFBJSVggd2l0
aCBsb3RzIG9mIG5ldw0KPj4+PiBmZWF0dXJlcyBpcyBJTUhPIGEgZ29vZCB3YXkgdG8gZG8gdGhh
dC4NCj4+PiANCj4+PiBEb2VzIHRoaXMgbWVhbiB0aGlzIHBhdGNoIGlzIGEgbm8tZ28gdGhlbj8g
OigNCj4+IA0KPj4gSSdkIHN1cHBvcnQgdGhpcyBwYXRjaCwgYXMgSSBkb24ndCB0aGluayBpdCBj
YW4gcmVhbGx5IGJlIGRlc2NyaWJlZCBhcw0KPj4gYmxvYXQgb3IgZGVzdGFiYWxpemluZy4gSXQg
aXMganVzdCBhZGRpbmcgYSBzaW1wbGUgcHJvcGVydHkgdG8NCj4+IGNvbmRpdGlvbmFsaXplIGV4
aXN0aW5nIGZ1bmN0aW9uYWxpdHkuICBUZWxsaW5nIHBlb3BsZSB0byBzd2l0Y2ggdG8gUTM1DQo+
PiBpcyB1bnJlYXNvbmFibGUgYXMgaXQgaXMgbm90IGEgc2ltcGxlIDEtMSBjb252ZXJzaW9uIGZy
b20gZXhpc3RpbmcgdXNlDQo+PiBvZiBQSUlYLiBRMzUgaGFzIG11Y2ggaGlnaGVyIGNvbXBsZXhp
dHkgaW4gaXRzIGNvbmZpZ3VyYXRpb24sIGhhcyBoaWdoZXINCj4+IG1lbW9yeSBvdmVyaGVhZCBw
ZXIgVk0gdG9vLCBhbmQgbGFja3MgY2VydGFpbiBmZWF0dXJlcyBvZiBQSUlYIHRvby4NCj4gDQo+
IENvb2wuIEhvdyBkbyB3ZSBnbyBmb3J3YXJkIGZyb20gaGVyZT8NCj4gDQoNCldlIHdvdWxkIHJl
YWxseSBhcHByZWNpYXRlIGlmIHdlIGNhbiBhZGQgdGhpcyBleHRyYSBrbm9iIGluIFFlbXUuIE1h
eWJlIHNvbWVvbmUgZWxzZSBhbHNvIGluIHRoZSBjb21tdW5pdHkgd2lsbCBmaW5kIHRoaXMgdXNl
ZnVsLiBXZSBkb27igJl0IHdhbnQgdG8gbWFpbnRhaW4gdGhpcyBwYXRjaCBpbnRlcm5hbGx5IGZv
cmV2ZXIgYnV0IHJhdGhlciBwcmVmZXIgd2UgbWFpbnRhaW4gdGhpcyBhcyBhIFFlbXUgY29tbXVu
aXR5Lg0KDQphbmkNCg0K

