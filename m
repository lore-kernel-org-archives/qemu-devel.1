Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB8C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DDD20731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="IZcJpqs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DDD20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiu4-00022P-U6
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTit6-00014S-L3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTirv-0005T4-Q8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:20:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:31312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTirv-0005IC-7c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:19:03 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T9FnY7032346; Wed, 29 Apr 2020 02:18:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=TNfDztYIux7eK2koJAn0RHnLwkaORxdyg3v24F+Q2DE=;
 b=IZcJpqs2P3W5IyAJmdbnW82lg/PZxtESFvr5g0mfw47dndlCCo2dhlv/813XnaqH2iMA
 NS342DfvoJ41hrDVPzLgnaCSqS3PBzqxp5GcSZszT3KiW7RsTy4BPeu4lxjVoxMUFhmt
 h6NG4csi4J/oKMHOHONvlyT0BCedzploHXOE7julH61phaO8YWXVNwuNU+HodJWZUT/n
 H9VFqQqMf5YJbAn2XalaHyoPEGRmi6pKlsWGxnliaipSOMp+uWe487egHxmmP644/Xg/
 mNFW8Ylfv2NUXhVAOkeREJOhhuz9op9l6tOOhDT3mLxL3rlnaON+1W1jwPc37+1IBD0U mg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mjr9gfdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 02:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcaChz0TYXd+E9Qq7xVE0W+zZ0CdqIFS+LsBdbHK3A+Tw6zUNrGk4/NOKwMzbYWwKtFAxoj5u4ISRPWnSmMhX7O8qT7F+fTdWjcXC8/6nsIHqXMQAfRy39lE2iI3LeYlPA8LVyQhq1E3POopXDog/+fB7M677d8xJBEj69SJ/YbmG9zTXZhvaRh8mOK8Upe+98K1uqWeW7xh450aT5Se822EHGVAXVL0DFhS4xvqnzfArGBKGKOm7k93wWJ7aYgJ6431ICe0hMHPQCvvXdSEFI42DVTf0pJCPKCdhwjF0tJrgNK4P4cN42SCQ+Rk2LJUYd7SbZkQauY6dnxjTE6DQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNfDztYIux7eK2koJAn0RHnLwkaORxdyg3v24F+Q2DE=;
 b=RSo/JiOEj9plRJJbHPfKf7KBHsfKJJDfNFPgqs3Aorlhwemhc/UKo4Ag+AvQhNLoihF6FY3WTco0E4+t3Ayo/uxqqd4KpiAydfx72VAcm9tDqlXmsq0fXpnnmTxyWliQLlSix9TmB67+BJFQcF5ShDCm53+ZfBJcox9BertN8+r+rbq4mgkUCbYkNKT4+8T/bzgqPCaDxHI/6XbHkqartUZ8h2+1KFqiAGKEYKhkxpZtcnql4bJY2ZqgoHiAoW8obkD8d4oHMpoJo439eaPvNoj1KZ4TwprI0LSxUUCI2/k9BwCAD/Ez6qrcx6Iqt3PlKXkQu1kmIFupbh6ULgaOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6448.namprd02.prod.outlook.com (2603:10b6:208:11c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 09:18:49 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 09:18:49 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgAgAAAq4CAAAGWAIAACeGAgAABVgCAAAdzAIAAATOAgAAL9gCAAATtAIAAATkA
Date: Wed, 29 Apr 2020 09:18:49 +0000
Message-ID: <73B966D5-3FC3-45FF-A5B9-1DC2F623AF83@nutanix.com>
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
 <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
In-Reply-To: <CEF52CB4-73FE-4D45-ACF7-440F7EC9AA1F@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 487209d2-adb2-4713-056e-08d7ec1e53bd
x-ms-traffictypediagnostic: MN2PR02MB6448:
x-microsoft-antispam-prvs: <MN2PR02MB6448CFC5E9C4A9E476C7B2D0F1AD0@MN2PR02MB6448.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(396003)(136003)(376002)(39850400004)(71200400001)(44832011)(8936002)(8676002)(86362001)(76116006)(91956017)(558084003)(36756003)(66946007)(66556008)(54906003)(66476007)(64756008)(66446008)(316002)(26005)(5660300002)(6506007)(53546011)(7416002)(33656002)(6916009)(966005)(186003)(4326008)(6512007)(478600001)(2906002)(2616005)(6486002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prre7VOH9RzvfDYsjjwj0SSYZxv8K4xoyuWeeAxeQlSDxZO6phtsbOczTKCzW7KB6NmqSCaKFGcCSCDsoz+29PORl0elqz4aPoV8M4e+7iG5ixzW35/q0tlkpyG6WEw4LnpV0W2zbQju2L0t0YD8ZNb2i7r3HJvz8POAhOr6mk1z7INsp/+Sd2pQBU/+sN5tbgbfk3zd3Sgrzs8OcfLL9DDJCv2WV9Mxd8SUWG7fqcMcZcn8bV3avllzgDDEVIaJlikKCFaieeFHADefqc4UjMlWRwFYFRA8OjB4qzAFajvInpO1IHjK3ODBx9TH8M/EMQgS8Nv+vHwgcu7Mv17C3JIREkhIsre+YEomYm7vZnKrQHMgg3tLdJrALE4MOdfJ46yU+FGt9KoqO0OPu11Lko+Dsa3SvLYD0ai+FprawFdBajuKOJzDQkgHG6yN8iwsjn4ny01CdGLDPx9KHTkekrg/eIAXvFy8FGtGT4NlcYFfN5fnWRLsHCQ+DcYCUUQWTbtZ7nLIrH/xtfLlNp5pOg==
x-ms-exchange-antispam-messagedata: N7cIuWVniZsaKVrj+euyQKJKvjI+XHfkBQ5kq79Jhy6gTRv3nm0zB3ywv6UfZeBFIU4Sm56cbTEg/+scCV7j/kl73I3YuU5BCk699WzL2zHagGBQ+wodK0uyTHuo3EeUnroEUs8AFXkIXsx79E3gg6o5aDkyvYLyR7OY8neOS5Iz12kmexqCJfWugmu+5HIFzMG4yt3K9AZbwCaGUYybsWlvWdDsmf3OwpoxIdL9TzVVYUhpIOE5mFJX7n3VqQcnuqQhsp1fb5Dvfvb2hDPm15gcRDGMG0nBpB57x/UXHNHWqtBWETgHPuEoCJM1WrfgUh4/cY5cB9vXhqFWtvCLTlKWyo4+uj6FRoF/zmXKmonx10k4/ax5cf+LGZsOJmIU31Zi3A/DYiJhC+3N62mwVT/2wFUNE9wF2hIsxOecnS+rZQWQ89EHbBqXjWa7Pm0Gd4TIBceasS8gsDE6viqsThv5T0Jco8mzS0P1SI0qi0DRnwRfcMD6o8FOBU4Vqz2sTZNb08AP//cWKKW+aiGbffz9rU7xOyfwgGyGvSOr+p72ZdNJ8rdpi0gUhp2MWPG3L1Q3ewDM3MLknu12VJQzbdWzWD1OOxtX33UUxZl4mmE7K+BQqFcfq4U8ExmZzo84tdg2+S4snhgyYcvfxFaEZZ3+SMEV80v5PqthmFuwc2lqf7vu8ibMYmSlgD5PBDOraSzyGU0GSetpeputnmV/jT054evKMMHQ6eg5xVSNEY48/UbTH3QUw1zwq3Ou6AzjNPCHzvI8pBqMzLH9iWbAceuO3HEwYJs0YMHcevgx2Ww=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E77232059DFB9B45951CC1586FE44047@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487209d2-adb2-4713-056e-08d7ec1e53bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 09:18:49.2356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqW0o6KpIYIH/Wa0wmWoEgsUBXQpPANG813gFyw0XEw5F4YfFmEaawQDazom/M1Nf2aljnHY6ukKfv8rbQ/9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6448
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

DQoNCj4gT24gQXByIDI5LCAyMDIwLCBhdCAyOjQ0IFBNLCBBbmlyYmFuIFNpbmhhIDxhbmkuc2lu
aGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IE5vdGUgdGhhdCDigJx0aGVzZSBjb250
cm9sIG1ldGhvZHMgYXJlIG9wdGlvbmFs4oCdIGxpbmUuIElmIHRoZSBPUyBhZGhlcmVzIHRvIHRo
ZSBzcGVjLCBpdCBzaG91bGQgbm90IGV4cGVjdCB0aGVtIHRvIGV4aXN0IGFsbCB0aGUgdGltZQ0K
DQpMaW51eCBmb3IgZXhhbXBsZSwgZGV0ZWN0cyBpdCBoZXJlOiBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvYWNwaS91dGlscy5jI0w1NzE=

