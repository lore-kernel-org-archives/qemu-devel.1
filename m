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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24124C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 02:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18F92051A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 02:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjzRs1Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18F92051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGYx2-0004ds-3S
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 22:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1jGYw8-0004CR-LH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 22:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1jGYw7-0005ZU-5N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 22:05:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1jGYw6-0005YY-U9
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 22:04:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id e19so15629523otj.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AyV+jfUa1bUOWbq4PtGj54ZGgoXBTMvxZXLg6vpgRTw=;
 b=NjzRs1Rl6uMXQEqK1TXwKvBwJjhX7vWaDfPYa40szKNefOO+IEJbCUuEKiQ5PStYSX
 W9D7JuBTkCnsxDkqnJ7qF5sVCdAe8apHz4qZb7Z56crZvTdYTw0Q8MvOpEvm+rAZpAIk
 QFcNrEI2ZJ6MhVfbjAd09BwHh8/fZS1pFh/f/5m2mbPiStHUW5pAq82hbBog5znQpYyt
 lLimbORCJiNcvbkHlN7zTFE6iNXRA5VLbfloUymg0+7UTGv8y0ds8xXvWyhbhLSVEcvk
 SvEAzietJyreWO08fSarxpe+9sh6g84dK5b8AC16Yj3I3dRUPs7wrhlNjrVYHtrRflkb
 Ip4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AyV+jfUa1bUOWbq4PtGj54ZGgoXBTMvxZXLg6vpgRTw=;
 b=GTLQ2TcOQzyI1WdxyECQSG6d0xqFTZMOiA7jAPTUXME9Z11X5ndCv1vrTbBB89xl1f
 M2TdDm36nkncBxXiNPwEOif1bjQp7i9BG76mTrOSOn+isaUyKIEyAEihIoIG7slbzYqB
 cWfeNk+0a0H1AO/TFq/xlov55VXmwi+FxLyPiZ0jomRgBG0BxJTUn2OoXhtXUpzk2FpV
 j9Y/623H2qJsF4tYJ/4YUtK9IiyPsv7AbRA5bixhpMRbgPeZ7+5TBkN6tBOTUt/QM1yA
 uK4QR6Sv3T9H5umjkv64faO44ultFVm1wbqNitr8UfOjsrAtmFw1n+z26QztXY+Mi79w
 SL6w==
X-Gm-Message-State: ANhLgQ3W4S5iF+Czm7OWS/7dW6cqt7jJizOr3/OPRD/FmQ+A+doso2J0
 SAjx1/O0rlTZqtSWBj19e2TCFabyoo7pkIWwxv0=
X-Google-Smtp-Source: ADFU+vv076GERJgGDg2nG6u5K++XRIN2kmlmzX97lNUP0MSIeJTMEmd82ns+BD6u9otxYPUBAT93ea2pIxLwbp9JQr8=
X-Received: by 2002:a05:6830:403d:: with SMTP id
 i29mr18934771ots.353.1585015497492; 
 Mon, 23 Mar 2020 19:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-3-ppandit@redhat.com>
In-Reply-To: <20200323122100.893417-3-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 24 Mar 2020 10:04:21 +0800
Message-ID: <CAKXe6SJFTVpnShkgXPa-+sLEv0T96r9_z+ZCXaU9Wm1wF_anTg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] net: tulip: add .can_receive routine
To: P J P <ppandit@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b10cb205a1902d48"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b10cb205a1902d48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:25=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Define .can_receive routine to do sanity checks before receiving
> packet data. And call qemu_flush_queued_packets to flush queued
> packets once they are read in tulip_receive().
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/net/tulip.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> Update v6: merge earlier patch 2 & 3 into one
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06868.html
>
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index fbe40095da..8d8c9519e7 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState *s, cons=
t
> uint8_t *addr)
>      return ret;
>  }
>
> +static int
> +tulip_can_receive(NetClientState *nc)
> +{
> +    TULIPState *s =3D qemu_get_nic_opaque(nc);
> +
> +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t
> size)
>  {
>      struct tulip_descriptor desc;
> @@ -236,7 +248,7 @@ static ssize_t tulip_receive(TULIPState *s, const
> uint8_t *buf, size_t size)
>      trace_tulip_receive(buf, size);
>
>      if (size < 14 || size > sizeof(s->rx_frame) - 4
> -        || s->rx_frame_len || tulip_rx_stopped(s)) {
> +        || !tulip_can_receive(s->nic->ncs)) {
>          return 0;
>      }
>
> @@ -275,6 +287,8 @@ static ssize_t tulip_receive(TULIPState *s, const
> uint8_t *buf, size_t size)
>          tulip_desc_write(s, s->current_rx_desc, &desc);
>          tulip_next_rx_descriptor(s, &desc);
>      } while (s->rx_frame_len);
> +
> +    qemu_flush_queued_packets(qemu_get_queue(s->nic));
>


Hi Prasad ans Jason,
I want to know why here we need call 'qemu_flush_queued_packets'.
AFAICS, the other networking card emulation need no this.

Thanks,
Li Qiang



>      return size;
>  }
>
> @@ -288,6 +302,7 @@ static NetClientInfo net_tulip_info =3D {
>      .type =3D NET_CLIENT_DRIVER_NIC,
>      .size =3D sizeof(NICState),
>      .receive =3D tulip_receive_nc,
> +    .can_receive =3D tulip_can_receive,
>  };
>
>  static const char *tulip_reg_name(const hwaddr addr)
> --
> 2.25.1
>
>
>

--000000000000b10cb205a1902d48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">P J P &lt;<a href=3D"mailto:ppandit@r=
edhat.com">ppandit@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:25=E5=86=99=E9=81=93=EF=BC=9A<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Prasad J P=
andit &lt;<a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">pjp@fe=
doraproject.org</a>&gt;<br>
<br>
Define .can_receive routine to do sanity checks before receiving<br>
packet data. And call qemu_flush_queued_packets to flush queued<br>
packets once they are read in tulip_receive().<br>
<br>
Suggested-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=
=3D"_blank">jasowang@redhat.com</a>&gt;<br>
Signed-off-by: Prasad J Pandit &lt;<a href=3D"mailto:pjp@fedoraproject.org"=
 target=3D"_blank">pjp@fedoraproject.org</a>&gt;<br>
---<br>
=C2=A0hw/net/tulip.c | 17 ++++++++++++++++-<br>
=C2=A01 file changed, 16 insertions(+), 1 deletion(-)<br>
<br>
Update v6: merge earlier patch 2 &amp; 3 into one<br>
=C2=A0 -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-=
03/msg06868.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.or=
g/archive/html/qemu-devel/2020-03/msg06868.html</a><br>
<br>
diff --git a/hw/net/tulip.c b/hw/net/tulip.c<br>
index fbe40095da..8d8c9519e7 100644<br>
--- a/hw/net/tulip.c<br>
+++ b/hw/net/tulip.c<br>
@@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState *s, const =
uint8_t *addr)<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+static int<br>
+tulip_can_receive(NetClientState *nc)<br>
+{<br>
+=C2=A0 =C2=A0 TULIPState *s =3D qemu_get_nic_opaque(nc);<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;rx_frame_len || tulip_rx_stopped(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_=
t size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct tulip_descriptor desc;<br>
@@ -236,7 +248,7 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)<br>
=C2=A0 =C2=A0 =C2=A0trace_tulip_receive(buf, size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (size &lt; 14 || size &gt; sizeof(s-&gt;rx_frame) - =
4<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || s-&gt;rx_frame_len || tulip_rx_stopped(s)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !tulip_can_receive(s-&gt;nic-&gt;ncs)) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -275,6 +287,8 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_write(s, s-&gt;current_rx_desc=
, &amp;desc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_next_rx_descriptor(s, &amp;desc);<b=
r>
=C2=A0 =C2=A0 =C2=A0} while (s-&gt;rx_frame_len);<br>
+<br>
+=C2=A0 =C2=A0 qemu_flush_queued_packets(qemu_get_queue(s-&gt;nic));<br></b=
lockquote><div><br></div><div><br></div><div>Hi Prasad ans Jason,</div><div=
>I want to know why here we need call &#39;qemu_flush_queued_packets&#39;.<=
/div><div>AFAICS, the other networking card emulation need no this.</div><d=
iv><br></div><div>Thanks,</div><div>Li Qiang</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0return size;<br>
=C2=A0}<br>
<br>
@@ -288,6 +302,7 @@ static NetClientInfo net_tulip_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.type =3D NET_CLIENT_DRIVER_NIC,<br>
=C2=A0 =C2=A0 =C2=A0.size =3D sizeof(NICState),<br>
=C2=A0 =C2=A0 =C2=A0.receive =3D tulip_receive_nc,<br>
+=C2=A0 =C2=A0 .can_receive =3D tulip_can_receive,<br>
=C2=A0};<br>
<br>
=C2=A0static const char *tulip_reg_name(const hwaddr addr)<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div>

--000000000000b10cb205a1902d48--

