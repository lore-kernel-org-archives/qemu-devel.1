Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB345C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E09C238D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E09C238D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKtZJ-0008Ul-4d
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 21:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtXG-0007ZO-6d
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:25:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:65364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtXD-0004OW-Ru
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:25:29 -0400
IronPort-SDR: m3O1DY4/3RFIlo2cTQPLS0eAqOFAWwCxH2gMDYzuROaCVxURoP2JWEhnGp9kdDWuel9ZbJ0A6O
 LJNZY6uPQQwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="158134696"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="158134696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 18:25:23 -0700
IronPort-SDR: tV+zLLvGOaw8iUwZmemxKM7wB8mYFv+hzH7L6AR+YuG1/nrhxe40XWNTxY0PZQUpbVYVAhVfWO
 mdhdEV1ylKDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="305171392"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga003.jf.intel.com with ESMTP; 22 Sep 2020 18:25:23 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 18:25:22 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 09:25:21 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 09:25:21 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Rao, Lei" <lei.rao@intel.com>, "lizhijian@cn.fujitsu.com"
 <lizhijian@cn.fujitsu.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com"
 <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [PATCH v2 2/3] Reduce the time of checkpoint for COLO
Thread-Topic: [PATCH v2 2/3] Reduce the time of checkpoint for COLO
Thread-Index: AQHWkMSuP4cqj6LmLE2Yov7OLQt9Cql1byYA
Date: Wed, 23 Sep 2020 01:25:20 +0000
Message-ID: <b9ca78217db34fb2abebde21994580ff@intel.com>
References: <1600766690-94980-1-git-send-email-lei.rao@intel.com>
 <1600766690-94980-3-git-send-email-lei.rao@intel.com>
In-Reply-To: <1600766690-94980-3-git-send-email-lei.rao@intel.com>
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
Received-SPF: pass client-ip=192.55.52.120; envelope-from=chen.zhang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 21:25:24
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Rao, Lei <lei.rao@intel.com>
> Sent: Tuesday, September 22, 2020 5:25 PM
> To: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> jasowang@redhat.com; quintela@redhat.com; dgilbert@redhat.com;
> pbonzini@redhat.com
> Cc: qemu-devel@nongnu.org; Rao, Lei <lei.rao@intel.com>
> Subject: [PATCH v2 2/3] Reduce the time of checkpoint for COLO
>=20
> we should set ram_bulk_stage to false after ram_state_init, otherwise the
> bitmap will be unused in migration_bitmap_find_dirty.
> all pages in ram cache will be flushed to the ram of secondary guest for =
each
> checkpoint.
>=20
> Signed-off-by: leirao <lei.rao@intel.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
>  migration/ram.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c index 76d4fee..59ff0cf 100=
644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3018,6 +3018,18 @@ static void
> decompress_data_with_multi_threads(QEMUFile *f,
>      qemu_mutex_unlock(&decomp_done_lock);
>  }
>=20
> + /*
> +  * we must set ram_bulk_stage to fasle, otherwise in
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
> 3061,7 +3073,7 @@ int colo_init_ram_cache(void)
>          }
>      }
>=20
> -    ram_state_init(&ram_state);
> +    colo_init_ram_state();
>      return 0;
>  }
>=20
> --
> 1.8.3.1


