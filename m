Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C6DC4727E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 03:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22E220796
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 03:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KgA5NB/D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D9JkCapE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22E220796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOBRp-0008Ov-19
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 23:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537860369=Dmitry.Fomichev@wdc.com>)
 id 1kOBR9-0007xk-Pz; Thu, 01 Oct 2020 23:08:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:40623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537860369=Dmitry.Fomichev@wdc.com>)
 id 1kOBR6-0002af-4k; Thu, 01 Oct 2020 23:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601608123; x=1633144123;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Rx8uK/R6uYiQ0DVH5EuwiG09tFunFnoGXCUf8120p3Y=;
 b=KgA5NB/D5qRqp4NhAXWFlCT9W1Gg0o7YBmwuz/Hvp7/ZEQ8ZwVt4rzv+
 kiePxTWaYSh5MLW6MJ0OmOUvjn8LfiENB1RG4M9QrMywnoyzDye4S6a+3
 Pxme++7M+Ob7vSN2AkrkpFyFzSKWFNOyrxMUavElzAjdvmMcunLcP58GT
 e2yvR6RVtiPnqPPZhiopeTH37IzjdbFqoXx4AWq000wV44QkuovtR3w++
 +tlv6qWaqlC3CEJFIUZPvCF5yAmAYESS/6UT8bfDYGLy3Ch/QPqCdVFTm
 Bcof1BDZ1PrO0bH5lU2/NR7R9xSZCZkFd0sm4xSpnXgzUHZ4C2lfztYJ/ g==;
IronPort-SDR: EDBRZId2WQZgyQPWrYwnFue0fdFr8nu/5N+CGaJNgPopu3GHKXFEEcDcTK126b0zIfYcgLiP9O
 0Tzrmxz4laR9ti+8h/5mKE2tsbzwyH/UOZQozSXUKeFkDpIxpiCk2s6WirMKKyF9sSVPmZw5IJ
 0o8cGT8SsHBmRP4pnT/KOisAEUxPsdPC7Vo3kxguFotqBmQYni3UpGGX6Q6q1DIFK+2PqBZZcJ
 xoIbrfA+1LZS7pysT+SIBp+hP4otWjAvf6g3/yGI6KvyFXqbRU3vGitx5DiCwJi45YrlJ40CiF
 SIg=
X-IronPort-AV: E=Sophos;i="5.77,326,1596470400"; d="scan'208";a="148785839"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 11:08:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KurR3wtoh7ne8UQdCb5ESuhx/vo+A6pHo7tqCZ2EVf4e6NYdr/q1YDOXK9XU6wxmXKgevQa76lShior6dB+Ehzp77gGAuB9PS2wizxz56wCT9OVOw7ERY6jnkFcvQBi3lXkQ9dElC32qmcI9yeXVFm9py7dTwm1bSA07t9YuhVXo94MXSSsiXalmUdLYWcVB2Letjvly03V/2Xfw4PBsZtaTe2Xel9nUKihEiB5xGDi6Go+4FBkecojat0ujQGrOafRQGHCFiiddWDCtkjwdoXLuWvrNzUhl/xkF7adLI2vpnM4/8KlMwMtDRn6glPk7lk2YlbQHUD5udTb1z+HFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xeD/jE8a/K5lqzQaCs2Nk2e2aquve5bsqke0ZRqyOw=;
 b=H5oCTsUAC3SBGdH54oqflndhbwoBVIzzKv+PcM96l5MsU7fDrGJMDC4zxztpwi/bSTIs4sAEg+R9WD+oqXtgtefZdkKVvwNEN4pTrgFzr1tShY9L667tCZ7qK6aQKH5yHYsMY3WeTJr2InKgbqdPgyYvX2Wwrl/aqrsomAYSUV2qLbNPvnBC0BN7CtsLT/OWnS/S6ZLKfP9J7LomAIDwKQoTKs48zF/cfchXMpTafjbZGYg/tJKCitnFxD+0kup5gmpvf9t8tOM5O0mGdOi9axn+l10JMHgSZMee27ZcL/jxG6jc0dT0jSo0dzlqr/uiMdPxT3uTwYnLiLggYPbOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xeD/jE8a/K5lqzQaCs2Nk2e2aquve5bsqke0ZRqyOw=;
 b=D9JkCapErVRM4lZQbJaY0u0wyW1+okyUXzZgOxCIHmSi6PUY5Kf8IW9k9InJ2pG9AmxT+1kaBdIjrJsUDZUmF7hmRHs/j/l3jdmZOdG9SMcPtmBqB5LjfmxJU0l7JXA9eQAAH0azhqscP/nPf4GzF5x4hll38bn+71nPM/A/wXw=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5998.namprd04.prod.outlook.com (2603:10b6:208:dc::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 03:08:35 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.034; Fri, 2 Oct 2020
 03:08:35 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/block/nvme: update nsid when registered
Thread-Topic: [PATCH] hw/block/nvme: update nsid when registered
Thread-Index: AQHWmD3yB6R1PMUhiEC+xPvzDKJuf6mDoUqA
Date: Fri, 2 Oct 2020 03:08:35 +0000
Message-ID: <MN2PR04MB5951FE6AF6E3DA3E3EF950BBE1310@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201001215059.866660-1-its@irrelevant.dk>
In-Reply-To: <20201001215059.866660-1-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2838a42d-e7d4-4027-1335-08d8668073b8
x-ms-traffictypediagnostic: MN2PR04MB5998:
x-microsoft-antispam-prvs: <MN2PR04MB5998DC0CBAF7E9E56FE04166E1310@MN2PR04MB5998.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7an3Oq8MdKavAaV4akjNc5ZVt3VEDvqk1efYoycy5UNu/gqObL4aWK4nFT8wRX96yMI4Du016nPhFPU7UvL9VJjZ6SRgQv7PoHp+X/Yn/Tidofn09k1W2r43Z/lgAEhy/6lUTKMiUCMtZGaJLXzfYlf1d/Hun36qWfBW4y/YF8xWqgI3af9AQzFpED9X4YOIv8etPsKwNf05y2EprSSx1RBa4x5QEtgxsIHfaNOFX0p4RKOPWB6RF1UzEfUS5mBwzyXew6bS+x/9XAhOVgX/fWX+dnGE7yi4T1G8OEALHKAZflPQCLJeRZE9OLuEnQcgt0SlBY7nr6Uz3TaRghkJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(76116006)(71200400001)(86362001)(8936002)(8676002)(9686003)(83380400001)(33656002)(4326008)(55016002)(478600001)(6506007)(54906003)(53546011)(316002)(2906002)(186003)(110136005)(26005)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(7696005)(15650500001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PG461QFoYiNHesmy8d09sQtBEK7/CgJePMIEspLUEA+h3/88BHS6BAgSCBD/pad1Ef5EkmLer02QazZm29Zxh5+NrlxE0/x5wap3/8fYZEyklJIAZwwTUFPx3PLk4onZQkL+K0Lnzf8yowc1B0WhdX2nN9OXXcJilrRbeM29ejOpc6zi3IsNNeSZpeLOXNIYGCNwXN8ObU1ktTYkHKibSh/r2gLvrqMlhf3aS1MLRdc3QZ5P7s4DUJ3uHnGz8IgFT8zX4yGWKKbtPiUsLR/yqaT1CVinp3UY/OiEU/t9xE2wzkQr0LHY+bKTOzIy6ubjD1t4KWK4uN/iUtkGlPu+Fxx3NuNjkCknUnlhaciKpWGQqL+Qwh2ivlrQY94ri2Vg8MBnIYApQ8Yl80DDjtdGIrbKsGauGqLds6v72svkhQ5aYXUXaPYyNYJaBbMOo0wzbNmJA7CwbxniL9tbujCqa7PEJg2oaVXkGZQ/tJ6R3AVK77CGsD2Z1XMjwfxoge3x+Ad0aQMa8lvzTqGqNtRb6yq4MScyC5kAJ5Srwbi6QeBLjTMgwOjVELXn7kaPwtYYiRu7oklE3Us69zbT29+gS9GpkgpSd4w8O8pUe7ZA00wlRapnpx0Fn//DHSXQx/275jUbh+US60UGAifJEd3EcA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2838a42d-e7d4-4027-1335-08d8668073b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 03:08:35.4186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPaxjwqw/XkO4HCmjM+fBZlY6JJB94z5dK7cAKc/Kc46pq1qs8ddAFdBd3tOAuXaqWzydQBWf7Z07t1woCaIxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5998
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=537860369=Dmitry.Fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:08:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+dmitry.fomichev=3Dwdc.com@nongnu.org> On Behalf Of Klaus
> Jensen
> Sent: Thursday, October 1, 2020 5:51 PM
> To: qemu-devel@nongnu.org
> Cc: Kevin Wolf <kwolf@redhat.com>; qemu-block@nongnu.org; Klaus Jensen
> <k.jensen@samsung.com>; Max Reitz <mreitz@redhat.com>; Klaus Jensen
> <its@irrelevant.dk>; Keith Busch <kbusch@kernel.org>
> Subject: [PATCH] hw/block/nvme: update nsid when registered
>=20
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> If the user does not specify an nsid parameter on the nvme-ns device,
> nvme_register_namespace will find the first free namespace id and assign
> that.
>=20
> This fix makes sure the assigned id is saved.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Yep, this makes autogenerated NSIDs work.
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index da8344f196a8..bb1ee009cd31 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2583,7 +2583,7 @@ int nvme_register_namespace(NvmeCtrl *n,
> NvmeNamespace *ns, Error **errp)
>          for (int i =3D 1; i <=3D n->num_namespaces; i++) {
>              NvmeNamespace *ns =3D nvme_ns(n, i);
>              if (!ns) {
> -                nsid =3D i;
> +                nsid =3D ns->params.nsid =3D i;
>                  break;
>              }
>          }
> --
> 2.28.0
>=20


