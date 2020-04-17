Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A207C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C421F22209
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QkatmwTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C421F22209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTyT-0002zJ-VM
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPTxK-000279-OS
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1jPTxJ-0002VR-9P
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:35:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:49224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1jPTxI-0002UI-SJ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:35:05 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03HGWuxU004041; Fri, 17 Apr 2020 09:35:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=71+lreVbjZLrhfoAhIRoPSoHmXPQsTnMKI8x2p8W0SA=;
 b=QkatmwTthBLiqzerj6dGEURNRD8tm4LUSR1q9FDeRhYYNFYCZu+Ngd5oKn821TcoNu1G
 fbXGchH1fVGDjsQnLKlN1COaU5Bq91dWShS8/8sujYnwPpDP7tUHiH4IEvtAXW0eatEb
 TNTIgsAOkJ6mIt2K3c1ucvSmBgnV2KleG94Wlkalj8t/ZlBG7Gq5Din7yVPPY9R9XRxs
 XKfGCdOg9tqTZlpsvkTF2pAk+rFJzJ87XxGw2VBGuK1+xSuTQZvhcHVfF/h57hXC5ofd
 LHDACpM4tbak7A7Yq0B18HhTcJd6RjsMzMNZJFHxxP7mtpebxjLTUyLSFHigqb0EnrKa +A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30dn9dfcc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2020 09:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8ORgb580fVeZaFv41rpOnKs/gagUWjMPThMQW7WcUiBOlhJ39MawdK+qr9uoiE1aWpke8ssggck4VM+74pyX0ZtjWEgRPyoBom3ydWnenorZY6R8SauqGVlJxwXR8PKJHnC4KmPEYIY65emnElq62i05oz+UTQSliChfpXs7gVIjUx66RnyW93tJTg4lOHW9PeSo1h7RXoafQljkEAIVYGcNnPpCRpMDYINy245QI/9XGMmYcAGUFbiB1CB+wWiHPAfMaEAPe8P0wzF1r85JVgiYSvQT//FCoz6oyxDzEguzAUjEHv56IRnEWSGl4Zsghk3nBpOAEDOCVlzoEcMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71+lreVbjZLrhfoAhIRoPSoHmXPQsTnMKI8x2p8W0SA=;
 b=dhDLGDmhNZwydk0656fps1iYsTf8LfxRMSwv40IVI1WTuypbSPu0eqRPaoDYE9hOR7mCnIsOncUelbenFpCA3mwlZpS+JX4PwOkKJ2/ol+VYm1/eR9HtRauFw7/4f9gFHpwZ8QyD+eYN5cPaSxBWNUKrxyW3WIWJNJcndn+/4e3emb2fymtQzFOteimOKHg9I+pxgRaQpu1BkNlzGq0oghQuNbPAOo//XeNUEAw5T+T1utjzrAViLxjtnUrpmHq552DdZmXBK5xTvnPrXYcyIxblCIcmwiuHnCy1GSQoelqSDqBYu7O/+1+wGBB4mzKLrQ99nLNxFplkM/IOmGdyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5789.namprd02.prod.outlook.com (2603:10b6:208:11e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 16:35:02 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2900.030; Fri, 17 Apr 2020
 16:35:02 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAAB0KA
Date: Fri, 17 Apr 2020 16:35:02 +0000
Message-ID: <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200417120732-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a9b239-e629-4c96-559e-08d7e2ed4761
x-ms-traffictypediagnostic: MN2PR02MB5789:
x-microsoft-antispam-prvs: <MN2PR02MB57897EE8EA5DB9900CD1B804F1D90@MN2PR02MB5789.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(71200400001)(5660300002)(4326008)(8936002)(478600001)(2616005)(86362001)(36756003)(91956017)(316002)(6916009)(44832011)(33656002)(6486002)(4744005)(66476007)(66556008)(66946007)(53546011)(6506007)(54906003)(64756008)(2906002)(76116006)(66446008)(81156014)(26005)(8676002)(186003)(6512007);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mVzdx71z+vrdjYWF4bFaLuYUekgm96W1J4KlPvzSsuTJs/Vxj7/461kEG2C4Riy98kHHJ0DFCneG4+SWRiXmK0yA7jIBzmDxzfM5GLmCCIc8GJNM7Qa0aWFVemIokSaADKzBT2BJPNZ4L93bQncS54OO+i9GVP3kCMA+OLsQ7QnUjj22ltIWRC3RTM9aaaIqNYDOZyWbsolkYhlRa/qdU118JPaGRIatzRRtzfBFA1m+O/Ba15tj1pOMliVoQsh4tpqk7/kVw4AtqgdYi6XqKO7A6UBDGAfCDsw/SJsDrnWNphEqnYaN95L0Scw1yOaLND0FpTnTMbOoADH2jJM62KfjlfVwH7p/Q/y6ssJiPFMVkCYKWLJ57OsJHde02SVlsAlKlJM4jPMKNhvL06Ka0T4zr+bDCDLHbCuH7gICEJVPkHZ6GEYiF4UrpdTe271
x-ms-exchange-antispam-messagedata: 1Hei52NQwcAzgrX/E6/gqWbmIM9g1mBFFawdxtFlvbDBG8pcSu4RNdcnpDlYW5AbT6c17nNHb/FIKnaaskOtHm3WZ6lw5c3XUiVnzSC6ny81fjHlE2r/fRwlqfSQaNZ4kUypB5/f62Eh/6LSWv041w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F434D57EED1134E89034516E89CC959@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a9b239-e629-4c96-559e-08d7e2ed4761
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 16:35:02.7563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8/HjllDfQU16/SJ1mfxTrGqSbv6pRz/btp3WK4a2LD+wfAytp7L2hYDRvTehFlEOvwapuNm0eBjw1lmxn68Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-17_07:2020-04-17,
 2020-04-17 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
 Laine Stump <laine@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Laine

> On Apr 17, 2020, at 9:39 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> Problem is, I think this is not something we can support with pcie or shp=
c.
> I'm reluctant to add features that only ACPI can support,
> we are trying to phase that out.

Hmm. I see. We use conventional PCI and hence was looking for providing thi=
s feature for conventional PCI only. Laine might be able to throw some ligh=
ts as to feasibility of the in PCIE world.


