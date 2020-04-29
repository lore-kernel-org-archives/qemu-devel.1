Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C05EC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3357D20731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="YheSlFRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3357D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTip2-0004P9-BQ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTinn-0003PZ-Oy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTini-0004d7-8N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:14:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:9060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTinh-0004cD-H0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:14:41 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T96aLR021292; Wed, 29 Apr 2020 02:14:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=94+HBv+0JoGENB2dgqbNRCSXhdUYFVKcVIlbZeg7o88=;
 b=YheSlFRfCLWg93Twb4q2hu61bHDZIpDH4e+b0HGV3EZ9eav1PK2reF0O6XdHdyF7yy3u
 TTd+d0g4i0h6QEfpohcgYNoFj3Kp7duQ90bHWBmFOeLCCu4Bj16rQShw3BjhXBc6GNHY
 TPYakwcUjtfu9OXgdmorhjAjnv7NE1hcrhZaU1MbDUUj+RxnXtSRHky3TI6CY1lJjFXU
 A9EpTlmFUGWD0mMkE1wCcs23UvkdTkU7VbxsCzKpoq/iwBh+x4G6SSVXvsmUL8BQdqtx
 w9PbwgJRq4Bo4fsP2ciEPjI9m/T+y/StXzMmLuyY7m9B9f9FamkBP6G3WMD7hksXo/il tw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mkak0dr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 02:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLeeAiLMf3iyld53rbzU33fS39xMcTIR8x55kQIiOKH+yK5rOwkIYGcCL5xtOJrrzqwj3T1zIAZjur24dQT+RZ7rZwyaD79CyI5EDsw4HD4mP1bVExjgZE0BDF0dt1GRPzOH8UmfqXTBhBt1gB7Ad6p6AMNN8dJZseRyQS+kUynO+F688818K1PEzML3sjq2VBXVWy0WdaSr6ti+WuTDUpE7XkGdax1h3XjqFRwEjMAqIPJYqVXH/QtOKSvxcFhq2oZ8KBYtK+jbA+tSDp9m6WJ0kq6lRN4B2znV1u1Yh7oY31dvzuOl0yoQZM5Yz8V2i1PT0vC7idTSmqoyUxwIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94+HBv+0JoGENB2dgqbNRCSXhdUYFVKcVIlbZeg7o88=;
 b=TCmCocZUluPLUZoB9pfMolM88onlAFKOv+CKnOVMIKYwf/YfMOUWLHTA7iiNIopfxvPud4/8+SCJvoXsT67FhmYY6wYhX8ajKkqmKgA0e3p0vfr4XJiaRM40DS9vrGA0tVXlBB+g4HyH0H30dVl7rG7sNSJsrae8j47K8UgcjHy/Xh0D/UubYjex8ndmkOXfFR1tV/dGud73yOt2uwtREr+mQmWfd2n4uuSGRdcrCx2cC0g9YB6/woSBAb7c2aqCrwjdYFfOqSlWCjTF/q2s7dLA0j3Dctkzjsbzm8BvR93V9lPWjBSdRikZeIEEVTA0TjrwOxIpXA/S+c/tW4biEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6734.namprd02.prod.outlook.com (2603:10b6:208:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 09:14:27 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 09:14:27 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgAgAAAq4CAAAGWAIAACeGAgAABVgCAAAdzAIAAATOAgAAL9gCAAATtAA==
Date: Wed, 29 Apr 2020 09:14:26 +0000
Message-ID: <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
References: <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
 <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
 <20200429035457-mutt-send-email-mst@kernel.org>
 <2F2DCEBC-C0B5-4653-B741-245A9FF38BDE@nutanix.com>
 <20200429045427-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429045427-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1e0c5fd-bd50-4927-9c01-08d7ec1db75d
x-ms-traffictypediagnostic: MN2PR02MB6734:
x-microsoft-antispam-prvs: <MN2PR02MB67346FEDC39E03901963F454F1AD0@MN2PR02MB6734.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(39850400004)(136003)(366004)(346002)(6512007)(26005)(33656002)(8676002)(2616005)(71200400001)(7416002)(4326008)(8936002)(36756003)(76116006)(2906002)(91956017)(966005)(66556008)(6486002)(66946007)(6916009)(86362001)(54906003)(478600001)(6506007)(53546011)(316002)(186003)(66476007)(44832011)(66446008)(5660300002)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yw001MmtO5fn0NiZcDQjNDmDnsARlTrIOWDboYON9TxrQOJwdEG9yhWrNvSkpnxm6Mrx6gKI3AW1RYaXsSQ0RFi25bkl17+1RCYk7a2suWoIfYk44PJATT0hW8LQSf3PTqCPm29CvVaJZ34WDBx7f7CaAwATPXAKCtgsJwd09Mhwjxk/ng5XgIfQyma39P//91wdHZqTZDRFHMMfal/86uAn1ROhWEvzkTuf5ENalkuQny+eqLT3hpaNJNZ6jTgItOOK3DgGCWvMYjSRvT3pCZoKABBkwn0dT4+fF+QiSgMAwLGKhlsPQsUqorv6xB7N0MkKn10jNVW+ykUohTqdn9kQBRVU9JSiVq53c8v/BERT1UNhZMy6eu/52cD0OlnHfVbnWHzshWQhHC3OTwyoYJ3d1Vpdb0blf06AlKn0ZfcsEaDtcboFefYHyQnYfCjPwM+LRy7ADIsxnZ8Fwc5EZIGSwfLMY72YHImuuth9nogBA1eJjRLm/c/9QbD3K0VG0XyRQ8/+Dli8VikuKlOfrw==
x-ms-exchange-antispam-messagedata: nQelw997ONR98WHP+ncXhB5nXbYIQ+Qv6/el6Jm6foyQHjC7mbVs2lTcyGMVatIvj9WGTDUM4Q2GerQvxg6ZGx/U0YhJSuA74FnshlMqqntwwjOGoxq2EZ0evEpNtvlQNgg5VMQONiyCA9+9hPMhjH9cuUK3di49vyhbhy/iEYiagkIxCBR8/LvaG0zifaR+5+pN+khnxHkb2hA2Xsqgo3FAXHQb8zVU4/HlWbePNdVXKBC5SbG6LfDjFLhnhbRPFnMLpAOTpxqkdC/Er5hQ9BB6SdGVF08dT8zeDnlrUqKZsOC9DuqJ6UmkMJAwGtxZVvjn36sZryxmK4eBLDurDXC3vEfh4vOpiVwclJq7R1kF3diGX4EDSv0CvgMJE+upGccY8tDqIziCBjOGLXZ2/bpg4ZhJzAv7tTc2E9RhU1MHANZRv4VhjP9RMPmb2jyk5MHp0w6dsdYrebKtbbSbYnEix1Xa4MyQPWzwrm5pTFmTdb+bptI5Z6BEx9GZ+hVTEUA/X/aJ+0fYdQ45eqVs7d4u+M05HqaMqxCc2SETyDTmqSg5k7qFME4oX2fyJRO+avruaYgGtZkgYs/t+c5/n5A4XMMTrnHGs/YNLgn89HwsetHfDc8kr5a4KnpA/RTkgYuIzxE9VYEojABdVztSWr5Rdq2MXYZ0NNUuXnxMl8R4GcKHkBcLR18JEd2qlY06WsLzSOwCuA96eyj3G5yPxzBpIZnr7zZkYbI3S8svYSK/k2734EqZ8qvc9g9OZaStFLjl+qMAZ7isLpcYaq5kYaGbHHpV8uhFTQTLyiG2AT8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A392090B8241341ADD23344B3430B8D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e0c5fd-bd50-4927-9c01-08d7ec1db75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 09:14:26.8367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X/bdW47egtIlxyM2ueTexXbWyR8dIVBZ90qx5e6H1mY/LfQDPjrgdO9+Atp7UxuVvSXyXm13SOOUIRYe8zeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_03:2020-04-28,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:36
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDI5LCAyMDIwLCBhdCAyOjI2IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IEV2ZW4gaWYgaXQgc2VlbXMgdG8gd29yayBmb3Ig
Z3Vlc3RzIG5vdywgaWYgd2UgZG9uJ3Qgc3RpY2sgdG8gZW11bGF0aW5nDQo+IGNhcGFiaWxpdGll
cyB0aGF0IGhhcmR3YXJlIGludGVyZmFjZXMgcHJvdmlkZSB3ZSBjYW4gbmV2ZXIgYmUgc3VyZSBp
dA0KPiB3aWxsIGtlZXAgd29ya2luZy4NCg0KT1MgZXMgdXNlIEFDUEkgZm9yIFBDSSBicmlkZ2Vz
OiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Jsb2IvbWFzdGVyL2RvY3MvcGNpZS50eHQN
ClRoZXkgdXNlIOKAnF9FSjDigJ0gdG8gZGV0ZWN0IGpvdCB1bnBsdWcgY2FwYWJpbGl0eTogaHR0
cHM6Ly91ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9BQ1BJXzMucGRmDQoN
CjYuMy4zIF9FSnggKEVqZWN0KSBUaGVzZSBjb250cm9sIG1ldGhvZHMgYXJlIG9wdGlvbmFsIGFu
ZCBhcmUgc3VwcGxpZWQgZm9yIGRldmljZXMgdGhhdCBzdXBwb3J0IGEgc29mdHdhcmUtY29udHJv
bGxlZCBWQ1JzdHlsZSBlamVjdGlvbiBtZWNoYW5pc20gb3IgdGhhdCByZXF1aXJlIGFuIGFjdGlv
biBiZSBwZXJmb3JtZWQgc3VjaCBhcyBpc29sYXRpb24gb2YgcG93ZXIvZGF0YSBsaW5lcyBiZWZv
cmUgdGhlIGRldmljZSBjYW4gYmUgcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0uIFRvIHN1cHBvcnQg
d2FybSAoc3lzdGVtIGlzIGluIGEgc2xlZXAgc3RhdGUpIGFuZCBob3QgKHN5c3RlbSBpcyBpbiBT
MCkgcmVtb3ZhbCwgYW4gX0VKeCBjb250cm9sIG1ldGhvZCBpcyBsaXN0ZWQgZm9yIGVhY2ggc2xl
ZXAgc3RhdGUgZnJvbSB3aGljaCB0aGUgZGV2aWNlIHN1cHBvcnRzIHJlbW92YWwsIHdoZXJlIHgg
aXMgdGhlIHNsZWVwaW5nIHN0YXRlIHN1cHBvcnRlZC4gRm9yIGV4YW1wbGUsIF9FSjAgaW5kaWNh
dGVzIHRoZSBkZXZpY2Ugc3VwcG9ydHMgaG90IHJlbW92YWw7IF9FSjHigJNFSjQgaW5kaWNhdGUg
dGhlIGRldmljZSBzdXBwb3J0cyB3YXJtIHJlbW92YWwuDQoNCg0KTm90ZSB0aGF0IOKAnHRoZXNl
IGNvbnRyb2wgbWV0aG9kcyBhcmUgb3B0aW9uYWzigJ0gbGluZS4gSWYgdGhlIE9TIGFkaGVyZXMg
dG8gdGhlIHNwZWMsIGl0IHNob3VsZCBub3QgZXhwZWN0IHRoZW0gdG8gZXhpc3QgYWxsIHRoZSB0
aW1lLg0KDQo=

