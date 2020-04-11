Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4785DC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 03:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4A020708
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 03:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4A020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jN7BU-0003Zd-11
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 23:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jN7Au-000392-Q3
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jN7At-0006Z3-Gm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:51:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:26716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jN7At-0006Y1-8T
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:51:19 -0400
IronPort-SDR: Lr/J87ypO8I0flJYBLJ1akDKwe5i7hsS36WyR2e9yiDRSdnZ3gk82tz45CTRGJEQhBactOOtUP
 gzPASK5vnqqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 20:51:17 -0700
IronPort-SDR: pew8S919r9v1z51Ac7+Se2qRi64NZrRPHNE2zkFmprRVyYR4UaDiE5LO5Og/RPZDaaQPSWqeF3
 H+LN8HLu4l9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; d="scan'208";a="252377738"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga003.jf.intel.com with ESMTP; 10 Apr 2020 20:51:17 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Apr 2020 20:51:17 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 11 Apr 2020 11:51:14 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Sat, 11 Apr 2020 11:51:14 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <dereksu@qnap.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 1/1] colo-compare: Fix memory leak in packet_enqueue()
Thread-Topic: [PATCH v5 1/1] colo-compare: Fix memory leak in packet_enqueue()
Thread-Index: AQHWDtvts6Y3dTVUqUygpsUCr0Q9ZahzSptw
Date: Sat, 11 Apr 2020 03:51:14 +0000
Message-ID: <fc0bb50f62c644729f64a6f9b671228f@intel.com>
References: <20200410020056.12104-1-dereksu@qnap.com>
 <20200410020056.12104-2-dereksu@qnap.com>
In-Reply-To: <20200410020056.12104-2-dereksu@qnap.com>
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
> Sent: Friday, April 10, 2020 10:01 AM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> jasowang@redhat.com; ctcheng@qnap.com; chyang@qnap.com;
> jwsu1986@gmail.com; Derek Su <dereksu@qnap.com>
> Subject: [PATCH v5 1/1] colo-compare: Fix memory leak in packet_enqueue()
>=20
> The patch is to fix the "pkt" memory leak in packet_enqueue().
> The allocated "pkt" needs to be freed if the colo compare primary or
> secondary queue is too big.
>=20
> Replace the error_report of full queue with a trace event.
>=20

Looks good for me. Thanks your contribution.

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>  net/colo-compare.c | 23 +++++++++++++++--------
>  net/trace-events   |  1 +
>  2 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 10c0239f9d..035e11d4d3 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -122,6 +122,10 @@ enum {
>      SECONDARY_IN,
>  };
>=20
> +static const char *colo_mode[] =3D {
> +    [PRIMARY_IN] =3D "primary",
> +    [SECONDARY_IN] =3D "secondary",
> +};
>=20
>  static int compare_chr_send(CompareState *s,
>                              const uint8_t *buf, @@ -217,6 +221,7 @@ stat=
ic int
> packet_enqueue(CompareState *s, int mode, Connection **con)
>      ConnectionKey key;
>      Packet *pkt =3D NULL;
>      Connection *conn;
> +    int ret;
>=20
>      if (mode =3D=3D PRIMARY_IN) {
>          pkt =3D packet_new(s->pri_rs.buf, @@ -245,16 +250,18 @@ static i=
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
> +        trace_colo_compare_drop_packet(colo_mode[mode],
> +            "queue size too big, drop packet");
> +        packet_destroy(pkt, NULL);
> +        pkt =3D NULL;
> +    }
> +
>      *con =3D conn;
>=20
>      return 0;
> diff --git a/net/trace-events b/net/trace-events index
> 02c13fd0ba..fa49c71533 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -12,6 +12,7 @@ colo_proxy_main(const char *chr) ": %s"
>=20
>  # colo-compare.c
>  colo_compare_main(const char *chr) ": %s"
> +colo_compare_drop_packet(const char *queue, const char *chr) ": %s: %s"
>  colo_compare_udp_miscompare(const char *sta, int size) ": %s =3D %d"
>  colo_compare_icmp_miscompare(const char *sta, int size) ": %s =3D %d"
>  colo_compare_ip_info(int psize, const char *sta, const char *stb, int ss=
ize,
> const char *stc, const char *std) "ppkt size =3D %d, ip_src =3D %s, ip_ds=
t =3D %s,
> spkt size =3D %d, ip_src =3D %s, ip_dst =3D %s"
> --
> 2.17.1


