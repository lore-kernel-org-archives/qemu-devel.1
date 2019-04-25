Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E187C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 02:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E174D2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 02:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hYmqS3Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E174D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJU65-0005I0-31
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 22:26:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJU4z-0004E6-TX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 22:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJTvW-0005Kv-N9
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 22:15:56 -0400
Received: from mail-eopbgr700084.outbound.protection.outlook.com
	([40.107.70.84]:26080
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJTvV-0005Ho-Px
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 22:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Xz02FmCrzCCRb1GiImEKt5HL8poGfyuZSGG0jb0VOwM=;
	b=hYmqS3SgNXGKEIuPIN68hWPbzT4xrATMd0ApuawnlAGayX+zls6xhRuAsUhel3ngZuKMD47e4+CqnHBjAS7aEFekWm5ezSVsPKgb+WNNK9z0Uc26i4243EWh4RPeYkGYr6xkApoWq+WuSVjdjXozE7c6YnpQXrbO0v7731bsLN8=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB3289.namprd12.prod.outlook.com (20.179.106.77) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Thu, 25 Apr 2019 02:15:49 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Thu, 25 Apr 2019 02:15:49 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: Steve Rutherford <srutherford@google.com>
Thread-Topic: [RFC PATCH v1 00/10] Add AMD SEV guest live migration support
Thread-Index: AQHU+rgpwai7tJB3uUaULXjJMShjVaZLrqMAgAAmZACAAC5kAIAAIMyA
Date: Thu, 25 Apr 2019 02:15:49 +0000
Message-ID: <329c5293-4b29-8392-2124-13f3093eda19@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<CABayD+eYsqT49-Smp0a9OGRt2or_L7LNKHpe-iraM62XzGq5_g@mail.gmail.com>
	<eee5e112-89bd-331b-6875-34c0712de4cb@amd.com>
	<CABayD+fy5+QNU8YWsVrfd6jyvPo3AWCBgR-V8iWKzZkWxQY=zA@mail.gmail.com>
In-Reply-To: <CABayD+fy5+QNU8YWsVrfd6jyvPo3AWCBgR-V8iWKzZkWxQY=zA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0024.prod.exchangelabs.com (2603:10b6:804:2::34)
	To DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [70.112.153.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a2c6d9d-3844-47bb-d17c-08d6c923ee9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3289; 
x-ms-traffictypediagnostic: DM6PR12MB3289:
x-microsoft-antispam-prvs: <DM6PR12MB3289E2315EEB11F65BD8F70FE53D0@DM6PR12MB3289.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(186003)(36756003)(8676002)(478600001)(102836004)(81166006)(81156014)(4326008)(14444005)(3846002)(6916009)(26005)(71190400001)(71200400001)(6116002)(256004)(31696002)(31686004)(99286004)(52116002)(76176011)(486006)(6506007)(386003)(6436002)(53546011)(68736007)(4744005)(8936002)(14454004)(97736004)(66946007)(305945005)(316002)(53936002)(6512007)(66066001)(66446008)(54906003)(6246003)(86362001)(7736002)(6486002)(66476007)(64756008)(66556008)(7416002)(2906002)(5660300002)(2616005)(93886005)(476003)(73956011)(25786009)(11346002)(446003)(229853002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3289;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i3HOdmiKst/dRWbUfEbrx0FR7up9BAz+p8QccOuFCd06MPlTxRFH0krKCTFAzKpDZDYZF1uwFyg8bEXUA06c+y4WjgJw0/u2JllbY5v9UCfRdGGKBMSwEG+03ciYPQTcVzfRP5v8TTb4GinHwI4aQ8xKDq/8oIA79UCDqBWmZmQD5B1l1kKCUsKdlTUng63pvFyqq2tEFh+VbysNuF0iaOfOHTwCULW3qt66pZaks/hOJydmZtzQrz8hxd6qvzKq13aEPVD0F+sc9jt1WygWaWrbr8ihcv7x4yTG8bljN5l9zwEWALnntD0NqaZRAJoP6gYZ5Y3clpIcDR0UcNNT3lcIGjZTjCie2dfhRMpNdbzJSaFZZwOPiuuGHLkm5JKA3PgIeypLA6yp1rL27RmZplo4Z0wsXblG7ziu3DG9ZzU=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <ED9CCEF63AB03A48A5711DE9DE877353@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2c6d9d-3844-47bb-d17c-08d6c923ee9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 02:15:49.8802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3289
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.84
Subject: Re: [Qemu-devel] [RFC PATCH v1 00/10] Add AMD SEV guest live
 migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	=?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H.
	Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425021549.oj43-FmklfnqBSj4tqRAQX6Yz9HBpfCb41NyGsMA6l4@z>

DQpPbiA0LzI0LzE5IDc6MTggUE0sIFN0ZXZlIFJ1dGhlcmZvcmQgd3JvdGU6DQo+IERvIHlvdSBt
ZWFuIE1pQi9zLCBNQi9zIG9yIE1iL3M/IFNpbmNlIHlvdSBhcmUgdGFsa2luZyBhYm91dCBuZXR3
b3JrDQo+IHNwZWVkcywgc29tZXRpbWVzIHRoZXNlIGdldCBjb25mbGF0ZWQuDQoNCkl0J3MgbWVn
YWJpdHMvc2VjLiBUaGUgUU1QIHF1ZXJ5LW1pZ3JhdGlvbiBjb21tYW5kIHNob3dzIHRoZSB0aHJv
dWdocHV0DQppbiBNYml0cy9zLiBJdCBpbmNsdWRlcyBQU1AgY29tbWFuZCBleGVjdXRpb24gYW5k
IHRoZSBuZXR3b3JrIHdyaXRlLg0KTW9zdCBvZiB0aGUgdGltZSBpcyBzcGVudCBpbiBQU1AgRlcu
IEkgaGF2ZSBub3QgcGVyZm9ybWVkIHJhdyBQU1ANCmNvbW1hbmQgYmVuY2htYXJrIHlldCBidXQg
SSBiZWxpZXZlIFNFViBGVyAwLjE3IG1heSByZXByb2R1Y2UgdXAgdG8NCjEyTWJpdHMvcy4gSSB3
aWxsIHVwZGF0ZSB0aHJlYWQgYWZ0ZXIgSSBmaW5pc2ggdGhlIGZ1cnRoZXIgcGVyZm9ybWFuY2UN
CmJyZWFrZG93bi4NCg0KLUJyaWplc2gNCg0K

