Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 02:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C060206F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 02:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsHpOJTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C060206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGZbb-0005z0-FK
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 22:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jGZas-0005Zz-HZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 22:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jGZar-00070u-BG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 22:47:06 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jGZar-0006zZ-6Q
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 22:47:05 -0400
Received: by mail-ot1-x344.google.com with SMTP id e19so15698322otj.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 19:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mSPjyt4X4bKg86ioeDwf37dPPj/s1j88H6eZJpdtGxE=;
 b=tsHpOJTGmhcDPK6ByuksEqnHlfLepg3+KcpYXhR+6Oc7/7JIJZm5OCwoHcl5GQfYRD
 P1LDD+/4DDJwXIi/j9S9S4y7y0uYJxbCfxKlESfNTidUhIKjjCQFfaozmXFdlfZNyMwb
 pNKxgemNWbEkj7bW5fB9bKegMlz+v1UqJMGVb5CQ52P6TJSZNbv5uVZOK379551rD9T6
 pI25QkFhAJWMQpcBQEVn55PKZN8Y3GFCpQMn6RvmYsrlB+iVBYmaVMSjSCNgTn00kjFi
 HppXNMN1XXeGCMUi5YC/1UtL3SQ1ERnSj6bqaP+1HiNdREHWDyH36GUNJP51goMhbQF5
 rkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mSPjyt4X4bKg86ioeDwf37dPPj/s1j88H6eZJpdtGxE=;
 b=c3NZu4aqtWj7bF3FK/D8euTy69l7XIN7LYk84KlYn1DcH2eqsVHqQ2WNPzM+gXWXOx
 W8zKYM6b09POVX4eUibAAZ009fHRBPslNEEWnip8Q32IDRTUE9We0SE9RVOX355Tq0h+
 OdvIdoh/4uYJrUK0SngvdJEIPWyTA6tlnEz1hOhQtzpBs6JgTK49cs5mT3iSNWn9sj3Y
 i+mbsK837y3PqYy11HiE8kTpHQRANIghJ8+K1eOoD9wz7oZVUsedb5cxs9OLADCYNM4a
 0QVAng/xeXis3qCCsvcHz0JLPsxc7mxkWwsV+N5PabONETo7CVf+d4AWJqtIotM55zMn
 ghKQ==
X-Gm-Message-State: ANhLgQ0MwMl17+hL3xKGHTKe94Ne+kRME2sek72vYpmhSWBh+H3m3Ptv
 gp3UqxjHJruEdj5TMeyZkJVnK2u0GC+GKfXADiY=
X-Google-Smtp-Source: ADFU+vusE/p8NlXSqJclPBdDSXrDr5Cyk2Zw628prZZ9Bgjf1kd2PgSmaCcCJk/RiTaHg0ocDDGekwji81KQtybMZ8g=
X-Received: by 2002:a05:6830:231b:: with SMTP id
 u27mr10827820ote.111.1585018023535; 
 Mon, 23 Mar 2020 19:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200322174751.12559-1-dereksu@qnap.com>
 <20200322174751.12559-2-dereksu@qnap.com>
 <883bf4e2916f43baa6700f98bbb85523@intel.com>
In-Reply-To: <883bf4e2916f43baa6700f98bbb85523@intel.com>
From: Jing-Wei Su <jwsu1986@gmail.com>
Date: Tue, 24 Mar 2020 10:46:52 +0800
Message-ID: <CAFKS8hUJ34Qh7gsggtbVM6GU4hLEn_xBLFM7X5mQrsmQg-Yc7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> > -----Original Message-----
> > From: Derek Su <jwsu1986@gmail.com>
> > Sent: Monday, March 23, 2020 1:48 AM
> > To: qemu-devel@nongnu.org
> > Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> > jasowang@redhat.com; dereksu@qnap.com
> > Subject: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
> > packet_enqueue()
> >
> > The patch is to fix the "pkt" memory leak in packet_enqueue().
> > The allocated "pkt" needs to be freed if the colo compare primary or
> > secondary queue is too big.
>
> Hi Derek,
>
> Thank you for the patch.
> I re-think this issue in a big view, looks just free the pkg is not enoug=
h in this situation.
> The root cause is network is too busy to compare, So, better choice is no=
tify COLO frame
> to do a checkpoint and clean up all the network queue. This work maybe de=
crease
> COLO network performance but seams better than drop lots of pkg.
>
> Thanks
> Zhang Chen
>

Hello, Zhang

Got it.
What is the concern of the massive "drop packets"?
Does the behavior make the COLO do checkpoint periodically (~20 seconds)
instead of doing immediate checkpoint when encountering different
response packets?

It seems that frequent checkpoints caused by the full queue (busy
network) instead of different
response packets may harm the high speed network (10 Gbps or higher)
performance dramatically.

Thanks
Derek

> >
> > Signed-off-by: Derek Su <dereksu@qnap.com>
> > ---
> >  net/colo-compare.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > 7ee17f2cf8..cdd87b2aa8 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -120,6 +120,10 @@ enum {
> >      SECONDARY_IN,
> >  };
> >
> > +static const char *colo_mode[] =3D {
> > +    [PRIMARY_IN] =3D "primary",
> > +    [SECONDARY_IN] =3D "secondary",
> > +};
> >
> >  static int compare_chr_send(CompareState *s,
> >                              const uint8_t *buf, @@ -215,6 +219,7 @@ st=
atic int
> > packet_enqueue(CompareState *s, int mode, Connection **con)
> >      ConnectionKey key;
> >      Packet *pkt =3D NULL;
> >      Connection *conn;
> > +    int ret;
> >
> >      if (mode =3D=3D PRIMARY_IN) {
> >          pkt =3D packet_new(s->pri_rs.buf, @@ -243,16 +248,18 @@ static=
 int
> > packet_enqueue(CompareState *s, int mode, Connection **con)
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
> > +        error_report("colo compare %s queue size too big,"
> > +                     "drop packet", colo_mode[mode]);
> > +        packet_destroy(pkt, NULL);
> > +        pkt =3D NULL;
> > +    }
> > +
> >      *con =3D conn;
> >
> >      return 0;
> > --
> > 2.17.1
>

