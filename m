Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD2C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC342371F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC342371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKtVM-0006Mg-36
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 21:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtSs-0004Kj-4W
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:20:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:38550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtSo-000446-6j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:20:57 -0400
IronPort-SDR: 1W1NEgnj3g6a5l8uqJxAkuAUvoso6L98U4uhmG/AqtCtHiss29xr/dAP3e5FZVKXRYJMGjT05A
 gaw6sRv/lKQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="178828596"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="178828596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 18:20:46 -0700
IronPort-SDR: LbqzYbx8VncCJZYuWeWCadWDEcfH1JgW1E/qUaLXpD3xS33K+pvuwyBI0b+58pUH6df6A84T+y
 uc+xo+PEwN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="347146508"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2020 18:20:45 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 18:20:45 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 09:20:43 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 09:20:43 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Rao, Lei" <lei.rao@intel.com>, "lizhijian@cn.fujitsu.com"
 <lizhijian@cn.fujitsu.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com"
 <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [PATCH v2 1/3] Optimize seq_sorter function for colo-compare
Thread-Topic: [PATCH v2 1/3] Optimize seq_sorter function for colo-compare
Thread-Index: AQHWkMSsLncnAdFNYUKoV4XqvVWxDql1ap6Q
Date: Wed, 23 Sep 2020 01:20:43 +0000
Message-ID: <4ab253f8cdb34d029260d579e9e77742@intel.com>
References: <1600766690-94980-1-git-send-email-lei.rao@intel.com>
 <1600766690-94980-2-git-send-email-lei.rao@intel.com>
In-Reply-To: <1600766690-94980-2-git-send-email-lei.rao@intel.com>
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
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 21:20:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> Subject: [PATCH v2 1/3] Optimize seq_sorter function for colo-compare
>=20
> The seq of tcp has been filled in fill_pkt_tcp_info, it can be used direc=
tly here.
>=20
> Signed-off-by: leirao <lei.rao@intel.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>
By the way, please add Zhijian's reviewed-by in new version of patches.

Thanks
Zhang Chen

> ---
>  net/colo-compare.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 3a45d64..86980ce 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -196,11 +196,7 @@ static void
> colo_compare_inconsistency_notify(CompareState *s)
>=20
>  static gint seq_sorter(Packet *a, Packet *b, gpointer data)  {
> -    struct tcp_hdr *atcp, *btcp;
> -
> -    atcp =3D (struct tcp_hdr *)(a->transport_header);
> -    btcp =3D (struct tcp_hdr *)(b->transport_header);
> -    return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
> +    return a->tcp_seq - b->tcp_seq;
>  }
>=20
>  static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
> --
> 1.8.3.1


