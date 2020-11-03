Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6AEC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 05:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF37E2225E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 05:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Ukvt1/Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF37E2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZoc6-0006tb-OY
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 00:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>)
 id 1kZobR-0006Rx-K9; Tue, 03 Nov 2020 00:11:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:51396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jin.yu@intel.com>)
 id 1kZobO-0001QA-Pk; Tue, 03 Nov 2020 00:11:28 -0500
IronPort-SDR: KvVx4/CrJo4JaFl3dEI15LcbDWPX6HVO3QMBFmvz3ClVfVb/U7rHO4UnARjrSL6cZs9XTvvWdl
 IxXw01ivzfNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148854904"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; d="scan'208";a="148854904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 21:11:22 -0800
IronPort-SDR: T1xfKvHoKKwQ0DPglb7TD7cHCi/ehCu28oX69BirKKHLzJVChq1w2+j038geEsDav75XUUm0+Q
 vItwX11fzdeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; d="scan'208";a="526932548"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2020 21:11:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 21:11:21 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 21:11:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Nov 2020 21:11:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 2 Nov 2020 21:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF3w1wjNFs5VOYOVNM6W0BHeRb0k///u8e6Dm9ravXhkzTvJP9Vq4V4WZe42xpGGiJGczdoI+82T/fXj20k9iTeQFs7F5T5gyBzuoaw9GQuMgMSgsHssPVgrHKsJEz/GnPD+Xa09ZZ83jTYRqYoUAdjPX3EeXCGAKbY38rfhn1PLSFpO1x8B3QoGyh5eSW8GkEu8M9pwZAnMS06hC5PSowGmtqigHWNu1/fDBh65GbFKAzjUWdN7BdD3zXNBturLPhTx2YkgmQytKbG8bF7W21U9m1wycv98S6SbzDVEW/uKMTLDRgia0H6zlnwk3+jD7SaWMs5Y5v8mMHvw3XrlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=any/jV3z7SWyDrF+/4MTxA3/QSK3CuVDDR6YGhaA4r4=;
 b=Ba5CefEdq7vRaMywI1uBlRnCQOo3aCZQbDNk94NRc5GLRF9nyxbXKDU8IYakDEJnOOf3+A9LylEEkzC1xBkoyw/8rsu4W3YS3uhIDBTDLgHv3m6xWlo8nGvdx1GcG/jP7QkXreGDv42n3rXHFn48J1zEFt+lvkXI+3M+G38dhhB53eHf9EGR2HQNvBR7R4HhPnmMYi0AcHGE8ZyuL82FJPSa05zb2iLa23xLGVWhRCixKu/a2tqgA8G93iYKmseXu7qprJ4ikyQBPSYxfmRwEgD6YfTIeH0TwGLA9UiUBIKWIpWjIWimcrEWBjLKTTEf361R34pyEsmW82Kbj3ERFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=any/jV3z7SWyDrF+/4MTxA3/QSK3CuVDDR6YGhaA4r4=;
 b=Ukvt1/GwhoJMfRColV/+utxeaU5N0Bp8AUMg3oNGxpsEUjsNBGZQP54V/qejZM4oiOuzILzbkLLsCGbttMG25sq24feGsRED/6h7bQRfQCUPwusb2B4IMewnotWIocKoP41gKwyvwlGth37jNYl1ggJ2MGGhUg54x8lAkDWduyo=
Received: from DM6PR11MB3723.namprd11.prod.outlook.com (2603:10b6:5:13f::25)
 by DM5PR11MB0073.namprd11.prod.outlook.com (2603:10b6:4:67::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.30; Tue, 3 Nov
 2020 05:11:19 +0000
Received: from DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::bcf4:8f24:f17b:541e]) by DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::bcf4:8f24:f17b:541e%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 05:11:19 +0000
From: "Yu, Jin" <jin.yu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Revert "vhost-blk: set features before setting inflight
 feature"
Thread-Topic: [PATCH] Revert "vhost-blk: set features before setting inflight
 feature"
Thread-Index: AQHWsTlQxgXs6V4YqUKBWlQCDtyoPam13G2Q
Date: Tue, 3 Nov 2020 05:11:18 +0000
Message-ID: <DM6PR11MB37234EA5646AF3693B66E7C180110@DM6PR11MB3723.namprd11.prod.outlook.com>
References: <20201102165709.232180-1-stefanha@redhat.com>
In-Reply-To: <20201102165709.232180-1-stefanha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faaf22da-7eb8-4642-0d9c-08d87fb6e60d
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-microsoft-antispam-prvs: <DM5PR11MB00736E92E35B3CB24C372FA380110@DM5PR11MB0073.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:96;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZmsSaQV4H9OM+nfnHeFXVYgAcbH1G+WbOv0Vr2KGRPtnFOohSDhvVj6S4mu8YqzY6y3VoRgPqtYZ7dyaWiKmTp7gEWZT3AsFirkWfpfsy6Akz2Zin9VBPUvYXFNijoYGgkEKEj/HKDnaescwBR3dB2G1zaDijfgjvwTtdsOsNtwWbGPjiKs2DeiO7HOAGlblBoZFIHWEqhy1aqBs9E15W2kYOH86lmhpeFQdA8rix4BDEvZe+pXIX7yVpsNbOzDIj7yUXzwSjo601Sm0BFXk7XUbBobxri0tOceHRYYSby2PSSgufTuXz10IF/sdA91oHodZjEdiwO8VwjENQhJvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3723.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(316002)(71200400001)(8676002)(86362001)(4326008)(33656002)(54906003)(9686003)(55016002)(6506007)(53546011)(52536014)(66476007)(76116006)(66946007)(478600001)(66556008)(83380400001)(8936002)(2906002)(66446008)(186003)(7696005)(110136005)(26005)(64756008)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8W/IX3MNvYwjiZ8rz74Qo0+gn/Sz+c4QyoDpR/NAV+uFYxvCz4XSed3gvlx9ltghDQgUg8698mWH46/PuJrpI3pkDB9Qf/V1x1hGHaGUPam+qVADeUzqMLC5LyklSa+odFt6kFubnzK759bgS70x/i3oFrUarwv8ng6WdTsZw0x4iZ4jZ4hSZ2+Y0cQpkBNSX9X8D+VXSNRyji1bZ9PTJLILx3x5+3yKDtPMF8aai9DFHeaAA0CMnLv3aS173x2lHMSUbAa9JwWttBdrVNlZTTgIwfablzmYUksDtCWLaRHWLuk9FTFhWfqAhu0WFfc/qoQS3djmIyVt5fS5tanvC+qnWQbt+YirYThCxjOtELWs2XGeyWpFwvrelEny40SXEvWMS5qZV4OocLn7/6gAG7NgO4Ay3weGDu0GL3oE7e8ilGiKb7rfdUhwJwgmQE+jiGQSConJFhISsCfuvpaEkbLTuDrLk+kuLG0fFVqHTjwqXr5CPbPOUWWKR0XyOw9yS8Bt06pio71VheV+OHruJZj2Dbid5h8JJMOW7+8aRIZv9+I2XqLB6mjmafY5sGGIgF+nWT+x+4PZpUpplbnXBH6zmwnuvxqPfFIUDVxQFyJfidPHRu7FXiCHGU0vDR2DKd6DZHKwN6EdTbn6QSIqKQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3723.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faaf22da-7eb8-4642-0d9c-08d87fb6e60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 05:11:19.2096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48jhYXJ8gJ6lsuWoGt+YAl4TYnP2Q3ZITiDI+z4FdubLFih8AGe7OhCfH6Pb9OB3lhm2tLSfNtmruAJf/apBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151; envelope-from=jin.yu@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:11:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi  Stefan,
	I have sent a version 2 and it should fix this issue.
	I also test it several times and I did not meet this issue again.

	Thanks for your report.

Best Regards
Jin

> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: Tuesday, November 3, 2020 12:57 AM
> To: qemu-devel@nongnu.org
> Cc: qemu-block@nongnu.org; Raphael Norwitz
> <raphael.norwitz@nutanix.com>; Max Reitz <mreitz@redhat.com>; Kevin
> Wolf <kwolf@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Stefan
> Hajnoczi <stefanha@redhat.com>; Yu, Jin <jin.yu@intel.com>
> Subject: [PATCH] Revert "vhost-blk: set features before setting inflight
> feature"
>=20
> This reverts commit adb29c027341ba095a3ef4beef6aaef86d3a520e.
>=20
> The commit broke -device vhost-user-blk-pci because the
> vhost_dev_prepare_inflight() function it introduced segfaults in
> vhost_dev_set_features() when attempting to access struct vhost_dev's vde=
v
> pointer before it has been assigned.
>=20
> To reproduce the segfault simply launch a vhost-user-blk device with the
> contrib vhost-user-blk device backend:
>=20
>   $ build/contrib/vhost-user-blk/vhost-user-blk -s /tmp/vhost-user-blk.so=
ck -r
> -b /var/tmp/foo.img
>   $ build/qemu-system-x86_64 \
>         -device vhost-user-blk-pci,id=3Ddrv0,chardev=3Dchar1,addr=3D4.0 \
>         -object memory-backend-memfd,id=3Dmem,size=3D1G,share=3Don \
>         -M memory-backend=3Dmem,accel=3Dkvm \
>         -chardev socket,id=3Dchar1,path=3D/tmp/vhost-user-blk.sock
>   Segmentation fault (core dumped)
>=20
> Cc: Jin Yu <jin.yu@intel.com>
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/virtio/vhost.h |  1 -
>  hw/block/vhost-user-blk.c |  6 ------
>  hw/virtio/vhost.c         | 18 ------------------
>  3 files changed, 25 deletions(-)
>=20
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h index
> 839bfb153c..94585067f7 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -141,7 +141,6 @@ void vhost_dev_reset_inflight(struct vhost_inflight
> *inflight);  void vhost_dev_free_inflight(struct vhost_inflight *inflight=
);  void
> vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);  i=
nt
> vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f); -i=
nt
> vhost_dev_prepare_inflight(struct vhost_dev *hdev);  int
> vhost_dev_set_inflight(struct vhost_dev *dev,
>                             struct vhost_inflight *inflight);  int
> vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size, diff -=
-git
> a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c index
> f67b29bbf3..a076b1e54d 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -131,12 +131,6 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
>=20
>      s->dev.acked_features =3D vdev->guest_features;
>=20
> -    ret =3D vhost_dev_prepare_inflight(&s->dev);
> -    if (ret < 0) {
> -        error_report("Error set inflight format: %d", -ret);
> -        goto err_guest_notifiers;
> -    }
> -
>      if (!s->inflight->addr) {
>          ret =3D vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflig=
ht);
>          if (ret < 0) {
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c index
> f2482378c6..79b2be20df 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1645,24 +1645,6 @@ int vhost_dev_load_inflight(struct vhost_inflight
> *inflight, QEMUFile *f)
>      return 0;
>  }
>=20
> -int vhost_dev_prepare_inflight(struct vhost_dev *hdev) -{
> -    int r;
> -
> -    if (hdev->vhost_ops->vhost_get_inflight_fd =3D=3D NULL ||
> -        hdev->vhost_ops->vhost_set_inflight_fd =3D=3D NULL) {
> -        return 0;
> -    }
> -
> -    r =3D vhost_dev_set_features(hdev, hdev->log_enabled);
> -    if (r < 0) {
> -        VHOST_OPS_DEBUG("vhost_dev_prepare_inflight failed");
> -        return r;
> -    }
> -
> -    return 0;
> -}
> -
>  int vhost_dev_set_inflight(struct vhost_dev *dev,
>                             struct vhost_inflight *inflight)  {
> --
> 2.28.0


