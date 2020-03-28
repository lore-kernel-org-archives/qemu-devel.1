Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C78CC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3B3206CC
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1HpGqvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3B3206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI2H2-00034n-74
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 23:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jI2GH-0002Wu-3N
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jI2GF-0005GA-N7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:35:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jI2GF-0005Dp-IO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:35:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id x11so12016051otp.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 20:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CXd9oGZ5W/NS+O2j8p84K8g9YYGur/h+bbl+M8NcFhw=;
 b=h1HpGqvnzIMSyGG0owm+X3Pp0G86BVV05KJcdSpFDEJCgOtQ09HSwROdzMfCIHy2Wn
 VuxlOgye1vcB0gU/ffgMcz7ohI51WB+OOO9qEozsEBpmB8znBJoebgmN8yb2wFqb/Pdc
 kkkJTf8iAcD6A5r9ytGr1CZd5rosd7TW7tkdGZCIrZnI7L8tTRpj3MMSAiiZh3h0kPGK
 CVVERp4wvfxg3Q84fnTNIZyDMn+/F5Zvsuwamy+i29FJaD8S5pC9Cv4oQhbAFXcY9Oia
 YMnx6N0RFkL+Fy8reiPhwBbaS5c3XMUxwaPtvPp28HDBPiPtt/EcZzlhU2Qjt5d/xBli
 nQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CXd9oGZ5W/NS+O2j8p84K8g9YYGur/h+bbl+M8NcFhw=;
 b=LG+vEf9CAKu3vtPAeficyWY+EsqFB4qnMzBsKVNDiQyk8D7dHxoF24xtPqg3NJn+Jc
 jzM2oaqJzi4ITamDF88iM5IqFqo3DyPf9MFqcHqMITD3j/ST/A5EAJnwlB03JiZ3VH3C
 TVzGeSUiadNsg84JNwLHQyN1bwsqtkqKKfNAy5HaPYheDmc7vSLD45mkDsf3HjKDRX9Z
 OxajDdx47g9kKslb9h40PxnearT+T04WUZ4ryJA8Cvk0UI8L/xQ61Jbhml2EG6dJ0LtN
 cId7jBxUJtsdT4+Hjsv0p+xVKNZ0SwiRmYzJwCd+iHJOCAHiHkLvt5bzU+fWXXDtPbtq
 XPjQ==
X-Gm-Message-State: ANhLgQ1KeInoYM7w87llpykk9I++dpLkZANU5UVOeeSU4Rp31/SeZjmn
 VydvP9ZdkhojuUyPaiKPrrj8B1v0iGb8ZZt4a+Q=
X-Google-Smtp-Source: ADFU+vtT+cuOngG1FvEdKukpcIZkfrmF83RAfeQOpuIITQa+a0g5wpoNxNTcQn2fRB9s7ZEOrw7b2dUsemuUTRbqNwI=
X-Received: by 2002:a4a:a226:: with SMTP id m38mr2076235ool.94.1585366548841; 
 Fri, 27 Mar 2020 20:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200325094354.19677-1-dereksu@qnap.com>
 <20200325094354.19677-3-dereksu@qnap.com>
 <20200327184549.3802f959@luklap>
 <CAFKS8hUUC4LCDJDdRmiHXa2VHdhrcytJGyXFFxz85h4p1hiJRw@mail.gmail.com>
 <20200327192807.121412ab@luklap>
In-Reply-To: <20200327192807.121412ab@luklap>
From: Derek Su <jwsu1986@gmail.com>
Date: Sat, 28 Mar 2020 11:35:37 +0800
Message-ID: <CAFKS8hW9Q=9vWz_2xSw+MSzVDWTdocDu9-B4Z7_qWSZ9DAW0ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
To: Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, Derek Su <dereksu@qnap.com>,
 jasowang@redhat.com, qemu-devel@nongnu.org, ctcheng@qnap.com, "Zhang,
 Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lukas Straub <lukasstraub2@web.de> =E6=96=BC 2020=E5=B9=B43=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sat, 28 Mar 2020 02:20:21 +0800
> Derek Su <jwsu1986@gmail.com> wrote:
>
> > Lukas Straub <lukasstraub2@web.de> =E6=96=BC 2020=E5=B9=B43=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:46=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, 25 Mar 2020 17:43:54 +0800
> > > Derek Su <dereksu@qnap.com> wrote:
> > >
> > > > The pervious handling of the full primary or queue is only dropping
> > > > the packet. If there are lots of clients to the guest VM,
> > > > the "drop" will lead to the lost of the networking connection
> > > > until next checkpoint.
> > > >
> > > > To address the issue, this patch drops the packet firstly.
> > > > Then, send all queued primary packets, remove all queued secondary
> > > > packets and do checkpoint.
> > > >
> > > > Signed-off-by: Derek Su <dereksu@qnap.com>
> > > > ---
> > > >  net/colo-compare.c | 41 ++++++++++++++++++++++++++++++-----------
> > > >  1 file changed, 30 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > > > index cdd87b2aa8..1a52f50fbe 100644
> > > > --- a/net/colo-compare.c
> > > > +++ b/net/colo-compare.c
> > > > @@ -125,6 +125,12 @@ static const char *colo_mode[] =3D {
> > > >      [SECONDARY_IN] =3D "secondary",
> > > >  };
> > > >
> > > > +enum {
> > > > +    QUEUE_INSERT_ERR =3D -1,
> > > > +    QUEUE_INSERT_OK =3D 0,
> > > > +    QUEUE_INSERT_FULL =3D 1,
> > > > +};
> > > > +
> > > >  static int compare_chr_send(CompareState *s,
> > > >                              const uint8_t *buf,
> > > >                              uint32_t size,
> > > > @@ -211,8 +217,10 @@ static int colo_insert_packet(GQueue *queue, P=
acket *pkt, uint32_t *max_ack)
> > > >  }
> > > >
> > > >  /*
> > > > - * Return 0 on success, if return -1 means the pkt
> > > > - * is unsupported(arp and ipv6) and will be sent later
> > > > + * Return QUEUE_INSERT_OK on success.
> > > > + * If return QUEUE_INSERT_FULL means list is full, and
> > > > + * QUEUE_INSERT_ERR means the pkt is unsupported(arp and ipv6) and
> > > > + * will be sent later
> > > >   */
> > > >  static int packet_enqueue(CompareState *s, int mode, Connection **=
con)
> > > >  {
> > > > @@ -234,7 +242,7 @@ static int packet_enqueue(CompareState *s, int =
mode, Connection **con)
> > > >      if (parse_packet_early(pkt)) {
> > > >          packet_destroy(pkt, NULL);
> > > >          pkt =3D NULL;
> > > > -        return -1;
> > > > +        return QUEUE_INSERT_ERR;
> > > >      }
> > > >      fill_connection_key(pkt, &key);
> > > >
> > > > @@ -258,11 +266,12 @@ static int packet_enqueue(CompareState *s, in=
t mode, Connection **con)
> > > >                       "drop packet", colo_mode[mode]);
> > > >          packet_destroy(pkt, NULL);
> > > >          pkt =3D NULL;
> > > > +        return QUEUE_INSERT_FULL;
> > > >      }
> > > >
> > > >      *con =3D conn;
> > > >
> > > > -    return 0;
> > > > +    return QUEUE_INSERT_OK;
> > > >  }
> > > >
> > > >  static inline bool after(uint32_t seq1, uint32_t seq2)
> > > > @@ -995,17 +1004,22 @@ static void compare_pri_rs_finalize(SocketRe=
adState *pri_rs)
> > > >  {
> > > >      CompareState *s =3D container_of(pri_rs, CompareState, pri_rs)=
;
> > > >      Connection *conn =3D NULL;
> > > > +    int ret;
> > > >
> > > > -    if (packet_enqueue(s, PRIMARY_IN, &conn)) {
> > > > +    ret =3D packet_enqueue(s, PRIMARY_IN, &conn);
> > > > +    if (ret =3D=3D QUEUE_INSERT_OK) {
> > > > +        /* compare packet in the specified connection */
> > > > +        colo_compare_connection(conn, s);
> > > > +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> > > > +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > > > +        colo_compare_inconsistency_notify(s);
> > > > +    } else {
> > > >          trace_colo_compare_main("primary: unsupported packet in");
> > > >          compare_chr_send(s,
> > > >                           pri_rs->buf,
> > > >                           pri_rs->packet_len,
> > > >                           pri_rs->vnet_hdr_len,
> > > >                           false);
> > > > -    } else {
> > > > -        /* compare packet in the specified connection */
> > > > -        colo_compare_connection(conn, s);
> > > >      }
> > > >  }
> > > >
> > > > @@ -1013,12 +1027,17 @@ static void compare_sec_rs_finalize(SocketR=
eadState *sec_rs)
> > > >  {
> > > >      CompareState *s =3D container_of(sec_rs, CompareState, sec_rs)=
;
> > > >      Connection *conn =3D NULL;
> > > > +    int ret;
> > > >
> > > > -    if (packet_enqueue(s, SECONDARY_IN, &conn)) {
> > > > -        trace_colo_compare_main("secondary: unsupported packet in"=
);
> > > > -    } else {
> > > > +    ret =3D packet_enqueue(s, SECONDARY_IN, &conn);
> > > > +    if (ret =3D=3D QUEUE_INSERT_OK) {
> > > >          /* compare packet in the specified connection */
> > > >          colo_compare_connection(conn, s);
> > > > +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> > > > +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > > > +        colo_compare_inconsistency_notify(s);
> > > > +    } else {
> > > > +        trace_colo_compare_main("secondary: unsupported packet in"=
);
> > > >      }
> > > >  }
> > > >
> > >
> > > Hi,
> > > I don't think we have to flush here because the (post-)checkpoint eve=
nt will flush the packets for us.
> > >
> >
> > Hi,
> > Yes, the periodical checkpoint can flush the packets.
> >
> > But, if many clients send many packets to the vm,
> > there is a high probability that packets are dropped because the
> > primary/secondary queues are always full.
> > It causes lots of re-transmission between clients and vm and
> > deteriorate service response to clients.
> >
> > Sincerely,
> > Derek Su
>
> I mean that we can still initiate a checkpoint here, but not do the flush=
ing here.
>
> Regards,
> Lukas Straub

Hi,

Your're right.
After checking the colo_do_checkpoint_transaction function,  the flush
in the patch is redundant.
It will be fixed in the next version.
Thanks.

Derek Su
>
> > > Regards,
> > > Lukas Straub
>

