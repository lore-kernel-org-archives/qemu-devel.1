Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7026EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268DD20774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv7Dw2F1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268DD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGky7-00080W-7X
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1jGkxH-0006lk-8O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1jGkxE-0005Fu-Bf
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:54:59 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1jGkxE-0005Eo-3v
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:54:56 -0400
Received: by mail-oi1-x241.google.com with SMTP id k9so6082633oia.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AaNT5i4Ku7iQhTd9k9EqGn5XEW1qeFDkPm39ClB8CxA=;
 b=jv7Dw2F1TPrr3eGA3OMU3T8o49kDgtpOtfLJ60PNMY/MeBCvgiEqvtggNXnFjRKyGe
 yNq83YgmukzHAWFJC4iqEH0c7sxVGqyIR3UWG1NIWiowDT4nqtkhcIaUB3x5WoaS88u/
 2qZ20bAvTEQvnzd67v21yKNM+vDQu9BgRhCa5blb+df1pbTRQm8JX2BdxyN01t2yombo
 /bzCtP93tc96eOgQmSwV5YkrCnkzQ9GNu93rM5UYKSEFp8gwdd7NgByQduHYqsKeq5Wp
 Z6KamhCOSa9+SnBAkD/yYjklOAZxW1gADW/OIBfsAtRW7OKD89epdj0PwkUmpnuwmMw1
 6A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AaNT5i4Ku7iQhTd9k9EqGn5XEW1qeFDkPm39ClB8CxA=;
 b=i41xRNcyzcFHaEhnbf1E/7eTrCFqCN0gXGKCDzkv4X2NdbzjwFf97I+HUhkF0EIKfP
 t0V6YX+WAy6wdIt8CsiqM86LvAvwcPiQOYAOCb27pl5pSJbEV6rLKSWki0O9JozjhF30
 IMU940vvS/+lYxNSkBNpm4VaAS+nppXhsM8gQ9FxxqGMB94CTCWjhNGhEi2Bp8EjpzHe
 PsQU8NaAh1/rVqgpdbhZnDpgKrPHf3Ia1hrXMgeOWn6y1r2V5oNKfuJ0Yx1CRf1qjggK
 uqYxBUY0450DM7xXLY7ghM9pBtmh/EQYCyHCcm42sxJrRdQBKdM4bPjkO3EYaT9hi4+h
 gS1A==
X-Gm-Message-State: ANhLgQ2mQiEkQdcltN5FS8ph3fqKTXf8S7bOhJ6h47R3C/UImGPm1xo0
 ZewetUvK3oRauRn1oWZX2YIDnXtr2nqUZvk3Pb8=
X-Google-Smtp-Source: ADFU+vsguIOQniwWpDJsIttLls+tLrYa1XAjsw5W0G+d1ldfR2MTLJOcAI28eRGG0ETXCuOxVSmWeum9mGTCwGsP+ag=
X-Received: by 2002:aca:a895:: with SMTP id r143mr3599896oie.150.1585061695090; 
 Tue, 24 Mar 2020 07:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-2-ppandit@redhat.com>
 <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
 <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
In-Reply-To: <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 24 Mar 2020 22:54:18 +0800
Message-ID: <CAKXe6SJMc0jinC-aWqhSp=ZH3Es0rHLbV-nwq1p0_hPY_vBTDA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] net: tulip: check frame size and r/w data length
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004874ef05a19aefbd"
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004874ef05a19aefbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:45=E5=86=99=E9=81=93=EF=BC=9A

>
> On 2020/3/24 =E4=B8=8A=E5=8D=889:29, Li Qiang wrote:
> >
> >
> > P J P <ppandit@redhat.com <mailto:ppandit@redhat.com>> =E4=BA=8E2020=E5=
=B9=B43=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=80
> > =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     From: Prasad J Pandit <pjp@fedoraproject.org
> >     <mailto:pjp@fedoraproject.org>>
> >
> >     Tulip network driver while copying tx/rx buffers does not check
> >     frame size against r/w data length. This may lead to OOB buffer
> >     access. Add check to avoid it.
> >
> >     Limit iterations over descriptors to avoid potential infinite
> >     loop issue in tulip_xmit_list_update.
> >
> >     Reported-by: Li Qiang <pangpei.lq@antfin.com
> >     <mailto:pangpei.lq@antfin.com>>
> >     Reported-by: Ziming Zhang <ezrakiez@gmail.com
> >     <mailto:ezrakiez@gmail.com>>
> >     Reported-by: Jason Wang <jasowang@redhat.com
> >     <mailto:jasowang@redhat.com>>
> >     Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org
> >     <mailto:pjp@fedoraproject.org>>
> >
> >
> >
> > Tested-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>>
> > But I have a minor question....
> >
> >     ---
> >      hw/net/tulip.c | 36 +++++++++++++++++++++++++++---------
> >      1 file changed, 27 insertions(+), 9 deletions(-)
> >
> >     Update v3: return a value from tulip_copy_tx_buffers() and avoid
> >     infinite loop
> >       ->
> >     https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
> >
> >     diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> >     index cfac2719d3..fbe40095da 100644
> >     --- a/hw/net/tulip.c
> >     +++ b/hw/net/tulip.c
> >     @@ -170,6 +170,10 @@ static void tulip_copy_rx_bytes(TULIPState
> >     *s, struct tulip_descriptor *desc)
> >              } else {
> >                  len =3D s->rx_frame_len;
> >              }
> >     +
> >     +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
> >     +            return;
> >     +        }
> >
> >
> >
> > Why here is '>=3D' instead of '>'.
> > IIUC the total sending length can reach to sizeof(s->rx_frame).
> > Same in the other place in this patch.
>
>
> Yes, this need to be fixed.
>
>
> >
> > PS: I have planned to write a qtest case. But my personal qemu dev
> > environment is broken.
> > I will try to write it tonight or tomorrow night.
>
>
> Cool, good to know this.
>
>
Hi all,
I have countered an interesting issue. Let's look at the definition of
TULIPState.

  21 typedef struct TULIPState {
  22     PCIDevice dev;
  23     MemoryRegion io;
  24     MemoryRegion memory;
  25     NICConf c;
  26     qemu_irq irq;
  27     NICState *nic;
  28     eeprom_t *eeprom;
  29     uint32_t csr[16];
  30
  31     /* state for MII */
  32     uint32_t old_csr9;
  33     uint32_t mii_word;
  34     uint32_t mii_bitcnt;
  35
  36     hwaddr current_rx_desc;
  37     hwaddr current_tx_desc;
  38
  39     uint8_t rx_frame[2048];
  40     uint8_t tx_frame[2048];
  41     uint16_t tx_frame_len;
  42     uint16_t rx_frame_len;
  43     uint16_t rx_frame_size;
  44
  45     uint32_t rx_status;
  46     uint8_t filter[16][6];
  47 } TULIPState;

Here we can see the overflow is occured after 'tx_frame'.
In my quest, I have see the overflow(the s->tx_frame_len is big).
However here doesn't cause SEGV in qtest.
In real case, the qemu process will access the data after TULIPState in
heap and trigger segv.
However in qtest mode I don't know how to trigger this.

The core code like this:

 qpci_device_enable(dev);
bar =3D qpci_iomap(dev, 0, NULL);
    context_pa =3D guest_alloc(alloc, sizeof(context));
    guest_pa =3D guest_alloc(alloc, 4096);
memset(guest_data, 'A', sizeof(guest_data));
    context[0].status =3D 1 << 31;
context[0].control =3D 0x7ff << 11 | 0x7ff;
context[0].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);
context[0].buf_addr1 =3D guest_pa;
    for (i =3D 1; i < ARRAY_SIZE(context); ++i) {
        context_pa +=3D sizeof(struct tulip_descriptor);
        context[i].status =3D 1 << 31;
context[i].control =3D 0x7ff << 11 | 0x7ff;
context[i].buf_addr2 =3D context_pa + sizeof(struct tulip_descriptor);
context[i].buf_addr1 =3D guest_pa;
}

qtest_memwrite(dev->bus->qts, context_pa, context, sizeof(context));
qtest_memwrite(dev->bus->qts, guest_pa, guest_data, sizeof(guest_data));
qpci_io_writel(dev, bar, 0x20, context_pa);
qpci_io_writel(dev, bar, 0x30, 1 << 13);

Paolo may give some hints?

Thanks,
Li Qiang



> Thanks
>
>
> >
> > Thanks,
> > Li Qiang
> >
> >
> >
> >
> >              pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
> >                  (s->rx_frame_size - s->rx_frame_len), len);
> >              s->rx_frame_len -=3D len;
> >     @@ -181,6 +185,10 @@ static void tulip_copy_rx_bytes(TULIPState
> >     *s, struct tulip_descriptor *desc)
> >              } else {
> >                  len =3D s->rx_frame_len;
> >              }
> >     +
> >     +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
> >     +            return;
> >     +        }
> >              pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
> >                  (s->rx_frame_size - s->rx_frame_len), len);
> >              s->rx_frame_len -=3D len;
> >     @@ -227,7 +235,8 @@ static ssize_t tulip_receive(TULIPState *s,
> >     const uint8_t *buf, size_t size)
> >
> >          trace_tulip_receive(buf, size);
> >
> >     -    if (size < 14 || size > 2048 || s->rx_frame_len ||
> >     tulip_rx_stopped(s)) {
> >     +    if (size < 14 || size > sizeof(s->rx_frame) - 4
> >     +        || s->rx_frame_len || tulip_rx_stopped(s)) {
> >              return 0;
> >          }
> >
> >     @@ -275,7 +284,6 @@ static ssize_t tulip_receive_nc(NetClientState
> >     *nc,
> >          return tulip_receive(qemu_get_nic_opaque(nc), buf, size);
> >      }
> >
> >     -
> >      static NetClientInfo net_tulip_info =3D {
> >          .type =3D NET_CLIENT_DRIVER_NIC,
> >          .size =3D sizeof(NICState),
> >     @@ -558,7 +566,7 @@ static void tulip_tx(TULIPState *s, struct
> >     tulip_descriptor *desc)
> >              if ((s->csr[6] >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
> >                  /* Internal or external Loopback */
> >                  tulip_receive(s, s->tx_frame, s->tx_frame_len);
> >     -        } else {
> >     +        } else if (s->tx_frame_len <=3D sizeof(s->tx_frame)) {
> >                  qemu_send_packet(qemu_get_queue(s->nic),
> >                      s->tx_frame, s->tx_frame_len);
> >              }
> >     @@ -570,23 +578,31 @@ static void tulip_tx(TULIPState *s, struct
> >     tulip_descriptor *desc)
> >          }
> >      }
> >
> >     -static void tulip_copy_tx_buffers(TULIPState *s, struct
> >     tulip_descriptor *desc)
> >     +static int tulip_copy_tx_buffers(TULIPState *s, struct
> >     tulip_descriptor *desc)
> >      {
> >          int len1 =3D (desc->control >> TDES1_BUF1_SIZE_SHIFT) &
> >     TDES1_BUF1_SIZE_MASK;
> >          int len2 =3D (desc->control >> TDES1_BUF2_SIZE_SHIFT) &
> >     TDES1_BUF2_SIZE_MASK;
> >
> >     +    if (s->tx_frame_len + len1 >=3D sizeof(s->tx_frame)) {
> >     +        return -1;
> >     +    }
> >          if (len1) {
> >              pci_dma_read(&s->dev, desc->buf_addr1,
> >                  s->tx_frame + s->tx_frame_len, len1);
> >              s->tx_frame_len +=3D len1;
> >          }
> >
> >     +    if (s->tx_frame_len + len2 >=3D sizeof(s->tx_frame)) {
> >     +        return -1;
> >     +    }
> >          if (len2) {
> >              pci_dma_read(&s->dev, desc->buf_addr2,
> >                  s->tx_frame + s->tx_frame_len, len2);
> >              s->tx_frame_len +=3D len2;
> >          }
> >          desc->status =3D (len1 + len2) ? 0 : 0x7fffffff;
> >     +
> >     +    return 0;
> >      }
> >
> >      static void tulip_setup_filter_addr(TULIPState *s, uint8_t *buf,
> >     int n)
> >     @@ -651,13 +667,15 @@ static uint32_t tulip_ts(TULIPState *s)
> >
> >      static void tulip_xmit_list_update(TULIPState *s)
> >      {
> >     +#define TULIP_DESC_MAX 128
> >     +    uint8_t i =3D 0;
> >          struct tulip_descriptor desc;
> >
> >          if (tulip_ts(s) !=3D CSR5_TS_SUSPENDED) {
> >              return;
> >          }
> >
> >     -    for (;;) {
> >     +    for (i =3D 0; i < TULIP_DESC_MAX; i++) {
> >              tulip_desc_read(s, s->current_tx_desc, &desc);
> >              tulip_dump_tx_descriptor(s, &desc);
> >
> >     @@ -675,10 +693,10 @@ static void
> >     tulip_xmit_list_update(TULIPState *s)
> >                      s->tx_frame_len =3D 0;
> >                  }
> >
> >     -            tulip_copy_tx_buffers(s, &desc);
> >     -
> >     -            if (desc.control & TDES1_LS) {
> >     -                tulip_tx(s, &desc);
> >     +            if (!tulip_copy_tx_buffers(s, &desc)) {
> >     +                if (desc.control & TDES1_LS) {
> >     +                    tulip_tx(s, &desc);
> >     +                }
> >                  }
> >              }
> >              tulip_desc_write(s, s->current_tx_desc, &desc);
> >     --
> >     2.25.1
> >
> >
>
>

--0000000000004874ef05a19aefbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jason Wang &lt;<a href=3D"mailto:jaso=
wang@redhat.com">jasowang@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B43=E6=9C=
=8824=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:45=E5=86=99=E9=81=93=
=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/3/24 =E4=B8=8A=E5=8D=889:29, Li Qiang wrote:<br>
&gt;<br>
&gt;<br>
&gt; P J P &lt;<a href=3D"mailto:ppandit@redhat.com" target=3D"_blank">ppan=
dit@redhat.com</a> &lt;mailto:<a href=3D"mailto:ppandit@redhat.com" target=
=3D"_blank">ppandit@redhat.com</a>&gt;&gt; =E4=BA=8E2020=E5=B9=B43=E6=9C=88=
23=E6=97=A5=E5=91=A8=E4=B8=80 <br>
&gt; =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0From: Prasad J Pandit &lt;<a href=3D"mailto:pjp@fed=
oraproject.org" target=3D"_blank">pjp@fedoraproject.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pjp@fedoraproject.org"=
 target=3D"_blank">pjp@fedoraproject.org</a>&gt;&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Tulip network driver while copying tx/rx buffers do=
es not check<br>
&gt;=C2=A0 =C2=A0 =C2=A0frame size against r/w data length. This may lead t=
o OOB buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0access. Add check to avoid it.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Limit iterations over descriptors to avoid potentia=
l infinite<br>
&gt;=C2=A0 =C2=A0 =C2=A0loop issue in tulip_xmit_list_update.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reported-by: Li Qiang &lt;<a href=3D"mailto:pangpei=
.lq@antfin.com" target=3D"_blank">pangpei.lq@antfin.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pangpei.lq@antfin.com"=
 target=3D"_blank">pangpei.lq@antfin.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reported-by: Ziming Zhang &lt;<a href=3D"mailto:ezr=
akiez@gmail.com" target=3D"_blank">ezrakiez@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ezrakiez@gmail.com" ta=
rget=3D"_blank">ezrakiez@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reported-by: Jason Wang &lt;<a href=3D"mailto:jasow=
ang@redhat.com" target=3D"_blank">jasowang@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jasowang@redhat.com" t=
arget=3D"_blank">jasowang@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Prasad J Pandit &lt;<a href=3D"mailt=
o:pjp@fedoraproject.org" target=3D"_blank">pjp@fedoraproject.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pjp@fedoraproject.org"=
 target=3D"_blank">pjp@fedoraproject.org</a>&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Tested-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com" target=3D"=
_blank">liq3ea@gmail.com</a> &lt;mailto:<a href=3D"mailto:liq3ea@gmail.com"=
 target=3D"_blank">liq3ea@gmail.com</a>&gt;&gt;<br>
&gt; But I have a minor question....<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/net/tulip.c | 36 +++++++++++++++++++++++++=
++---------<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 27 insertions(+), 9 deletions=
(-)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Update v3: return a value from tulip_copy_tx_buffer=
s() and avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0infinite loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 -&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.gnu.org/archive/html/qemu-=
devel/2020-02/msg06275.html" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html</a><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/hw/net/tulip.c b/hw/net/tulip.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index cfac2719d3..fbe40095da 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/hw/net/tulip.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/hw/net/tulip.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -170,6 +170,10 @@ static void tulip_copy_rx_byte=
s(TULIPState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len=
 =3D s-&gt;rx_frame_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;rx_frame_len=
 + len &gt;=3D sizeof(s-&gt;rx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Why here is &#39;&gt;=3D&#39; instead of &#39;&gt;&#39;.<br>
&gt; IIUC the total sending length can reach to sizeof(s-&gt;rx_frame).<br>
&gt; Same in the other place in this patch.<br>
<br>
<br>
Yes, this need to be fixed.<br>
<br>
<br>
&gt;<br>
&gt; PS: I have planned to write a qtest case. But my personal qemu dev <br=
>
&gt; environment is broken.<br>
&gt; I will try to write it tonight or=C2=A0tomorrow night.<br>
<br>
<br>
Cool, good to know this.<br>
<br></blockquote><div><br></div><div>Hi all,</div><div>I have countered an =
interesting issue. Let&#39;s look at the definition of TULIPState.</div><di=
v><br></div><div>=C2=A0 21 typedef struct TULIPState {<br>=C2=A0 22 =C2=A0 =
=C2=A0 PCIDevice dev;<br>=C2=A0 23 =C2=A0 =C2=A0 MemoryRegion io;<br>=C2=A0=
 24 =C2=A0 =C2=A0 MemoryRegion memory;<br>=C2=A0 25 =C2=A0 =C2=A0 NICConf c=
;<br>=C2=A0 26 =C2=A0 =C2=A0 qemu_irq irq;<br>=C2=A0 27 =C2=A0 =C2=A0 NICSt=
ate *nic;<br>=C2=A0 28 =C2=A0 =C2=A0 eeprom_t *eeprom;<br>=C2=A0 29 =C2=A0 =
=C2=A0 uint32_t csr[16];<br>=C2=A0 30 <br>=C2=A0 31 =C2=A0 =C2=A0 /* state =
for MII */<br>=C2=A0 32 =C2=A0 =C2=A0 uint32_t old_csr9;<br>=C2=A0 33 =C2=
=A0 =C2=A0 uint32_t mii_word;<br>=C2=A0 34 =C2=A0 =C2=A0 uint32_t mii_bitcn=
t;<br>=C2=A0 35 <br>=C2=A0 36 =C2=A0 =C2=A0 hwaddr current_rx_desc;<br>=C2=
=A0 37 =C2=A0 =C2=A0 hwaddr current_tx_desc;<br>=C2=A0 38 <br>=C2=A0 39 =C2=
=A0 =C2=A0 uint8_t rx_frame[2048];<br>=C2=A0 40 =C2=A0 =C2=A0 uint8_t tx_fr=
ame[2048];<br>=C2=A0 41 =C2=A0 =C2=A0 uint16_t tx_frame_len;<br>=C2=A0 42 =
=C2=A0 =C2=A0 uint16_t rx_frame_len;<br>=C2=A0 43 =C2=A0 =C2=A0 uint16_t rx=
_frame_size;<br>=C2=A0 44 <br>=C2=A0 45 =C2=A0 =C2=A0 uint32_t rx_status;<b=
r>=C2=A0 46 =C2=A0 =C2=A0 uint8_t filter[16][6];<br>=C2=A0 47 } TULIPState;=
<br></div><div><br></div><div>Here we can see the overflow is occured after=
 &#39;tx_frame&#39;.</div><div>In my quest, I have see the overflow(the s-&=
gt;tx_frame_len is big).</div><div>However here doesn&#39;t cause SEGV in q=
test.=C2=A0</div><div>In real case, the qemu process will access the data a=
fter TULIPState in heap and trigger segv.</div><div>However in qtest mode I=
 don&#39;t know how to trigger this.</div><div><br></div><div>The core code=
 like this:</div><div><br></div><div>=C2=A0qpci_device_enable(dev);<br>	bar=
 =3D qpci_iomap(dev, 0, NULL);<br>=C2=A0 =C2=A0 context_pa =3D guest_alloc(=
alloc, sizeof(context));<br>=C2=A0 =C2=A0 guest_pa =3D guest_alloc(alloc, 4=
096);<br>	memset(guest_data, &#39;A&#39;, sizeof(guest_data));<br>=C2=A0 =
=C2=A0 context[0].status =3D 1 &lt;&lt; 31;<br>	context[0].control =3D 0x7f=
f &lt;&lt; 11 | 0x7ff;<br>	context[0].buf_addr2 =3D context_pa + sizeof(str=
uct tulip_descriptor);<br>	context[0].buf_addr1 =3D guest_pa;<br>=C2=A0 =C2=
=A0 for (i =3D 1; i &lt; ARRAY_SIZE(context); ++i) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 context_pa +=3D sizeof(struct tulip_descriptor);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 context[i].status =3D 1 &lt;&lt; 31;<br>		context[i].cont=
rol =3D 0x7ff &lt;&lt; 11 | 0x7ff;<br>		context[i].buf_addr2 =3D context_pa=
 + sizeof(struct tulip_descriptor);<br>		context[i].buf_addr1 =3D guest_pa;=
<br>	}<br><br>	qtest_memwrite(dev-&gt;bus-&gt;qts, context_pa, context, siz=
eof(context));<br>	qtest_memwrite(dev-&gt;bus-&gt;qts, guest_pa, guest_data=
, sizeof(guest_data));<br>	qpci_io_writel(dev, bar, 0x20, context_pa);<br>	=
qpci_io_writel(dev, bar, 0x30, 1 &lt;&lt; 13);<br></div><div><br></div><div=
>Paolo may give some hints?</div><div><br></div><div>Thanks,</div><div>Li Q=
iang</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
Thanks<br>
<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Li Qiang<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(&am=
p;s-&gt;dev, desc-&gt;buf_addr1, s-&gt;rx_frame +<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-=
&gt;rx_frame_size - s-&gt;rx_frame_len), len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_frame_le=
n -=3D len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -181,6 +185,10 @@ static void tulip_copy_rx_byte=
s(TULIPState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*s, struct tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len=
 =3D s-&gt;rx_frame_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;rx_frame_len=
 + len &gt;=3D sizeof(s-&gt;rx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(&am=
p;s-&gt;dev, desc-&gt;buf_addr2, s-&gt;rx_frame +<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-=
&gt;rx_frame_size - s-&gt;rx_frame_len), len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_frame_le=
n -=3D len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -227,7 +235,8 @@ static ssize_t tulip_receive(TU=
LIPState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0const uint8_t *buf, size_t size)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0trace_tulip_receive(buf, size);=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (size &lt; 14 || size &gt; 2048 |=
| s-&gt;rx_frame_len ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0tulip_rx_stopped(s)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (size &lt; 14 || size &gt; sizeof=
(s-&gt;rx_frame) - 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || s-&gt;rx_frame_len =
|| tulip_rx_stopped(s)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -275,7 +284,6 @@ static ssize_t tulip_receive_nc=
(NetClientState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*nc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return tulip_receive(qemu_get_n=
ic_opaque(nc), buf, size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static NetClientInfo net_tulip_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.type =3D NET_CLIENT_DRIVER_NIC=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0.size =3D sizeof(NICState),<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -558,7 +566,7 @@ static void tulip_tx(TULIPState=
 *s, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;csr[6]=
 &gt;&gt; CSR6_OM_SHIFT) &amp; CSR6_OM_MASK) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
Internal or external Loopback */<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tul=
ip_receive(s, s-&gt;tx_frame, s-&gt;tx_frame_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s-&gt;tx_fr=
ame_len &lt;=3D sizeof(s-&gt;tx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qem=
u_send_packet(qemu_get_queue(s-&gt;nic),<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;tx_frame, s-&gt;tx_frame_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -570,23 +578,31 @@ static void tulip_tx(TULIPSta=
te *s, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-static void tulip_copy_tx_buffers(TULIPState *s, s=
truct<br>
&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static int tulip_copy_tx_buffers(TULIPState *s, st=
ruct<br>
&gt;=C2=A0 =C2=A0 =C2=A0tulip_descriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len1 =3D (desc-&gt;control =
&gt;&gt; TDES1_BUF1_SIZE_SHIFT) &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0TDES1_BUF1_SIZE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int len2 =3D (desc-&gt;control =
&gt;&gt; TDES1_BUF2_SIZE_SHIFT) &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0TDES1_BUF2_SIZE_MASK;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s-&gt;tx_frame_len + len1 &gt;=
=3D sizeof(s-&gt;tx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&amp=
;s-&gt;dev, desc-&gt;buf_addr1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&=
gt;tx_frame + s-&gt;tx_frame_len, len1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame_le=
n +=3D len1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s-&gt;tx_frame_len + len2 &gt;=
=3D sizeof(s-&gt;tx_frame)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (len2) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&amp=
;s-&gt;dev, desc-&gt;buf_addr2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&=
gt;tx_frame + s-&gt;tx_frame_len, len2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame_le=
n +=3D len2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0desc-&gt;status =3D (len1 + len=
2) ? 0 : 0x7fffffff;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_setup_filter_addr(TULIPStat=
e *s, uint8_t *buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0int n)<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -651,13 +667,15 @@ static uint32_t tulip_ts(TULI=
PState *s)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static void tulip_xmit_list_update(TULIPState=
 *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define TULIP_DESC_MAX 128<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 uint8_t i =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0struct tulip_descriptor desc;<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (tulip_ts(s) !=3D CSR5_TS_SU=
SPENDED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 for (;;) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 for (i =3D 0; i &lt; TULIP_DESC_MAX;=
 i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_read(s=
, s-&gt;current_tx_desc, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_dump_tx_des=
criptor(s, &amp;desc);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -675,10 +693,10 @@ static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0tulip_xmit_list_update(TULIPState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;tx_frame_len =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_co=
py_tx_buffers(s, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc=
.control &amp; TDES1_LS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tulip_tx(s, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tul=
ip_copy_tx_buffers(s, &amp;desc)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (desc.control &amp; TDES1_LS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 tulip_tx(s, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_write(=
s, s-&gt;current_tx_desc, &amp;desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.25.1<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--0000000000004874ef05a19aefbd--

