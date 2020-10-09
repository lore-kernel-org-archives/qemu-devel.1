Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E7CC43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04BA22261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="anrsM56P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="mAY9CGdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04BA22261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv2O-0001LI-E9
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQuqo-00042H-AS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:35 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37081)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQuqY-0001Dr-JU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1602259338; x=1633795338;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bKryMW5MZ7/L6xZZUCIXD8CVuUfBCpqVdL9s9YkoPks=;
 b=anrsM56PZTSbz3SCV4Wb8Igr2+ZSfklU3I2Gn2CNTJ3bbUzoChrII1GV
 R9A+eiODIzJTlA8mLsqyWvhmypoBVh1qehcRWAmXUQphcR7pfllFXxtt9
 +2s4RJvIAr6v/vlm85Pwh23QcAEMslM6LHuQu70IHOaZBkzyWusXvMTIa Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Oct 2020 09:02:11 -0700
X-QCInternal: smtphost
Received: from nasanexm03f.na.qualcomm.com ([10.85.0.47])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 09 Oct 2020 09:02:11 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Oct 2020 09:02:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 9 Oct 2020 09:02:11 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6660.namprd02.prod.outlook.com (2603:10b6:a03:212::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Fri, 9 Oct
 2020 16:02:10 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 16:02:10 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Topic: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Index: AQHWdXdf6p/vkS3v9UGs80VPN3oP2KlOWTUAgD+1nUCAADfPgIAAExFwgAAXOYCAAAhvQIABE8OAgAAxPyA=
Date: Fri, 9 Oct 2020 16:02:09 +0000
Message-ID: <BYAPR02MB4886B589D6CA8D47F26687E2DE080@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
 <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <b77feb32-9170-0c19-8147-5a195a227cca@linaro.org>
 <BYAPR02MB488658CFC0440D56F13F68D0DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <7f0ae43c-97a0-3337-eac7-938a2f244d3d@linaro.org>
 <BYAPR02MB4886A2E28C56A059B9F54942DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <b609e70e-aa24-f724-43ba-8898bc8e956f@linaro.org>
In-Reply-To: <b609e70e-aa24-f724-43ba-8898bc8e956f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12adffc5-85f1-428f-2b61-08d86c6cadd4
x-ms-traffictypediagnostic: BY5PR02MB6660:
x-microsoft-antispam-prvs: <BY5PR02MB666009A0DF3551E852B933B8DE080@BY5PR02MB6660.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: etmZmVajZz7/oLxPacKaOJKSLz8DGiJOQvH+XdzcxFXb4cbL10Ca5SOrch/u/oL+/sJY644gIrv3sYf33aO+7g+LqcufSxNs53ToOO09s0vFDppoyJmIf2Fqi009Lestnd1stioF4A0nm+2UXqJ7NdF+Hp0WZVokwbC0v4rNvS4jdAnIjHvx0LRiYqKxgs3X9sNdE3pT+wRgg6/4v5LlbcUR/9pjS6gl0n3fPylnh+jzlHOVMceeT4MYpJuMm6GyZuF/2u8eqHDAlnCn1Vqrrt7Fk2mURhVGIO9nSBYqDP6HQtAPEbx50LrAyjA1GsXMGKgS1vVRLe8uWhwfGrG6cA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(396003)(366004)(39860400002)(376002)(7696005)(83380400001)(66446008)(2906002)(76116006)(66556008)(54906003)(110136005)(478600001)(55016002)(5660300002)(316002)(26005)(186003)(66946007)(53546011)(6506007)(66476007)(52536014)(64756008)(86362001)(9686003)(4326008)(71200400001)(8936002)(8676002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MQhPV6yJub2PRFlcAwz9tLsUqcKazV5J4b9Qj5HfG2X24e1KsW5zj/fUSWOm5cw+1ydeXvjpeP0m4cFBaw+CdfMTHMPrFZfhdETsEE1ZfGRuTyoEubxEmw884SeIytN4zOT9GkIgTIiPGBxuFTO5By1+HWjP4EObi753ue+4WlStJhhtHgdBIX3hj5HBDLzcz4Y7XepYUw4UTZcPnCm0CoUOqDXj6EUUTaNueOAeuMKSJL3CHsRQ8GDhCa8oFlnU0hpdP07amG7YHeNfhwjnIVHQNRJ67gIvv28ZeFd6fars16pEJVFrVvIxeDHwVMFwWwaiPr+Ikd3cmZRoJkBS/LPZqxB3JgBRm84vhKEM65//dBVH3KEa3HC+wLByVSWqohy/uyMXpwdj6fk59l9AvWwG2+xnVfV0bG7uOOjYnONhYkXjPZq8g7KlX+ljkeum4tuPE/85oi0gSCWxJ0p90emL5mkwET21OzWyvk3loL89BBVupKu8//Hc9h62BSZnOswu78MVCwaJkHKJobrCVKmcoHeaniM2u2PGkNsJnEz3OYDwfXCQ+IA48HVyRdN2geNxYItxzBr+L++bTAcAxdykgY5TtF/sMeTwxtaSg/jQiYYjm07xCNvPA8sclLTpy3d4KXATkzp4YL0LaI4xiA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmXz815SQtMT+K98Y3T1ZbXolSYmUfUEwhzvXl2vfI1FaaxLultyAGtB0F4H5vGGC+CHvsG//xXfEQk8fY2Eb0vOxbBtMoRQxDUSE6/BARLNbToJwldtmuJuxLd+JJ0vOAUTDxsZZcMZbitOH0mYYgNO2joDKfQlKuEFz/h4YNNcoJGMgZCfQcE7CYlgskqkYA0lW+y0esRjG74QFFbqU2qdW6RccNOhXng6UiOYpb/aIvtUIuexHg/9r0sVUQNKUTtHsLdvSxRdfJc0AChXRG0/OZHcnrNZIoPmaucph/bRVYeWnelZPRuiOs2Vln+pFc3k1mCm/bFX0Ott0K9kIQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TcB2QtFcuAcXRqTlBbzJcF50vtWLrA8M0roZDWaAzA=;
 b=cFCRku/hDnxkDfuePY6BXNW1pmm0vr2sIQaKp/BWlktU1rjJnY5pAowbA7EqWVl2DzT3v4YJTvm6F6hHK+Eto15t+dHznOnTMmqnAv71fTOJ3U55O9/4O96DpqAfsHolfs7JL1DU5+I1blqh0aWpV6flvSadg98NxYiYSDMa6qSGAVnV888GmHvcA9ckouEcnv3JkD6EgAjb0z4OqEFb/44+sWmvJXC2/+0IuYdZb73CllumTCvfD0JGCFSD/9sLPW78eFfB4DuHsRKPGR9e00LxKB9gisUD0RAMwGY/4REz99SBe8itr5X+ZqtgngWjmMoegMGvHCOCTRrOjPnJug==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TcB2QtFcuAcXRqTlBbzJcF50vtWLrA8M0roZDWaAzA=;
 b=mAY9CGddQzEBNw5OuSSeCtDq7xiEBjwtRdqZKZIW9bSnIjq9cyUowkLD/mCIeiTmJ35JXxXaaA+C2+mbYfftHkfjaxfdbWOMfaC9TSuBLyV9M57L2aPk1foM5Fwc0hGCRGswrtsd0JVDhP7JzvIy0utUdN0vCK8DwJTNSGie8fk=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 12adffc5-85f1-428f-2b61-08d86c6cadd4
x-ms-exchange-crosstenant-originalarrivaltime: 09 Oct 2020 16:02:09.9787 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: zLtH2V7GmTYQdH5lWcs7/kJpVlURR1fTbMFAZF81dSdy9GLNNUl8rcsbqCN42tblBpX+QLFeFK7BhZwDvW1WNA==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6660
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 12:02:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgSGVuZGVyc29u
IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIg
OSwgMjAyMCA2OjU5IEFNDQo+DQo+IE9uIDEwLzgvMjAgMzo1NCBQTSwgVGF5bG9yIFNpbXBzb24g
d3JvdGU6DQo+ID4gSSdsbCByZWFjaCBvdXQgdG8gdGhlIGFyY2hpdGVjdHMgYW5kIGFzayBpZiB0
aGVyZSBpcyBhIGNhc2Ugd2hlcmUgZG9pbmcgdGhlDQo+IHN0b3JlIGZpcnN0IGNvdWxkIGJlIGEg
cHJvYmxlbSAtIGFuZCBhbHNvIGFib3V0IHRoZSBwcmlvcml0eSBvZiBleGNlcHRpb25zLg0KPg0K
PiBPZiBjb3Vyc2UgdGhlcmUgYXJlIGNhc2VzIHdoZXJlIGRvaW5nIHRoZSBzdG9yZSBmaXJzdCB3
aWxsIGNhdXNlIHByb2JsZW1zLg0KPg0KPiA+IFRoaXMgbWF5IG9yIG1heSBub3QgYmUgcG9zc2li
bGUuICBXZSBhbHJlYWR5IGhhdmUgdG8gcmVvcmRlciB0byBwdXQgLm5ldw0KPiBjb25zdW1lcnMg
YWZ0ZXIgdGhlIHByb2R1Y2VycywgYW5kIHdlIGhhdmUgdG8ga2VlcCB0aGUgY2hhbmdlLW9mLWZs
b3cNCj4gaW5zdHJ1Y3Rpb25zIGluIHRoZSBvcmlnaW5hbCBvcmRlci4gIFNvLCBJJ20gcmVsdWN0
YW50IHRvIGdvIGRvd24gdGhpcyBwYXRoDQo+IHdvcnJ5aW5nIHRoYXQgdGhlcmUgd2lsbCBiZSBh
IGxvbmcgdGFpbCBvZiBjb3JuZXIgY2FzZSBidWdzIHRvIGVuZ2luZWVyIG91dC4NCj4NCj4gV2Vs
bCwgZG8gYXMgeW91IGxpa2UsIEkgc3VwcG9zZSwgYnV0IEkgdGhpbmsgdGhlIG1lcmdpbmcgdGhp
bmcgdGhhdCB5b3Ugd2VyZQ0KPiB0cnlpbmcgdG8gZG8gaXMganVzdCBhcyBmcmF1Z2h0IHdpdGgg
cGVyaWwuDQoNClRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZSBvbiB0aGlzLiAgQWZ0ZXIgc3BlYWtp
bmcgdG8gdGhlIGFyY2hpdGVjdHMgYW5kIHB1dHRpbmcgbW9yZSBjb21tZW50cyBpbiB0aGUgZGVj
b2RlciAocGVyIHlvdXIgZmVlZGJhY2spLCAgSSdtIGNvbnZpbmNlZCB0aGF0IGRvaW5nIHRoZSBz
dG9yZSBmaXJzdCB3b24ndCBsZWFkIHRvIHByb2JsZW1zLiAgU28sIEknbGwgbW92ZSBmb3J3YXJk
IHdpdGggeW91ciBzdWdnZXN0aW9uLg0KDQpJbiBvdGhlciBuZXdzLCB0aGlzIGNoYW5nZSBhbmQg
dGhlIHN3aXRjaCB0byBxZW11IHNvZnRmbG9hdCBhcmUgdGhlIG9ubHkgYmxvY2tlcnMgZnJvbSB5
b3VyIHJldmlldy4gIE9uY2UgdGhlc2UgYXJlIGRvbmUsIEknbGwgc3VibWl0IHY1IG9mIHRoZSBz
ZXJpZXMuICBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2ssIGl0J3MgbWFkZSBvdXIgY29kZSBzaWdu
aWZpY2FudGx5IGJldHRlci4NCg0KDQpUaGFua3MNClRheWxvcg0K

