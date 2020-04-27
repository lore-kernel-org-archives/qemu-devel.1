Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F01C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1546F221F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1546F221F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSuBy-0000pg-6J
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 23:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSuBJ-00005o-A3
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSuBI-0007qC-Ek
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:11:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:19411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jSuBH-0007q5-Us
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:11:40 -0400
IronPort-SDR: sskHH5TyqfLDOelaMjxRaOJkD6C4GyDag0U1oL3MxjCpttczT6fU49wgZa+q/j/tZhpL4jVhbv
 zvMHsxbHektQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 20:11:37 -0700
IronPort-SDR: TQIH46WocEsEw2dg/iWZsFKQWVCQyyCVZVo3dszZrdVy5a2gtn7u4Fp7Rcftj4ID9gdATHW7Ua
 3tu4dzEUqKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; d="scan'208";a="366999473"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2020 20:11:21 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 20:11:21 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Apr 2020 11:11:19 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Mon, 27 Apr 2020 11:11:19 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, Derek Su <dereksu@qnap.com>
Subject: RE: [PATCH v5 1/1] colo-compare: Fix memory leak in packet_enqueue()
Thread-Topic: [PATCH v5 1/1] colo-compare: Fix memory leak in packet_enqueue()
Thread-Index: AQHWDtvts6Y3dTVUqUygpsUCr0Q9ZaiK1uyAgAGN10A=
Date: Mon, 27 Apr 2020 03:11:19 +0000
Message-ID: <99afa827c86c43a6b6049d58ca2ab155@intel.com>
References: <20200410020056.12104-1-dereksu@qnap.com>
 <20200410020056.12104-2-dereksu@qnap.com> <20200426132523.51992c28@luklap>
In-Reply-To: <20200426132523.51992c28@luklap>
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
Received-SPF: pass client-ip=134.134.136.31; envelope-from=chen.zhang@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:11:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.31
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
Cc: "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>,
 "chyang@qnap.com" <chyang@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>,
 "jwsu1986@gmail.com" <jwsu1986@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Sunday, April 26, 2020 7:25 PM
> To: Derek Su <dereksu@qnap.com>
> Cc: qemu-devel@nongnu.org; lizhijian@cn.fujitsu.com; chyang@qnap.com;
> jasowang@redhat.com; ctcheng@qnap.com; Zhang, Chen
> <chen.zhang@intel.com>; jwsu1986@gmail.com
> Subject: Re: [PATCH v5 1/1] colo-compare: Fix memory leak in
> packet_enqueue()
>=20
> On Fri, 10 Apr 2020 10:00:56 +0800
> Derek Su <dereksu@qnap.com> wrote:
>=20
> > The patch is to fix the "pkt" memory leak in packet_enqueue().
> > The allocated "pkt" needs to be freed if the colo compare primary or
> > secondary queue is too big.
> >
> > Replace the error_report of full queue with a trace event.
> >
> > Signed-off-by: Derek Su <dereksu@qnap.com>
>=20
> Looks good now and works well in my tests.
> Reviewed-by: Lukas Straub <lukasstraub2@web.de>
> Tested-by: Lukas Straub <lukasstraub2@web.de>
>=20

I will queue this patch to COLO branch, then submit to Jason.

Thanks
Zhang Chen

> Regards,
> Lukas Straub
>=20
> > ---
> >  net/colo-compare.c | 23 +++++++++++++++--------
> >  net/trace-events   |  1 +
> >  2 files changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > 10c0239f9d..035e11d4d3 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -122,6 +122,10 @@ enum {
> >      SECONDARY_IN,
> >  };
> >
> > +static const char *colo_mode[] =3D {
> > +    [PRIMARY_IN] =3D "primary",
> > +    [SECONDARY_IN] =3D "secondary",
> > +};
> >
> >  static int compare_chr_send(CompareState *s,
> >                              const uint8_t *buf, @@ -217,6 +221,7 @@
> > static int packet_enqueue(CompareState *s, int mode, Connection **con)
> >      ConnectionKey key;
> >      Packet *pkt =3D NULL;
> >      Connection *conn;
> > +    int ret;
> >
> >      if (mode =3D=3D PRIMARY_IN) {
> >          pkt =3D packet_new(s->pri_rs.buf, @@ -245,16 +250,18 @@ static
> > int packet_enqueue(CompareState *s, int mode, Connection **con)
> >      }
> >
> >      if (mode =3D=3D PRIMARY_IN) {
> > -        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)=
) {
> > -            error_report("colo compare primary queue size too big,"
> > -                         "drop packet");
> > -        }
> > +        ret =3D colo_insert_packet(&conn->primary_list, pkt,
> > + &conn->pack);
> >      } else {
> > -        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sac=
k)) {
> > -            error_report("colo compare secondary queue size too big,"
> > -                         "drop packet");
> > -        }
> > +        ret =3D colo_insert_packet(&conn->secondary_list, pkt,
> > + &conn->sack);
> >      }
> > +
> > +    if (!ret) {
> > +        trace_colo_compare_drop_packet(colo_mode[mode],
> > +            "queue size too big, drop packet");
> > +        packet_destroy(pkt, NULL);
> > +        pkt =3D NULL;
> > +    }
> > +
> >      *con =3D conn;
> >
> >      return 0;
> > diff --git a/net/trace-events b/net/trace-events index
> > 02c13fd0ba..fa49c71533 100644
> > --- a/net/trace-events
> > +++ b/net/trace-events
> > @@ -12,6 +12,7 @@ colo_proxy_main(const char *chr) ": %s"
> >
> >  # colo-compare.c
> >  colo_compare_main(const char *chr) ": %s"
> > +colo_compare_drop_packet(const char *queue, const char *chr)
> ": %s: %s"
> >  colo_compare_udp_miscompare(const char *sta, int size) ": %s =3D %d"
> >  colo_compare_icmp_miscompare(const char *sta, int size) ": %s =3D %d"
> >  colo_compare_ip_info(int psize, const char *sta, const char *stb, int =
ssize,
> const char *stc, const char *std) "ppkt size =3D %d, ip_src =3D %s, ip_ds=
t =3D %s,
> spkt size =3D %d, ip_src =3D %s, ip_dst =3D %s"


