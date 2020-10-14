Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88533C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765EC208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765EC208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfnH-0005b8-3I
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSfhZ-0001bQ-IF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:16:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:56189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSfhW-00045x-Ha
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:16:16 -0400
IronPort-SDR: xjNeGtErxSwGBfcHUOu9YLANPZyQVjeBtSMK3OhR2PQwqIuDxUltfni762WJSzsCekixURgBkR
 7nz1XhA5aw7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145955409"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="145955409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 05:16:09 -0700
IronPort-SDR: IPhoWbF4dnPLN9jkKrFZbK24tYEERxGl74I14YCDyIu8JPuJVAxVp4EYieGKUPsEZWF0GLfkAv
 yTb6DiooQXVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="357359654"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga007.jf.intel.com with ESMTP; 14 Oct 2020 05:16:09 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 05:16:06 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 20:16:04 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 14 Oct 2020 20:16:04 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Derek Su <dereksu@qnap.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 03/10] Reduce the time of checkpoint for COLO
Thread-Topic: [PATCH 03/10] Reduce the time of checkpoint for COLO
Thread-Index: AQHWofucVKZSGIC6yUaSJ9bVWmzGramXA1Zw
Date: Wed, 14 Oct 2020 12:16:04 +0000
Message-ID: <cc2e4d3a889f4a04b4d6bcbe7124946b@intel.com>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <20201014072555.12515-4-chen.zhang@intel.com>
In-Reply-To: <20201014072555.12515-4-chen.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.151; envelope-from=chen.zhang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:16:10
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Rao, Lei" <lei.rao@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Zhang Chen <chen.zhang@intel.com>
> Sent: Wednesday, October 14, 2020 3:26 PM
> To: Jason Wang <jasowang@redhat.com>; qemu-dev <qemu-
> devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Rao, Lei <lei.rao@intel.com>;
> Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH 03/10] Reduce the time of checkpoint for COLO
>=20
> From: "Rao, Lei" <lei.rao@intel.com>
>=20
> we should set ram_bulk_stage to false after ram_state_init, otherwise the
> bitmap will be unused in migration_bitmap_find_dirty.
> all pages in ram cache will be flushed to the ram of secondary guest for =
each
> checkpoint.
>=20
> Signed-off-by: leirao <lei.rao@intel.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Sorry, I forgot to add:
Signed-off-by: Derek Su <dereksu@qnap.com>

Thanks
Zhang Chen

> ---
>  migration/ram.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c index 433489d633..9cfac3d9=
ba
> 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3009,6 +3009,18 @@ static void
> decompress_data_with_multi_threads(QEMUFile *f,
>      qemu_mutex_unlock(&decomp_done_lock);
>  }
>=20
> + /*
> +  * we must set ram_bulk_stage to false, otherwise in
> +  * migation_bitmap_find_dirty the bitmap will be unused and
> +  * all the pages in ram cache wil be flushed to the ram of
> +  * secondary VM.
> +  */
> +static void colo_init_ram_state(void)
> +{
> +    ram_state_init(&ram_state);
> +    ram_state->ram_bulk_stage =3D false;
> +}
> +
>  /*
>   * colo cache: this is for secondary VM, we cache the whole
>   * memory of the secondary VM, it is need to hold the global lock @@ -
> 3052,7 +3064,7 @@ int colo_init_ram_cache(void)
>          }
>      }
>=20
> -    ram_state_init(&ram_state);
> +    colo_init_ram_state();
>      return 0;
>  }
>=20
> --
> 2.17.1


