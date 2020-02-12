Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E25C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32EC206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="1rvU0pd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32EC206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1nkC-0003IS-8F
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 03:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j1njX-0002fD-2u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j1njV-0004Jm-S9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:50:59 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:42719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j1njV-0004Ic-FZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:50:57 -0500
Received: by mail-yb1-xb41.google.com with SMTP id z125so733240ybf.9
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 00:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g6i6+V8L61m6zMZOQ3zXHQBhCIPLP3oyIEZWnIhFpR8=;
 b=1rvU0pd3Afb3wbDjT5MihZWEgakW+Ui4mozEGlpkhA23TIdkyoBb5zn939molPGncs
 Uv1qw646oYD5lIKXCMY8Z/FRk+Ai/ZmCZjSSsR52TBNnl39p/3siWdQLu3rFWXh2yMHc
 P4qdLeKsKLJxjzePj3qVezc8WXxcuYZ63LTMHqrjAVZh9WmuEvgksWkOVeyu10ujToBu
 P9THNGa7UDv32gygcXoLXlw0vOaRIQiy5qaN1f/bEtzp1SJL0kWerjgPCDM+57nzgAo4
 6WHA+7e8Ca549gUUHwThQTLgencQUSF1C4U4TTUXTcpBiDQEs/menMZ7WdFzIOU/0SaA
 T0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g6i6+V8L61m6zMZOQ3zXHQBhCIPLP3oyIEZWnIhFpR8=;
 b=km5+fif3x0dnA9sVx3peSa+EAVUDn7mw3Lm6eGm3i0W76XENuay0rNSv4kPPmf6LVV
 OPDr4Ie35MOX+OxurAs2vopQuQDDbXesQgaV383VJ2qAMD2HG0oLLma5L4mCocXbh7U/
 H5yZt2KedZgGWQB30YRBX4dtx48xYXn/DrKnOgamR3HYsxeBQIS5xfk5efYVmGWQ7i9r
 +7gDmSPXfJvUE9xhvG/Ugj1T7RfbQdkar0KDoa8ddVZZIaOFxmH2YUY4euAKHyLPsUT0
 4ES1aCQFDlEvf+dntgVepVzrjwhS00zHgFRq7rJEznoVny2Rl1+qBTLGjt07PbbBjWsN
 soKg==
X-Gm-Message-State: APjAAAVWSnmy8PWHOBtwXXpTTjtpb8iAdZ5Rl9LVUvlZUQhyNd1yOVmX
 9v6BnW43DKvw6Abu3mRlFms3eX8vFgf0tai46BvIrQ==
X-Google-Smtp-Source: APXvYqz2bxPWvYXroQtjaK/qedxx56ZF9jnzIczx3IZeyEHomUlMVjSrkTlMQTQgC08X0JnIxbRc47FqNIoZPPBFEew=
X-Received: by 2002:a25:a444:: with SMTP id f62mr9335876ybi.235.1581497456089; 
 Wed, 12 Feb 2020 00:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20200127115405.13459-1-yuri.benditovich@daynix.com>
 <DDDADB15-A1C8-40E6-A595-6A516F6E5831@gmail.com>
In-Reply-To: <DDDADB15-A1C8-40E6-A595-6A516F6E5831@gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 12 Feb 2020 10:50:44 +0200
Message-ID: <CAOEp5Oc8qYN=abgh5QYarvMPnG-BuC_isfHBw6V0FvbKvwe0JQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] NetRxPkt: Introduce support for additional hash types
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

Can you please review these 2 patches and apply if there are no objections.

Thanks,
Yuri Benditovich

On Wed, Jan 29, 2020 at 6:09 PM Dmitry Fleytman
<dmitry.fleytman@gmail.com> wrote:
>
>
>
> > On 27 Jan 2020, at 13:54, Yuri Benditovich <yuri.benditovich@daynix.com> wrote:
> >
> > Add support for following hash types:
> > IPV6 TCP with extension headers
> > IPV4 UDP
> > IPV6 UDP
> > IPV6 UDP with extension headers
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>
>
> Acked-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
>
>
> > ---
> > hw/net/net_rx_pkt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > hw/net/net_rx_pkt.h |  6 +++++-
> > hw/net/trace-events |  4 ++++
> > 3 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> > index 98a5030ace..b2a06bd27d 100644
> > --- a/hw/net/net_rx_pkt.c
> > +++ b/hw/net/net_rx_pkt.c
> > @@ -307,6 +307,20 @@ _net_rx_rss_prepare_tcp(uint8_t *rss_input,
> >                           &tcphdr->th_dport, sizeof(uint16_t));
> > }
> >
> > +static inline void
> > +_net_rx_rss_prepare_udp(uint8_t *rss_input,
> > +                        struct NetRxPkt *pkt,
> > +                        size_t *bytes_written)
> > +{
> > +    struct udp_header *udphdr = &pkt->l4hdr_info.hdr.udp;
> > +
> > +    _net_rx_rss_add_chunk(rss_input, bytes_written,
> > +                          &udphdr->uh_sport, sizeof(uint16_t));
> > +
> > +    _net_rx_rss_add_chunk(rss_input, bytes_written,
> > +                          &udphdr->uh_dport, sizeof(uint16_t));
> > +}
> > +
> > uint32_t
> > net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
> >                          NetRxPktRssType type,
> > @@ -347,6 +361,34 @@ net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
> >         trace_net_rx_pkt_rss_ip6_ex();
> >         _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, &rss_length);
> >         break;
> > +    case NetPktRssIpV6TcpEx:
> > +        assert(pkt->isip6);
> > +        assert(pkt->istcp);
> > +        trace_net_rx_pkt_rss_ip6_ex_tcp();
> > +        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, &rss_length);
> > +        _net_rx_rss_prepare_tcp(&rss_input[0], pkt, &rss_length);
> > +        break;
> > +    case NetPktRssIpV4Udp:
> > +        assert(pkt->isip4);
> > +        assert(pkt->isudp);
> > +        trace_net_rx_pkt_rss_ip4_udp();
> > +        _net_rx_rss_prepare_ip4(&rss_input[0], pkt, &rss_length);
> > +        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
> > +        break;
> > +    case NetPktRssIpV6Udp:
> > +        assert(pkt->isip6);
> > +        assert(pkt->isudp);
> > +        trace_net_rx_pkt_rss_ip6_udp();
> > +        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, false, &rss_length);
> > +        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
> > +        break;
> > +    case NetPktRssIpV6UdpEx:
> > +        assert(pkt->isip6);
> > +        assert(pkt->isudp);
> > +        trace_net_rx_pkt_rss_ip6_ex_udp();
> > +        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, &rss_length);
> > +        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
> > +        break;
> >     default:
> >         assert(false);
> >         break;
> > diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
> > index 7adf0fad51..048e3461f0 100644
> > --- a/hw/net/net_rx_pkt.h
> > +++ b/hw/net/net_rx_pkt.h
> > @@ -133,7 +133,11 @@ typedef enum {
> >     NetPktRssIpV4Tcp,
> >     NetPktRssIpV6Tcp,
> >     NetPktRssIpV6,
> > -    NetPktRssIpV6Ex
> > +    NetPktRssIpV6Ex,
> > +    NetPktRssIpV6TcpEx,
> > +    NetPktRssIpV4Udp,
> > +    NetPktRssIpV6Udp,
> > +    NetPktRssIpV6UdpEx,
> > } NetRxPktRssType;
> >
> > /**
> > diff --git a/hw/net/trace-events b/hw/net/trace-events
> > index 6f990ede87..73d4558f7e 100644
> > --- a/hw/net/trace-events
> > +++ b/hw/net/trace-events
> > @@ -92,9 +92,13 @@ net_rx_pkt_l3_csum_validate_csum(size_t l3hdr_off, uint32_t csl, uint32_t cntr,
> >
> > net_rx_pkt_rss_ip4(void) "Calculating IPv4 RSS  hash"
> > net_rx_pkt_rss_ip4_tcp(void) "Calculating IPv4/TCP RSS  hash"
> > +net_rx_pkt_rss_ip4_udp(void) "Calculating IPv4/UDP RSS  hash"
> > net_rx_pkt_rss_ip6_tcp(void) "Calculating IPv6/TCP RSS  hash"
> > +net_rx_pkt_rss_ip6_udp(void) "Calculating IPv6/UDP RSS  hash"
> > net_rx_pkt_rss_ip6(void) "Calculating IPv6 RSS  hash"
> > net_rx_pkt_rss_ip6_ex(void) "Calculating IPv6/EX RSS  hash"
> > +net_rx_pkt_rss_ip6_ex_tcp(void) "Calculating IPv6/EX/TCP RSS  hash"
> > +net_rx_pkt_rss_ip6_ex_udp(void) "Calculating IPv6/EX/UDP RSS  hash"
> > net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash for %zu bytes: 0x%X"
> > net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset) "Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
> >
> > --
> > 2.17.1
> >
>

