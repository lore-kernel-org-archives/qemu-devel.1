Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74192C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2B422522
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=data61.csiro.au header.i=@data61.csiro.au header.b="lyu1l2N8";
	dkim=pass (1024-bit key) header.d=CSIROAU.onmicrosoft.com header.i=@CSIROAU.onmicrosoft.com header.b="nKoSEj8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2B422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=data61.csiro.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iropW-0004mR-6M
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=27638d3c8=Peter.Chubb@data61.csiro.au>)
 id 1irook-0004D5-7x
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=27638d3c8=Peter.Chubb@data61.csiro.au>)
 id 1irooi-0002g6-V1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:59:05 -0500
Received: from act-mtaout1.csiro.au ([2405:b000:e00:257::7:37]:23059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=27638d3c8=Peter.Chubb@data61.csiro.au>)
 id 1irooh-0002Xh-LD; Wed, 15 Jan 2020 14:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=data61.csiro.au; i=@data61.csiro.au; q=dns/txt;
 s=dkim; t=1579118343; x=1610654343;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xU/vRVlP3E8EtJf9QNbYIs/iKX0dZCxMDHL2nr37pp4=;
 b=lyu1l2N89RBARSt1Oo/FV/kLN0vRls+db8GJfm+jwhXg8byePUVCwnJ/
 wgyBSEvjR89f25qvbmvC1sFPUpP7XuQ6OCLg94mzVEklY+516KMdHKJIW
 XIqeL5zYge5B3FDZTWRPX3+fTKsKkXHvcYI0tWurlNLvV+FHq43gOd7Zj 0=;
IronPort-SDR: vNYw3oi4mAWOuqBjEOT9SKxKrQia23R1hKcAtBDKlWYsEeaW6NMGrYKoZ6goie6hnrkcttxIGt
 exzAOE+2Pjkg==
X-SBRS: 5.1
IronPort-PHdr: =?us-ascii?q?9a23=3AKABb9B9OdWdknf9uRHGN82YQeigqvan1NQcJ65?=
 =?us-ascii?q?0hzqhDabmn44+9ZB7E/fs4iljPUM2b8P9Ch+fM+4HYEW0bqdfk0jgZdYBUER?=
 =?us-ascii?q?oMiMEYhQslVfaIFUDhatXqciYwNMhLSFY7pjewKklPH4D3eg6arw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+F6AQCxbR9elwCwBSSwhIATAJKcgDR?=
 =?us-ascii?q?lHAEBAQEBBwEBEQEEBAEBgXuBVFBegQsENQqHSwOKeJ0/A1QJAQEBDQEtAgE?=
 =?us-ascii?q?BAoQ+AoIAJDgTAgMBAQsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnDINOcQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AgEDEhUTBgE?=
 =?us-ascii?q?BNwEPAgEIDigQECIlAgQOBSKDBIJLAy0BAQICnV0CgTiIYAEBgXMzgn8BAQW?=
 =?us-ascii?q?FGBiCDQkJAYEsjBiCGoFHgl0+hEmFbq9IBwECgjiWMBuabqlcAgQCBAUCDgE?=
 =?us-ascii?q?BBYFpIYFaHU+DQFAYDYgBGoNZilN0gSmLJQGBDwEB?=
X-IPAS-Result: =?us-ascii?q?A+F6AQCxbR9elwCwBSSwhIATAJKcgDRlHAEBAQEBBwEBE?=
 =?us-ascii?q?QEEBAEBgXuBVFBegQsENQqHSwOKeJ0/A1QJAQEBDQEtAgEBAoQ+AoIAJDgTA?=
 =?us-ascii?q?gMBAQsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnDINOcQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AgEDEhUTBgEBNwEPAgEIDigQE?=
 =?us-ascii?q?CIlAgQOBSKDBIJLAy0BAQICnV0CgTiIYAEBgXMzgn8BAQWFGBiCDQkJAYEsj?=
 =?us-ascii?q?BiCGoFHgl0+hEmFbq9IBwECgjiWMBuabqlcAgQCBAUCDgEBBYFpIYFaHU+DQ?=
 =?us-ascii?q?FAYDYgBGoNZilN0gSmLJQGBDwEB?=
Received: from exch4-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:34])
 by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 16 Jan 2020 06:58:53 +1100
Received: from exch3-cdc.nexus.csiro.au (2405:b000:601:13::247:33) by
 exch4-cdc.nexus.csiro.au (2405:b000:601:13::247:34) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 16 Jan 2020 06:58:53 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch3-cdc.nexus.csiro.au
 (152.83.247.33) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jan 2020 06:58:53 +1100
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.51)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Jan 2020 06:58:49 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1whZd3HpW/ZtjId1GNL7gfZ27qH5VsxTR+mwTxvfAfT4mpSPkUyyQVjoRSPkH3Pej5DtZqVtMz+zq0NG1l3SlgG38PdC3de+O1yIb51R9bAdHSX2epoB40LvebsgruPg17omVzSBpIx18S7nqXet8AXC1JHUojKFGEC+UgXJPy/GIU32vEEZ2whqgOm+lMRHac1mG2GAyl0hUxWO/x1uNgr1TVQeFhMD6Z8wW0gw2JzfSKhMtxheRRTDqPXQUpIInJdAzUpUylfttXwkMi1OfuGsQ6pDPLkcChNjhG0hLC+7dDb0dddRuQHo6zlLzTe5lfx7gtL6SCB9YdV+FpMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk6cRetLriHldrYHWBqAYTYPQdYFJZZczFB/GdaJBP4=;
 b=IjTCYNLKG7pqb2uQ/UomTwkfcMStMWA/DXK40g94W4tW8zNmF5SrjeE2/pxMAj1jTR46KOC+INPav9DRnmDg5lbcZCtxjQeAqTOzytFMgfJyTshUP45yZ32N0pEPn/7HAWcTU4eiAIcrH1Xl4z7a2UVd1nkCdOOO828XuXrFbCMVrVeCnyBcfyQ+db1DgZaedbmGGW78ubZPGBzDZbfPwhA4vcYMDtny5PmehFLOGgPo+xvuWkZFrvgUNTSlboebE6rL1rBdMwWKcdqqMOWz+xbEd7y+s+7YHzS8RwAfVviWY9md17OEeS6lFq52yyfl6pPhil4rGpHcI+yGMel4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=data61.csiro.au; dmarc=pass action=none
 header.from=data61.csiro.au; dkim=pass header.d=data61.csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk6cRetLriHldrYHWBqAYTYPQdYFJZZczFB/GdaJBP4=;
 b=nKoSEj8QWs4VUrLgjYOwHFQ+jTt7zySVoTjtrL5PoxTXnrpHa8fXvLeuOh/C3R/AwbOosRBp68i2qOJW5CtKQXL7nc0BDJZQN4/pzv6I8Tl0LX/v5WUmn3ZJpXKXSKSCCK0Kbal3qlF7Xpl9Y/6do7gJjpuASaMbT2M25zLVXBs=
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com (52.134.217.84) by
 MEAPR01MB4422.ausprd01.prod.outlook.com (20.178.177.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 19:58:52 +0000
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com
 ([fe80::195f:37a0:9e0e:2362]) by MEAPR01MB3734.ausprd01.prod.outlook.com
 ([fe80::195f:37a0:9e0e:2362%4]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 19:58:51 +0000
From: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 18/86] arm:kzm: drop RAM size fixup
Thread-Topic: [PATCH v2 18/86] arm:kzm: drop RAM size fixup
Thread-Index: AQHVy7YGPyWxMmQ210ObJ3DYpTCKKKfsJPwA
Date: Wed, 15 Jan 2020 19:58:51 +0000
Message-ID: <87sgkgv6dh.wl-Peter.Chubb@data61.csiro.au>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-19-git-send-email-imammedo@redhat.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Peter.Chubb@data61.csiro.au; 
x-originating-ip: [221.199.209.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e57b94dc-ed47-4c30-0b98-08d799f557fc
x-ms-traffictypediagnostic: MEAPR01MB4422:
x-microsoft-antispam-prvs: <MEAPR01MB442215044A13B2F14608C9C8BB370@MEAPR01MB4422.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39840400004)(366004)(376002)(396003)(199004)(189003)(54906003)(66446008)(64756008)(316002)(66946007)(26005)(76116006)(66556008)(66476007)(4326008)(91956017)(6916009)(8676002)(2906002)(81166006)(81156014)(8936002)(478600001)(71200400001)(5660300002)(6506007)(2616005)(6512007)(86362001)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MEAPR01MB4422;
 H:MEAPR01MB3734.ausprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwA0X+rBadMtS+Ysw2IEn8nifj+F5sxHy56BrAuSByaShuZ1wr6eEVXLHmLBNREbSYqKY7YK5C45Hyczkp4sj/UnwPS/Vtzmc8mT+uRzcauNthIdGi9dfTY4Z1ZCCZWD80uWsO2f4jvjNU1OwXsqXXQm638AyGevJq2fbhuNAuU4THNYKY7wLElA7flRu4kKcpp6WrCdwtJ0imy/KDd+dQjTW9x01s/KxaycS1Ix1fyJkitpPnaU0tGK7F6TAMcyTH9jHns5l2gD0av+UOwuNiRzKnIVuWxj9zGGjUyf3SA/X56BiAYiIDFKx6jF0xV3eX6pH6YU1ads0aKORlyD4x8Q0zbCgNzesXk/RxfvacOd6APoEV2YfzRH7ktwwh/wwO8wCWsuV52AF2Xa/NT3lnj+PIJMtDVQ26EAGnkJ3j2PS/wpSmbMs67qetCnYPf9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <100683064CB705438E6D80FB8FFBDC4E@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e57b94dc-ed47-4c30-0b98-08d799f557fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 19:58:51.6488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2viptLCsZoxXm6M0IpRrk2zOwwtx9SwtbQMENgwp6UGTN7K7CkSpn6uck4e7TQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB4422
X-OriginatorOrg: data61.csiro.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2405:b000:e00:257::7:37
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

Igor> If user provided non-sense RAM size, board will complain and
Igor> continue running with max RAM size supported.  Also RAM is going
Igor> to be allocated by generic code, so it won't be possible for
Igor> board to fix things up for user.

Igor> Make it error message and exit to force user fix CLI, instead of
Igor> accepting non-sense CLI values.
 I think this comment needs rewording a little.  Maybe:
   If the user provided too large a RAM size, the code used to
   complain and trim it to the max size.  Now tht RAM is allocated by
   generic code, that's no longer possible, so generate an error and
   exit instead.


Igor>    /* Check the amount of memory is compatible with the SOC */
Igor>   if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE +
Igor>   FSL_IMX31_SDRAM1_SIZE)) {
Igor> - warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
Igor> + error_report("RAM size " RAM_ADDR_FMT " above max supported, "
Igor>                "reduced to %x", machine->ram_size,
Igor>                FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);

        This needs to be changed so it doesn't say that the RAM size
	is reduced, just what the maximum is.  Maybe:
	error_report("RAM size " RAM_ADDR_FMT " above max (%x) supported.",
	machine->ram_size, FSL_IMX31_SDRAM0_SIZE +
	FSL_IMX31_SDRAM1_SIZE);


Peter C=

