Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6337CC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3842081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=data61.csiro.au header.i=@data61.csiro.au header.b="hbpR2wdN";
	dkim=pass (1024-bit key) header.d=CSIROAU.onmicrosoft.com header.i=@CSIROAU.onmicrosoft.com header.b="d+aoVzbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3842081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=data61.csiro.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irp14-00042P-7K
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 15:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=27638d3c8=Peter.Chubb@data61.csiro.au>)
 id 1irp0H-0003SW-VU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 15:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=27638d3c8=Peter.Chubb@data61.csiro.au>)
 id 1irp0G-0001kL-PC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 15:11:01 -0500
Received: from act-mtaout4.csiro.au ([2405:b000:e00:257::7:41]:23852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=27638d3c8=Peter.Chubb@data61.csiro.au>)
 id 1irp0F-0001gF-78; Wed, 15 Jan 2020 15:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=data61.csiro.au; i=@data61.csiro.au; q=dns/txt;
 s=dkim; t=1579119059; x=1610655059;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tNXdb+XemRGIjAOkE6lYlh97mwjZGksRqcl8VBDcaaA=;
 b=hbpR2wdNay50RNjxW2sTV/5YPqae+mf2FuaKQHZEeDvHKZ5n+O63uMa5
 Mzx4M1z4JWYlrl7wv7QAFO+GDa3LTsZjmwhgOHFivXQ8iUpXpFBrHsVdW
 HB2VZ1/nRDqNWjPzYAxAYAHFl8XtvZmNMkTsgEByFitgP4ifPvTNngUGv g=;
IronPort-SDR: Jrn+BPF7JtchN8mKmjC57B0mGk3AqrcpOcYLtlYbcV/Mv3NI4wKiV3Bn9B62cVLd3foakrhBlJ
 E9jwyMTB0HJw==
X-SBRS: 5.1
IronPort-PHdr: =?us-ascii?q?9a23=3AsWeVsR1LaYGlStVesmDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxOHt+51ggrPWoPWo7JfhuzavrqoeFRI4I3J8RVgOIdJSw?=
 =?us-ascii?q?dDjMwXmwI6B8vQMUDnIeSsRCwnFs5qWFZ59i/id0NOGdz5IVTP8TW/?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+EcAAA1cR9elwCwBSSwhIATAJKcgDR?=
 =?us-ascii?q?lHQEBAQkBEQUFAYFnCAELAYFTUF6BCwQ1CodLA4Rahh6SRolVgSQDVAkBAQE?=
 =?us-ascii?q?NAS0CAQEChD4CggAkNAkOAgMBAQsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnDIN?=
 =?us-ascii?q?OcQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AgE?=
 =?us-ascii?q?DEi4BATcBDwIBCA44ECIlAgQOBSKDBIJLAy0BAQICnWUCgTiIYAEBgiaCfwE?=
 =?us-ascii?q?BBYUdGIINCQkBgSwBjBeCGoFHgl0+hEmFbpctmBsHAQKCOJYwG4I3AZg2qVw?=
 =?us-ascii?q?CBAIEBQIOAQEFgVI4gVodT4NAUBgNiAEag1mKU3QCgSeLJQGBDwEB?=
X-IPAS-Result: =?us-ascii?q?A+EcAAA1cR9elwCwBSSwhIATAJKcgDRlHQEBAQkBEQUFA?=
 =?us-ascii?q?YFnCAELAYFTUF6BCwQ1CodLA4Rahh6SRolVgSQDVAkBAQENAS0CAQEChD4Cg?=
 =?us-ascii?q?gAkNAkOAgMBAQsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnDINOcQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AgEDEi4BATcBDwIBC?=
 =?us-ascii?q?A44ECIlAgQOBSKDBIJLAy0BAQICnWUCgTiIYAEBgiaCfwEBBYUdGIINCQkBg?=
 =?us-ascii?q?SwBjBeCGoFHgl0+hEmFbpctmBsHAQKCOJYwG4I3AZg2qVwCBAIEBQIOAQEFg?=
 =?us-ascii?q?VI4gVodT4NAUBgNiAEag1mKU3QCgSeLJQGBDwEB?=
Received: from exch4-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:34])
 by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 16 Jan 2020 07:09:27 +1100
Received: from exch1-cdc.nexus.csiro.au (2405:b000:601:13::247:31) by
 exch4-cdc.nexus.csiro.au (2405:b000:601:13::247:34) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 16 Jan 2020 07:09:26 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch1-cdc.nexus.csiro.au
 (152.83.247.31) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jan 2020 07:09:26 +1100
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.51)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Jan 2020 07:09:22 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcqUFG0mahqtxa4VWLsP4shgqdfCnIqU8HxZN3NE2gjMJ1ChLZjPOcPGvwe2Hl8u3GE5kqmBwzEDCNNg6H32Q3r2gTy4T88bgV3Rn4pQg2a0sgon8qTl9podKynPabXTgjIayhJMNhuX6mPO6k1fOtMpxbFofQk1QERh6VgJntoTf0tiKcdo3MohQJHaKNaSSHiUvQVFn+lO6LN8EMFwxzqVNm+PNM6Ta8gv+ig3Oe8wjSpPxD0bIMvtm/yDKzB+6p9qo5BkOdc3/EvsGsNL+2KtGCFia4PcGoJ3ZH3scP0+zsBubhMgDqWRSyUstJTF7xOUDn+720fRRWRpJo78qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNXdb+XemRGIjAOkE6lYlh97mwjZGksRqcl8VBDcaaA=;
 b=a/p35zodkOYAwP/PiP2zI7CLA6KXX28sMFu0Lq1diZrJGHqTpTISBv2x7gtGERulHYxTOTNSZLQkw9CFukWOx+nIVwMXk+oj1U2/e7yo6xUp1GM6thrPCIFhH4tBePqI3aCdGiEUrQFVrcxFMgWMVEdx4rWDCZQi81QydEBjn1/Km1bgXOkBpqsVFjOo+OQtheVl+KLLaa3hRYE9Aeh918ae+ZJcm92SlCpUl2jO/57iQ1oZLUsnNoERmp1X/grImcF241DnrpR4lgR0MmEOQaVGubucaRXyi7pJL0hCta+mFVzYaL/vZN0Ok91sBAWSrby/JHdn0Pi150+1vw1hCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=data61.csiro.au; dmarc=pass action=none
 header.from=data61.csiro.au; dkim=pass header.d=data61.csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNXdb+XemRGIjAOkE6lYlh97mwjZGksRqcl8VBDcaaA=;
 b=d+aoVzbY/VR6zsb6zNtRAknSuH07E9mXj3Ar9W7VcUXJJMRFcc+Ul0oSqw1em270zbNV62UDU7Wbni6fZQxZ+ETKQEEGmAzcR2t7XfhCn3wmBgKyEnBOKOd9skJ71C9DW61zuG8hIMcoRZETD2Jj9lZkmdqB3CqspWzDyiexGMw=
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com (52.134.217.84) by
 MEAPR01MB3494.ausprd01.prod.outlook.com (52.134.216.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 20:09:26 +0000
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com
 ([fe80::195f:37a0:9e0e:2362]) by MEAPR01MB3734.ausprd01.prod.outlook.com
 ([fe80::195f:37a0:9e0e:2362%4]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 20:09:26 +0000
From: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 19/86] arm:kzm: use memdev for RAM
Thread-Topic: [PATCH v2 19/86] arm:kzm: use memdev for RAM
Thread-Index: AQHVy7YGdqUjzmOeW0C6ero1urQrJafsJ++A
Date: Wed, 15 Jan 2020 20:09:25 +0000
Message-ID: <87r200v5vw.wl-Peter.Chubb@data61.csiro.au>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-20-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-20-git-send-email-imammedo@redhat.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Peter.Chubb@data61.csiro.au; 
x-originating-ip: [221.199.209.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e767de70-be4b-4b91-a6b3-08d799f6d207
x-ms-traffictypediagnostic: MEAPR01MB3494:
x-microsoft-antispam-prvs: <MEAPR01MB349488DB37F059D928E119B1BB370@MEAPR01MB3494.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:336;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(189003)(199004)(478600001)(86362001)(558084003)(5660300002)(4326008)(6512007)(71200400001)(186003)(2616005)(54906003)(316002)(6486002)(76116006)(81166006)(8936002)(66446008)(8676002)(64756008)(66556008)(6506007)(26005)(66476007)(66946007)(91956017)(6916009)(2906002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MEAPR01MB3494;
 H:MEAPR01MB3734.ausprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QI/Xl/KYD47TVUQISEACORnNt/cstTqvbrKyjUFGbVS7SrLrlQtqsXUG6h/Wk2sRTSdDkqWa5c9UGvmFcXf3KjNeDf9dJyzlC6A7Pd8UHr/W94EzypcsRQ9y66jfxe/sx8XYKtmvVhTVG649PZ+N9zM3aPb0SNGwV0/8uzHTjVvtMb/8zv6V1JPEbUmi50+e+i/X/m6jalxsFH64V9fyl56NLv3SbiayPm7oC8RUcRhX4fCgkzydCieFx9IV84ENob9uNp+nQlIbzO/KxkUSPNnJpQ4zaikbBZEjoRAiyVogcqjf47h7cpl14mjvIweaJtt87YzZ8Ax1zID/2H3IgE6et83Y6pJPHm/kdOzcgEHSmYR1CcVugG6Gj4E283DTDvcAlgV9pr9kVqj1hb+Yo+Fk8h503kCH/luyjHpfjKHyu4CEehVMZNaztOFrAttW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C0C74D552280BF4DAC37D8C6C16A8D92@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e767de70-be4b-4b91-a6b3-08d799f6d207
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 20:09:25.9186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mp4sGDbuo7pG/egGB+CVWv9sdbX8tjHfJA4ZtcbfrXphTX3pXgQ24d/3e/OAmbYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB3494
X-OriginatorOrg: data61.csiro.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2405:b000:e00:257::7:41
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.chubb@nicta.com.au" <peter.chubb@nicta.com.au>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>>>> "Igor" =3D=3D Igor Mammedov <imammedo@redhat.com> writes:

Igor> memory region.

Igor> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Igor> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Igor> ---
Igor> CC: peter.chubb@nicta.com.au

You can add:
Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>

Igor> CC: peter.maydell@linaro.org
Igor> CC: qemu-arm@nongnu.org

Peter C=

