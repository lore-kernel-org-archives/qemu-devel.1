Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7835421775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="vHHnCWbK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="e24HkUpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7835421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhly-0006zH-LJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1izhky-0006KF-1D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1izhkv-0003V2-Qk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:03:47 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1izhks-0003Mc-O0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580997822; x=1612533822;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q+vygnuUAQ9GQOWsBfMpBSRn7rCbZ9y2C/1WYNdw844=;
 b=vHHnCWbK1SJVEebPOSKIWw+i55PMJ45qjz08RUiePhpV+XW8XTC5/Pu8
 nJYd8okE/dIgtGjCABgcliopBKw8gJHonU+oAUrV2Y2L12FcEGBnxWV1l
 yMNgSdXIT0EXyDc9Fm/lYKvYZFkT20iEuwleoRA+oqR3rNR36gxhW2oWh o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Feb 2020 06:03:41 -0800
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 06 Feb 2020 06:03:41 -0800
Received: from NASANEXM01C.na.qualcomm.com (10.85.0.83) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 6 Feb 2020 06:03:40 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Thu, 6 Feb 2020 06:03:40 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4632.namprd02.prod.outlook.com (52.135.239.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 14:03:38 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 14:03:37 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gNrT4AgABKNoCAABLgEA==
Date: Thu, 6 Feb 2020 14:03:37 +0000
Message-ID: <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
 <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
In-Reply-To: <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cd4fc23-5ca6-400a-e59a-08d7ab0d5d05
x-ms-traffictypediagnostic: BYAPR02MB4632:
x-microsoft-antispam-prvs: <BYAPR02MB463271DE56A5B74BFCC709BFDE1D0@BYAPR02MB4632.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(4326008)(55016002)(76116006)(66946007)(9686003)(71200400001)(81166006)(8676002)(81156014)(8936002)(86362001)(186003)(478600001)(110136005)(6506007)(26005)(53546011)(316002)(66446008)(66556008)(64756008)(33656002)(66476007)(52536014)(2906002)(5660300002)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4632;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xXRdkUCVuDKxqQlYIeZ31jB+0VR/Tib4Oim/scAJMYAMMw5obSQxZ0Ra8yHf5v2nhWWiojaBYIibnBhyLKjdA4EBM6xIfjfkOpIvwHKXWhNriGS56almDKMxhTfJ8yeet+I0o6eoHiCwLLbReY96i9dAf3OPi6Ih+NWxorc3F6QDo2B8MSfC4SZ3+h5KHeLWqoP65yrkM8UReaWJWSgXBoCeplFwx62wwvNkzNf3biQyUNA77OO0GgeiuiKXJzKLK1ohlC7GJ+yMrYlwDMfghCNOm8ZKJzSMp0rrDeoM1Ywy6hOXWxiEipZVqgazWVKCJ4BmGkLQ5/bSgcmlVjj9HFhxji1/wQPsTirAZ0lm8fL46voga1Qf5KQy+DXiKMRaMXrAanzqpMW+ACFLwCXD0kZ1FuQxMqUvr7osC+XMR17fJxGb3RGiPp7rpSq2yNIH
x-ms-exchange-antispam-messagedata: rnwrAW9NXBNizAcvsKYjTiWgS24lygPQQAifJOmqne1tg0ogJsQbOajk+/AP74kvfcYgqd7/r8ublaDZT4mLks5XPf+fCcMQCtFFRp1AGqjktH2zJH1t8X6oetMfjX60pCp2kAmuZNra9iMY1Bjosw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9kzijPmRIYQaWM5ACwGq+MmTLQrJYWcdXoG4p23p4IvA5QrBefryOfYU0AgOFxEemSi+GMSaGVFDDrkRk4jvzHRxEbb4i8B0y0RGU2KclOYnOQD5Ix+ZCEg75dKTUZ2q3x5CmKcThULXX3M92+bWRXsJkW458Y/OOLnwy7G4uGrcQtqFOB1jmsJ6NtWQ++vj/Gvxb9D7MJDgkZQf15HX6YaF1xVKQ/05wZlXdV5Vo/cfCc7YACMeThguKS1wI59JqfqZ5WeoO+jDlKqHgpncNctpPVO+0+2XEHGnCpoNlCjXaZao5mm77xpaknteAHuYW95NELavoeyU8cmCeIJ0g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NleoV7QbcDMEsQWzG2uNCTLMqC98n8LtZuieM4uiTRU=;
 b=ACHdcLLlSbw5tyPiF8nfbOZQkc63yEAONMZVhZrwAZV/gvG79PeIRSmXX7lJ9V0twGpeA8OuwTE9vh4XAMifdr2W52/uCenexO+LP5KVfSU3WcZJvXZNOQCKTQXl69H/GSmiqTLzjF7BrzlTBgguaX93Akw5WvX1RHW1/A14RXtv+b+oJg8FncZQPLL+tG4Yhcjflcc3JOfv6k+z7FhqP8lkzmHdl5XviLR8LE+3Lzk2Doe1U1AX6FuhV7/c7ok7agw7d+vu8Q9BJHBLqcSp///ooAnCvA5qlOG0X/GJlZNb0P0yXh+s5rsoiyFZIEZhMb0woqyjaQti6oIXPQb0Zw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NleoV7QbcDMEsQWzG2uNCTLMqC98n8LtZuieM4uiTRU=;
 b=e24HkUplHJ8Jn7CqUUELDHSWqL0ZUDa9BENltbzvdDHnswnxd+TQWFDkJeInnZdT8bKSg/04ECFseYitDvXRQeL+fdCHKQkeYPDRrCZ2y6zWFLKZhR/OfByEzwbVf9lTzinuWdj2hHLZnbCU0q7lFkCj/55y/LVR4IY0GfjcId4=
x-ms-exchange-crosstenant-network-message-id: 6cd4fc23-5ca6-400a-e59a-08d7ab0d5d05
x-ms-exchange-crosstenant-originalarrivaltime: 06 Feb 2020 14:03:37.7857 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: XYSoVGT918lFkFwW4FmRtyLGBC2IcKIC4MVf8ecrgKJyaJT6oelr5WYD/w83nkDF+rFQ6tC0dxBKifi4LxtnMg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4632
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U29tZSBvZiB0aGUgbW9yZSBjb21wbGV4IGluc3RydWN0aW9ucyBuZWVkIGEgbG90IG9mIG9wZXJh
bmRzLiAgSGVyZSdzIGFuIGV4YW1wbGUNCiAgICBpZiAoUHY0KSBtZW1iKFJzMzIgKyBSdTMyIDw8
ICN1MikgPSBSdDMyDQpUaGlzIGlzIGEgcHJlZGljYXRlZCBzdG9yZSB3aXRoIDUgb3BlcmFuZHM6
DQogICAgUHY0cHJlZGljYXRlDQogICAgUnMzMiwgUnUzMiwgdTJ1c2VkIHRvIGNvbXB1dGUgdGhl
IGVmZmVjdGl2ZSBhZGRyZXNzDQogICAgUnQzMnZhbHVlIHRvIHN0b3JlDQpJbiBhZGRpdGlvbiwg
ZXZlcnkgaGVscGVyIGdldHMgYW4gZW52IGFyZ3VtZW50LCBhbmQgcHJlZGljYXRlZCBpbnN0cnVj
dGlvbnMgZ2V0IGEgInNsb3QiIGFyZ3VtZW50LiAgVGhlIHNsb3QgYXJndW1lbnQgcmVmZXJzIHRv
IHRoZSBWTElXIHNsb3Qgd2hlcmUgdGhlIGluc3RydWN0aW9uIGlzIGxvY2F0ZWQgd2l0aGluIHRo
ZSBwYWNrZXQuICBJdCBpcyB1c2VkIGZvciBwcmVkaWNhdGVkIGluc3RydWN0aW9ucyB0byBjb21t
dW5pY2F0ZSB0byB0aGUgZW5kLW9mLXBhY2tldCBoYW5kbGluZyB0byBkZXRlcm1pbmUgd2hldGhl
ciB0aGUgaW5zdHJ1Y3Rpb24gc2hvdWxkIGNvbW1pdC4NCg0KU28sIHRoZSBzaWduYXR1cmUgZm9y
IHRoZSBoZWxwZXIgZm9yIHRoaXMgaW5zdHJ1Y3Rpb24gaXMNCiAgICB2b2lkIEhFTFBFUihTNF9w
c3RvcmVyYnRfcnIpKENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQzMl90IFB2ViwgaW50MzJfdCBS
c1YsIGludDMyX3QgUnVWLCBpbnQzMl90IFJ0ViwgaW50MzJfdCB1aVYsIHVpbnQzMl90IHNsb3Qp
DQoNCkhUSCwNClRheWxvcg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFJpY2hhcmQgSGVuZGVyc29uIDxydGg3NjgwQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIFJpY2hh
cmQNCj4gSGVuZGVyc29uDQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2LCAyMDIwIDQ6Mjkg
QU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQWRkIHN1cHBvcnQgZm9yIGEgaGVscGVyIHdpdGggNyBh
cmd1bWVudHMNCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9y
aWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uDQo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4NCj4gT24gMi82LzIwIDY6MDIgQU0sIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0K
PiA+IE9uIDIvNS8yMCAxMDo0MSBQTSwgVGF5bG9yIFNpbXBzb24gd3JvdGU6DQo+ID4+IEN1cnJl
bnRseSwgaGVscGVycyBjYW4gb25seSB0YWtlIHVwIHRvIDYgYXJndW1lbnRzLiAgVGhpcyBwYXRj
aCBhZGRzIHRoZQ0KPiA+PiBjYXBhYmlsaXR5IGZvciB1cCB0byA3IGFyZ3VtZW50cy4gIEkgaGF2
ZSB0ZXN0ZWQgaXQgd2l0aCB0aGUgSGV4YWdvbiBwb3J0DQo+ID4+IHRoYXQgSSBhbSBwcmVwYXJp
bmcgZm9yIHN1Ym1pc3Npb24uDQo+ID4NCj4gPiBUaGlzIGlzIG5vdCBzYWZlLCBpbiBnZW5lcmFs
LCB3aXRob3V0IG90aGVyIGNoYW5nZXMuDQo+ID4NCj4gPj5Gcm9tIGluY2x1ZGUvdGNnL3RjZy5o
Og0KPiA+DQo+ID4+IC8qIFdoaWxlIHdlIGxpbWl0IGhlbHBlcnMgdG8gNiBhcmd1bWVudHMsIGZv
ciAzMi1iaXQgaG9zdHMsIHdpdGggcGFkZGluZywNCj4gPj4gICAgdGhpcyBpbXBsZXMgYSBtYXgg
b2YgNioyICg2NC1iaXQgaW4pICsgMiAoNjQtYml0IG91dCkgPSAxNCBvcGVyYW5kcy4NCj4gPj4g
ICAgVGhlcmUgYXJlIG5ldmVyIG1vcmUgdGhhbiAyIG91dHB1dHMsIHdoaWNoIG1lYW5zIHRoYXQg
d2UgY2FuIHN0b3JlIGFsbA0KPiA+PiAgICBkZWFkICsgc3luYyBkYXRhIHdpdGhpbiAxNiBiaXRz
LiAgKi8NCj4gPj4gI2RlZmluZSBERUFEX0FSRyAgNA0KPiA+PiAjZGVmaW5lIFNZTkNfQVJHICAx
DQo+ID4+IHR5cGVkZWYgdWludDE2X3QgVENHTGlmZURhdGE7DQo+ID4NCj4gPiBUaHVzIDcgdWlu
dDY0X3QgaW5wdXRzLCBvbiBhIDMyLWJpdCBob3N0LCB3aWxsIG92ZXJmbG93IFRDR0xpZmVEYXRh
Lg0KPg0KPiBNeSBiYWQsIG5vIGl0IHdvbid0LiAgRm9yIHNvbWUgcmVhc29uIEkgaGFkIHR3byBv
dXRwdXRzIGluIG15IGhlYWQsIGJ1dA0KPiB0aGV5J2xsDQo+IGJvdGggYmUgdWludDMyX3Qgbm90
IHR3byB1aW50NjRfdC4gIDcgdWludDY0X3QgaW5wdXRzIHdpdGggMSB1aW50NjRfdCBvdXRwdXQN
Cj4gd2lsbCAqanVzdCogZml0Lg0KPg0KPg0KPiA+IFdoYXQgYXJlIHlvdSBkb2luZyB0aGF0IHJl
cXVpcmVzIHNvIG1hbnkgYXJndW1lbnRzPw0KPg0KPiBCdXQgSSdkIHN0aWxsIGxpa2UgdG8ga25v
dyB3aHkgeW91IG5lZWQgc28gbWFueS4NCj4NCj4NCj4gcn4NCg==

