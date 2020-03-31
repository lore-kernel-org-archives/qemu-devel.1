Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D6FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F1920714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F1920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ5Vm-0007db-LH
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 21:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jJ5Ul-0006K1-Vi
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jJ5Uk-0006oo-2x
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:15:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:29355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jJ5Uj-0006ho-Pq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:15:10 -0400
IronPort-SDR: t6JMH/jHkQzjQXpkCjd9YSnbAmlLaEJEwah9lSkU/P7aHwh8QTbSYBToX6x9kEJgV8oM2ZBSNW
 s8S76x93I7Pw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 18:15:02 -0700
IronPort-SDR: RiE1LACNUuTemayIc8kTOFlT/l14FwZwoWsZJfwShJQt165090ZzOVXjUfv+q/CttRwwkTEPy+
 /LHJZPI9cFww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; d="scan'208";a="242211224"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 18:15:01 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 18:15:00 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 09:14:52 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 31 Mar 2020 09:14:52 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <dereksu@qnap.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 1/2] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Topic: [PATCH v4 1/2] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Index: AQHWBP8PJ8vbywkfJ0C3muxyKGgpjqhh6Tgg
Date: Tue, 31 Mar 2020 01:14:52 +0000
Message-ID: <83a9fc55b00e4de2a26a4f100583acc8@intel.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-2-dereksu@qnap.com>
In-Reply-To: <20200328124646.7778-2-dereksu@qnap.com>
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
X-Received-From: 192.55.52.93
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "jwsu1986@gmail.com" <jwsu1986@gmail.com>, "chyang@qnap.com" <chyang@qnap.com>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Derek Su <dereksu@qnap.com>
> Sent: Saturday, March 28, 2020 8:47 PM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> jasowang@redhat.com; ctcheng@qnap.com; chyang@qnap.com;
> jwsu1986@gmail.com; Derek Su <dereksu@qnap.com>
> Subject: [PATCH v4 1/2] net/colo-compare.c: Fix memory leak in
> packet_enqueue()
>=20
> The patch is to fix the "pkt" memory leak in packet_enqueue().
> The allocated "pkt" needs to be freed if the colo compare primary or
> secondary queue is too big.
>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

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


