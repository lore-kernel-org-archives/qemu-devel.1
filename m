Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170BEC4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2748206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2748206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGSi0-0005VD-29
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jGSgr-0004Ck-Tb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jGSgp-0001ur-HP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:25771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jGSgp-0001qp-8S
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:47 -0400
IronPort-SDR: 2mx5H6uCDsIOPgH+rgUOWK6ihoBtJT346qfFywvizeIVzn1Ji2WsjrPYemfB3LN40bNhWZcET8
 s8j2JXcJbSbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 12:24:38 -0700
IronPort-SDR: ebNvahESyXXyHY4DN/wgtrH0PqSBivVKIHldu4fazCAfif4w42CZhWFcJWBNVnHMuD6PRVZ3cz
 PegvCSPR883w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; d="scan'208";a="445925090"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2020 12:24:37 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Mar 2020 12:24:37 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Mar 2020 03:24:35 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 24 Mar 2020 03:24:35 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <jwsu1986@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Topic: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Index: AQHWAHITxBU5D7mjSkWbPnpdLQyVtKhWi7uA
Date: Mon, 23 Mar 2020 19:24:35 +0000
Message-ID: <883bf4e2916f43baa6700f98bbb85523@intel.com>
References: <20200322174751.12559-1-dereksu@qnap.com>
 <20200322174751.12559-2-dereksu@qnap.com>
In-Reply-To: <20200322174751.12559-2-dereksu@qnap.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: "dereksu@qnap.com" <dereksu@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Derek Su <jwsu1986@gmail.com>
> Sent: Monday, March 23, 2020 1:48 AM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> jasowang@redhat.com; dereksu@qnap.com
> Subject: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
> packet_enqueue()
>=20
> The patch is to fix the "pkt" memory leak in packet_enqueue().
> The allocated "pkt" needs to be freed if the colo compare primary or
> secondary queue is too big.

Hi Derek,

Thank you for the patch.
I re-think this issue in a big view, looks just free the pkg is not enough =
in this situation.
The root cause is network is too busy to compare, So, better choice is noti=
fy COLO frame
to do a checkpoint and clean up all the network queue. This work maybe decr=
ease
COLO network performance but seams better than drop lots of pkg.

Thanks
Zhang Chen=20

>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>  net/colo-compare.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 7ee17f2cf8..cdd87b2aa8 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -120,6 +120,10 @@ enum {
>      SECONDARY_IN,
>  };
>=20
> +static const char *colo_mode[] =3D {
> +    [PRIMARY_IN] =3D "primary",
> +    [SECONDARY_IN] =3D "secondary",
> +};
>=20
>  static int compare_chr_send(CompareState *s,
>                              const uint8_t *buf, @@ -215,6 +219,7 @@ stat=
ic int
> packet_enqueue(CompareState *s, int mode, Connection **con)
>      ConnectionKey key;
>      Packet *pkt =3D NULL;
>      Connection *conn;
> +    int ret;
>=20
>      if (mode =3D=3D PRIMARY_IN) {
>          pkt =3D packet_new(s->pri_rs.buf, @@ -243,16 +248,18 @@ static i=
nt
> packet_enqueue(CompareState *s, int mode, Connection **con)
>      }
>=20
>      if (mode =3D=3D PRIMARY_IN) {
> -        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) =
{
> -            error_report("colo compare primary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret =3D colo_insert_packet(&conn->primary_list, pkt,
> + &conn->pack);
>      } else {
> -        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)=
) {
> -            error_report("colo compare secondary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret =3D colo_insert_packet(&conn->secondary_list, pkt,
> + &conn->sack);
>      }
> +
> +    if (!ret) {
> +        error_report("colo compare %s queue size too big,"
> +                     "drop packet", colo_mode[mode]);
> +        packet_destroy(pkt, NULL);
> +        pkt =3D NULL;
> +    }
> +
>      *con =3D conn;
>=20
>      return 0;
> --
> 2.17.1


