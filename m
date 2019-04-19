Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D93BC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 04:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE72220869
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 04:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=data61.csiro.au header.i=@data61.csiro.au header.b="oebltQu8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=CSIROAU.onmicrosoft.com header.i=@CSIROAU.onmicrosoft.com header.b="uPV2JB+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE72220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=data61.csiro.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHKr5-0002DY-HS
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 00:10:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=005e97291=Peter.Chubb@data61.csiro.au>)
	id 1hHKph-0001Pb-Jn
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 00:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=005e97291=Peter.Chubb@data61.csiro.au>)
	id 1hHKfb-0000h0-48
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 23:58:36 -0400
Received: from act-mtaout4.csiro.au ([2405:b000:e00:257::7:41]:8391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=005e97291=Peter.Chubb@data61.csiro.au>)
	id 1hHKfX-0000aa-Rm; Thu, 18 Apr 2019 23:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=data61.csiro.au; i=@data61.csiro.au; q=dns/txt;
	s=dkim; t=1555646311; x=1587182311;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=KNTIRV2KeUddD45ESVK//XYwfqeyqxBcrZ+UhmXqFYs=;
	b=oebltQu8Zrg2Va54Z524A8B9lnGcr8cpBUioW9Afb9gk78hQDhBgDtTv
	vxGflr1n1vfk4fXBRXIgO4EZ5TNkmAt2nHF0WaOGm5gG4tAi1ylubNqe+
	jvCqsIUAo59TTBnVO8zxYHuZ/l6NxHDfY7kH9XqU1yFDdTzDpIUQiS2Un g=;
X-SBRS: 4.0
IronPort-PHdr: =?us-ascii?q?9a23=3ALkZ5tBA0zhEF8DmpsMaGUyQJPHJ1sqjoPgMT9p?=
	=?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qo13kTRU9Dd7PRJw6rNvqbsVHZIwK7JsWtKMfkuHw?=
	=?us-ascii?q?QAld1QmgUhBMCfDkiuFPP2YjZ8N8RfXlVN83inOBYMXs3lZkfV5HSvvnYf?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+FTAQAGR7lcjACwBSSYiIBxAISUgiR?=
	=?us-ascii?q?mHgEGBwaBUQkLAYE9UFoRVSAEMwqHSwOPFUqaV4E/PA8BHw4CgQKCFIEoAoY?=
	=?us-ascii?q?aIzQJDgEDAQEFAQEBAQICAhABAQEmTAyDRTkxAQEBAQEBAQEBAQEBAQEBAQE?=
	=?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQUCMwU5AwNAAQE3AQ8CAQgOLQsQIiUCBA4?=
	=?us-ascii?q?FgyIBgWkDGwEBAgKcewKKFIIggnkBAQV1hA4Ygg0JCQGBKAGLSYIWEn+DEj6?=
	=?us-ascii?q?ERIVhjQKFVpN4BwEBAoIGhg6MGhuBe5MPkjOKMYNLAgQCBAUCDgEBBYFPN4F?=
	=?us-ascii?q?YHU+DQAmCBRodgXKBRopTcgGBKI4oAYEgAQE?=
X-IPAS-Result: =?us-ascii?q?A+FTAQAGR7lcjACwBSSYiIBxAISUgiRmHgEGBwaBUQkLA?=
	=?us-ascii?q?YE9UFoRVSAEMwqHSwOPFUqaV4E/PA8BHw4CgQKCFIEoAoYaIzQJDgEDAQEFA?=
	=?us-ascii?q?QEBAQICAhABAQEmTAyDRTkxAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
	=?us-ascii?q?QEBAQEBAQEBAQUCMwU5AwNAAQE3AQ8CAQgOLQsQIiUCBA4FgyIBgWkDGwEBA?=
	=?us-ascii?q?gKcewKKFIIggnkBAQV1hA4Ygg0JCQGBKAGLSYIWEn+DEj6ERIVhjQKFVpN4B?=
	=?us-ascii?q?wEBAoIGhg6MGhuBe5MPkjOKMYNLAgQCBAUCDgEBBYFPN4FYHU+DQAmCBRodg?=
	=?us-ascii?q?XKBRopTcgGBKI4oAYEgAQE?=
Received: from exch4-mel.nexus.csiro.au ([IPv6:2405:b000:302:71::85:124])
	by act-ironport-int.csiro.au with ESMTP/TLS/AES256-SHA;
	19 Apr 2019 13:58:19 +1000
Received: from exch1-mel.nexus.csiro.au (2405:b000:302:71::85:121) by
	exch4-mel.nexus.csiro.au (2405:b000:302:71::85:124) with Microsoft SMTP
	Server (TLS) id 15.0.1395.4; Fri, 19 Apr 2019 13:58:19 +1000
Received: from exedge2.csiro.au (150.229.64.34) by exch1-mel.nexus.csiro.au
	(138.194.85.121) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
	Frontend Transport; Fri, 19 Apr 2019 13:58:19 +1000
Received: from AUS01-SY3-obe.outbound.protection.outlook.com (104.47.117.55)
	by exedge2.csiro.au (150.229.64.34) with Microsoft SMTP Server (TLS) id
	15.0.1395.4; Fri, 19 Apr 2019 13:58:11 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=CSIROAU.onmicrosoft.com; s=selector1-data61-csiro-au;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=47TcUOXX+GQ2jL0Vio6fMmM9NZP1iOctFD5d/FVYB2c=;
	b=uPV2JB+JoIvGcChkR0EWFZGxnFM1fAHNiMwMfN+CaGHcQl0fc+ySTvK3g/Tw0SNdg2yoLZP443Hs6biPtAGlXNL4FlCRgXqlux0JKQUWwn2AGKhiy/8jgoPeprccH315tSl/YEAEU7YAHjccF8+c6OlSRUKFC67voqz5W1Q6crI=
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com (52.134.217.84) by
	MEASPR01MB0009.ausprd01.prod.outlook.com (20.178.177.215) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Fri, 19 Apr 2019 03:58:18 +0000
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com
	([fe80::7c08:1847:9eed:49e4]) by
	MEAPR01MB3734.ausprd01.prod.outlook.com
	([fe80::7c08:1847:9eed:49e4%4]) with mapi id 15.20.1813.011;
	Fri, 19 Apr 2019 03:58:18 +0000
From: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
To: Thomas Huth <thuth@redhat.com>
Thread-Topic: [PATCH for-QEMU-4.1 v5 07/29] hw/arm: Express dependencies of
	the fsl-imx31 machine with Kconfig
Thread-Index: AQHU9hDfK3IokJEEzkKHsws0zFJQiqZC3BcA
Date: Fri, 19 Apr 2019 03:58:17 +0000
Message-ID: <8436melk89.wl-Peter.Chubb@data61.csiro.au>
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-8-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-8-thuth@redhat.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Peter.Chubb@data61.csiro.au; 
x-originating-ip: [221.199.209.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccad084c-937c-4cde-2031-08d6c47b41a4
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MEASPR01MB0009; 
x-ms-traffictypediagnostic: MEASPR01MB0009:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MEASPR01MB0009169E06D4264C234B4AE5BB270@MEASPR01MB0009.ausprd01.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39850400004)(199004)(189003)(6246003)(186003)(966005)(7736002)(478600001)(53936002)(6306002)(99286004)(8936002)(68736007)(6512007)(7416002)(5660300002)(229853002)(72206003)(76116006)(66946007)(4744005)(305945005)(2906002)(54906003)(4326008)(14454004)(6116002)(102836004)(86372001)(86362001)(316002)(97736004)(8676002)(446003)(71190400001)(81166006)(6916009)(25786009)(81156014)(71200400001)(6486002)(74482002)(76176011)(26005)(256004)(3846002)(6506007)(66066001)(66476007)(6436002)(64756008)(11346002)(2616005)(73956011)(476003)(486006)(66556008)(66446008)(91956017);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MEASPR01MB0009;
	H:MEAPR01MB3734.ausprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SnjnOnC0tfQERfsS56t0dHQjuXii5SgahkFpSy/2SkznhFTmbsn7TC6r2J4sU3miukgHfR6DS2tRe5a05CCdqLAgQQ4lnwmvuQj2vvcpQJGAndtjCMktb7s+RR1DVjYYhd2zSg0r1BCI2ZwJK54SYJt+ujWWJxDvKd0hhlD96q8TD+ZpjtsoocOB6rN89FsQFT7611kPER9I3yDeaWO4Np8529zCivnVm1J3/0W73aroitPn7qRCG7IfXIGWGAGQTACW04lT084ehU5jLPWpTtXa1uI3s/uMpJC0au0SN1AZoP3Xe1T5t/lVs/zeLY6VqOlXhhUSGILN//xdonfbIkrpTVRe9OqtE3vEtNpY3tTaEZ+Mr2xhYpJjrCBEqcxeJsof8IclNIYXCnxsxI9QKQgct0wIYn29+YDIp9Krn88=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <D4F06FF565C66F488BAC81E136EC975E@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccad084c-937c-4cde-2031-08d6c47b41a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 03:58:17.9579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEASPR01MB0009
X-OriginatorOrg: data61.csiro.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2405:b000:e00:257::7:41
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 07/29] hw/arm: Express
 dependencies of the fsl-imx31 machine with Kconfig
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	"yang.zhong@intel.com" <yang.zhong@intel.com>,
	Rob Herring <robh@kernel.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Jan Kiszka <jan.kiszka@web.de>, Cedric Le Goater <clg@kaod.org>,
	John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419035817.jEGq_tEFytTxgK9YVG0CmRgA4vnqWFZyIzz-oaF7GJg@z>

>>>>> "Thomas" =3D=3D Thomas Huth <thuth@redhat.com> writes:

Thomas> Add Kconfig dependencies for the fsl-imx31 / kzm machine.
Thomas> This patch is slightly based on earlier work by =C1kos Kov=E1cs
Thomas> (i.e.  his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Thomas> Signed-off-by: Thomas Huth <thuth@redhat.com>=20
Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
--
Dr Peter Chubb         Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
Trustworthy Systems Group                     Data61, CSIRO (formerly NICTA=
)=

