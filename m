Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0571920679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="raCb17CI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="SAQrYmt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0571920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5FU-0007cH-9d
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5D6-00044A-N0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:08 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40434)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5D3-0003Le-OO
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485925; x=1630021925;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OvoXMBv7nysrHZnr10yhmfEQDUVABoaeb5V0GXHjbsI=;
 b=raCb17CIweOxZlucsdH5dGbTedd9b262EFrPSKtCzw6rTtYI4RL5Mqp2
 cnw7EvNtV5DaAi7lxT29thoQB2hMel98j3KPQY7sfa5gfEt5SMANUdI51
 QCARKi3we0hy5yN+sih7f6IHTIUIP0yc4rKjXG4uovCP34vDd1P1seZno w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Aug 2020 16:52:04 -0700
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:52:04 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:03 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:02 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:02 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 06/34] Hexagon (disas) disassembler
Thread-Topic: [RFC PATCH v3 06/34] Hexagon (disas) disassembler
Thread-Index: AQHWdXdf6Bkdia2BCkCfJsWMUFdXf6lKdU0AgABmFlA=
Date: Wed, 26 Aug 2020 23:52:02 +0000
Message-ID: <BYAPR02MB4886FE852A685F4C750CAD52DE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-7-git-send-email-tsimpson@quicinc.com>
 <96c192d2-e0ba-9b80-d3cd-50eadf3dc349@linaro.org>
In-Reply-To: <96c192d2-e0ba-9b80-d3cd-50eadf3dc349@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfecc45b-5c71-4c43-6e4f-08d84a1b07bc
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB4952BAADB5A5C6FFD6880366DE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dkk3L1SPis6ptZTHSBr9B0LfRsgCggRhDLjMb5I2+ewt2PRpadkuyp2J/adzOywM789kdaz23isFB7f+Uadym3oIsIH6jc62uIt6oWgncE4Q12MUAYdWP7mZwMuReQ7e9seMxZIIu0DCfmoGAdjBN/Em6eStu51LKEE7Cs5P5ikbB7cR1AabMsHaKq7VGbZAn98m19htpLN/m3qGMv9nRw7/V4iB3Ue/zvBhbclU6D7MlczLIbwZAQnkoLGz3oleDuNo/LBPf4hZd1NjXa3PaLT5VHAYHMG9vbhYScCxxanPMdsrQTnRXH9iCI3cKL4w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(4744005)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: GBUW67j+zj6LCohDpjpL2uSV4K2t7XqgBqTvotMbnaLHbVwENC+Q1V45bJ6Po0vbz1yDmUTn2I1MJrpKT+NqN/ekCO5HxMZ1WjhwclHh7N/QnOTkB2PwAWNcZbqkLSiKb+rKE+k9IJlxujCwk8yZxlYAPeelBV4ul+gpcvEuzszKPD4u6UI5xJIK33Zk5wmBeQQ++R4RPtwnyFiQzyYb2Tr/ZaQB8kSDgHEj56qVBKnXywo0ISYFR5eDsLC9lnv0wbBY68D5ELa25pr6383gGh5uce2cYP56pn6NlMLupztRxpqv6Gar1fmdBRTtG/bcKGGnaIt/fX+ZoB7AB4ta7qEwaVU+szZ0JodmLkVrBoczJRzgDkCf+fsCaNQQSTFBRMSp2KzV4oLoYMPXEZgHGRaA/dKsoqIU70ygYVLlxP351O2YUHNkLzHAuGIjgnzKeiSWfDExpUqrnncZb6K3eogdLXwsT41rfuwwTY4H6D976+Tp3hGbno8AIlwnuB6IxZrTBUhVXC8a/ESkwt76bYbhzaQYorK/yc9yhOurffPFRNBq057qeAX7NEdCEVzYpQwKoTLMR2ubvyHqp6/UFf2SZptXBsFlbVhvZAgx2woslkL9MFCBwdHOoYwyi4a/XqCCC6RMbPplr1b1UZGffA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb9MkEsl3iTKYqOozrWxM/mndEos04ZcXzbrm1gdNmxHtQxBgRGgg866Vw7G3HxCcZVyEwUB0szA3HiP/uYus8jip4axK5icqYn5oA/jnm+5FDcmleZymfgjzq0MruIdVVt27a2IvmsgQsPBEzhfLk/QHMT14qoZbUONJUAMZbyxM5IxFgB0vRQuFDWJ4PijHzlLJQFq/dIrSF+0M5ROtYaHpg1IO+gl7B48pvg2/KC2lh8czcFZb5axijsUqGf4kG6wI4qnVJRD8M9DsYj4TSunoYaZjmQkC1h1QWhpralhwoD7hJYwsLBtjGxX1yZ0gA/mTc861ltxfcV6UjRDSQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoPiqf4yxQgvJADEsme6ILO1U22t6gBF0M0sOD5jGh8=;
 b=QZO1ANZYJ33NfVnzX9yueEEzdMejNY/z5JknvQxfqaL5BOxakm+vHPWsrh3u4KqRm4deIfSTdHQ2W97I8f1TmRpRhZnNBbvPoNnhJQ31mr3G9Vz+fflAo+J86jDWe/KWBJ+xyZT+Qx35mFAdBXwtPc/cSUSGO1uxiOfNAZxq7zDObpJS7ttPNdU9eVZv67QhXktILsvtZQAmUDbIsoma9aT5Nq59YVZ+6NQOTZjU/Cy0z3GiOzxd4xUkfRBCV3RKDlthcq5sW8QcL0K5RHLsHEztyE1uUckYspTjc6NF2QCajSZzIFcDnP4JQRxBEH9j2iBJMmurjJQuX8cOiC8W3A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoPiqf4yxQgvJADEsme6ILO1U22t6gBF0M0sOD5jGh8=;
 b=SAQrYmt8/SEwbkrvOsTed3lkc2wPKffuSqLAuLNtqUMZCvmYqXTk7TR3BIqO/+gAak/FKwoYig97yossWGqTwGHejKGt6UG7wrDzwUdeJLAFV7AqCSxNs1gAwQ5DJzGhweMQf1yLG9/ngPgZkzvYdy9UAJR9hjfZJtEmTkiJdrg=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: cfecc45b-5c71-4c43-6e4f-08d84a1b07bc
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:02.5847 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 0gWroo3VaHZTQ4OxxNnOM58uhAFC8nkBWKJM2DODkC1D809YfKtgq1cA/SAiB5JimTLHPH8QSl1o8olljhf2EA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 19:52:04
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI2LCAyMDIwIDc6NTIgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAw
Ni8zNF0gSGV4YWdvbiAoZGlzYXMpIGRpc2Fzc2VtYmxlcg0KPg0KPiBOb3JtYWxseSBvdXIgZGlz
YXNzZW1ibGVycyBwcmludCB0aGUgaW5zdHJ1Y3Rpb24gYWRkcmVzczsgc29tZXRpbWVzIHRoZSBy
YXcNCj4gYnl0ZXMgKG9yIHdvcmQpIG9mIHRoZSBpbnN0cnVjdGlvbi4NCg0KT0sNCg0K

