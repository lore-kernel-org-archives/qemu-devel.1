Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C53C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAF720719
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kXyhBe/D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s0S9zjK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAF720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO78a-000505-SL
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 18:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=536915954=Dmitry.Fomichev@wdc.com>)
 id 1kO76T-0003sh-TO; Thu, 01 Oct 2020 18:31:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=536915954=Dmitry.Fomichev@wdc.com>)
 id 1kO76N-0008Fb-Hg; Thu, 01 Oct 2020 18:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601591463; x=1633127463;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7QpD3Wr6D6Om+ehj5GCVnlf8U61P5GJUadHpPgrIW6M=;
 b=kXyhBe/D09H/RjJDGPZFBRTZu3fTXMfNQJDJi3SD65cZnryf/7mZ3AlS
 WpGOTtsIA33gqz+Y5Vp0Tx6JoQNbsHvnq21BKsLcjKZsRrGkcbjjGfR1k
 7gEj8DvHeNawLxfnbmiZmLUh90l0+ri6JyVyvWflcnUtiUNB6bEboMv3D
 KlSpQvv9pEEHa9vOc5llBUyza3aBf/3G7jplGTM3aoQpczn9VKwWCrH6e
 xUrFYPmBdliijznIT9yO7jAERQHzmAlfVSxPJnQKTbopPLsAnDS/wthbe
 R20JrPTIZk3ANKk0+aU5wtP0WBsJ1vh823j6nGdpDnVTXl58dekgeZiUU w==;
IronPort-SDR: zncUX0yAbWo9CcBJBOuIm+NgvN5kLli1ml6rYo/QaA6dLlzTOlmKmPPjzNxGEr+JcOaSeozyOR
 MJeeoFtdwRM6a/4nIm9pgaD5rEbmDBpuxIofc/9gkJlp0EEOzkt+bIgXIi1vgK+QM7fbuspmz2
 AdI6e5f+YFSjNDRFnz5RjiSlxnxlSKp8bX6ntwsQOg1d9bJSU1U1upb5gSKJaM3fa09CSEunfx
 iXa+z1+jl6+kiDR+gvWMttE7YbvmoHbOBQ8ovyUGLGNca6JsZluOoRdIl8ldBx9MlljLC3bfpZ
 PZo=
X-IronPort-AV: E=Sophos;i="5.77,325,1596470400"; d="scan'208";a="258617985"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 06:30:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfRbAWQ2v63cO5Klo76HTvdoZtmssfdjCfueeYDIdIuOP/0ThnYoqm+h5sIR8wTtJyZoagHbd1wgiQYwqGEjzseYB99IahxA/XB1P6SpMXsse5QJQGkd3Qab/Tfv12CEQrUpSXwThwf7PB2Fq0rxdTJoKRA5ghgxkq4RcJ1Se0FQDTzcw9P0kEvtbp1PZUOsUbqqihC03wZoiml8nZ3wLl/83UU+5G/sm9GJUWWeOXNpYxMuipG2Z1QAvPSIzixUXa8MBXjvIrUW3dDKfgWck2aT6+0/EhoOcji24XvR9DPcs1liUChU34SHeOD+w4wJI66DI5/X6mlrl80CFAkzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QpD3Wr6D6Om+ehj5GCVnlf8U61P5GJUadHpPgrIW6M=;
 b=RXmYgGza8nzYTaJV83rn09kDEdPG85lzODfEnFTREGAtLLlRQukb1l29rW7ajbV1WHhSJXrQlEpo3/qEQarEKhPsxfhXLd9euJXoDiQf2a8N7C0ksNW2CWwPaJs1KQGbPsYOWppYv15cgqm/Q94nJ7wr83NppR1j9nW4D3xkHbqUzw3cHqolimkzw9gnq2rG/HLDaJtwub4cZCuJV1Gk++KJSzLlbSW9GNbVjR17wA/8xtMUK5RHiO6+wlJvEEY1GqQmfB8pXc9gjJB8A1NGhN6L9qsDPuVd965I7cBZk6eW6d8fvuZgFCg3/e4L+N5i+zNWfVMO64FGR8Wnv85peQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QpD3Wr6D6Om+ehj5GCVnlf8U61P5GJUadHpPgrIW6M=;
 b=s0S9zjK+Qs8jN3exSjpYg4C9AFDFxmv2sefHwtFbuMWHpZ06gT/AhWhENvaVfxVnoXLPIb360YqBqAvKaFt2jOZFqzjji/jRaKALR8IeXkrCtdhLvgk06pgBwjulEzBFuzT51wzR890ZUzLAdf453Y2asKuby3y9AjJ0Hrk/9ec=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5648.namprd04.prod.outlook.com (2603:10b6:208:a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 1 Oct
 2020 22:30:55 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 22:30:55 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWlUAVDU4vw65+1E6gJIAdDV/2DqmDVjIAgAADDVA=
Date: Thu, 1 Oct 2020 22:30:55 +0000
Message-ID: <MN2PR04MB595171B213B7365D222A9EFDE1300@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
 <20201001221520.GA841624@apples.localdomain>
In-Reply-To: <20201001221520.GA841624@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41008bc6-6449-43ad-eb63-08d86659a96d
x-ms-traffictypediagnostic: MN2PR04MB5648:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB56481EBC307A4F6190965EF3E1300@MN2PR04MB5648.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6iuTX/iJJWZrkdfUNxnBPyb35Xsg4N7salBwbArV2WzMbSH169fEqPF1Qmj84/lUAw0rbMXfUmxgaUMUGpyCf4DuOIGzw2JCCgVLLqd1++HhjuvVFl5yR4dJjR3+ae+rlKecN7ELPwE8Qt4ZJWnnr19L5kwWCsrOam8J3dzkbaWgiBAfUZYWLUEo+nDA6kA6OEn5Yg27Ya3XXtu8VCTC+CF+H/NzgBvrW/B7ZDULdHVzn55kJv2KTEtRM6FsB7lMUXnYeVc9sKl5A9HoUwvOKrfJjhpHMvcLVSf1ri/X6mwR7OYvUSLMKAyGFma3/3UdolPmTTLAgbfisUsr7KTIAZogc6TAE1RLbuzFfX2ig1MeIrIyF05qj8XNGBhb2yN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(6506007)(26005)(9686003)(55016002)(86362001)(186003)(8676002)(53546011)(478600001)(8936002)(54906003)(66556008)(71200400001)(4326008)(52536014)(316002)(2906002)(33656002)(66476007)(66446008)(83380400001)(66946007)(7696005)(6916009)(76116006)(5660300002)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: TsJISUFyxFLIfWGyCd6k7/UrR3pyfkQU866EVrRBaFJ0Y5XmX1qn9YDvW/otEuwL/1g/qFDCzPtPeGsbXZ14zGMyIoGSvac6Fc4uePZqKOyaChy/dYzHLT8aqffpRK+y4+14K+gd3Iy7JF8TdtQL+rb0MqcGH2vTqSKQVYsU7Xf+PzIFnYa/hllaXwC3TP1jzhx1mcIetEBW0s5UgWyFaLcgzlu7RiHsY3QUYCfU4+anqFwP26R6JSZa2Glhe0Ewqr32IDYX1biub4BX2XqvVpwm5gPozIU1nW9i2WMYwoTpWZpqBVActRN29SFKgStXPBqUzggD4tZUTRPKinBYxasFjjLpKOOByFpWEyxvoBC+fBmaBa+ix/YPXHSPI/nOuqcW/CQzEa9NJ2P2vio0Lg9HjwMMbMh7NL2GO8B7B5Jo3b72cDgEtjY9t/qeyepj+TDcBWB0VLJdg85ZGBfYNQW20XctxrYfDws0ir4F3A3mUu7H17VBavdn6QCJTFaDM3u3DdU16f4mKAza+bzgclxf7Dl92KEuGpiWPk3xli2+evQdYs6dkIkmU7vNlqafdriO/6l1NmC3PQ3nLmi7cRlZWWR3iBu/CyYaHajXzDR4nKg+CHRu6XTT19Mxj8De+SMS5tR4K7blqxvolqPwtw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41008bc6-6449-43ad-eb63-08d86659a96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 22:30:55.1911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7micuVXmHQ4CKSw128rkgtV5fEA6US89aE/0scAOrM06mD1U1qipRtW4KFUVdSRbHjxWWJ3krjVdOC8hKDEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5648
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=536915954=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 18:30:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0Bp
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxLCAyMDIwIDY6MTUgUE0N
Cj4gVG86IERtaXRyeSBGb21pY2hldiA8RG1pdHJ5LkZvbWljaGV2QHdkYy5jb20+DQo+IENjOiBL
ZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+OyBLbGF1cyBKZW5zZW4NCj4gPGsuamVuc2Vu
QHNhbXN1bmcuY29tPjsgS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IFBoaWxpcHBlDQo+
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IE1heGltIExldml0c2t5DQo+IDxt
bGV2aXRza0ByZWRoYXQuY29tPjsgRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD47IE5pa2xhcyBD
YXNzZWwNCj4gPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IERhbWllbiBMZSBNb2FsIDxEYW1pZW4u
TGVNb2FsQHdkYy5jb20+Ow0KPiBxZW11LWJsb2NrQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsg
TWF0aWFzIEJqb3JsaW5nIDxNYXRpYXMuQmpvcmxpbmdAd2RjLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NSAwNS8xNF0gaHcvYmxvY2svbnZtZTogQWRkIHN1cHBvcnQgZm9yIE5hbWVzcGFj
ZQ0KPiBUeXBlcw0KPiANCj4gT24gU2VwIDI4IDExOjM1LCBEbWl0cnkgRm9taWNoZXYgd3JvdGU6
DQo+ID4gRnJvbTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPg0KPiA+DQo+
ID4gTmFtZXNwYWNlIFR5cGVzIGludHJvZHVjZSBhIG5ldyBjb21tYW5kIHNldCwgIkkvTyBDb21t
YW5kIFNldHMiLA0KPiA+IHRoYXQgYWxsb3dzIHRoZSBob3N0IHRvIHJldHJpZXZlIHRoZSBjb21t
YW5kIHNldHMgYXNzb2NpYXRlZCB3aXRoDQo+ID4gYSBuYW1lc3BhY2UuIEludHJvZHVjZSBzdXBw
b3J0IGZvciB0aGUgY29tbWFuZCBzZXQgYW5kIGVuYWJsZQ0KPiA+IGRldGVjdGlvbiBmb3IgdGhl
IE5WTSBDb21tYW5kIFNldC4NCj4gPg0KPiA+IFRoZSBuZXcgd29ya2Zsb3dzIGZvciBpZGVudGlm
eSBjb21tYW5kcyByZWx5IGhlYXZpbHkgb24gemVyby1maWxsZWQNCj4gPiBpZGVudGlmeSBzdHJ1
Y3RzLiBFLmcuLCBjZXJ0YWluIENOUyBjb21tYW5kcyBhcmUgZGVmaW5lZCB0byByZXR1cm4NCj4g
PiBhIHplcm8tZmlsbGVkIGlkZW50aWZ5IHN0cnVjdCB3aGVuIGFuIGluYWN0aXZlIG5hbWVzcGFj
ZSBOU0lEDQo+ID4gaXMgc3VwcGxpZWQuDQo+ID4NCj4gPiBBZGQgYSBoZWxwZXIgZnVuY3Rpb24g
aW4gb3JkZXIgdG8gYXZvaWQgY29kZSBkdXBsaWNhdGlvbiB3aGVuDQo+ID4gcmVwb3J0aW5nIHpl
cm8tZmlsbGVkIGlkZW50aWZ5IHN0cnVjdHVyZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
aWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RG1pdHJ5IEZvbWljaGV2IDxkbWl0cnkuZm9taWNoZXZAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAg
aHcvYmxvY2svbnZtZS1ucy5jIHwgICAzICsNCj4gPiAgaHcvYmxvY2svbnZtZS5jICAgIHwgMjEw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+IC0tLS0tLS0NCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxNzUgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS1ucy5jIGIvaHcvYmxvY2svbnZtZS1ucy5j
DQo+ID4gaW5kZXggYmJkNzg3OTQ5Mi4uMzFiN2Y5ODZjMyAxMDA2NDQNCj4gPiAtLS0gYS9ody9i
bG9jay9udm1lLW5zLmMNCj4gPiArKysgYi9ody9ibG9jay9udm1lLW5zLmMNCj4gDQo+IFRoZSBm
b2xsb3dpbmcgbG9va3MgbGlrZSBhIHJlYmFzZSBnb25lIHdyb25nLg0KPiANCj4gVGhlcmUgYXJl
IHNvbWUgcmVkdW5kYW50IGNoZWNrcyBhbmQgd3JvbmcgcmV0dXJuIHZhbHVlcy4NCj4gDQo+ID4g
IHN0YXRpYyB1aW50MTZfdCBudm1lX2lkZW50aWZ5X25zX2Rlc2NyX2xpc3QoTnZtZUN0cmwgKm4s
IE52bWVSZXF1ZXN0DQo+ICpyZXEpDQo+ID4gIHsNCj4gPiAgICAgIE52bWVJZGVudGlmeSAqYyA9
IChOdm1lSWRlbnRpZnkgKikmcmVxLT5jbWQ7DQo+ID4gKyAgICBOdm1lTmFtZXNwYWNlICpuczsN
Cj4gPiAgICAgIHVpbnQzMl90IG5zaWQgPSBsZTMyX3RvX2NwdShjLT5uc2lkKTsNCj4gPiAtICAg
IHVpbnQ4X3QgbGlzdFtOVk1FX0lERU5USUZZX0RBVEFfU0laRV07DQo+ID4gLQ0KPiA+IC0gICAg
c3RydWN0IGRhdGEgew0KPiA+IC0gICAgICAgIHN0cnVjdCB7DQo+ID4gLSAgICAgICAgICAgIE52
bWVJZE5zRGVzY3IgaGRyOw0KPiA+IC0gICAgICAgICAgICB1aW50OF90IHZbMTZdOw0KPiA+IC0g
ICAgICAgIH0gdXVpZDsNCj4gPiAtICAgIH07DQo+ID4gLQ0KPiA+IC0gICAgc3RydWN0IGRhdGEg
Km5zX2Rlc2NycyA9IChzdHJ1Y3QgZGF0YSAqKWxpc3Q7DQo+ID4gKyAgICBOdm1lSWROc0Rlc2Ny
ICpkZXNjOw0KPiA+ICsgICAgdWludDhfdCBsaXN0W05WTUVfSURFTlRJRllfREFUQV9TSVpFXSA9
IHt9Ow0KPiA+ICsgICAgc3RhdGljIGNvbnN0IGludCBkYXRhX2xlbiA9IHNpemVvZihsaXN0KTsN
Cj4gPiArICAgIHZvaWQgKmxpc3RfcHRyID0gbGlzdDsNCj4gDQo+IE9oIG1hYWFuLCBwbGVhc2Ug
ZG8gbm90IHJlcGxhY2UgbXkgbmljZWx5IGNsZWFuZWQgdXAgY29kZSB3aXRoIHBvaW50ZXINCj4g
YXJpdGhtZXRpY3MgOigNCj4gDQo+ID4NCj4gPiAgICAgIHRyYWNlX3BjaV9udm1lX2lkZW50aWZ5
X25zX2Rlc2NyX2xpc3QobnNpZCk7DQo+ID4NCj4gPiAtICAgIGlmICghbnZtZV9uc2lkX3ZhbGlk
KG4sIG5zaWQpIHx8IG5zaWQgPT0gTlZNRV9OU0lEX0JST0FEQ0FTVCkgew0KPiA+IC0gICAgICAg
IHJldHVybiBOVk1FX0lOVkFMSURfTlNJRCB8IE5WTUVfRE5SOw0KPiA+IC0gICAgfQ0KPiA+IC0N
Cj4gDQo+IFRoaXMgcmVtb3ZhbCBsb29rcyB3cm9uZy4NCj4gDQo+ID4gICAgICBpZiAodW5saWtl
bHkoIW52bWVfbnMobiwgbnNpZCkpKSB7DQo+ID4gICAgICAgICAgcmV0dXJuIE5WTUVfSU5WQUxJ
RF9GSUVMRCB8IE5WTUVfRE5SOw0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gLSAgICBtZW1zZXQobGlz
dCwgMHgwLCBzaXplb2YobGlzdCkpOw0KPiA+ICsgICAgbnMgPSBudm1lX25zKG4sIG5zaWQpOw0K
PiA+ICsgICAgaWYgKHVubGlrZWx5KCFucykpIHsNCj4gPiArICAgICAgICByZXR1cm4gbnZtZV9y
cHRfZW1wdHlfaWRfc3RydWN0KG4sIHJlcSk7DQo+ID4gKyAgICB9DQo+ID4NCj4gDQo+IEFuZCB0
aGlzIGRvZXNudCBsb29rIGxpa2UgaXQgYmVsb25ncyAoaXRzIGNoZWNrZWQganVzdCBhIGZldyBs
aW5lcw0KPiBiZWZvcmUsIGFuZCBpdCByZXR1cm5zIGFuIGVycm9yIHN0YXR1cyBhcyBpdCBzaG91
bGQpLg0KPiANCg0KVGhpcyBhbmQgYWJvdmUgbG9va3MgbGlrZSBhIG1lcmdlIGVycm9yLCBJIGFt
IGNvcnJlY3RpbmcgdGhpcyBhbG9uZw0Kd2l0aCBtb3ZpbmcgVVVJRCBjYWxjdWxhdGlvbiB0byBh
IHNlcGFyYXRlIGNvbW1pdC4NCg0KPiA+ICAgICAgLyoNCj4gPiAgICAgICAqIEJlY2F1c2UgdGhl
IE5HVUlEIGFuZCBFVUk2NCBmaWVsZHMgYXJlIDAgaW4gdGhlIElkZW50aWZ5IE5hbWVzcGFjZQ0K
PiBkYXRhDQo+ID4gQEAgLTE1OTcsMTIgKzE2NjcsMzEgQEAgc3RhdGljIHVpbnQxNl90DQo+IG52
bWVfaWRlbnRpZnlfbnNfZGVzY3JfbGlzdChOdm1lQ3RybCAqbiwgTnZtZVJlcXVlc3QgKnJlcSkN
Cj4gPiAgICAgICAqIE5hbWVzcGFjZSBJZGVudGlmaWNhdGlvbiBEZXNjcmlwdG9yLiBBZGQgYSB2
ZXJ5IGJhc2ljIE5hbWVzcGFjZQ0KPiBVVUlEDQo+ID4gICAgICAgKiBoZXJlLg0KPiA+ICAgICAg
ICovDQo+ID4gLSAgICBuc19kZXNjcnMtPnV1aWQuaGRyLm5pZHQgPSBOVk1FX05JRFRfVVVJRDsN
Cj4gPiAtICAgIG5zX2Rlc2Nycy0+dXVpZC5oZHIubmlkbCA9IE5WTUVfTklETF9VVUlEOw0KPiA+
IC0gICAgc3RsX2JlX3AoJm5zX2Rlc2Nycy0+dXVpZC52LCBuc2lkKTsNCj4gPiArICAgIGRlc2Mg
PSBsaXN0X3B0cjsNCj4gPiArICAgIGRlc2MtPm5pZHQgPSBOVk1FX05JRFRfVVVJRDsNCj4gPiAr
ICAgIGRlc2MtPm5pZGwgPSBOVk1FX05JRExfVVVJRDsNCj4gPiArICAgIGxpc3RfcHRyICs9IHNp
emVvZigqZGVzYyk7DQo+ID4gKyAgICBtZW1jcHkobGlzdF9wdHIsIG5zLT5wYXJhbXMudXVpZC5k
YXRhLCBOVk1FX05JRExfVVVJRCk7DQo+ID4gKyAgICBsaXN0X3B0ciArPSBOVk1FX05JRExfVVVJ
RDsNCj4gPg0KPiA+IC0gICAgcmV0dXJuIG52bWVfZG1hKG4sIGxpc3QsIE5WTUVfSURFTlRJRllf
REFUQV9TSVpFLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgIERNQV9ESVJFQ1RJT05fRlJPTV9E
RVZJQ0UsIHJlcSk7DQo+ID4gKyAgICBkZXNjID0gbGlzdF9wdHI7DQo+ID4gKyAgICBkZXNjLT5u
aWR0ID0gTlZNRV9OSURUX0NTSTsNCj4gPiArICAgIGRlc2MtPm5pZGwgPSBOVk1FX05JRExfQ1NJ
Ow0KPiA+ICsgICAgbGlzdF9wdHIgKz0gc2l6ZW9mKCpkZXNjKTsNCj4gPiArICAgICoodWludDhf
dCAqKWxpc3RfcHRyID0gTlZNRV9DU0lfTlZNOw0KPiA+ICsNCj4gPiArICAgIHJldHVybiBudm1l
X2RtYShuLCBsaXN0LCBkYXRhX2xlbiwgRE1BX0RJUkVDVElPTl9GUk9NX0RFVklDRSwNCj4gcmVx
KTsNCj4gPiArfQ0KPiA+ICsNCg0K

