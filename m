Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ECEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 02:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901232070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 02:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="eGrTBvk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901232070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqonX-0006nD-RY
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 22:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jqomg-0006J9-Nq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 22:17:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:19458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jqomd-0007ms-W9
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 22:17:06 -0400
IronPort-SDR: vFfWekNsFNoZngncIThgVoFsq/IeIykRr+t58xOyh3AtBcdfCm+Mtxwda8OCxXvItJjP+37ttl
 kSIvqVQKM05g==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144281505"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; d="scan'208";a="144281505"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 19:16:54 -0700
IronPort-SDR: x6OyYWPwe1+NXc44/ojtG4oqrqq6+HT1XmHOKxZFnzQjuE2LYYIrv41UI/1xHKmMsZq0WILyXz
 XbPSnKovKhaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; d="scan'208";a="281798617"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga006.jf.intel.com with ESMTP; 01 Jul 2020 19:16:53 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jul 2020 19:16:53 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jul 2020 19:16:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 1 Jul 2020 19:16:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyD4V4dadDKnM4ZCx8atU8pkVnajBs46RMRLUbs41yG0F93NE3DBADXADuNhni2xBEkXQxPFNUSEucHTet6szoS7dJcL9iYuZ7pTzsdUZGtxtRQSuTXWitmJ682E4dtX/olW9U8XCa7+PrW5x5VwHr//NNYBqca6zgz1i6QkTE9xm0asqaG0HvFcCHUxXqmFdWvPkcnduT+ltl1RoHVTFRqIWenTAzl/TOiKiyQzJqc0dcO3+sZO6i35mjpdNyyHRS6admWfkBwfll6kGaiPCUdB2BHlHx8aoaDGAcXTfXwYZeOQfcpDLvCWyOq8NdiRZAUDNOH3evm9zkJY/pCKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2kS0zrEvoJZYJ/nysd76xoJA+yrr015M/6OVbproJo=;
 b=LqvrLngBUnukTEncgK19ZwzHXdJ0c2gGPd+2Mnk89/J51UAdbc5ix1xgUKdYmtp1anHrorySLdo/WgPnrc22GOyuf0EDo10D1VopUftrUHuFG4FI8ieRgxY0m5KXrSiJsnxrnzpCq6Fa9hArj7mr9ybDf4GLaojHu4t1wVQB2PXTlPJIvvaphbheQW/AcWKxkkE2+C1AuufRwqpTaY2DNW12diEg0vCTRqTlQSPCtzKMJaSpNaLv6J5FLftcWqVGk1QQvE00gQTjqaU2CbkmzjsWfsKbvLXkKIoqSrwQNhc2/5kEoDDRENx9m9OmHPBTsSYGNljHG4AMuAJNSLhtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2kS0zrEvoJZYJ/nysd76xoJA+yrr015M/6OVbproJo=;
 b=eGrTBvk0kgD4MzYF0GXxBql3kIAvraCCsrT/hHtM+625rXVnQO9Qre00KoLB8v2AvehWhUnIbon2wTTZfko8dhtlNOAQOnlYNXMlvhxHyZquJ2Rio/L87ttBB+Xpwz982Eq2CTb07+fiZJ2FR0vOG8ZaxMMUpacP5N92nRQJyY8=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Thu, 2 Jul 2020 02:16:51 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3131.033; Thu, 2 Jul 2020
 02:16:51 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] MAINTAINERS: add VT-d entry
Thread-Topic: [PATCH] MAINTAINERS: add VT-d entry
Thread-Index: AQHWT6VokdGjfuIG4U6EpiYiSWN3oajzjhog
Date: Thu, 2 Jul 2020 02:16:51 +0000
Message-ID: <DM5PR11MB1435A04A76307FC186297FA5C36D0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20200701124418.63060-1-peterx@redhat.com>
In-Reply-To: <20200701124418.63060-1-peterx@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56cc97a9-4075-4410-d8e5-08d81e2dfb85
x-ms-traffictypediagnostic: DM5PR11MB1434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1434AEC0B7A710DC467E905DC36D0@DM5PR11MB1434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDk9AwpytQVjjoCNFNSHOKjicPKQpV6alqDD+kxTUN39AmkbOULh+Tjjuf8pl9aBO/fuhw7/yXpduO0s+cPWbtF4LMatXv+CWBWDROjmWRtsvRJg+QLKhuJK1UvajFk8NIXKjfZnc7kVouHfj6Kah5+w9SAA8LeqXfSeggXeJuc45DgJgGc4ZdGfXwV6HveJDD0+VtuUSUI61OfrH29x9YQzHwHVJZhy3ImWs5VaAVqchL2zoh3OoocSTPaNegErR8IV2W2bXqapN/QTXxreZYvbddWRnhs/Ya8uT2RMiiu+mhU9TTJn66juZwtgasXSGy71YnvM/6ZkiBI7Xorufw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(26005)(6506007)(4326008)(186003)(107886003)(9686003)(7696005)(4744005)(2906002)(66476007)(64756008)(76116006)(5660300002)(66946007)(71200400001)(52536014)(66446008)(66556008)(86362001)(8936002)(8676002)(55016002)(316002)(33656002)(54906003)(110136005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kH4ujc/s3YpSiMmF2QNe4uuihgFyBusgwpbVw2Nj5xodm5fixBQE+KAefyAI+AcIgfTU2s4McZQ3XEiVnW6Ie3pxyZwxum2CXd41J5S3wfqbMAJnua9RcHc7CmgP9nrHaM4hEEwPtvN99j0DL8su0/9U1J8CfzjqnqC2SC89MhFZ3POIGuQmWMMuHhEv9QEU3ok8j44dWI0/dB3puRrJdnIUKRNV9/+eZU8OwNv5vgTRUN4GWQlJ4XeBttMgLp82AHvBb0qKEv2119DcByst2CR0WZfhWj17GJtnwYBMCRB+v30U/A+LcdzaU5VS1HJy4vxkbIpdhz0Ech1CGbDBsYTPRsBzWUo40RXlZfVsQz++aqQmdFO+ABX/ncyz1MqAXVHC9ZgobE9WV52ZuqIbg35m5HNOc4H+tHQ6aCzcc9QeNv4uJj3jRw3XLJkfTml9+rKejJOKfWnHvErKQeWU9fWWusPh2NnAV1U+ux7b8rGq3Ef6MPFZfIRSB3t3Q11s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cc97a9-4075-4410-d8e5-08d81e2dfb85
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 02:16:51.3750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQ4L9xZx6cUwHiuwT+7iJsMJEBM2BezSIHGTBMztNZhGnBzGqLD7aNbjljmolEpxUcXvEBN1y9JDp0W2ctwiuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=yi.l.liu@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 22:16:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Peter Xu <peterx@redhat.com>
> Sent: Wednesday, July 1, 2020 8:44 PM>=20
> Add this entry as suggested by Jason and Michael.
>=20
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..569cfc1fcd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2615,6 +2615,15 @@ F: tests/uefi-test-tools/
>  F: .gitlab-ci.d/edk2.yml
>  F: .gitlab-ci.d/edk2/
>=20
> +VT-d Emulation
> +M: Michael S. Tsirkin <mst@redhat.com>
> +M: Peter Xu <peterx@redhat.com>
> +R: Jason Wang <jasowang@redhat.com>

great!

Regards,
Yi Liu

> +S: Supported
> +F: hw/i386/intel_iommu.c
> +F: hw/i386/intel_iommu_internal.h
> +F: include/hw/i386/intel_iommu.h
> +
>  Usermode Emulation
>  ------------------
>  Overall usermode emulation
> --
> 2.26.2
>=20


