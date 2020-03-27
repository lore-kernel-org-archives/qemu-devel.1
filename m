Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EB6C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C4E2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+Ly6fsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C4E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtbk-0006fb-Hr
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jHtau-0005DM-S6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jHtat-000640-CK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:20:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jHtat-000639-6f
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:20:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id q204so9570153oia.13
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kgfu25sOAGG/kz/ioKZadtyFeWYDObYKU2OTe3el3HA=;
 b=t+Ly6fsFaXrr75GubwMBCsS/fLVpW2z0Blm5WsWWlMvwF8FeAcUUEJtn2RsqIvaGJ5
 +JadEI4ol0HVGplBRFb/mZMsL+U5BPGg2zWh35jA2WXQExk5y22XMVcrqZM2izJKrTHe
 Rqf2G+jdWcYy/ieFf67PPjrlhD9p3kcdgvScLDRderVEqB0xsBe2qDXZ9KKFZbi/9+ce
 NqGiapMLtD2kUgzl15slrg3TkH4sVRDRo9W7aLBIzePbd0hvlvV9WKuxKEjhlNWZqGiw
 T7AdOnLjry8OxW1eyfnrW1zR3dPgSVienD3Wks1n3CabH8k9/v4qJ+M85W8/stDzzTi0
 naTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kgfu25sOAGG/kz/ioKZadtyFeWYDObYKU2OTe3el3HA=;
 b=BgR2wC5WWELIBqtBoli+csRhI8aqVe2kgqliiR7L0v5vNfcKen1iniOAqB5w78VxfO
 fmNGR8zG3Blhc8KbI8cfUO3dO/am5eseLDoEILrU6qn3KrcVbpmcPcc+JigN2sFEJ+p+
 6CtbKHW0Z9rdh88jfGV6C4J2+Vsj0I+tx5DyYJ3eoeQSF3+WCbr5pN31uv48v95NtWf8
 ON8kkqvEkpkC9aGy9TFfEs+wR4QHFo7QHaLFKG/vwBe//0XyYC+xsiN8pPxuF1xAItGg
 YzvhgkmbnIELUiJhK4ziS/OibBHiIAV5TziniMvOxugdf5tLkP0gNeUjfW3Mmef44/F9
 USQA==
X-Gm-Message-State: ANhLgQ2YIkGD4I0+4Q1VHZLG5BT0/j/r7D0TfMPIKGCiBGSRdWgL6gzQ
 kR5rJcekVEZ1fclXwua/nOTg87zuS7PZEjiBk4Y=
X-Google-Smtp-Source: ADFU+vszSazor3zQy01UZqfMbBKj0ui0CrffgBughGwxW2Q5g/N6D4iBrLjxJAHACHkAfy4DfZGmhNX0dpjRX60crcI=
X-Received: by 2002:a05:6808:b30:: with SMTP id
 t16mr123716oij.66.1585333233716; 
 Fri, 27 Mar 2020 11:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200325094354.19677-1-dereksu@qnap.com>
 <20200325094354.19677-3-dereksu@qnap.com>
 <20200327184549.3802f959@luklap>
In-Reply-To: <20200327184549.3802f959@luklap>
From: Derek Su <jwsu1986@gmail.com>
Date: Sat, 28 Mar 2020 02:20:21 +0800
Message-ID: <CAFKS8hUUC4LCDJDdRmiHXa2VHdhrcytJGyXFFxz85h4p1hiJRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
To: Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 25 Mar 2020 17:43:54 +0800
> Derek Su <dereksu@qnap.com> wrote:
>
> > The pervious handling of the full primary or queue is only dropping
> > the packet. If there are lots of clients to the guest VM,
> > the "drop" will lead to the lost of the networking connection
> > until next checkpoint.
> >
> > To address the issue, this patch drops the packet firstly.
> > Then, send all queued primary packets, remove all queued secondary
> > packets and do checkpoint.
> >
> > Signed-off-by: Derek Su <dereksu@qnap.com>
> > ---
> >  net/colo-compare.c | 41 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > index cdd87b2aa8..1a52f50fbe 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -125,6 +125,12 @@ static const char *colo_mode[] =3D {
> >      [SECONDARY_IN] =3D "secondary",
> >  };
> >
> > +enum {
> > +    QUEUE_INSERT_ERR =3D -1,
> > +    QUEUE_INSERT_OK =3D 0,
> > +    QUEUE_INSERT_FULL =3D 1,
> > +};
> > +
> >  static int compare_chr_send(CompareState *s,
> >                              const uint8_t *buf,
> >                              uint32_t size,
> > @@ -211,8 +217,10 @@ static int colo_insert_packet(GQueue *queue, Packe=
t *pkt, uint32_t *max_ack)
> >  }
> >
> >  /*
> > - * Return 0 on success, if return -1 means the pkt
> > - * is unsupported(arp and ipv6) and will be sent later
> > + * Return QUEUE_INSERT_OK on success.
> > + * If return QUEUE_INSERT_FULL means list is full, and
> > + * QUEUE_INSERT_ERR means the pkt is unsupported(arp and ipv6) and
> > + * will be sent later
> >   */
> >  static int packet_enqueue(CompareState *s, int mode, Connection **con)
> >  {
> > @@ -234,7 +242,7 @@ static int packet_enqueue(CompareState *s, int mode=
, Connection **con)
> >      if (parse_packet_early(pkt)) {
> >          packet_destroy(pkt, NULL);
> >          pkt =3D NULL;
> > -        return -1;
> > +        return QUEUE_INSERT_ERR;
> >      }
> >      fill_connection_key(pkt, &key);
> >
> > @@ -258,11 +266,12 @@ static int packet_enqueue(CompareState *s, int mo=
de, Connection **con)
> >                       "drop packet", colo_mode[mode]);
> >          packet_destroy(pkt, NULL);
> >          pkt =3D NULL;
> > +        return QUEUE_INSERT_FULL;
> >      }
> >
> >      *con =3D conn;
> >
> > -    return 0;
> > +    return QUEUE_INSERT_OK;
> >  }
> >
> >  static inline bool after(uint32_t seq1, uint32_t seq2)
> > @@ -995,17 +1004,22 @@ static void compare_pri_rs_finalize(SocketReadSt=
ate *pri_rs)
> >  {
> >      CompareState *s =3D container_of(pri_rs, CompareState, pri_rs);
> >      Connection *conn =3D NULL;
> > +    int ret;
> >
> > -    if (packet_enqueue(s, PRIMARY_IN, &conn)) {
> > +    ret =3D packet_enqueue(s, PRIMARY_IN, &conn);
> > +    if (ret =3D=3D QUEUE_INSERT_OK) {
> > +        /* compare packet in the specified connection */
> > +        colo_compare_connection(conn, s);
> > +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> > +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > +        colo_compare_inconsistency_notify(s);
> > +    } else {
> >          trace_colo_compare_main("primary: unsupported packet in");
> >          compare_chr_send(s,
> >                           pri_rs->buf,
> >                           pri_rs->packet_len,
> >                           pri_rs->vnet_hdr_len,
> >                           false);
> > -    } else {
> > -        /* compare packet in the specified connection */
> > -        colo_compare_connection(conn, s);
> >      }
> >  }
> >
> > @@ -1013,12 +1027,17 @@ static void compare_sec_rs_finalize(SocketReadS=
tate *sec_rs)
> >  {
> >      CompareState *s =3D container_of(sec_rs, CompareState, sec_rs);
> >      Connection *conn =3D NULL;
> > +    int ret;
> >
> > -    if (packet_enqueue(s, SECONDARY_IN, &conn)) {
> > -        trace_colo_compare_main("secondary: unsupported packet in");
> > -    } else {
> > +    ret =3D packet_enqueue(s, SECONDARY_IN, &conn);
> > +    if (ret =3D=3D QUEUE_INSERT_OK) {
> >          /* compare packet in the specified connection */
> >          colo_compare_connection(conn, s);
> > +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> > +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> > +        colo_compare_inconsistency_notify(s);
> > +    } else {
> > +        trace_colo_compare_main("secondary: unsupported packet in");
> >      }
> >  }
> >
>
> Hi,
> I don't think we have to flush here because the (post-)checkpoint event w=
ill flush the packets for us.
>

Hi,
Yes, the periodical checkpoint can flush the packets.

But, if many clients send many packets to the vm,
there is a high probability that packets are dropped because the
primary/secondary queues are always full.
It causes lots of re-transmission between clients and vm and
deteriorate service response to clients.

Sincerely,
Derek Su

> Regards,
> Lukas Straub

